class SocialUserModel{
  String?name;
  String?email;
  String?password;
  String?image;
  String?phone;
  String?uId;
  String?bio;
  String?cover;
  bool? isEmailVerfied;
  String?token;
  SocialUserModel({
    this.name,
    this.phone,
    this.password,
    this.email,
    this.uId,
    this.isEmailVerfied,
    this.image,
    this.bio,
    this.cover,
    this.token

});
  SocialUserModel.fromJson(Map<String,dynamic>json)
  {
    name=json['name'];
    email=json['email'];
    password=json['password'];
    phone=json['phone'];
    uId=json['uId'];
    bio=json['bio'];
    image=json['image'];
    isEmailVerfied=json['isEmailVerfied'];
    cover=json['cover'];
    token=json['token'];
  }
  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'email':email,
      'password':password,
      'phone':phone,
      'uId':uId,
      'bio':bio,
      'image':image,
      'isEmailVerfied':isEmailVerfied,
      'cover':cover,
      'token':token,
    };
}

}