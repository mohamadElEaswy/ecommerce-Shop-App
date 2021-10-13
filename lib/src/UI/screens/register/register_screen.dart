import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop2/src/UI/Style/consts.dart';
import 'package:shop2/src/UI/widgets/default_text_form_widget.dart';
import 'package:shop2/src/UI/widgets/default_form_button.dart';
import 'package:shop2/src/UI/widgets/toast.dart';
import 'package:shop2/src/core/route/const_route_functions.dart';
import 'package:shop2/src/cubit/home_screen_cubit/cubit.dart';
import 'package:shop2/src/cubit/home_screen_cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


final TextEditingController passwordController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController phoneController = TextEditingController();

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if (state is RegisterErrorState) {
          defaultToast(
            msg: ShopCubit.get(context).userModel.message,
            state: toastStates.error,
          );
        }
        if (state is RegisterSuccessState) {
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
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(spacerHeight),
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Register',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const Text('welcome ...'),
                  const SizedBox(height: spacerHeight),
                  DefaultTextFormField(
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    controller: nameController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'name is required, please enter your name';
                      }
                    },
                    hintText: 'name',
                    prefixIcon: Icons.person,
                  ),
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
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'phone number is required, please enter your phone number';
                      }
                    },
                    hintText: 'phone',
                    prefixIcon: Icons.phone,
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
                      text: 'register now'.toUpperCase(),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.get(context).userRegister(
                            email: emailController.text,
                            password: passwordController.text,
                            phone: phoneController.text,
                            name: nameController.text,
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
                      text: 'LogIn with your account'.toUpperCase(),
                      onPressed: () {
                        navigateAndRemove(
                            context: context, newRouteName: '/login');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
