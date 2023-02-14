import 'package:fpdart/fpdart.dart';
import 'package:raiz/features/user/models/UserRaiz.dart';

abstract class AuthRepo {
  Future<Either<String, String>> signUp(
      {required String email, required String password});

  Future<Either<UserRaiz, String>> login(
      {required String email, required String password});

  Stream<UserRaiz?> listenToAuthStateChanges();

  Future<void> confirmUser();

  Future<void> logOut();
}
