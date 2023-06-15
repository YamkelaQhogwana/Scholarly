import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

class AddClasses extends StatelessWidget {
  Function(
      String,
      String,
      String,
      String,
      TextEditingController,
      TextEditingController,
      TextEditingController,
      TextEditingController,
      ) onAddModule;
  final TextEditingController moduleNameController = TextEditingController();
  final TextEditingController moduleCodeController = TextEditingController();
  final TextEditingController moduleGradeController = TextEditingController();
  final TextEditingController moduleLecturerController = TextEditingController();

  AddClasses({required this.onAddModule});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Center(
                    child: Text(
                      "Add your modules",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Module name:",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                SizedBox(height: 10.0),
                Container(
                  width: 330.0,
                  height: 40.0,
                  child: TextField(
                    controller: moduleNameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF4F7F9),
                      hintText: 'Enter your module name here',
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
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Module code:",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                SizedBox(height: 10.0),
                Container(
                  width: 330.0,
                  height: 40.0,
                  child: TextField(
                    controller: moduleCodeController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF4F7F9),
                      hintText: 'Enter your module code here',
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
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Module grade:",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                SizedBox(height: 10.0),
                Container(
                  width: 330.0,
                  height: 40.0,
                  child: TextField(
                    controller: moduleGradeController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF4F7F9),
                      hintText: 'Enter your module grade here',
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
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Module name:",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                SizedBox(height: 10.0),
                Container(
                  width: 330.0,
                  height: 40.0,
                  child: TextField(
                    controller: moduleLecturerController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF4F7F9),
                      hintText: 'Enter your module lecturer name here',
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
                SizedBox(height: 28.0),
                Center(
                  child: Container(
                    width: 330.0,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        final moduleName = moduleNameController.text;
                        final moduleCode = moduleCodeController.text;
                        final moduleGrade = moduleGradeController.text;
                        final moduleLecturer = moduleLecturerController.text;

                        // Call the callback function with the module details
                        onAddModule(
                          moduleName,
                          moduleCode,
                          moduleGrade,
                          moduleLecturer,
                          moduleNameController,
                          moduleCodeController,
                          moduleGradeController,
                          moduleLecturerController,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF383B53),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'Add Module',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
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
