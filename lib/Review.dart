import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReviewDisplayPage extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String dob;
  final String address;
  final String email;
  final String phone;
  final String gender;
  final String review;
  final double rating;

  const ReviewDisplayPage({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.address,
    required this.email,
    required this.phone,
    required this.gender,
    required this.review,
    required this.rating,
  });

  IconData getRatingIcon() {
    if (rating == 1) {
      return Icons.sentiment_very_dissatisfied;
    } else if (rating == 2) {
      return Icons.sentiment_dissatisfied;
    } else if (rating == 3) {
      return Icons.sentiment_neutral;
    } else if (rating == 4) {
      return Icons.sentiment_satisfied;
    } else {
      return Icons.sentiment_very_satisfied;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.orange, Colors.pink],
              center: Alignment(-1, 0),
              radius: 5,
            ),
          ),
          child: AppBar(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(FontAwesomeIcons.clapperboard,
                    size: 30.0, color: Colors.white),
                const SizedBox(width: 10),
                const Text(
                  'Movie Review Submission',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'serif',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.pink],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Name: $firstName $lastName',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text('Date of Birth: $dob', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Text('Gender: $gender', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Text('Address: $address', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Text('Phone: $phone', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Text('Email: $email', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  const Text('Review:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(review, style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  const Text('Rating:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Icon(
                    getRatingIcon(),
                    color: Colors.orange,
                    size: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
