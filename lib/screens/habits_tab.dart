import 'package:flutter/material.dart';

class Habits_Page extends StatelessWidget {
  final List<String> habits = [
    'Go for a walk',
    'Revision',
    'Drink water',
    'Go for a walk',
    'Daily journal',
  ];

  final List<String> daysOfWeek = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  final List<Color> habitColors = [
    Color.fromRGBO(234, 223, 214, 1), // Go for a walk
    Color.fromRGBO(234, 245, 230, 1), // Revision
    Color.fromRGBO(237, 244, 254, 1), // Drink water
    Color.fromRGBO(255, 234, 209, 1), // Go for a walk
    Color.fromRGBO(252, 240, 240, 1), // Daily journal
  ];
  final Map<String, IconData> habitIcons = {
    'Call parents': Icons.phone,
    'Revision': Icons.book,
    'Drink water': Icons.local_drink,
    'Go for a walk': Icons.directions_walk,
    'Daily journal': Icons.edit,
  };

  @override
  Widget build(BuildContext context) {
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
            colors: [Color(0xFF2F008E), Color(0xFF6500FF)],
          ),
        ),
        child: ListView.builder(
          itemCount: habits.length, // Number of habits
          itemBuilder: (context, index) {
            DateTime currentDate = DateTime.now();
            DateTime habitDate = currentDate.subtract(Duration(days: index));

            return Card(
              color: habitColors[index % habitColors.length],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: Icon(
                  habitIcons[habits[index]],
                  color: Color(0xFF8D8F9D),
                ),
                title: Text(
                  habits[index],
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
