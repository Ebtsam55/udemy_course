import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/news_app/news_cubit.dart';
import '../../cubit/news_app/news_state.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
              controller: controller,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                NewsCubit.get(context).getSearchResult(value);
              },
              decoration: const InputDecoration(
                  labelText: 'search', prefixIcon: Icon(Icons.search))),
          Expanded(
            child: BlocConsumer<NewsCubit, NewsState>(
                buildWhen: (_, state) => state is GettingSearchResultSuccess,
                listener: (_, __) {},
                builder: (context, __) {
                  return ListView.separated(
                      separatorBuilder: (ctx, index) => const Divider(),
                      itemBuilder: (ctx, index) => ListTile(
                          leading: (NewsCubit.get(context).searchResult[index]
                                      ['urlToImage'] !=
                                  null)
                              ? Image.network(
                                  NewsCubit.get(context).searchResult[index]
                                      ['urlToImage'],
                                  fit: BoxFit.cover,
                                  width: 60,
                                  height: 60,
                                )
                              : Container(
                                  width: 60,
                                  color: Colors.grey,
                                  height: 60,
                                ),
                          title: Text(
                            NewsCubit.get(context).searchResult[index]['title'],
                            style: Theme.of(context).textTheme.bodyText1,
                          )),
                      itemCount: NewsCubit.get(context).searchResult.length,

                  );
                }),
          )
        ],
      ),
    );
  }
}
