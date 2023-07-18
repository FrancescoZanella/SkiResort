import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ski_resorts_app/old_screens/settings/rate_our_app_screen/user_rating.dart';

class RateOurAppScreen extends StatefulWidget {
  const RateOurAppScreen({Key? key}) : super(key: key);

  @override
  State<RateOurAppScreen> createState() => _RateOurAppScreenState();
}

class _RateOurAppScreenState extends State<RateOurAppScreen> {
  final _formKey = GlobalKey<FormState>();
  double _rating = 0.0;
  String _feedback = '';

  List<UserRating> userRatings = [
    UserRating('User 1', 4.5, 'Great app!'),
    UserRating('User 2', 3.0, 'Good app.'),
    UserRating('User 3', 5.0, 'Best app ever!'),
    // Add more ratings here...
  ];

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
              const SizedBox(height: 50), // space below AppBar
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
              const SizedBox(height: 30), // space below RatingBar
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
                maxLines: 5,
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
              Divider(
                color: Theme.of(context).dividerColor, // This adds the line
                thickness: 2.0,
                height: 50.0, // This adds space below the line
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: userRatings.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'User: ${userRatings[index].name}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          RatingBar.builder(
                            initialRating: userRatings[index].stars,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            ignoreGestures: true,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          Text('Comment: ${userRatings[index].comment}'),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
