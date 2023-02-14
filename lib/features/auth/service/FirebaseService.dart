import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/src/either.dart';
import 'package:raiz/features/auth/repository/AuthRepo.dart';
import 'package:raiz/features/user/models/UserRaiz.dart';

final firebaseProvider = Provider(((ref) => FirebaseService()));

class FirebaseService extends AuthRepo {
  @override
  Future<Either<String, String>> signUp(
      {required String email, required String password}) async {
    try {
      await Amplify.Auth.signUp(
        username: email,
        password: password,
      );
      return left("");
    } catch (e) {
      return right(e.toString());
    }
  }

  @override
  Future<Either<UserRaiz, String>> login(
      {required String email, required String password}) async {
    try {
      await Amplify.Auth.signIn(
        username: email,
        password: password,
      );

      final awsUser = await Amplify.Auth.getCurrentUser();

      UserRaiz user = UserRaiz(
          id: awsUser.userId,
          token: "",
          name: "",
          email: email,
          profilePicture:
              "https://imgs.search.brave.com/3VuAtBalFgTr818B9fEFe151eK-ibcVnHr2t_H-WhQc/rs:fit:332:332:1/g:ce/aHR0cHM6Ly93d3cu/c29mdHpvbmUuZXMv/YXBwL3VwbG9hZHMt/c29mdHpvbmUuZXMv/MjAxOC8wNC9ndWVz/dC0zMzJ4MzMyLnBu/Zw");
      return left(user);
    } catch (e) {
      return right(e.toString());
    }
  }

  @override
  Stream<UserRaiz?> listenToAuthStateChanges() async* {
    StreamController<UserRaiz?> controller = StreamController();
    final result = Amplify.Hub.listen([HubChannel.Auth], ((event) {}));
    result.onData((event) async {
      switch (event.eventName) {
        case 'SIGNED_IN':
          final awsUser = await Amplify.Auth.getCurrentUser();
          UserRaiz user = UserRaiz(
              id: awsUser.userId,
              token: "",
              name: "",
              email: awsUser.username,
              profilePicture:
                  "https://imgs.search.brave.com/3VuAtBalFgTr818B9fEFe151eK-ibcVnHr2t_H-WhQc/rs:fit:332:332:1/g:ce/aHR0cHM6Ly93d3cu/c29mdHpvbmUuZXMv/YXBwL3VwbG9hZHMt/c29mdHpvbmUuZXMv/MjAxOC8wNC9ndWVz/dC0zMzJ4MzMyLnBu/Zw");
          controller.sink.add(user);
          controller.close();
          break;
        default:
          break;
      }
    });

    yield await controller.stream.last;
  }

  @override
  Future<void> logOut() async {
    await Amplify.Auth.signOut();
  }

  @override
  Future<void> confirmUser() async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
          username: 'myusername', confirmationCode: '123456');
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }
}
