import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ci.dart';
import 'package:scholarly/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scholarly/screens/main_screen_menu.dart';

class CustomAppBarInfo extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBarInfo({Key? key}) : super(key: key);

  @override
  _CustomAppBarInfoState createState() => _CustomAppBarInfoState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _CustomAppBarInfoState extends State<CustomAppBarInfo> {
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
                const Text(
                  'Welcome to the information center!',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.kSecondaryText,
                    fontWeight: FontWeight.w400,
                  ),
                ),
            ],
          ),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuPage()),
                );
                
              },
              icon: const Iconify(
                Ci.menu_alt_05,
                color: AppColors.kMainText,
                size: 30,
              ),
            ),
          ],
        ),
      ),
     
    );
  }
}

