import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'onboarding.dart';

final Auth _auth = Auth();
final CollectionReference _usersCollection =
    FirebaseFirestore.instance.collection('users');
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isSigningUp = false;
  final TextEditingController _fullNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';
  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$',
    );
    return emailRegex.hasMatch(email);
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Insert user data into Firestore collection
        await _usersCollection.doc(user.uid).set({
          'email': user.email,
          'fname': user.displayName,
          'pauseNotifications': true,
          'habitNotifications': 0,
          'streakNotifications': 0,
          'taskNotifications': 0,
          'institution': 'Eduvos',
          'campus': 'Bedfordview',
          'year': '3',
          'course': 'Software Engineering',
          'icon': 'images/avatars/black-wn-av.png',
          'hasSeenOnboarding': false
        });

        // Navigate to the onboarding page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OnboardingPage()),
        );
      } else {
        // Google sign-in failed, handle the error
      }
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }

  void _registerWithEmailAndPassword() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final fullName = _fullNameController.text;
    final displayName = fullName;

    if (password != confirmPassword) {
      setState(() {
        _errorMessage = 'Passwords do not match.';
      });
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSigningUp = true; // Start the loading indicator
      _errorMessage = ''; // Clear any previous error message
    });

    try {
      // Check if the email is already in use
      final existingUser =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);
      if (existingUser.isNotEmpty) {
        setState(() {
          _errorMessage =
              'Email is already in use. Please use a different email address.';
          _isSigningUp = false; // Stop the loading indicator
        });
        return;
      }

      await _auth.registerWithEmailAndPassword(email, password, displayName);

      // Insert user data into Firestore collection
      await _usersCollection.add({
        'email': email,
        'fname': fullName,
        'pauseNotifications': true,
        'habitNotifications': 0,
        'streakNotifications': 0,
        'taskNotifications': 0,
        'institution': 'Eduvos',
        'campus': 'Bedfordview',
        'year': '3',
        'course': 'Software Engineering',
        'icon': 'images/avatars/black-wn-av.png',
        'hasSeenOnboarding': false
      });

      // Registration successful, navigate to the onboarding page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } on RegistrationException catch (e) {
      setState(() {
        _errorMessage = _getErrorMessage(e);
      });
    } catch (e) {
      print('Unknown error: $e');
      setState(() {
        _errorMessage = 'Registration failed. Please try again later.';
      });
    } finally {
      setState(() {
        _isSigningUp = false; // Stop the loading indicator
      });
    }
  }

  String _getErrorMessage(RegistrationException exception) {
    if (exception.exception is FirebaseAuthException) {
      final FirebaseAuthException firebaseException =
          exception.exception as FirebaseAuthException;
      switch (firebaseException.code) {
        case 'email-already-in-use':
          return 'Email already exists. Please use a different email address.';
        case 'weak-password':
          return 'Weak password. Please choose a stronger password.';
        case 'invalid-email':
          return 'The email address is invalid.';
        default:
          return 'Registration failed. Please try again later.';
      }
    } else if (exception.exception is FirebaseException) {
      final FirebaseException firebaseException =
          exception.exception as FirebaseException;
      if (firebaseException.code == 'email-already-in-use') {
        return 'Email already exists. Please use a different email address.';
      } else if (firebaseException.code == 'invalid-email') {
        return 'The email address is invalid.';
      } else {
        return 'Registration failed. Please try again later.';
      }
    } else {
      return 'Registration failed. Please try again later.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 70.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Text(
                      "Welcome 👋🏼\nsign up to continue",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  if (_errorMessage.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        _errorMessage,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  SizedBox(height: 28.0),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Text(
                      "Full Name",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.only(left: 30.0),
                    width: 330.0,
                    // height: 40.0,
                    child: TextFormField(
                      controller: _fullNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFF4F7F9),
                        hintText: 'Jane Doe',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 28.0),
                  const Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Text(
                      "Student E-mail",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.only(left: 30.0),
                    width: 330.0,
                    //height: 40.0,
                    child: TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFF4F7F9),
                        hintText: 'example@university.co.za',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 28.0),
                  const Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Text(
                      "Password",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.only(left: 30.0),
                    width: 330.0,
                    //  height: 40.0,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFF4F7F9),
                        hintText: '••••••••••••',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 28.0),
                  const Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Text(
                      "Confirm Password",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.only(left: 30.0),
                    width: 330.0,
                    // height: 40.0,
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFF4F7F9),
                        hintText: '••••••••••••',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 28.0),
                  Container(
                    margin: EdgeInsets.only(left: 39.0),
                    width: 330.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4.0,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Color(
                          0xFF383B53), // Set the background color explicitly
                      borderRadius: BorderRadius.circular(10.0),
                      child: InkWell(
                        onTap:
                            _isSigningUp ? null : _registerWithEmailAndPassword,
                        child: Container(
                          width: double.infinity,
                          height: 50.0,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              if (_isSigningUp)
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 24.0,
                                      height: 24.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              if (!_isSigningUp)
                                Center(
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 1.5,
                            color: Color.fromRGBO(195, 197, 198, 1),
                          ),
                        ),
                        SizedBox(width: 15.0),
                        const Text(
                          'or sign up with',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(141, 143, 157, 1),
                          ),
                        ),
                        SizedBox(width: 15.0),
                        Expanded(
                          child: Container(
                            height: 1.5,
                            color: Color.fromRGBO(195, 197, 198, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 46.0,
                      width: 210.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        border:
                            Border.all(color: Color(0xFF121212), width: 1.0),
                      ),
                      child: InkWell(
                        onTap: _signInWithGoogle, // Add this method
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/google logo.png',
                                width: 20.0,
                                height: 20.0,
                              ),
                              SizedBox(width: 10.0),
                              const Padding(
                                padding: EdgeInsets.only(left: 11.0),
                                child: Text(
                                  'Google Account',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Padding(
                    padding: EdgeInsets.only(left: 18.0, top: 38.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(141, 143, 157, 1),
                            height: 1.0,
                            letterSpacing: 0.0,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              height: 1.0,
                              letterSpacing: 0.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
