import 'package:flutter/material.dart';
import 'package:weather_app/app_constants/constants.dart';

class PrimaryButton extends StatelessWidget {
  final Function onPressed;
  final String title;

  const PrimaryButton({Key? key, required this.onPressed, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        fixedSize: const Size(double.infinity, 55),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: Constants.white,
        ),
      ),
    );
  }
}
