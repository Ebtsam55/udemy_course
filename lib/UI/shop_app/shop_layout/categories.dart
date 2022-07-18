import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/shopApp/home/shop_home_cubit.dart';
import 'package:news_app/cubit/shopApp/home/shop_home_state.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: ShopCubit.get(context).categoriesModel != null,
            builder: (context) => ListView.separated(
                itemCount: ShopCubit.get(context)
                        .categoriesModel
                        ?.data
                        ?.data
                        ?.length ??
                    0,
                scrollDirection: Axis.vertical,
                separatorBuilder: (_, __) => const SizedBox(
                      width: 10,
                    ),
                itemBuilder: (context, index) => _buildCategoryItem(
                    context,
                    ShopCubit.get(context)
                            .categoriesModel
                            ?.data
                            ?.data?[index]
                            .image ??
                        '',
                    ShopCubit.get(context)
                            .categoriesModel
                            ?.data
                            ?.data?[index]
                            .name ??
                        '')),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Widget _buildCategoryItem(BuildContext context, String image, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
              fit: BoxFit.cover,
              width: 100,
              height: 100,
              image: NetworkImage(image)),
          const SizedBox(
            width: 10,
          ),
          Text(
            name,
            style: Theme.of(context).textTheme.bodyText1,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
