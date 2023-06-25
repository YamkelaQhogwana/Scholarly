import 'package:flutter/material.dart';
import 'package:scholarly/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
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
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons
                .admin_panel_settings), // Replace with the actual admin icon
            SizedBox(width: 8),
            Text("Scholarly Admin Panel"), // Replace with the actual admin name
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  color: AppColors.kBlueDark,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: GridItem(
                  icon: Icons.message,
                  buttonText: 'View Messages',
                  buttonColor: AppColors.kBlueDark,
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  color: AppColors.kPurpleDark,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: GridItem(
                  icon: Icons.person,
                  buttonText: 'Manage Users',
                  buttonColor: AppColors.kPurpleDark,
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  color: AppColors.kPink,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: GridItem(
                  icon: Icons.person,
                  buttonText: 'Manage Users',
                  buttonColor: AppColors.kPinkDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final IconData icon;
  final String buttonText;
  final Color buttonColor;

  const GridItem({
    required this.icon,
    required this.buttonText,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(primary: buttonColor),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
