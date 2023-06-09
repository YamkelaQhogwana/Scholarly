import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AdminMessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Messages'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('feedback').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final feedbacks = snapshot.data!.docs;
          final feedbackCount = feedbacks.length;

          return ListView.builder(
            itemCount: feedbackCount,
            itemBuilder: (context, index) {
              final feedback = feedbacks[index].data() as Map<String, dynamic>;
              final message = feedback['message'] as String;
              final satisfactionRating =
                  feedback['satisfactionRating'] as String;
              final timeStamp = feedback['timestamp'] as Timestamp;
              final wouldRecommend = feedback['wouldRecommend'] as bool;

              // Convert timestamp to readable time format
              final dateTime = timeStamp.toDate();
              final formattedTime =
                  DateFormat('yyyy-MM-dd HH:mm').format(dateTime);

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Rating: $satisfactionRating',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Timestamp: $formattedTime',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Would Recommend: ${wouldRecommend ? 'Yes' : 'No'}',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
