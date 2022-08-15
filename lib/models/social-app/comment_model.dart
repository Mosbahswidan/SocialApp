class CommentModel{
  String?name;
  String?comment;
  String?image;
  String?dateTime;
  CommentModel({
    this.image,
    this.name,
    this.comment,
    this.dateTime
});
  CommentModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    comment=json['comment'];
    image=json['image'];
    dateTime=json['dateTime'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'image':image,
      'comment':comment,
      'dateTime':dateTime,
    };
  }

}