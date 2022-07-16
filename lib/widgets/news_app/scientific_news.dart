import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/news_app/news_cubit.dart';
import '../../cubit/news_app/news_state.dart';
class ScientificNews extends StatelessWidget {
  const ScientificNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
        buildWhen: (_, state) => state is GettingScienceNewsSuccess,
        listener: (_, __) {},
        builder: (context, __) {
          return ConditionalBuilder(
            condition: NewsCubit.get(context).science.isEmpty,
            builder: (context) =>
            const Center(child: CircularProgressIndicator()),
            fallback: (context) => ListView.separated(
              separatorBuilder: (ctx, index) => const Divider(),
              itemBuilder: (ctx, index) => ListTile(
                  leading: (NewsCubit.get(context).science[index]
                  ['urlToImage'] !=
                      null)
                      ? Image.network(
                    NewsCubit.get(context).science[index]['urlToImage'],
                    fit: BoxFit.cover,
                    width: 60,
                    height: 60,
                  )
                      : Container(
                    width: 60,
                    color: Colors.grey,
                    height: 60,
                  ),
                  title: Text(NewsCubit.get(context).science[index]['title'], style: Theme.of(context).textTheme.bodyText1)),
              itemCount: NewsCubit.get(context).science.length,
            ),
          );
        });
  }
}
