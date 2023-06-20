import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  Future<void>? _resetPasswordFuture;

  void _resetPassword(BuildContext context) {
    final email = _emailController.text;

    setState(() {
      _resetPasswordFuture = _firebaseAuth.sendPasswordResetEmail(email: email)
          .then((_) {
        // Display the popup dialog
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Success',
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              content: Text(
                'Password reset email has been sent successfully.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Dismiss the dialog
                    Navigator.of(context).pop(); // And navigate back
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }).catchError((e) {
        print('Error sending password reset email: $e');
      }).whenComplete(() {
        setState(() {
          _resetPasswordFuture = null; // Enable the button again after the Future has completed
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Text(
                  "Please enter your e-mail to receive your password reset link:",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  width: 330.0,
                  height: 40.0,
                  child: TextField(
                    controller: _emailController,
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
                        vertical: 10.0,
                        horizontal: 15.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 12.0,
                    ),
                  ),
                ),
                SizedBox(height: 30.0),

                Container(
                  width: 330.0,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_resetPasswordFuture == null) {
                        _resetPassword(context);
                      }
                      // If _resetPasswordFuture is not null, the button won't do anything when pressed.
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF383B53),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: FutureBuilder<void>(
                      future: _resetPasswordFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator(color: Colors.white);
                        } else {
                          return Text(
                            'Submit',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),


                SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
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
