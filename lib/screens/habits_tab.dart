import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Habits_Page extends StatelessWidget {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  final List<String> daysOfWeek = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  final List<Color> habitColors = [
    Color.fromRGBO(236, 216, 199, 1), // Go for a walk
    Color.fromRGBO(218, 240, 209, 1), // Revision
    Color.fromRGBO(208, 224, 247, 1), // Drink water
    Color.fromRGBO(255, 234, 209, 1), // Go for a walk
    Color.fromRGBO(238, 209, 209, 1), // Daily journal
  ];
  final Map<String, IconData> habitIcons = {
    'Call parents': Icons.phone,
    'Revision': Icons.book,
    'Drink water': Icons.local_drink,
    'Go for a walk': Icons.directions_walk,
    'Daily journal': Icons.edit,
    'Sleep': Icons.hotel,
    'Soccer': Icons.sports_soccer,
    'Gym': Icons.fitness_center,
  };

  @override
  Widget build(BuildContext context) {
    CollectionReference habitCollection =
        FirebaseFirestore.instance.collection('habits');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            for (String day in daysOfWeek)
              Padding(
                padding: EdgeInsets.all(9),
                child: Container(
                  height: 15,
                  width: 10,
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Text(
                    day,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          backgroundBlendMode: BlendMode.darken,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 254, 253, 255)
            ],
          ),
        ),
        child: FutureBuilder<QuerySnapshot>(
          future: habitCollection
              .where('userEmail', isEqualTo: currentUser?.email)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            if (snapshot.hasData) {
              List<QueryDocumentSnapshot> habitDocs = snapshot.data!.docs;

              return ListView.builder(
                itemCount: habitDocs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> habitData =
                      habitDocs[index].data() as Map<String, dynamic>;

                  IconData? habitIcon =
                      habitIcons.containsKey(habitData['name'])
                          ? habitIcons[habitData['name']]
                          : habitIcons['Default'];

                  return Card(
                    color: habitColors[index % habitColors.length],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: Icon(
                        habitIcon,
                        color: Color(0xFF8D8F9D),
                      ),
                      title: Text(
                        habitData['name'],
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return Center(
              child: Text('No habits found.'),
            );
          },
        ),
      ),
    );
  }
}
