import 'package:flutter/material.dart';
import 'package:shop2/src/UI/widgets/default_text_form_widget.dart';
import 'package:shop2/src/UI/widgets/defualt_form_button.dart';



class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  var formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'LOG IN',
                  style: Theme.of(context).textTheme.headline3,
                ),
                const Text('welcome Back again...'),
                const SizedBox(height: 20.0),
                DefaultTextFormField(
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (value) {
                    if (value.isEmpty) {return 'email is required, please enter your email';}
                  },
                  hintText: 'email',
                  prefixIcon: Icons.email,
                ),
                const SizedBox(height: 10.0),
                DefaultTextFormField(
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  controller: passwordController,
                  validator: (value) {
                    if (value.isEmpty) {return 'password is required, please enter your password';}
                  },
                  hintText: 'password',
                  prefixIcon: Icons.password,
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: DefaultFormButton(text: 'LogIn'.toUpperCase(),onPressed: (){
                      if(formKey.currentState!.validate()){print('validated');}else{print('not validated');}
                    },)),
                    const SizedBox(width: 10.0,),
                    const Text('or'),const SizedBox(width: 10.0,),
                    Expanded(child: DefaultFormButton(text: 'register'.toUpperCase(),onPressed: (){},)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

