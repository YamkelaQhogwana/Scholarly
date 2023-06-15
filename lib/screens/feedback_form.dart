import 'package:flutter/material.dart';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final TextEditingController _messageController = TextEditingController();
  bool _wouldRecommend = true;

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
        )),
        //centerTitle: true,
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
                  onPressed: () {
                    // Process the feedback form submission
                    String message = _messageController.text;
                    ('Feedback: $message');
                    ('Would recommend: $_wouldRecommend');
                    // Perform any other actions, such as sending the feedback to a server
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF007BC2)),
                  ),
                  child: const Text(
                    'Send',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Feedback Form Demo',
    home: FeedbackForm(),
  ));
}
