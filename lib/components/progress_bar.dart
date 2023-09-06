import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.currentQuestionIndex, required this.length});
  final int currentQuestionIndex;
  final int length;

  @override
  Widget build(BuildContext context) {
    double getProgressBarValue() {
      return currentQuestionIndex / length;
    }

    return LinearProgressIndicator(
      value: getProgressBarValue(),
      backgroundColor: Colors.grey,
      color: Colors.deepPurple,
    );
  }
}
