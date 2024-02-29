import 'package:flutter/material.dart';
import 'package:para_drivers/main.dart';

class BlockDialog extends StatelessWidget
{
  final String? message;
  BlockDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 20,
          ),
          const SizedBox(height: 15,),
          Text(
            message!,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        const SizedBox(height: 15,),
        ElevatedButton(
          child: const Center(
            child: Text("OK"),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
          ),
          onPressed: ()
          {
            MyApp.restartApp(context);
          },
        ),
      ],
    );
  }
}