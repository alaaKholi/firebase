import '/models/Zker_model.dart';
import '../constants.dart';
import '/ui/screens/details_screen.dart';
import 'package:flutter/material.dart';

class CustomZekerWidget extends StatelessWidget {
  const CustomZekerWidget(
    this.zeker, {
    Key? key,
  }) : super(key: key);
  final Zker zeker;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailsScreen.routeName,
            arguments: {'zeker': zeker});
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[300],
            boxShadow: [
              BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 10)
            ]),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                child: Text('${zeker.counter} / ${zeker.targetCount}'),
                minRadius: 25,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(zeker.title),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: mainColor,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, DetailsScreen.routeName,
                      arguments: {'zeker': zeker});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
