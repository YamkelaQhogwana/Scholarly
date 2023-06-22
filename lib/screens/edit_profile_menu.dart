import 'package:flutter/material.dart';
import 'package:scholarly/screens/home.dart';
import 'package:scholarly/screens/calendar.dart';
import 'package:scholarly/screens/info.dart';
import 'package:scholarly/screens/classes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholarly/screens/main_screen_menu.dart';

class EditProfileMenu extends StatefulWidget {
  const EditProfileMenu({Key? key}) : super(key: key);

  @override
  _EditProfileMenuState createState() => _EditProfileMenuState();
}

class _EditProfileMenuState extends State<EditProfileMenu> {
  String fullName = "";
  String email = "";
  String institution = "";
  String campus = "";
  String year = "";
  String course = "";
  String icon = "";

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController institutionController = TextEditingController();
  TextEditingController campusController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController courseController = TextEditingController();

  List<String> iconOptions = [
    'images/avatars/black-wn-av.png',
    'images/avatars/black-mn-av.png',
    'images/avatars/brunette-wn-av.png',
    'images/avatars/ginger-mn-av.png',
    'images/avatars/tan-mn-av.png',
    'images/avatars/white-wn-av.png'
  ];

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
          email = userData['email'];
          institution = userData['institution'];
          campus = userData['campus'];
          year = userData['year'];
          course = userData['course'];
          icon = userData['icon'];
        });
      }
    }
  }

  void openIconOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Icon'),
          content: Container(
            width: double.maxFinite,
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: iconOptions.length,
              itemBuilder: (context, index) {
                final option = iconOptions[index];
                return GestureDetector(
                  onTap: () {
                    changeIcon(option);
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Image.asset(
                        option,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void showFillFieldsAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Error',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: Text(
            'Please Fill in All Fields',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void changeIcon(String newIcon) {
    setState(() {
      icon = newIcon;
    });
  }

  void saveProfileData() {
    String fullNameValue = fullNameController.text;
    if (fullNameValue.isEmpty) {
      fullNameValue = fullName;
    }
    String emailValue = emailController.text;
    if (emailValue.isEmpty) {
      emailValue = email;
    }
    String institutionValue = institutionController.text;
    if (institutionValue.isEmpty) {
      institutionValue = institution;
    }
    String campusValue = campusController.text;
    if (campusValue.isEmpty) {
      campusValue = campus;
    }
    String yearValue = yearController.text;
    if (yearValue.isEmpty) {
      yearValue = fullName;
    }
    String courseValue = courseController.text;
    if (courseValue.isEmpty) {
      courseValue = course;
    }

    if (fullNameValue.isNotEmpty &&
        emailValue.isNotEmpty &&
        institutionValue.isNotEmpty &&
        campusValue.isNotEmpty &&
        yearValue.isNotEmpty &&
        courseValue.isNotEmpty &&
        icon.isNotEmpty) {
      // Save the data to the database
      final user = FirebaseAuth.instance.currentUser;
      final userEmail = user?.email ?? '';
      if (user != null) {
        FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: userEmail)
            .get()
            .then((querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            final documentSnapshot = querySnapshot.docs[0];
            documentSnapshot.reference.update({
              'fname': fullNameValue,
              'email': emailValue,
              'institution': institutionValue,
              'campus': campusValue,
              'year': yearValue,
              'course': courseValue,
              'icon': icon,
            });
            print('Data saved successfully');
            print(yearValue);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MenuPage()),
            );
          }
        }).catchError((error) {
          print('Error saving data: $error');
        });
      }
    } else {
      print('Please fill in all the fields');
      showFillFieldsAlert(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        '<',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Placeholder code for the save button
                        print('Save button pressed');
                        saveProfileData();
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage(icon),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Image.asset(
                            'assets/images/icons/change-avi.png',
                            width: 24,
                            height: 24,
                          ),
                          onPressed: openIconOptionsDialog,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Full Name',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                          ),
                        ),
                        SizedBox(height: 4),
                        TextField(
                          controller: fullNameController,
                          decoration: InputDecoration(
                            hintText: fullName,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                          ),
                        ),
                        SizedBox(height: 4),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: email,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Institution',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                          ),
                        ),
                        SizedBox(height: 4),
                        TextField(
                          controller: institutionController,
                          decoration: InputDecoration(
                            hintText: institution,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Campus',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                          ),
                        ),
                        SizedBox(height: 4),
                        TextField(
                          controller: campusController,
                          decoration: InputDecoration(
                            hintText: campus,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Academic Year',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                          ),
                        ),
                        SizedBox(height: 4),
                        TextField(
                          controller: yearController,
                          onChanged: (value) {
                            setState(() {
                              year = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: year,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Major/Course',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                          ),
                        ),
                        SizedBox(height: 4),
                        TextField(
                          controller: courseController,
                          decoration: InputDecoration(
                            hintText: course,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Placeholder code for the floating button
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(8), // Adjust the border radius as desired
        ),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.calendar_month),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CalendarPage()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.school),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClassesPage()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.newspaper),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InformationCentre()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfileDialog extends StatelessWidget {
  final List<String> options;
  final Function(String) onSelect;

  const EditProfileDialog({
    required this.options,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.5, // Adjust the aspect ratio as desired
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: options.length,
              itemBuilder: (context, index) {
                final option = options[index];
                return GestureDetector(
                  onTap: () {
                    onSelect(option);
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        option,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
