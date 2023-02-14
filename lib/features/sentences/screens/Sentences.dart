import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:raiz/features/auth/controller/AuthController.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(actions: [
        InkWell(
            onTap: (() => ref.read(authControllerProvider.notifier).logOut()),
            child: Icon(Icons.logout))
      ]),
      body: Container(child: Text("home")),
    );
  }
}
