import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:memotask/Firestore/firestore_collections_and_documents.dart';
import 'package:memotask/Models/usermodel.dart';
import 'package:memotask/components/snakbars.dart';

class SignUpViewModel extends ChangeNotifier {
  String _name = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _isLoading = false;

  String get name => _name;
  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  bool get isLoading => _isLoading;

  void setName(String name) {
    if (name == _name) return;
    if (name.isEmpty) return;
    _name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    if (email == _email) return;
    if (email.isEmpty) return;
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    if (password == _password) return;
    if (password.isEmpty) return;
    _password = password;
    notifyListeners();
  }

  void setConfirmPassword(String confirmPassword) {
    if (confirmPassword == _confirmPassword) return;
    if (confirmPassword.isEmpty) return;
    _confirmPassword = confirmPassword;
    notifyListeners();
  }

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<bool> signUp({
    required BuildContext context,
  }) async {
    if (_name.isEmpty) {
      showErrorSnackBar(context, "Name cannot be empty");
      return false;
    }
    if (_email.startsWith('@') ||
        _email.endsWith('@') ||
        _email.startsWith('.') ||
        _email.endsWith('.') ||
        !_email.contains('@')) {
      showErrorSnackBar(context, "Invalid Email Address");
      return false;
    }
    if (_password.length < 8) {
      showErrorSnackBar(context, "Password must be at least 8 characters");
      return false;
    }
    if (_password != _confirmPassword) {
      showErrorSnackBar(context, "Password does not match");
      return false;
    }

    setIsLoading(true);
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _email.trim(),
        password: _password,
      )
          .then((value) async {
        await FirebaseAuth.instance.currentUser!
            .updateDisplayName(_name.trim());
      });

      // log(user.toString());
      // await FirebaseFirestore.instance.collection('users').add(user.toJson());
      // showSuccessSnackBar(context, 'Account created successfully');
      // Navigator.of(context).pop();
      setIsLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showErrorSnackBar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showErrorSnackBar(context, 'Wrong password provided for that user.');
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
