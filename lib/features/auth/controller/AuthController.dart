import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:raiz/features/auth/service/FirebaseService.dart';
import 'package:raiz/features/common/widgets/Error.dart';
import 'package:raiz/features/auth/repository/AuthRepo.dart';
import 'package:raiz/features/user/models/UserRaiz.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
    ((ref) => AuthController(ref.watch(firebaseProvider))));
final userChanges = StreamProvider(
    ((ref) => ref.watch(authControllerProvider.notifier).authStateChanges));

class AuthController extends StateNotifier<bool> {
  final AuthRepo service;

  AuthController(this.service) : super(false);

  Stream<UserRaiz?> get authStateChanges => service.listenToAuthStateChanges();

  void signUp(BuildContext context,
      {required String email, required String password}) async {
    state = true;
    final result = await service.signUp(email: email, password: password);
    state = false;
    result.fold((l) {}, (r) {
      showError(context, r);
    });
  }

  void login(BuildContext context,
      {required String email, required String password}) async {
    state = true;
    final result = await service.login(email: email, password: password);
    state = false;
    result.fold((l) {}, (r) {
      showError(context, r);
    });
  }

  void logOut() async {
    state = true;
    await service.logOut();
    state = false;
  }
}
