class ChangeFavouritsModel{
  bool? status;
  String? message;
  ChangeFavouritsModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
  }
}