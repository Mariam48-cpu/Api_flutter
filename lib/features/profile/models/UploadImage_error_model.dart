class UploadImageError {
  int? statusCode;
  String? message;
  UploadImageError({this.statusCode, this.message});
  UploadImageError.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
  }
}