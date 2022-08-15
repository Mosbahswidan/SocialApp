  class ShopLoginModel{
  bool? status;
  String? message;
  userData? data;
  ShopLoginModel.fromJason(Map<String,dynamic> jason){
    status=jason['status'];
    message=jason['message'];
    data=jason['data']!=null?userData.fromJason(jason['data']):null;
  }
  }
  class userData {
    int? id;
    String? name;
    String? email;
    String? phone;
    String? image;
    int? points;
    int? credit;
    String? token;
    userData.fromJason(Map<String, dynamic> jason){
      id = jason['id'];
      name = jason['name'];
      email = jason['email'];
      phone = jason['phone'];
      image = jason['image'];
      points = jason['points'];
      credit = jason['credit'];
      token = jason['token'];
    }
  }