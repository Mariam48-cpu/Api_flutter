  class UploadImageModel {
  String? originalname;
  String? filename;
  String? location;

  UploadImageModel({this.originalname, this.filename, this.location});

  UploadImageModel.fromJson(Map<String, dynamic> json) {
    originalname = json['originalname'];
    filename = json['filename'];
    location = json['location'];
  }

}