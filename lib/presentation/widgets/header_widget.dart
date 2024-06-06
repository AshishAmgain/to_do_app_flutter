import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        text: 'Manage your \n',
        style: TextStyle(fontSize: 30, color: Colors.black),
        children: [
          TextSpan(
            text: 'Todos',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: ' in your elegant \n',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          TextSpan(
            text: 'Todopad',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
