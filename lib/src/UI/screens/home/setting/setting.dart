import 'package:flutter/material.dart';
import 'package:shop2/src/UI/Style/consts.dart';
import 'package:shop2/src/UI/widgets/default_text_form_widget.dart';
import 'package:shop2/src/UI/widgets/default_form_button.dart';
import 'package:shop2/src/UI/widgets/toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shop2/src/cubit/auth_cubit/cubit.dart';
import 'package:shop2/src/cubit/auth_cubit/state.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController(
        text: ShopCubit.get(context).userModel.userData!.email);
    TextEditingController nameController = TextEditingController(
        text: ShopCubit.get(context).userModel.userData!.name);
    TextEditingController phoneController = TextEditingController(
        text: ShopCubit.get(context).userModel.userData!.phone);

    var formKey = GlobalKey<FormState>();
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if (state is UpdateErrorState) {
          defaultToast(
            msg: ShopCubit.get(context).userModel.message,
            state: toastStates.error,
          );
        }
        if (state is UpdateSuccessState) {
          if (state.userModel!.status) {
            defaultToast(
              msg: ShopCubit.get(context).userModel.message,
              state: toastStates.success,
            );
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel.userData!.token.isNotEmpty,
          builder: (context) => Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(spacerHeight),
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(height: spacerHeight),
                    // Image(
                    //   image: NetworkImage(
                    //     ShopCubit.get(context).userModel.userData!.image,
                    //   ),
                    // ),
                    const SizedBox(height: spacerHeight),
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
                    // const SizedBox(height: spacerHeight),
                    // DefaultTextFormField(
                    //   obscureText: false,
                    //   keyboardType: TextInputType.number,
                    //   controller: passwordController,
                    //   validator: (value) {
                    //     if (value.isEmpty) {
                    //       return 'password is required, please enter your password';
                    //     }
                    //   },
                    //   hintText: 'password',
                    //   prefixIcon: Icons.password,
                    // ),
                    const SizedBox(height: spacerHeight),
                    SizedBox(
                      width: double.infinity,
                      height: btnHeight,
                      child: DefaultFormButton(
                        text: 'update'.toUpperCase(),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ShopCubit.get(context).updateSettingsData(
                              email: emailController.text,
                              // password: passwordController.text,
                              phone: phoneController.text,
                              name: nameController.text,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }
}
