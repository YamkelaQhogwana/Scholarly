import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerWithEmailAndPassword(
      String email, String password, String displayName) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,

      );

      User? user = _auth.currentUser;
      if (user != null) {
        await user.updateDisplayName(displayName);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw RegistrationException(
            'weak-password', 'The password provided is too weak.', e);
      } else if (e.code == 'email-already-in-use') {
        throw RegistrationException(
            'email-already-in-use',
            'The account already exists for that email.',
            e);
      } else {
        throw RegistrationException(
            'unknown', 'Registration failed. Error: ${e.code}', e);
      }
    } on Exception catch (e) {
      throw RegistrationException(
          'unknown', 'Registration failed. Error: $e', e);
    }
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print(email);

      print('Login successful'); // Add this print statement
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        throw LoginException('Incorrect email or password.');
      } else {
        throw LoginException('Login failed. Please try again.');
      }
    } catch (e) {
      throw LoginException('Login failed. Please try again.');
    }
  }

  Future<void> updateDisplayName(String displayName) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updateDisplayName(displayName);
      }
    } catch (e) {
      throw UpdateDisplayNameException('Failed to update display name.');
    }
  }
}

class RegistrationException implements Exception {
  final String code;
  final String message;
  final Object exception;

  RegistrationException(this.code, this.message, this.exception);
}

class LoginException implements Exception {
  final String message;

  LoginException(this.message);
}

class UpdateDisplayNameException implements Exception {
  final String message;

  UpdateDisplayNameException(this.message);
}
