class CategoriesModel{
  bool?status;
CategoriesDataModel? data;
CategoriesModel.fromJason(Map<String,dynamic>json){
  status=json['status'];
  data=CategoriesDataModel.fromJason(json['data']);
}
}

class CategoriesDataModel{
  int?current_page;
  List<DataModell> data=[];
  CategoriesDataModel.fromJason(Map<String,dynamic>json){
   current_page=json['current_page'];
   json['data'].forEach((element){
     data.add(DataModell.fromJason(element));
   });
  }
}

class DataModell{
  int? id;
  String?name;
  String?image;

  DataModell.fromJason(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}