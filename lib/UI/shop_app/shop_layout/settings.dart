import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/UI/shop_app/login_screen.dart';
import 'package:news_app/cubit/shopApp/home/shop_home_cubit.dart';
import 'package:news_app/cubit/shopApp/home/shop_home_state.dart';
import 'package:news_app/model/shop_models/login_models.dart';
import 'package:news_app/network/cache_helper.dart';
import 'package:news_app/widgets/common/components.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    ShopCubit.get(context).getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          LoginModel? userModel = ShopCubit.get(context).userDataModel;
          _nameController.text = userModel?.data?.name ?? '';
          _emailController.text = userModel?.data?.email ?? '';
          _phoneController.text = userModel?.data?.phone ?? '';
          return Scaffold(
            body: SingleChildScrollView(
              child: ConditionalBuilder(
                condition: ShopCubit.get(context).userDataModel != null,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildUserData(),
                        const SizedBox(
                          height: 24,
                        ),
                        defaultButton(
                            function: () {
                              ShopCubit.get(context).updateUserData(
                                  _nameController.text,
                                  _emailController.text,
                                  _phoneController.text);
                            },
                            text: 'update',
                            isLoading: state is UpdateUserDataLoadingState),
                        const SizedBox(
                          height: 24,
                        ),
                        defaultButton(
                            function: () {
                              CacheHelper.removeData(key: 'token').then((value) {
                                if (value) {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (ctx) => const LoginScreen()));
                                }
                              });
                            },
                            text: 'Logout')
                      ],
                    ),
                  );
                },
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          );
        });
  }

  Widget _buildUserData() {
    return Column(
      children: [
        defaultFormField(
            controller: _nameController,
            type: TextInputType.name,
            validate: (value) {
              if (value?.isEmpty ?? true) {
                return 'Name required ';
              } else {
                return null;
              }
            },
            label: 'name',
            prefix: Icons.person),
        const SizedBox(
          height: 16,
        ),
        defaultFormField(
            controller: _emailController,
            type: TextInputType.emailAddress,
            validate: (value) {
              if (value?.isEmpty ?? true) {
                return 'Email required ';
              } else {
                return null;
              }
            },
            label: 'Email',
            prefix: Icons.email),
        const SizedBox(
          height: 16,
        ),
        defaultFormField(
            controller: _phoneController,
            type: TextInputType.phone,
            validate: (value) {
              if (value?.isEmpty ?? true) {
                return 'Phone required ';
              } else {
                return null;
              }
            },
            label: 'Phone',
            prefix: Icons.phone),
      ],
    );
  }
}
