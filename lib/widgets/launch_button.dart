import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bounce_button.dart';

Widget LaunchButton({
  String title,
  String value,
  IconData icon,
  Color color,
  BuildContext context,
  Function() onPressed,
}) {
  return  FittedBox(
    child: BounceButton(
      child: Container(
        margin: const EdgeInsets.all(4.0),
        child: FittedBox(
          child: Column(
            children: [
              Icon(icon, size: 25, color: Colors.white),
              Text(
                title,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),
              ),
              Text(
                value,
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: onPressed,
      height: MediaQuery.of(context).size.height / 8,
      width: MediaQuery.of(context).size.width / 2.5,
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5)
      ),
    ),
  );
}