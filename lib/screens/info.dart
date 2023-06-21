import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class InformationCentre extends StatefulWidget {
  const InformationCentre({Key? key}) : super(key: key);

  @override
  _InformationCentreState createState() => _InformationCentreState();
}

class _InformationCentreState extends State<InformationCentre> {
  bool isDarkMode = false;
  String fullName = "";
  String icon = "";
  String year = "";

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    final userEmail = user?.email ?? '';
    if (user != null) {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> userData = querySnapshot.docs[0].data();
        setState(() {
          fullName = userData['fname'];
          icon = userData['icon'];
          year = userData['year'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 390,
        height: 1158,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              width: 334,
              height: 100,
              left: 28,
              top: 160,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(61.5),
                ),
              ),
            ),
            Positioned(
              width: 80,
              height: 80,
              left: 40,
              top: 170,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF007BC2),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              width: 50,
              height: 50,
              left: 55,
              top: 185,
              child: Icon(
                Icons.phone,
                color: Colors.white,
              ),
            ),
            Positioned(
              left: 12.5,
              right: 9.38,
              top: 9.38,
              bottom: 12.5,
              child: Container(
                color: Color(0xFFF5F5F5),
              ),
            ),
            Positioned(
              width: 130,
              height: 24,
              left: 130,
              top: 223,
              child: Text(
                '(080) 036-3636',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  height: 24 / 16, // line-height
                  color: Color(0xFF54576B),
                ),
              ),
            ),
            Positioned(
              width: 56,
              height: 24,
              left: 130,
              top: 200,
              child: Text(
                'SADAG',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  height: 24 / 16, // line-height
                  color: Color(0xFF007BC2),
                ),
              ),
            ),
            Positioned(
              width: 168,
              height: 20,
              left: 130,
              top: 180,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Emergency Helpline',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    height: 20 / 16, // line-height
                    color: Color(0xFF000000),
                  ),
                ),
              ),
            ),
            Positioned(
              width: 334,
              height: 100,
              left: 28,
              top: 290,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFEDF3F8),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xFF000000),
                            ),
                          ),
                          Text(
                            'Campus Counsellor',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xFF54576B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.black,
                              size: 20,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '07:30 - 20:00',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xFF54576B),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: Colors.black,
                              size: 20,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '(011) 555-2213',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xFF54576B),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.mail,
                              color: Colors.black,
                              size: 20,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'johnd@uni.com',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xFF54576B),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              width: 334,
              height: 100,
              left: 28,
              top: 420, // Adjust the top value as needed
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFEDF3F8),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Adam Walker',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xFF000000),
                            ),
                          ),
                          Text(
                            'Faculty Representative',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xFF54576B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.black,
                              size: 20,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '09:00 - 17:00',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xFF54576B),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: Colors.black,
                              size: 20,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '(011) 555-2213',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xFF54576B),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.mail,
                              color: Colors.black,
                              size: 20,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'adamw@uni.com',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xFF54576B),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              width: 334,
              height: 100,
              left: 28,
              top: 550, // Adjust the top value as needed
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFEDF3F8),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sam Robin',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xFF000000),
                            ),
                          ),
                          Text(
                            'Student Representative',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xFF54576B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.black,
                              size: 20,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '10:00 - 15:30',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xFF54576B),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: Colors.black,
                              size: 20,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '(011) 555-2213',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xFF54576B),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.mail,
                              color: Colors.black,
                              size: 20,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'samr@uni.com',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xFF54576B),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              width: 390,
              height: 70,
              left: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, -4),
                      blurRadius: 20,
                      color: Color.fromRGBO(195, 197, 198, 0.19),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              width: 55,
              height: 55,
              left: 25,
              top: 65,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/black-wn-av.png'),
                  ),
                ),
              ),
            ),
            Positioned(
              width: 216,
              height: 15,
              left: 91,
              top: 95,
              child: Text(
                'Welcome to the information centre',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Color(0xFF8D8F9D),
                ),
              ),
            ),
            Positioned(
              width: 123,
              height: 30,
              left: 91,
              top: 65,
              child: Text(
                fullName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  color: Color(0xFF1D1D1D),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
