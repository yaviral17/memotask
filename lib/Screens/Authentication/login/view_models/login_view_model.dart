import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memotask/Firestore/firestore_collections_and_documents.dart';
import 'package:memotask/Models/usermodel.dart';
import 'package:memotask/Screens/Home/main_navigator.dart';
import 'package:memotask/components/snakbars.dart';
import 'package:memotask/main.dart';

class LoginViewModel extends ChangeNotifier {
  String _email = '';
  String _password = '';
  bool _isLoading = false;
  UserModel? _loggedInUser;

  String get email => _email;
  String get password => _password;
  bool get isLoading => _isLoading;
  UserModel? get loggedInUser => _loggedInUser;

  void getLoggedInUser({bool forced = false}) async {
    if (_loggedInUser != null && !forced) {
      return;
    }
    _loggedInUser =
        await FirestoreRefrence.getUser(FirebaseAuth.instance.currentUser!.uid);
    notifyListeners();
  }

  void setEmail(String email) {
    if (email == _email) return;
    if (email.isEmpty) return;
    _email = email;
  }

  void setPassword(String password) {
    if (password == _password) return;
    if (password.isEmpty) return;
    _password = password;
  }

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<bool> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    setIsLoading(true);
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      log(credential.user!.email!);
      setIsLoading(false);
      showSuccessSnackBar(
          NavigationService.navigatorKey.currentContext!, 'Login Successful');
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const MainNavigator()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showErrorSnackBar(NavigationService.navigatorKey.currentContext!,
            'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showErrorSnackBar(NavigationService.navigatorKey.currentContext!,
            'Wrong password provided for that user.');
      }
    } catch (e) {
      log(e.toString());
      showErrorSnackBar(
          NavigationService.navigatorKey.currentContext!, 'An error occurred');
    }
    setIsLoading(false);
    return false;
  }
}
