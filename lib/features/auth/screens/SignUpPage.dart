import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:raiz/features/auth/controller/AuthController.dart';
import 'package:raiz/features/common/widgets/primary_button.dart';
import 'package:raiz/utils/assets_path.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: FormBuilder(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: size.height * 0.20,
              ),
              Transform.scale(
                  scale: 1.5,
                  child: Lottie.asset(chill2, height: size.height * 0.20)),
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
                  title: "Sign up",
                  onPressed: () {
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      ref
                          .read(authControllerProvider.notifier)
                          .signUp(context, email: email!, password: password!);
                    }
                  }),
              SizedBox(
                height: size.height * 0.05,
              ),
              GestureDetector(
                onTap: (() => context.go("/")),
                child: const Text("Already have an account?"),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
