import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:raiz/features/auth/screens/LoginPage.dart';
import 'package:raiz/features/auth/screens/SignUpPage.dart';
import 'package:raiz/features/sentences/screens/Sentences.dart';

final GoRouter loggedOutRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'signUp',
          builder: (BuildContext context, GoRouterState state) {
            return const SignUpPage();
          },
        ),
      ],
    ),
  ],
);

final GoRouter signedInRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Home();
      },
    ),
  ],
);
