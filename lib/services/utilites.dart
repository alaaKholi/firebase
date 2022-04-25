import 'package:flutter/material.dart';

Future<dynamic> showCustomDialog(
    BuildContext context, List<Widget> actionWidget) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      actions: actionWidget,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            'https://cdn.dribbble.com/users/1283437/screenshots/4486866/checkbox-dribbble-looped-landing.gif',
            height: 100,
          ),
          SizedBox(height: 16.0),
          Text('لقد اكملت العدد المطلوب من هذ الذكر')
        ],
      ),
    ),
  );
}
