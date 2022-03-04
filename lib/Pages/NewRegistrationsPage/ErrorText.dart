import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {

  TextEditingController _controller = new TextEditingController();




  @override
  Widget build(BuildContext context) {
    _controller.text = 'Brak połączenia z serwerem';
    return Container(
            child: TextField(
              style: TextStyle(
                color: Colors.red
              ),
              readOnly: true,
        controller: _controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),

        ),
      ),
    );
  }
}