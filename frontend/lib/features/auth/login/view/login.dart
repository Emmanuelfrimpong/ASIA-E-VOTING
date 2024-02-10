import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/config/responsiveness/responsive.dart';
import 'package:frontend/core/widgets/custom_button.dart';
import 'package:frontend/core/widgets/custom_input.dart';
import 'package:frontend/utils/styles.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var resp = ResponsiveUI(context: context);
    return Scaffold(
        backgroundColor: secondaryColor.withOpacity(0.2),
        body: Center(
            child: resp.getResponsiveWidget(
                mobile: buildMobile(context), desktop: buildDesktop(context))));
  }

  Widget buildMobile(BuildContext context) {
    return Text(
      'Login Page on mobile',
      style: getTextStyle(),
    );
  }

  Widget buildDesktop(BuildContext context) {
    var resp = ResponsiveUI(context: context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          elevation: 10,
          child: SizedBox(
            width: resp.isDesktop()
                ? resp.getScreenWidth() * 0.5
                : resp.getScreenWidth() * .7,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 600,
                    color: primaryColor,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          // width: 500,
                        ),
                        Text(
                          'Crypto Polls'.toUpperCase(),
                          style: getTextStyle(
                              size: 45,
                              color: Colors.white,
                              weight: FontWeight.bold,
                              wordSpacing: 2,
                              letterSpacing: 1.5,
                              height: 1.5),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    height: 600,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 50),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('LOGIN',
                              style: getTextStyle(
                                  size: 35,
                                  letterSpacing: 2,
                                  weight: FontWeight.bold,
                                  color: primaryColor)),
                          const Divider(
                            height: 2,
                            thickness: 5,
                            endIndent: 20,
                            indent: 20,
                            color: primaryColor,
                          ),
                          const SizedBox(height: 60),
                          buildForm(context),
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const CustomTextFields(
            label: 'User ID',
            hintText: 'Enter your user ID',
            prefixIcon: Icons.person,
          ),
          const SizedBox(height: 30),
          CustomTextFields(
              label: 'Password',
              hintText: 'Enter your password',
              prefixIcon: Icons.lock,
              obscureText: _obscureText,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: const Icon(Icons.visibility),
              )),
          const SizedBox(height: 45),
          CustomButton(
            onPressed: () {},
            text: 'Login',
            icon: Icons.login,
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {},
            child: const Text('Forgot Password?'),
          ),
        ],
      ),
    );
  }
}
