

import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import '../models/user.dart';
import 'dart:developer';

class AuthProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> login(String email, String password) async {
    try {
      _user = await FirebaseService.signIn(email, password);
      notifyListeners();
    } catch (e) {
      _user = null;
      log(e.toString());
      rethrow;
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      _user = await FirebaseService.signUp(name, email, password);
      notifyListeners();
    } catch (e) {
      _user = null;
      log(e.toString());
      rethrow;
    }
  }

  Future<void> signOut() async {
    await FirebaseService.signOut();
    _user = null;
    notifyListeners();
  }
}
