import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholarly/constants/colors.dart';
import 'package:scholarly/modules/stats.dart';
import 'package:scholarly/screens/calendar.dart';
import 'package:scholarly/screens/classes.dart';
import 'package:scholarly/screens/home.dart';
import 'package:scholarly/screens/info.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MenuStatistics extends StatelessWidget {
  const MenuStatistics({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance.collection('statistics').doc('No2dz33RIoc47qFqOTWk').get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
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

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(
            child: Text('No data found.'),
          );
        }

        final data = snapshot.data!.data()!;
        final completedHabitsCount = data['completedHabitsCount'] ?? 0;
        final completedTasksCount = data['completedTasksCount'] ?? 0;
        final habitsThisWeek = data['habitsThisWeek'] ?? '';

        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: AppColors.kMainText, size: 18),
            title: const Text(
              'Statistics',
              style: TextStyle(color: AppColors.kMainText, fontSize: 16),
            ),
            backgroundColor: const Color.fromARGB(255, 248, 248, 248),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Overview',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatBlock(
                      'Completed Tasks',
                      completedTasksCount.toString(),
                    ),
                    const SizedBox(height: 16.0),
                    _buildStatBlock(
                      'Completed Habits',
                      completedHabitsCount.toString(),
                    ),
                    const SizedBox(height: 24.0),
                  ],
                ),
                const SizedBox(height: 25.0),
                BarGraphWidget(habitsThisWeek),
              ],
            ),
          ),
          // Rest of the code...
        );
      },
    );
  }

  Widget _buildStatBlock(String label, String value) {
    return Container(
      width: 110,
      height: 110,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.kBlue,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 38.0,
              fontWeight: FontWeight.bold,
              color: AppColors.kPrimary400,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12.0,
              color: AppColors.kMainText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class BarGraphWidget extends StatelessWidget {
  final String habitsThisWeek;

  const BarGraphWidget(this.habitsThisWeek);

  @override
  Widget build(BuildContext context) {
    final dataPoints = habitsThisWeek.split(',').map((value) => int.tryParse(value) ?? 0).toList();
    final List<DataPoint> chartData = List.generate(dataPoints.length, (index) {
      return DataPoint(index, dataPoints[index]);
    });

    return Container(
      width: 350,
      height: 150,
      decoration: BoxDecoration(
        color: AppColors.kBlueLight,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(),
        series: <ChartSeries>[
          BarSeries<DataPoint, int>(
            dataSource: chartData,
            xValueMapper: (DataPoint data, _) => data.x,
            yValueMapper: (DataPoint data, _) => data.y,
          ),
        ],
      ),
    );
  }
}

class DataPoint {
  final int x;
  final int y;

  DataPoint(this.x, this.y);
}
