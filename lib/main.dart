import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:registration/Review.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Review',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        fontFamily: 'serif',
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  String _selectedGender = 'Male';
  double _rating = 3.0;

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Submission'),
          content: const Text('Are you sure you want to submit the review?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Review Submitted Successfully')),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewDisplayPage(
                      firstName: _fnameController.text,
                      lastName: _lnameController.text,
                      dob: _dobController.text,
                      address: _addressController.text,
                      email: _emailController.text,
                      phone: _phoneController.text,
                      gender: _selectedGender,
                      review: _reviewController.text,
                      rating: _rating,
                    ),
                  ),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
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
              mainAxisSize:
                  MainAxisSize.min, // Ensures the Row doesn't take full width
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
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _fnameController,
                          decoration:
                              const InputDecoration(labelText: 'First Name'),
                          validator: (value) =>
                              value!.isEmpty ? 'First name is required' : null,
                        ),
                        TextFormField(
                          controller: _lnameController,
                          decoration:
                              const InputDecoration(labelText: 'Last Name'),
                          validator: (value) =>
                              value!.isEmpty ? 'Last name is required' : null,
                        ),
                        DropdownButtonFormField<String>(
                          value: _selectedGender,
                          decoration:
                              const InputDecoration(labelText: 'Gender'),
                          items: ['Male', 'Female', 'Other']
                              .map((String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          onChanged: (newValue) =>
                              setState(() => _selectedGender = newValue!),
                          validator: (value) =>
                              value == null ? 'Gender is required' : null,
                        ),
                        TextFormField(
                          controller: _dobController,
                          decoration: const InputDecoration(
                            labelText: 'Date of Birth',
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );

                            if (pickedDate != null) {
                              setState(() {
                                _dobController.text =
                                    "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                              });
                            }
                          },
                          validator: (value) => value!.isEmpty
                              ? 'Date of birth is required'
                              : null,
                        ),
                        TextFormField(
                          controller: _addressController,
                          decoration:
                              const InputDecoration(labelText: 'Address'),
                          validator: (value) =>
                              value!.isEmpty ? 'Address is required' : null,
                        ),
                        TextFormField(
                          controller: _phoneController,
                          decoration:
                              const InputDecoration(labelText: 'Phone Number'),
                          keyboardType: TextInputType.phone,
                          validator: (value) => value!.isEmpty
                              ? 'Phone number is required'
                              : null,
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email is required';
                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _reviewController,
                          decoration:
                              const InputDecoration(labelText: 'Movie Review'),
                          maxLines: 3,
                          validator: (value) =>
                              value!.isEmpty ? 'Review is required' : null,
                        ),
                        const SizedBox(height: 10),
                        const Text('Rating:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => setState(() => _rating = 1),
                              child: Icon(
                                Icons.sentiment_very_dissatisfied,
                                color:
                                    _rating >= 1 ? Colors.orange : Colors.grey,
                                size: 40,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => setState(() => _rating = 2),
                              child: Icon(
                                Icons.sentiment_dissatisfied,
                                color:
                                    _rating >= 2 ? Colors.orange : Colors.grey,
                                size: 40,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => setState(() => _rating = 3),
                              child: Icon(
                                Icons.sentiment_neutral,
                                color:
                                    _rating >= 3 ? Colors.orange : Colors.grey,
                                size: 40,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => setState(() => _rating = 4),
                              child: Icon(
                                Icons.sentiment_satisfied,
                                color:
                                    _rating >= 4 ? Colors.orange : Colors.grey,
                                size: 40,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => setState(() => _rating = 5),
                              child: Icon(
                                Icons.sentiment_very_satisfied,
                                color:
                                    _rating >= 5 ? Colors.orange : Colors.grey,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _showConfirmationDialog();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Please fill all required fields')),
                                );
                              }
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  colors: [Colors.orange, Colors.pink],
                                  center: Alignment(-1, 0),
                                  radius: 5,
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 32.0),
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
