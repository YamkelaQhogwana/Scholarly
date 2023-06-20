import 'package:flutter/material.dart';
import 'package:scholarly/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomAppBarClasses extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBarClasses({Key? key}) : super(key: key);

  @override
  _CustomAppBarClassesState createState() => _CustomAppBarClassesState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _CustomAppBarClassesState extends State<CustomAppBarClasses> {
  late String userName = '';
  late List<Map<String, dynamic>> modules;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: user.email)
            .limit(1)
            .get();
        if (snapshot.docs.isNotEmpty) {
          DocumentSnapshot userDoc = snapshot.docs.first;
          Map<String, dynamic>? data =
          userDoc.data() as Map<String, dynamic>?;
          if (data != null) {
            setState(() {
              userName = data['fname'] ?? '';
            });
          }
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void _onAddModule(String name,
      String code,
      String grade,
      String lecturer,
      TextEditingController moduleNameController,
      TextEditingController moduleCodeController,
      TextEditingController moduleGradeController,
      TextEditingController moduleLecturerController,) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String? userEmail = user?.email;
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: userEmail)
            .limit(1)
            .get();
        if (snapshot.docs.isNotEmpty) {
          DocumentSnapshot userDoc = snapshot.docs.first;
          String uid = userDoc.id;

          await FirebaseFirestore.instance.collection('modules').add({
            'lecturer': lecturer,
            'code': code,
            'grade': grade,
            'name': name,
            'userID': userEmail, // Use 'uid' instead of 'userID'
          });

          // Perform any additional actions after saving to the database, if needed

          // Reset the text fields
          moduleNameController.clear();
          moduleCodeController.clear();
          moduleGradeController.clear();
          moduleLecturerController.clear();

          // Refresh the displayed modules by calling fetchModuleData()
          List<Map<String, dynamic>> updatedModules = await fetchModuleData();
          setState(() {
            modules = updatedModules;
          });
        }
      }
    } catch (e) {
      print('Error saving module details: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchModuleData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String? userEmail = user.email;
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('modules')
            .where('userID', isEqualTo: userEmail) // Filter by the user's email
            .get();
        List<Map<String, dynamic>> moduleData = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        return moduleData;
      }
    } catch (e) {
      print('Error fetching module data: $e');
    }
    return []; // Return an empty list if no data or error occurs
  }


  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      toolbarHeight: 100,
      automaticallyImplyLeading: false,
      title: SizedBox(
        height: 60,
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage:
                  AssetImage('assets/images/avatars/black-wn-av.png'),
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
            ),
            const SizedBox(width: 10),
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  color: Color(0xFF1D1D1D),
                ),
              ),
              const SizedBox(height: 3),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchModuleData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    int moduleCount = snapshot.data!
                        .length;
                    return Text(
                      'You have $moduleCount module${moduleCount !=
                          1 ? 's' : ''} this block',
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color(0xFF8D8F9D),
                      ),
                    );
                  } else {
                    return const Text(
                      'Error loading module data',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color(0xFF8D8F9D),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
            const Spacer(),
            // Remove the commented IconButton widget
          ],
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.kMainText, // Change the menu icon color here
      ),
    );
  }
}

