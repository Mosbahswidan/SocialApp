



import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/layout/shop_app/cubit/cubit.dart';
import 'package:proj1/layout/shop_app/cubit/states.dart';
import 'package:proj1/models/shop_app/home_model.dart';

import '../../../models/shop_app/categories_model.dart';

class productsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state){},
      builder: (context, state)
      {
      return ConditionalBuilder(
         condition: ShopCubit.get(context).homeModel !=null && ShopCubit.get(context).categoriesModel!=null,
         builder: (context) =>productsBuilder(ShopCubit.get(context).homeModel!,ShopCubit.get(context).categoriesModel!,context) ,
         fallback: (context)=>Center(child: CircularProgressIndicator()),
       );
      },
    );
  }

  Widget productsBuilder(HomeModel model,CategoriesModel categoriesModel,context)=>SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items: model.data!.banners.map((e) => Image(
              image: NetworkImage(
                '${e.image}',
              ),
              width: double.infinity,
              fit: BoxFit.cover,
            )).toList(),
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              reverse: false,
              autoPlay: true,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,


            )
        ),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Container(
                height: 100,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    itemBuilder:(context, index) => buildCategoryItem(categoriesModel.data!.data[index]),
                    separatorBuilder:(context,index)=>SizedBox(width: 10,),
                    itemCount: categoriesModel.data!.data.length,
                ),
              ),
              Text(
                'New Products',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1/1.57,
            children: List.generate(
                model.data!.products.length,
                    (index) =>BuildGridPeoduct(model.data!.products[index],context),
            ),
          ),
        ),
      ],
    ),
  );


  Widget BuildGridPeoduct(ProductModel model,context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(
                model.image!,
              ),
            width: double.infinity,
              height: 200,
            ),
            if(model.discount!=0)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white
                  ),
                ),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    'price: ${model.price.round()}'
                  ),
                  Spacer(),
                  IconButton(onPressed: (){
                    ShopCubit.get(context).changeFavourits(model.id!);

                  }, icon: Icon(Icons.favorite_border_outlined),
                  color: ShopCubit.get(context).favourits[model.id]==true?Colors.red:Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget buildCategoryItem(DataModell model) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage(model.image!),
        height: 100.0,
        width: 100.0,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(
          .8,
        ),
        width: 100.0,
        child: Text(
          model.name!,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}
