class PostModel{
  String?name;
  String?image;
  String?uId;
  String? text;
  String ?postImage;
  PostModel({
    this.name,
    this.uId,
    this.image,
    this.text,
    this.postImage,

});
  PostModel.fromJson(Map<String,dynamic>json)
  {
    name=json['name'];
    uId=json['uId'];
    image=json['image'];
    text=json['text'];
    postImage=json['postImage'];
  }
  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'uId':uId,
      'image':image,
      'text':text,
      'postImage':postImage,
    };
}

}