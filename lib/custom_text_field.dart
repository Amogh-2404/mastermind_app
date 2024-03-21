import 'package:flutter/material.dart';

class MyCustomTextField extends StatelessWidget {
  String text;
  MyCustomTextField({Key? key,required String this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Theme(
      data: Theme.of(context).copyWith(
        textTheme: const TextTheme(
          subtitle1: TextStyle(
            color: Colors.blue, // Color for the input text and label when it is floating (after focus)
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(
            color: Colors.blue, // Color for the label when it is not floating (before focus)
          ),
          floatingLabelStyle: TextStyle(
            color: Colors.blue, // Color for the label when it is floating (after focus)
          ),
        ),
      ),
      child: TextFormField(
        cursorColor: Colors.blue, // Color for the cursor
        decoration: InputDecoration(
          labelText: '${text}',
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(100.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
            borderRadius: BorderRadius.circular(100.0),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        ),
      ),
    );
  }
}