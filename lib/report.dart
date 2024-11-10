import 'dart:ffi';

class Report {
  
  String? title;
  String? comment;

  String? address;
  double? latitude;
  double? longitude;

  Array? images;

  Report (this.title, this.comment, this.address, this.latitude, this.longitude, this.images);

}