import 'package:ecommerce_app_api_26/features/profile/data/profile_api.dart';
import 'package:ecommerce_app_api_26/features/profile/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  XFile? selectedImage;
  ProfileModel? profileModel;
  bool isLoading = true;
  bool isEditing = false;
  String? uploadedImage;
  String? name;
  String? role;

  /// pick Image
  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  /// update Profile
  Future<void> updateProfile() async {
    if (profileModel == null) return;
    setState(() {
      isLoading = true;
    });
    try {
      if (selectedImage != null) {
        uploadedImage = await ProfileApi().uploadImage(selectedImage!.path);
      }
      final EditedUser = await ProfileApi().updateProfile(
        profileModel!.id!,
        name!,
        role!,
        uploadedImage ?? profileModel!.avatar,
      );
      setState(() {
        profileModel = EditedUser;
        selectedImage = null;
        isEditing = false;
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully!")),
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  /// Get Profile
  Future<void> getProfile() async {
    try {
      final user = await ProfileApi().getProfile();
      setState(() {
        profileModel = user;
        name = user.name ?? '';
        role = user.role ?? 'customer';
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        child: Skeletonizer(
          enabled: isLoading && profileModel == null,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(24, 60, 24, 30),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade400, Colors.blue.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(40),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: selectedImage != null
                            ? Image.file(
                                File(selectedImage!.path),
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                profileModel?.avatar ?? '',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profileModel?.name ?? '',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          profileModel?.role ?? ' ',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        isEditing ? Icons.save : Icons.edit_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        if (isEditing == true) {
                           updateProfile();
                        } else {
                          setState(() {
                            isEditing = true;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              if (isEditing == true)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ElevatedButton.icon(
                    onPressed: pickImage,
                    label: const Text("Upload Image"),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    _buildSectionTitle('Account Settings'),
                    _buildProfileTile(
                      Icons.shopping_bag_outlined,
                      'My Orders',
                      'Track your orders',
                    ),
                    _buildProfileTile(
                      Icons.favorite_outline,
                      'Wishlist',
                      'Your favorite items',
                    ),
                    _buildProfileTile(
                      Icons.location_on_outlined,
                      'Shipping Address',
                      'Manage your addresses',
                    ),
                    _buildProfileTile(
                      Icons.payment_outlined,
                      'Payment Methods',
                      'Credit cards, wallets',
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('App Settings'),
                    _buildProfileTile(
                      Icons.notifications_none,
                      'Notifications',
                      'Control your alerts',
                    ),
                    _buildProfileTile(
                      Icons.lock_outline,
                      'Privacy',
                      'Manage your security',
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.logout, color: Colors.red),
                        label: const Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          backgroundColor: Colors.red.withOpacity(0.05),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16, left: 4),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildProfileTile(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.blue, size: 24),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
        onTap: () {},
      ),
    );
  }
}
