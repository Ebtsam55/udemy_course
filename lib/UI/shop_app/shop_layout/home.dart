import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/shopApp/home/shop_home_cubit.dart';
import 'package:news_app/cubit/shopApp/home/shop_home_state.dart';
import 'package:news_app/model/shop_models/categories_model.dart';
import 'package:news_app/network/shop_data_model.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).categoriesModel != null,
            builder: (context) => _buildHomeData(
                homeModel: ShopCubit.get(context).homeModel,
                categoriesModel: ShopCubit.get(context).categoriesModel),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Widget _buildHomeData(
      {HomeModel? homeModel, CategoriesModel? categoriesModel}) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: homeModel?.data.banners
                  .map((element) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: NetworkImage(element.image),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                  height: 250,
                  reverse: false,
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  viewportFraction: 1,
                  initialPage: 0,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(seconds: 3)),
            ),
            const SizedBox(
              height: 10,
            ),
            _buildCategoriesSection(categoriesModel),
            const SizedBox(
              height: 10,
            ),
            _buildProductsSection(homeModel?.data.products),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(CategoriesModel? categoriesModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Categories",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 150,
          child: ListView.separated(
              itemCount: categoriesModel?.data?.data?.length ?? 0,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, __) => const SizedBox(
                    width: 10,
                  ),
              itemBuilder: (context, index) => _buildCategoryItem(
                  categoriesModel?.data?.data?[index].image ?? '',
                  categoriesModel?.data?.data?[index].name ?? '')),
        )
      ],
    );
  }

  Widget _buildCategoryItem(String image, String name) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
            fit: BoxFit.cover,
            width: 120,
            height: 150,
            image: NetworkImage(image)),
        Container(
          padding: const EdgeInsets.all(5),
          width: 120,
          color: Colors.black54,
          child: Text(
            name,
            style: const TextStyle(fontSize: 14, color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }

  Widget _buildProductsSection(List<ProductModel>? products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Products",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          children: products?.map((e) => _buildProductItem(e)).toList() ?? [],
          childAspectRatio: 1 / 1.6,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        )
      ],
    );
  }

  Widget _buildProductItem(ProductModel product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(product.image),
                height: 200,
                width: double.infinity,
              ),
              if (product.discount != 0)
                Container(
                  color: Colors.red,
                  child: const Padding(
                    padding: EdgeInsets.all(2),
                    child: Text(
                      "DISCOUNT",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14),
          ),
          Row(
            children: [
              Text(
                '${product.price}',
                style: const TextStyle(color: Colors.blueAccent),
              ),
              const SizedBox(
                width: 10,
              ),
              if (product.discount != 0)
                Text(
                  '${product.oldPrice}',
                  style: const TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough),
                ),
              const Spacer(),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.favorite_border))
            ],
          )
        ],
      ),
    );
  }
}
