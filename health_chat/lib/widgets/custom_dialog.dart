import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  const CustomAlertDialog({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold),),
      content: Text(content),
      actions: <Widget>[
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text('OK', style:TextStyle(color: theme.primaryColor, fontWeight: FontWeight.bold)
    ),
        )
      ],
    );
  }
}
