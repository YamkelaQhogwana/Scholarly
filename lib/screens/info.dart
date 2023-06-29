import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import '../constants/colors.dart';
import 'calendar.dart';
import 'classes.dart';
import 'home.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationCentre extends StatefulWidget {
  const InformationCentre({Key? key}) : super(key: key);

  @override
  _InformationCentreState createState() => _InformationCentreState();
}

class _InformationCentreState extends State<InformationCentre> {

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
      body: SingleChildScrollView(
        child: Container(
          width: 420,
          height: 1158,
          color: Colors.white,
          child: Stack(
            children: [
              Positioned(
                width: 334,
                height: 100,
                left: 32,
                top: 160,
                child: Container(
                  width: 334,
                  height: 100,
                  decoration: ShapeDecoration(
                    color: Color(0xFFF4F4F4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(61.50),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
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
                child: Container(),
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
                left: 20,
                top: 300,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('staffDetails').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final staffMembers = snapshot.data!.docs;

                      return Column(
                        children: staffMembers.map((staffMember) {
                          final data = staffMember.data() as Map<String, dynamic>;
                          final hours = data['hours'] ?? '';
                          final name = data['name'] ?? '';
                          final staffEmail = data['staffEmail'] ?? '';
                          final staffNumber = data['staffNumber'] ?? '';
                          final position = data['position'] ?? '';

                          return Container(
                            width: 375,
                            height: 120,
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Color(0xFFEDF3F8),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 25),
                                        child: Iconify(
                                          MaterialSymbols.person_2_rounded,
                                          color: Color(0xFFB5D3F7),
                                          size: 70.0,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            name,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              color: Color(0xFF000000),
                                            ),
                                          ),
                                          Text(
                                            position,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10,
                                              color: Color(0xFF54576B),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20, left: 8),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.access_time,
                                            color: Color(0xFFB5D3F7),
                                            size: 15,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            hours,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 13, left: 8),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            color: Color(0xFFB5D3F7),
                                            size: 15,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            staffNumber,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 13, left: 8),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.mail,
                                            color: Color(0xFFB5D3F7),
                                            size: 15,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            staffEmail,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    // Show a loading indicator while data is being fetched
                    return CircularProgressIndicator();
                  },
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
                left: 28,
                top: 720,
                child: Text(
                  'Latest Articles',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              //articles
              //articles
              Positioned(
                top: 760,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('articles').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      final articles = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          final articleData = articles[index].data() as Map<String, dynamic>;
                          final title = articleData['title'] ?? '';
                          final author = articleData['author'] ?? '';
                          final content = articleData['content'] ?? '';
                          final date = articleData['date'] ?? '';
                          final link = articleData['link'] ?? '';

                          return Positioned(
                            top: index * 100.0, // Adjust the spacing between each article
                            left: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                launch(link); // Open the link when tapped
                              },
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 360,
                                      height: 170,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(width: 0.70, color: Color(0xFF8D8F9D)),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 8, top: 15),
                                            child: Text(
                                              title,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF007BC2),
                                                fontSize: 16,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(left: 8),
                                                child: Text(
                                                  'by',
                                                  style: TextStyle(
                                                    color: Color(0xFF8D8F9D),
                                                    fontSize: 12,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                author,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xFF1D1D1D),
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: EdgeInsets.only(left: 8),
                                            child: Text(
                                              content,
                                              style: TextStyle(
                                                color: Color(0xFF1D1D1D),
                                                fontSize: 12,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(left: 8),
                                                child: SvgPicture.string(
                                                  '''
                                    <svg width="15" height="15" viewBox="0 0 15 15" fill="none" xmlns="http://www.w3.org/2000/svg">
<g id="solar:calendar-date-bold">
<g id="Group">
<path id="Vector" d="M4.84375 1.5625C4.84375 1.43818 4.79437 1.31895 4.70646 1.23104C4.61855 1.14314 4.49932 1.09375 4.375 1.09375C4.25068 1.09375 4.13145 1.14314 4.04355 1.23104C3.95564 1.31895 3.90625 1.43818 3.90625 1.5625V2.55C3.00625 2.62187 2.41625 2.79812 1.9825 3.2325C1.54813 3.66625 1.37188 4.25687 1.29938 5.15625H13.7006C13.6281 4.25625 13.4519 3.66625 13.0175 3.2325C12.5838 2.79812 11.9931 2.62187 11.0938 2.54937V1.5625C11.0938 1.43818 11.0444 1.31895 10.9565 1.23104C10.8686 1.14314 10.7493 1.09375 10.625 1.09375C10.5007 1.09375 10.3815 1.14314 10.2935 1.23104C10.2056 1.31895 10.1563 1.43818 10.1563 1.5625V2.50813C9.74063 2.5 9.27438 2.5 8.75 2.5H6.25C5.72563 2.5 5.25938 2.5 4.84375 2.50813V1.5625Z" fill="#8D8F9D"/>
<path id="Vector_2" fill-rule="evenodd" clip-rule="evenodd" d="M13.75 7.5C13.75 6.97563 13.75 6.50938 13.7419 6.09375H1.25813C1.25 6.50938 1.25 6.97563 1.25 7.5V8.75C1.25 11.1069 1.25 12.2856 1.9825 13.0175C2.71437 13.75 3.89313 13.75 6.25 13.75H8.75C11.1069 13.75 12.2856 13.75 13.0175 13.0175C13.75 12.2856 13.75 11.1069 13.75 8.75V7.5ZM8.75 7.65625C8.45992 7.65625 8.18172 7.77148 7.9766 7.9766C7.77148 8.18172 7.65625 8.45992 7.65625 8.75V10C7.65625 10.2901 7.77148 10.5683 7.9766 10.7734C8.18172 10.9785 8.45992 11.0938 8.75 11.0938C9.04008 11.0938 9.31828 10.9785 9.5234 10.7734C9.72852 10.5683 9.84375 10.2901 9.84375 10V8.75C9.84375 8.45992 9.72852 8.18172 9.5234 7.9766C9.31828 7.77148 9.04008 7.65625 8.75 7.65625ZM8.75 8.59375C8.70856 8.59375 8.66882 8.61021 8.63951 8.63951C8.61021 8.66882 8.59375 8.70856 8.59375 8.75V10C8.59375 10.0414 8.61021 10.0812 8.63951 10.1105C8.66882 10.1398 8.70856 10.1562 8.75 10.1562C8.79144 10.1562 8.83118 10.1398 8.86049 10.1105C8.88979 10.0812 8.90625 10.0414 8.90625 10V8.75C8.90625 8.70856 8.88979 8.66882 8.86049 8.63951C8.83118 8.61021 8.79144 8.59375 8.75 8.59375ZM6.74187 7.69188C6.82754 7.72736 6.90075 7.78745 6.95226 7.86454C7.00377 7.94164 7.03126 8.03228 7.03125 8.125V10.625C7.03125 10.7493 6.98186 10.8685 6.89396 10.9565C6.80605 11.0444 6.68682 11.0938 6.5625 11.0938C6.43818 11.0938 6.31895 11.0444 6.23104 10.9565C6.14314 10.8685 6.09375 10.7493 6.09375 10.625V9.25625L5.95625 9.39375C5.86739 9.47655 5.74986 9.52163 5.62842 9.51948C5.50699 9.51734 5.39112 9.46815 5.30524 9.38226C5.21935 9.29638 5.17016 9.18051 5.16802 9.05908C5.16587 8.93764 5.21095 8.82011 5.29375 8.73125L6.23125 7.79375C6.29676 7.72819 6.38023 7.68353 6.47112 7.66539C6.562 7.64726 6.65622 7.65648 6.74187 7.69188Z" fill="#8D8F9D"/>
</g>
</g>
</svg>

                  ''',
                                                  color: Colors.grey,
                                                  width: 15,
                                                  height: 15,
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                date,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xFF1D1D1D),
                                                  fontSize: 12,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),

              //profile
              Positioned(
                height: 55,
                left: 25,
                top: 60,
                child: Container(
                  child: Row(
                    children: [
                      Image.asset(
                        icon,
                        width: 55,
                        height: 55,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 260.0),
                        child: SvgPicture.string(
                          '''
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
              <path fill="none" stroke="#000000" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 17h8m-8-5h14m-8-5h8"/>
            </svg>
            ''',
                          color: Colors.black,
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ],
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
                height: 30,
                left: 91,
                top: 65,
                child: Text(
                  fullName,
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
                    MaterialPageRoute(builder: (context) => HomePage()),
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
                  MaterialPageRoute(builder: (context) => const CalendarPage()),
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
                  MaterialPageRoute(builder: (context) => InformationCentre()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
