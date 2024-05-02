import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  QuizState createState() => QuizState();
}

class QuizState extends State<Quiz> {
  int _currentQuestion = 0;
  final List<int> _answers = [];
  bool _quizCompleted = false; // Track if the quiz is completed

  static const List<String> _questions = [
    '1. What\'s your preferred everyday attire?',
    '2. Which footwear would you most likely choose for a casual outing?',
    '3. What\'s your ideal attire for a formal event?',
    '4. Which accessories do you gravitate towards?',
    '5. How do you prefer to style your hair on a typical day?',
    '6. Which color palette dominates your wardrobe?',
    '7. When shopping for clothes, what\'s your priority?',
  ];

  static const List<List<String>> _options = [
    [
      'a. Jeans and a t-shirt',
      'b. Nice pants and a shirt',
      'c. Flowy skirts or loose pants',
      'd. High-waisted jeans or a retro dress',
      'e. Pants and a nice blouse',
      'f. Mix and match different styles'
    ],
    [
      'a. Sneakers',
      'b. Loafers or oxfords',
      'c. Sandals or ankle boots',
      'd. Vintage-style shoes',
      'e. Ballet flats or heels',
      'f. Funky shoes'
    ],
    [
      'a. Long dress or a top with pants',
      'b. Dressy outfit or a suit',
      'c. Flowy dress or a skirt with a blouse',
      'd. Retro outfit or a suit',
      'e. Little black dress or a fitted suit',
      'f. Standout outfit'
    ],
    [
      'a. Watch and a cap',
      'b. Watch and cufflinks',
      'c. Lots of jewelry',
      'd. Vintage accessories',
      'e. Simple jewelry',
      'f. Bold accessories'
    ],
    [
      'a. Leave it down or in a messy bun',
      'b. Sleek bun or a ponytail',
      'c. Waves or braids',
      'd. Retro curls',
      'e. Smooth blowout or a chignon',
      'f. Funky updo'
    ],
    [
      'a. Neutrals like black, white, and gray',
      'b. Earth tones like brown and green',
      'c. Bright colors and prints',
      'd. Pastels and floral patterns',
      'e. Classic colors like navy and burgundy',
      'f. Mix of different colors and patterns'
    ],
    [
      'a. Comfort and ease',
      'b. Quality and durability',
      'c. Expressing your style',
      'd. Finding unique vintage pieces',
      'e. Timeless and elegant',
      'f. Trying new styles and trends'
    ],
  ];

  static const List<String> _styles = [
    'Casual',
    'Formal',
    'Bohemian',
    'Vintage',
    'Classic',
    'Artsy',
  ];

  void _selectAnswer(int answer) {
    setState(() {
      _answers.add(answer);
      if (_currentQuestion < _questions.length - 1) {
        _currentQuestion++;
      } else {
        _showResult();
      }
    });
  }

  void _showResult() {
    int maxCount = 0;
    int maxIndex = 0;
    for (int i = 0; i < 6; i++) {
      int count = _answers.where((answer) => answer == i).length;
      if (count > maxCount) {
        maxCount = count;
        maxIndex = i;
      }
    }

    final userStyle = _styles[maxIndex];

    // Save the style result to Firestore
    FirebaseFirestore.instance.collection('quizResults').add({
      'userId': FirebaseAuth.instance.currentUser?.uid,
      'style': userStyle,
    });

    setState(() {
      _quizCompleted = true; // Set quiz as completed
    });

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              'Your Style',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500
              ),
            ),
          ),
          content: Text(
            'Based on your answers, your preferred style is $userStyle. View the images in the results.',
            style: const TextStyle(
              fontSize: 18,
              fontFamily: "Montserrat"
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Navigate back to the previous screen
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Style Suggester",
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: _quizCompleted
          ? const Center(child: Text('Quiz completed'))
          : _currentQuestion < _questions.length
              ? Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            _questions[_currentQuestion],
                            style: const TextStyle(
                              fontSize: 17.0,
                              fontFamily: "Montserrat"
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: ListView.builder(
                          itemCount: _options[_currentQuestion].length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(
                                _options[_currentQuestion][index],
                                style: const TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 14
                                ),
                              ),
                              onTap: () {
                                _selectAnswer(index);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
    );
  }
}