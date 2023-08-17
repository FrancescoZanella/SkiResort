import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:ski_resorts_app/phone/screens/settings/rate_our_app_screen/user_rating.dart';
import 'package:firebase_database/firebase_database.dart';

final url = Uri.https(
  'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
  '/user-review-table.json',
);

Future<void> updateDataOnFirebase(String userId, field, newValue) async {
  // Create a reference to the specific user entry
  final DatabaseReference userRef =
      FirebaseDatabase.instance.ref().child('user-review-table').child(userId);

  // update the user entries in the firebase realtime database
  await userRef.update({field: newValue});
}

class RateOurAppScreen extends StatefulWidget {
  const RateOurAppScreen({Key? key}) : super(key: key);

  @override
  State<RateOurAppScreen> createState() => _RateOurAppScreenState();
}

class _RateOurAppScreenState extends State<RateOurAppScreen> {
  final _formKey = GlobalKey<FormState>();
  List<UserRating> userRatings = [];
  double _rating = 0.0;
  String _feedback = '';
  String? _name;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _getUserNameAndId();
    _getUserRatings();
  }

  void _getUserRatings() async {
    final postResponse = await http.get(url);
    if (postResponse.statusCode == 200) {
      // Check if the response body is not null before trying to decode it
      Map<String, dynamic>? data = json.decode(postResponse.body);
      // Check if 'data' is not null before trying to use it
      if (data != null) {
        List<UserRating> tempRatings = [];

        data.forEach((key, value) {
          tempRatings.add(
            UserRating(
              value['userName'],
              (value['rating']).toDouble(),
              value['feedback'],
            ),
          );
        });

        setState(() {
          userRatings = tempRatings;
        });
      } else {
        if (kDebugMode) {
          print('Failed to load user ratings: ${postResponse.statusCode}');
        }
      }
    }
  }

  void _getUserNameAndId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Assuming the username is stored under the key 'username'
    String? name = prefs.getString('name');
    String? userId = prefs.getString('userId');
    setState(() {
      _name = name;
      _userId = userId;
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create a map with the user review data
      Map<String, dynamic> userReview = {
        'userId': _userId,
        'userName': _name,
        'rating': _rating,
        'feedback': _feedback,
      };

      // Convert the map to a JSON string
      String body = json.encode(userReview);

      final getResponse = await http.get(url);
      if (getResponse.statusCode == 200) {
        // search if the user has already left a review
        Map<String, dynamic>? data = json.decode(getResponse.body);
        // Check if 'data' is not null before trying to use it
        //if data is null, it means that the user has not left a review yet
        if (data == null) {
          // Send the data to Firestore
          final postResponse = await http.post(url,
              headers: {'Content-Type': 'application/json'}, body: body);

          if (postResponse.statusCode == 200) {
            // Show a success message
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Thank you for your feedback!')));
            }
          } else {
            if (mounted) {
              // If the server returns an error
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to submit feedback')));
            }
          }
        } else {
          for (var entry in data.entries) {
            var id = entry.key; // The unique Firebase ID
            var user = entry.value;
            if (user['userId'] == _userId) {
              // If the user has already left a review, modify the existing review
              await updateDataOnFirebase(id, 'rating', _rating);
              await updateDataOnFirebase(id, 'feedback', _feedback);
              await updateDataOnFirebase(id, 'userName', _name);
            } else {
              // If the user has not left a review, add a new review
              // Send the data to Firestore
              final postResponse = await http.post(url,
                  headers: {'Content-Type': 'application/json'}, body: body);

              if (postResponse.statusCode == 200) {
                // Show a success message
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Thank you for your feedback!')));
                }
              } else {
                if (mounted) {
                  // If the server returns an error
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Failed to submit feedback')));
                }
              }
            }
          }
        }
      }
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
              const SizedBox(height: 30),
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
                color: Theme.of(context).dividerColor,
                thickness: 2.0,
                height: 50.0,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: userRatings.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                          height:
                              8.0), // This will add space between containers
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Theme.of(context).colorScheme.background
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 16),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'User: ${userRatings[index].name}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.color
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                // Padding for RatingBarIndicator
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: RatingBarIndicator(
                                  rating: userRatings[index].stars,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 20.0,
                                  direction: Axis.horizontal,
                                ),
                              ),
                              const SizedBox(
                                  height:
                                      8), // Added space between stars and the review

                              Padding(
                                // Padding for Review
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'Review: ${userRatings[index].comment}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.color
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
