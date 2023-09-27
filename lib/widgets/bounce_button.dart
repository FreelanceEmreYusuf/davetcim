import 'package:flutter/material.dart';
class BounceButton extends StatefulWidget {
  final Widget child;
  final Function onTap;
  final double height;
  final double width;
  final Duration duration;
  final Decoration decoration;

  const BounceButton({
    Key key,
    this.child,
    this.onTap,
    this.height,
    this.width,
    this.duration,
    this.decoration
  }) : super(key: key);

  /* KULLANIMI
  BounceButton(
    child: Text('Press me', style: TextStyle(color: Colors.white),),
    onTap: (){print('pressed');},
    height: 50,
    width: 100,
    duration: Duration(milliseconds: 500),
    decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(20)
    ),
  ),


//kalp
  BounceButton(
    child: Icon(
      Icons.favorite,
      color: Colors.red,
      size: 40,
    ),
    onTap: (){print('pressed');},
    height: 50,
    width: 100,
    duration: Duration(milliseconds: 500),
    decoration: BoxDecoration(
      shape: BoxShape.circle, // Yuvarlak şekil
      color: Colors.white70, // Düğme rengi
    ),
  ),
   */

  @override
  _BounceButtonState createState() => _BounceButtonState();
}

class _BounceButtonState extends State<BounceButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
        _controller.forward().then((_) {
          _controller.reverse();
        });
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: AnimatedContainer(
              alignment: Alignment.center,
              duration: widget.duration,
              height: widget.height,
              width: widget.width,
              decoration: widget.decoration,
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}