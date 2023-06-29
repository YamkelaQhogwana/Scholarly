import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:scholarly/screens/main_screen_menu.dart';
import '../constants/colors.dart';
import 'calendar.dart';
import 'home.dart';
import 'info.dart';
import 'add_classes.dart';
import 'menu/notification_menu.dart';
import 'menu/profile_menu.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/gridicons.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:scholarly/screens/menu/habits.dart';
import 'package:scholarly/screens/menu/statistics.dart';


class ClassesPage extends StatefulWidget {
  @override
  _ClassesPageState createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  late String userName = '';
  late String icon = "";
  late bool isIconLoading = true; // New variable to track icon loading state

  late List<Map<String, dynamic>> modules;
  late List<Color> containerColors = [
    const Color(0xFFEAF5E6), // First color
    const Color(0xFFEDE4F9), // Second color
    const Color(0xFFFCECEB), // Third color
  ];
  final Map<Color, Color> colorMappings = {
    const Color(0xFFEAF5E6): const Color(0xFF87C782),
    // First container color maps to first text/icon color
    const Color(0xFFEDE4F9): const Color(0xFF8F76C9),
    // Second container color maps to second text/icon color
    const Color(0xFFFCECEB): const Color(0xFFE66A64),
    // Third container color maps to third text/icon color
  };

