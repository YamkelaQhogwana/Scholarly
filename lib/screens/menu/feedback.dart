import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum SatisfactionRating {
  verySatisfied,
  satisfied,
  neutral,
  dissatisfied,
  veryDissatisfied,
}

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final TextEditingController _messageController = TextEditingController();
  bool _wouldRecommend = true;
  SatisfactionRating _satisfactionRating = SatisfactionRating.neutral;

  Future<void> _sendFeedback() async {
    String message = _messageController.text;

    // Create a reference to the 'feedback' collection in Firestore
    CollectionReference feedbackCollection =
        FirebaseFirestore.instance.collection('feedback');

    try {
      await feedbackCollection.add({
        'message': message,
        'wouldRecommend': _wouldRecommend,
        'satisfactionRating': _satisfactionRating.toString(),
        'timestamp': DateTime.now(),
      });
      print('Feedback sent successfully!');
      Navigator.of(context).pop();
    } catch (e) {
      print('Error sending feedback: $e');
      // Handle any error that occurred while sending feedback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Center(
          child: Text(
            'Feedback',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Give us feedback',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                fontSize: 24.0,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'We’d love to hear what you think of our app.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'How satisfied are you with the app?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.sentiment_very_dissatisfied),
                  color:
                      _satisfactionRating == SatisfactionRating.veryDissatisfied
                          ? Colors.red
                          : Colors.grey,
                  onPressed: () {
                    setState(() {
                      _satisfactionRating = SatisfactionRating.veryDissatisfied;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.sentiment_dissatisfied),
                  color: _satisfactionRating == SatisfactionRating.dissatisfied
                      ? Colors.red
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      _satisfactionRating = SatisfactionRating.dissatisfied;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.sentiment_neutral),
                  color: _satisfactionRating == SatisfactionRating.neutral
                      ? Colors.amber
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      _satisfactionRating = SatisfactionRating.neutral;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.sentiment_satisfied),
                  color: _satisfactionRating == SatisfactionRating.satisfied
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      _satisfactionRating = SatisfactionRating.satisfied;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.sentiment_very_satisfied),
                  color: _satisfactionRating == SatisfactionRating.verySatisfied
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      _satisfactionRating = SatisfactionRating.verySatisfied;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Do you have any thoughts you’d like to share?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _messageController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Insert message here...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Would you recommend this app to friends?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Yes'),
                    leading: Radio(
                      value: true,
                      groupValue: _wouldRecommend,
                      onChanged: (bool? value) {
                        setState(() {
                          _wouldRecommend = value ?? false;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('No'),
                    leading: Radio(
                      value: false,
                      groupValue: _wouldRecommend,
                      onChanged: (bool? value) {
                        setState(() {
                          _wouldRecommend = value ?? false;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            SizedBox(
              width: 120.0,
              height: 38.36,
              child: ElevatedButton(
                onPressed: _sendFeedback,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFF007BC2)),
                ),
                child: const Text(
                  'Send',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'Feedback Form Demo',
    home: FeedbackForm(),
  ));
}
