import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import '../constants/colors.dart';
import '../constants/custom_appbar_info.dart';
import 'calendar.dart';
import 'classes.dart';
import 'home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:iconify_flutter/icons/ic.dart';

class InformationCentre extends StatefulWidget {
  const InformationCentre({Key? key}) : super(key: key);

  @override
  _InformationCentreState createState() => _InformationCentreState();
}

class _InformationCentreState extends State<InformationCentre> {
  late FirebaseFirestore firestore;

  @override
  void initState() {
    super.initState();
    fetchUserData();
    firestore = FirebaseFirestore.instance;
  }

  late String fullName = "";
  String icon = "";
  String year = "";
  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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

  List<Map<String, dynamic>> personnelDetails = [
  {
    'name': 'John Doe',
    'occupation': 'Campus Counsellor',
    'openHours': '07:30 - 20:00',
    'phoneNumber': '(011)7555-2213',
    'email': 'johnd@uni.com',
  },
  {
    'name': 'Adam Walker',
    'occupation': 'Faculty Representative',
    'openHours': '09:00 - 17:00',
    'phoneNumber': '(011)7555-2213',
    'email': 'adamw@uvi.com',
  },
  {
    'name': 'Sam Robin',
    'occupation': 'Student Representative',
    'openHours': '10:00 - 15:30',
    'phoneNumber': '(011)7555-2213',
    'email': 'samr@uni.com',
  },
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarInfo(),
      body: Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
  child: SingleChildScrollView(
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                 GestureDetector(
                    onTap: () async {
                      const phoneNumber = '0828850710'; // Replace with the phone number you want to call
                      final url = Uri.parse('tel:$phoneNumber');

                      if (await canLaunch(url.toString())) {
                        await launch(url.toString());
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color(0xFF007BC2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Emergency Hotline',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: AppColors.kMainText,
                          ),
                        ),
                        Text(
                          'SADAG',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 16, // line-height
                            color: AppColors.kPrimary400,
                          ),
                        ),
                        Text(
                          '(080) 036-3636',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
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
        const SizedBox(height: 30.0),
        Column(
          children: personnelDetails.map((person) {
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.kBlueLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const Iconify(
                        MaterialSymbols.person_2_rounded, 
                      color: AppColors.kBlueDark,
                      size: 60,
                      ),
                      const SizedBox(width: 6.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            person['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            person['occupation'],
                          ),
                        ],
                      ),
                      const SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.schedule, color: AppColors.kBlueDark, size:15),
                              const SizedBox(width: 4.0),
                              Text(person['openHours'], style: const TextStyle(fontSize: 13),),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(Icons.phone, color: AppColors.kBlueDark, size:15),
                              const SizedBox(width: 4.0),
                              Text(person['phoneNumber'], style: const TextStyle(fontSize: 13),),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(Icons.email, color: AppColors.kBlueDark, size:15),
                              const SizedBox(width: 4.0),
                              Text(person['email'], style: const TextStyle(fontSize: 13),),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0), 
                
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 16.0),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Latest Articles',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: firestore.collection('articles').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  List<DocumentSnapshot> articles = snapshot.data!.docs;
                  return Column(
                    children: articles.map((article) {
                      return GestureDetector(
                        onTap: () {
                          String url = article['link'];
                          launchURL(url);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF8D8F9D),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.all(16.0),
                          margin: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article['title'],
                                style: const TextStyle(
                                  color: AppColors.kPrimary400,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  const Text(
                                    'by',
                                    style: TextStyle(
                                      color: Color(0xFF8D8F9D),
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    ' ${article['author']}',
                                    style: const TextStyle(
                                      color: AppColors.kMainText,
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                _getExcerpt(article['content']),
                                style: const TextStyle(
                                  color: AppColors.kMainText,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  const Iconify(
                                    Ic.baseline_calendar_month,
                                    color: Color(0xFF8D8F9D),
                                    size: 15,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    article['date'],
                                    style: const TextStyle(
                                      color: AppColors.kMainText,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),

              const SizedBox(height: 50)
            ],
            
          ),
          
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: kBottomNavigationBarHeight / 2,
            left: (MediaQuery.of(context).size.width - 56) /
                2, // Adjust the left position
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.kPrimary400,
                // Set your desired button color here
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: IconButton(
                onPressed: () {
                  // Placeholder code for add button
                  //showTaskFormBottomSheet(context);
                  print('Add button pressed');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              color: AppColors.kMainText,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.calendar_month),
              color: AppColors.kMainText,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarPage()),
                );
              },
            ),
            const SizedBox(width: 56), // Empty space for the float button
            IconButton(
              icon: const Icon(Icons.school),
              color: AppColors.kMainText,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClassesPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.newspaper),
              color: AppColors.kPrimary400,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InformationCentre()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

   String _getExcerpt(String content) {
    // Logic to extract an excerpt from the content
    // You can customize this method based on your requirements
    // For example, you can return the first few sentences or a specific number of characters.
    return '${content.substring(0, min(content.length, 100))}...';
  }
}
