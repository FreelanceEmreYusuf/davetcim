import 'package:flutter/material.dart';
import '../shared/sessions/user_state.dart';

class NotificationBadge extends StatefulWidget {
  final IconData icon;
  final double size;
  final String count;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;

  NotificationBadge(
      {Key key,
        @required this.icon,
        @required this.size,
        @required this.count,
        @required this.backgroundColor,
        @required this.textColor,
        @required this.fontSize})
      : super(key: key);

  @override
  _NotificationBadgeState createState() => _NotificationBadgeState();
}

int notificationCount;
void initState() {
  notificationCount = 0;
}

@override
class _NotificationBadgeState extends State<NotificationBadge> {
  String getUserNotificationCount() {
    if (UserState.isPresent()) {
      setState(() {
        notificationCount = UserState.notificationCount;
      });
    } else
      notificationCount = 0;

    return notificationCount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Icon(
          widget.icon,
          size: widget.size,
        ),
        Positioned(
          right: 0.0,
          child: Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: BoxConstraints(
              minWidth: 13,
              minHeight: 13,
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 1),
              child: Text(
                widget.count,
                //getUserNotificationCount(),
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: widget.fontSize,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
