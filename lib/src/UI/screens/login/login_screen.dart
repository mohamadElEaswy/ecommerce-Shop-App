import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop2/src/UI/Style/consts.dart';
import 'package:shop2/src/UI/widgets/default_text_form_widget.dart';
import 'package:shop2/src/UI/widgets/default_form_button.dart';
import 'package:shop2/src/UI/widgets/toast.dart';
import 'package:shop2/src/core/route/const_route_functions.dart';
import 'package:shop2/src/cubit/home_screen_cubit/cubit.dart';
import 'package:shop2/src/cubit/home_screen_cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          defaultToast(
            msg: ShopCubit.get(context).userModel.message,
            state: toastStates.error,
          );
        }
        if (state is LoginSuccessState) {
          if (state.userModel.status) {
            defaultToast(
              msg: ShopCubit.get(context).userModel.message,
              state: toastStates.success,
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(spacerHeight),
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LOG IN',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const Text('welcome Back again...'),
                    const SizedBox(height: spacerHeight),
                    DefaultTextFormField(
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'email is required, please enter your email';
                        }
                      },
                      hintText: 'email',
                      prefixIcon: Icons.email,
                    ),
                    const SizedBox(height: spacerHeight),
                    DefaultTextFormField(
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      controller: passwordController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'password is required, please enter your password';
                        }
                      },
                      hintText: 'password',
                      prefixIcon: Icons.password,
                    ),
                    const SizedBox(height: spacerHeight),
                    SizedBox(
                      width: double.infinity,
                      height: btnHeight,
                      child: DefaultFormButton(
                        text: 'LogIn'.toUpperCase(),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ShopCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                              context: context,
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: spacerHeight),
                    const Center(child: Text('or')),
                    const SizedBox(height: spacerHeight),
                    SizedBox(
                      width: double.infinity,
                      height: btnHeight,
                      child: DefaultFormButton(
                        text: 'register'.toUpperCase(),
                        onPressed: () {
                          navigateAndRemove(
                              context: context, newRouteName: '/register');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
