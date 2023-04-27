import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();

  void _submitFeedback() async {
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('feedback').add({
        'feedback': _feedbackController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });
      Navigator.pop(context);
    }
  }

  void _navigateToFeedbackList() {
    Navigator.pushNamed(context, '/feedbackList');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Feedback'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How was the event?',
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _feedbackController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide some feedback';
                  }
                  return null;
                },
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Enter your feedback here',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: _submitFeedback,
                  child: Text('Submit Feedback'),
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: _navigateToFeedbackList,
                  child: Text('View Feedback List'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

