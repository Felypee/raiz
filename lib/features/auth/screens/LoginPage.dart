import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:raiz/features/auth/controller/AuthController.dart';
import 'package:raiz/features/common/widgets/primary_button.dart';
import 'package:raiz/utils/assets_path.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _loginFormKey = GlobalKey<FormBuilderState>();
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: FormBuilder(
        key: _loginFormKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: size.height * 0.20,
              ),
              Transform.scale(
                  scale: 2,
                  child: Lottie.asset(chill, height: size.height * 0.20)),
              SizedBox(
                height: size.height * 0.1,
              ),
              FormBuilderTextField(
                name: "email",
                decoration: const InputDecoration(hintText: "Email"),
                onChanged: (value) => email = value,
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              FormBuilderTextField(
                name: "password",
                decoration: const InputDecoration(hintText: "Password"),
                onChanged: (value) => password = value,
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              PrimaryButton(
                  title: "Log in",
                  onPressed: () {
                    if (_loginFormKey.currentState?.saveAndValidate() ??
                        false) {
                      ref
                          .read(authControllerProvider.notifier)
                          .login(context, email: email!, password: password!);
                    }
                  }),
              SizedBox(
                height: size.height * 0.05,
              ),
              GestureDetector(
                child: const Text("Don't you have an account?"),
                onTap: () => context.go("/signUp"),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
