import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/models/shop_app/favourties_model.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../sahred/component/component.dart';

class favouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return ConditionalBuilder(
          condition: state is !ShopLoadingGetFavourite,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildFavItem(ShopCubit.get(context).favoriteModel!.data!.data![index].product!, context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: ShopCubit.get(context).favoriteModel!.data!.data!.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }


}
