import "package:flutter/material.dart";
import 'main_screen.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child:
          KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Center(
          child: Column(
            children: [
              TextField(),
              Text(
                'The keyboard is: ${isKeyboardVisible ? 'VISIBLE' : 'NOT VISIBLE'}',
              ),
            ],
          ),
        );
      })),
    );
  }
}