  @override
  void initState() {
    super.initState();
    fetchUserDataWithRetry();
  }
  void fetchUserDataWithRetry() {
    const retryDelay = Duration(seconds: 2); // Adjust the delay as needed
    const maxRetryAttempts = 3; // Maximum number of retry attempts
    int retryCount = 0;

    void fetchData() async {
      try {
        await fetchUserData();
        // Image loaded successfully, break out of the loop
        return;
      } catch (e) {
        print('Error fetching user data: $e');
        retryCount++;
        await Future.delayed(retryDelay);
        if (retryCount < maxRetryAttempts) {
          fetchData(); // Retry fetching data
        } else {
          setState(() {
            isIconLoading = false; // Set loading state to false even if retries fail
          });
        }
      }
    }

    fetchData();
  }
  Future<void> fetchUserData() async {
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
          Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
          if (data != null) {
            setState(() {
              userName = data['fname'] ?? '';
              icon = data['icon'];
              isIconLoading = false; // Set the loading state to false when the icon is loaded
            });
          }
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void _onAddModule(
    String name,
    String code,
    String grade,
    String lecturer,
    TextEditingController moduleNameController,
    TextEditingController moduleCodeController,
    TextEditingController moduleGradeController,
    TextEditingController moduleLecturerController,
  ) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String? userEmail = user.email;
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 65, left: 25),
                            child: Row(
                              children: [
                                isIconLoading
                                    ? CircularProgressIndicator() // Show loading indicator while icon is loading
                                    : Image.asset(
                                  icon,
                                  width: 55,
                                  height: 55,
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
                                          int moduleCount =
                                              snapshot.data!.length;
                                          return Text(
                                            'You have $moduleCount module${moduleCount != 1 ? 's' : ''} this block',
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
                                Builder(
                                  builder: (context) => GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MenuPage(),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 60.0),
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 30, left: 25, right: 25, bottom: 30),
                                child:
                                    FutureBuilder<List<Map<String, dynamic>>>(
                                  future: fetchModuleData(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else if (snapshot.hasData) {
                                      List<Map<String, dynamic>> moduleData =
                                          snapshot.data!;
                                      if (moduleData.isNotEmpty) {
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: moduleData.length,
                                          itemBuilder: (context, index) {
                                            String moduleName =
                                                moduleData[index]['name'] ?? '';
                                            String moduleCode =
                                                moduleData[index]['code'] ?? '';
                                            String moduleGrade =
                                                moduleData[index]['grade'] ??
                                                    '';
                                            String moduleLecturer =
                                                moduleData[index]['lecturer'] ??
                                                    '';
                                            int colorIndex =
                                                index % containerColors.length;
                                            Color containerColor =
                                                containerColors[index %
                                                    containerColors.length];

                                            // Get the corresponding text/icon color based on the container color using the mapping
                                            Color textIconColor =
                                                colorMappings[containerColor] ??
                                                    Colors.black;
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20),
                                              child: Container(
                                                width: 350,
                                                height: 170,
                                                decoration: BoxDecoration(
                                                  color: containerColors[
                                                      colorIndex],
                                                  // Assign the color based on the index
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                            height: 20),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: Text(
                                                            'Module Name',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12,
                                                              color:
                                                                  textIconColor,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 3),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: Text(
                                                            moduleName,
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 16,
                                                              color: Color(
                                                                  0xFF1D1D1D),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: Text(
                                                            'Module Code',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12,
                                                              color:
                                                                  textIconColor,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 3),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: Text(
                                                            moduleCode,
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 16,
                                                              color: Color(
                                                                  0xFF1D1D1D),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 20),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SvgPicture
                                                                      .string(
                                                                    '''
                  <svg xmlns="http://www.w3.org/2000/svg" width="512" height="512" viewBox="0 0 512 512">
                    <path fill="#8F76C9" d="M286.883 449.302c-32.074-5.598-44.248-61.722-57.684-141.257c-35.493 5.57-84.224 15.62-136.646 26.918c-8.547 22.392-23.16 55.117-43.838 98.189C37.15 458.017-.483 447.932.005 421.615c0-8.204 12.902-39.392 38.711-93.573c-10.963-19.661-1.16-37.43 20.766-42.046c44.515-79.694 125.23-218.94 149.464-223.298c34.272.02 27.712 46.153 43.839 114.341l38.2 178.177c16.024 46.692 41.436 85.73-4.102 94.086zm-90.5-293.03l-73.32 118.188c20.678-5.295 52.043-11.705 94.088-19.227l-20.766-98.96zm224.6-39.731c-1.207 16.875-2.378 36.667-1.537 57.427c47.449 1.985 91.73-8.746 92.549 23.585c.268 12.222-9.834 24.105-22.047 23.586c-22.209-3.485-45.74-.7-69.99-1.539v60.247c2.12 31.834-48.317 30.886-45.633 0l-.513-59.221c-52.638 3.635-83.997 3.46-83.576-21.79c1.267-29.974 19.67-18.519 83.576-23.844c-.739-23.628-.75-45.79 2.052-62.297c6-28.701 44.984-21.366 45.119 3.846z"/>
                </svg>
                    ''',
                                                                    width: 12,
                                                                    height: 12,
                                                                    color:
                                                                        textIconColor,
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          5),
                                                                  Text(
                                                                    moduleGrade,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          16,
                                                                      color: Color(
                                                                          0xFF1D1D1D),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  width: 20),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            50),
                                                                    child: SvgPicture
                                                                        .string(
                                                                      '''
                          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
                            <path fill="#8F76C9" d="M8 8a3 3 0 1 0 0-6a3 3 0 0 0 0 6Zm2-3a2 2 0 1 1-4 0a2 2 0 0 1 4 0Zm4 8c0 1-1 1-1 1H3s-1 0-1-1s1-4 6-4s6 3 6 4Zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332c-.678.678-.83 1.418-.832 1.664h10Z"/>
                          </svg>
                          ''',
                                                                      color:
                                                                          textIconColor,
                                                                      width: 12,
                                                                      height:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          5),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            50),
                                                                    child: Text(
                                                                      moduleLecturer,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                        fontSize:
                                                                            16,
                                                                        color: Color(
                                                                            0xFF1D1D1D),
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
                                                    Positioned(
                                                      right: 0,
                                                      top: 0,
                                                      child: IconButton(
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color: textIconColor,
                                                        ),
                                                        onPressed: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                title:
                                                                    const Text(
                                                                  'Delete Module',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                                content:
                                                                    const Text(
                                                                  'Are you sure you want to delete this module?',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                    child:
                                                                        const Text(
                                                                      'Cancel',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  ),
                                                                  TextButton(
                                                                    child:
                                                                        const Text(
                                                                      'Delete',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      // Delete the module from Firebase
                                                                      DocumentSnapshot docSnapshot = await FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'modules')
                                                                          .where(
                                                                              'name',
                                                                              isEqualTo:
                                                                                  moduleName)
                                                                          .limit(
                                                                              1)
                                                                          .get()
                                                                          .then((snapshot) => snapshot
                                                                              .docs
                                                                              .first);

                                                                      if (docSnapshot
                                                                          .exists) {
                                                                        docSnapshot
                                                                            .reference
                                                                            .delete();
                                                                      }

                                                                      // Refresh the displayed modules by calling fetchModuleData()
                                                                      List<Map<String, dynamic>>
                                                                          updatedModules =
                                                                          await fetchModuleData();
                                                                      setState(
                                                                          () {
                                                                        modules =
                                                                            updatedModules;
                                                                      });

                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        return const Center(
                                          child: Text(
                                            'No modules found',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: Color(0xFF8D8F9D),
                                            ),
                                          ),
                                        );
                                      }
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
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/images/classespage/bottom.png',
                                width: 365,
                              ),
                              Positioned(
                                bottom: 60,
                                // Adjust the value to position the "Add" icon vertically
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddClasses(
                                          onAddModule: _onAddModule,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 56,
                                    height: 56,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
                  color: Colors.white, // Set the icon color
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
              color: AppColors.kPrimary400,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClassesPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.newspaper),
              color: AppColors.kMainText,
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
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 250.0,
              child: DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 120.0,
                      height: 120.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/avatars/black-wn-av.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Jane Doe',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Third Year',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Iconify(MaterialSymbols.person_2_rounded),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileMenu(),
                  ),
                );
                // Add your logic for Inbox onTap
              },
            ),
            ListTile(
              leading: const Iconify(Mdi.bell_badge),
              title: const Text('Notifications'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationsMenu(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Iconify(Mdi.clock_check),
              title: const Text('Habits/Goals'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HabitsPage(),
                  ),
                );
                // Add your logic for Sent onTap
              },
            ),
            ListTile(
              leading: const Iconify(Gridicons.stats_down_alt),
              title: const Text('Statistics'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MenuStatistics(),
                  ),
                );
                // Add your logic for Sent onTap
              },
            ),
            ListTile(
              leading: const Iconify(Mdi.comment_text),
              title: const Text('Feedback'),
              onTap: () {
                print('Feedback');
              },
            ),
            ListTile(
              leading: const Iconify(Majesticons.logout),
              title: const Text('Logout'),
              onTap: () {
                print('Logout Clicked');
              },
            ),
            ListTile(
              leading: const Iconify(Bx.bxs_moon),
              title: const Text('Dark Mode'),
              onTap: () {
                print('DarkMode');
              },
            ),
            const SizedBox(
              height: 50,
            ),
            const Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Scholarly v.1.0.0',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
