import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateOurAppScreen extends StatefulWidget {
  const RateOurAppScreen({Key? key}) : super(key: key);

  @override
  State<RateOurAppScreen> createState() => _RateOurAppScreenState();
}

class _RateOurAppScreenState extends State<RateOurAppScreen> {
  final _formKey = GlobalKey<FormState>();
  double _rating = 0.0;
  String _feedback = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Send the data to Firestore or your server
      if (kDebugMode) {
        print('Rating: $_rating'); //TODO: Send to FIREBASE
        print('Feedback: $_feedback');
      }

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thank you for your feedback!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate Our App'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Leave your feedback'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your feedback';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _feedback = value!;
                  });
                },
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
