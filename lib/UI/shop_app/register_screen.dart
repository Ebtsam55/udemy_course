import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/UI/shop_app/register_screen.dart';
import 'package:news_app/UI/shop_app/shop_layout/shop_layout.dart';
import 'package:news_app/cubit/shopApp/auth/auth_cubit.dart';
import 'package:news_app/cubit/shopApp/auth/auth_state.dart';
import 'package:news_app/network/cache_helper.dart';
import 'package:news_app/widgets/common/components.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AuthCubit>(
        create: (_) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthStates>(
          listener: (_, state) {
            if (state is RegisterSuccessState) {
              if (state.model.status??false) {
                CacheHelper.putData(
                        key: 'token', value: state.model.data?.token)
                    .then((value) => {
                          if (value)
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (ctx) => ShopLayout()))
                        });
              } else {
                showToast(msg: state.model.message??'', state: ToastState.ERROR);
              }
            }

            if (state is RegisterErrorState) {
              showToast(msg: state.error, state: ToastState.ERROR);
            }
          },
          builder: (context, state) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Register",
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).textTheme.bodyText1?.color),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    defaultFormField(
                        controller: _nameController,
                        type: TextInputType.name,
                        validate: (value) {
                          return (value?.isEmpty ?? false)
                              ? "Name Required "
                              : null;
                        },
                        label: 'Name',
                        prefix: Icons.person),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                        controller: _phoneController,
                        type: TextInputType.phone,
                        validate: (value) {
                          return (value?.isEmpty ?? false)
                              ? "Phone Required "
                              : null;
                        },
                        label: 'Phone Address',
                        prefix: Icons.phone),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                        controller: _emailController,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          return (value?.isEmpty ?? false)
                              ? "Email Required "
                              : null;
                        },
                        label: 'Email Address',
                        prefix: Icons.email_outlined),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                        isPassword: AuthCubit.get(context).isPasswordShown,
                        suffix: AuthCubit.get(context).passSuffixIcon,
                        suffixPressed: () =>
                            AuthCubit.get(context).changePasswordVisibility(),
                        controller: _passController,
                        type: TextInputType.visiblePassword,
                        validate: (value) {
                          return (value?.isEmpty ?? false)
                              ? "Password is too short "
                              : null;
                        },
                        label: 'Password',
                        prefix: Icons.lock_outline),
                    const SizedBox(
                      height: 30,
                    ),
                    defaultButton(
                        isLoading: state is RegisterLoadingState,
                        function: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            AuthCubit.get(context).register(
                                name: _nameController.text,
                                phone: _phoneController.text,
                                email: _emailController.text,
                                pass: _passController.text);
                          }
                        },
                        text: "register"),


                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
