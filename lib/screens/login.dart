import 'package:flutter/material.dart';
import 'package:scholarly/screens/onboarding.dart';
import 'package:scholarly/screens/forgot_password.dart';
import 'package:scholarly/screens/signup.dart';
import 'auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginStatusWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            // User is not logged in
            return Login();
          } else {
            // User is logged in
            return OnboardingPage();
          }
        } else {
          // Connection state is still loading
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _errorMessage = '';
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String get userName => _firebaseAuth.currentUser?.displayName ?? '';


  void handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      try {
        bool loginSuccessful = await Auth().signInWithEmailAndPassword(email, password);

        if (loginSuccessful) {
          User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            await Auth().updateDisplayName(user.email!.split('@')[0]);
          }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OnboardingPage()),
          );
        } else {
          setState(() {
            _errorMessage = 'Incorrect email or password.';
          });
        }
      } on LoginException catch (e) {
        setState(() {
          _errorMessage = e.message;
        });
      } catch (e) {
        setState(() {
          _errorMessage = 'Login failed. Please try again later.';
        });
      }
    }
  }
  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Insert user data into Firestore collection
        // Your code to insert into the Firestore collection

        Navigator.pushReplacement(
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    "Hello 👋🏼\nlogin to continue",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 31.0),
                    child: Text(
                      _errorMessage,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                SizedBox(height: 28.0),
                const Padding(
                  padding: EdgeInsets.only(left: 31.0),
                  child: Text(
                    "E-mail",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  margin: EdgeInsets.only(left: 31.0),
                  width: 330.0,
                  height: 40.0,
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
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
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
                  padding: EdgeInsets.only(left: 31.0),
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
                  margin: EdgeInsets.only(left: 31.0),
                  width: 330.0,
                  height: 40.0,
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
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
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
                  child: ElevatedButton(
                    onPressed: handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF383B53),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPassword()),
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(141, 143, 157, 1),
                        height: 1.0,
                        letterSpacing: 0.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
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
                        'or',
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
                SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 46.0,
                    width: 210.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: Color(0xFF121212),
                        width: 1.0,
                      ),
                    ),
                    child: InkWell(
                      onTap: _signInWithGoogle,
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
                              padding: EdgeInsets.only(
                                left: 11.0,
                              ), // Adjust the value as needed
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
                SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.only(left: 18.0, top: 150.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
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
                            MaterialPageRoute(builder: (context) => SignUpPage()),
                          );
                        },
                        child: const Text(
                          'Sign Up',
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
    );
  }
}
