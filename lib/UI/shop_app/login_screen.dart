import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/UI/shop_app/register_screen.dart';
import 'package:news_app/UI/shop_app/shop_layout/shop_layout.dart';
import 'package:news_app/cubit/shopApp/auth/auth_cubit.dart';
import 'package:news_app/cubit/shopApp/auth/auth_state.dart';
import 'package:news_app/network/cache_helper.dart';
import 'package:news_app/widgets/common/components.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider<AuthCubit>(
        create: (_) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthStates>(
          listener: (_, state) {
            if (state is LoginSuccessState) {
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

            if (state is LoginErrorState) {
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
                      "Login",
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).textTheme.bodyText1?.color),
                    ),
                    const SizedBox(
                      height: 30,
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
                        isLoading: state is LoginLoadingState,
                        function: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            AuthCubit.get(context).login(
                                email: _emailController.text,
                                pass: _passController.text);
                          }
                        },
                        text: "Login"),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account ? ",
                          style: TextStyle(fontSize: 16),
                        ),
                        defaulTextButton(
                            function: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => RegisterScreen()));
                            },
                            text: "Register")
                      ],
                    )
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
