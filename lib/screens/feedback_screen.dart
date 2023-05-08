import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();
  int _rating = 0;
  bool _likedVenue = false;

  void _submitFeedback() async {
    if (_formKey.currentState!.validate() && _rating != 0) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('feedback').add({
        'feedback': _feedbackController.text,
        'rating': _rating,
        'liked_venue': _likedVenue,
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
              Text('Rate your experience:'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _rating = 1;
                      });
                    },
                    icon: Icon(_rating >= 1 ? Icons.star : Icons.star_border),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _rating = 2;
                      });
                    },
                    icon: Icon(_rating >= 2 ? Icons.star : Icons.star_border),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _rating = 3;
                      });
                    },
                    icon: Icon(_rating >= 3 ? Icons.star : Icons.star_border),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _rating = 4;
                      });
                    },
                    icon: Icon(_rating >= 4 ? Icons.star : Icons.star_border),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _rating = 5;
                      });
                    },
                    icon: Icon(_rating >= 5 ? Icons.star : Icons.star_border),
                  ),
                ],
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
              Text('Did you like the venue?'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _likedVenue = true;
                      });
                    },
                    child: Text('Yes'),
                    style: ElevatedButton.styleFrom(
                      primary: _likedVenue ? Colors.green : null,
                      onPrimary: Colors.white,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _likedVenue = false;
                      });
                    },
                    child: Text('No'),
                    style: ElevatedButton.styleFrom(
                      primary: !_likedVenue ? Colors.red : null,
                      onPrimary: Colors.white,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _submitFeedback,
                    child: Text('Submit'),
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: _navigateToFeedbackList,
                    child: Text('View Feedback'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
