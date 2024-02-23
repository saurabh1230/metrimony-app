import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void _showCustomPopupMenu(BuildContext context) {
  Navigator.of(context).push(_customPopupPageRoute());
}

PageRouteBuilder _customPopupPageRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return CustomPopupMenu();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
  );
}


class CustomPopupMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: 400,
          width: 300,
          color: Colors.white,
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text('Option 1'),
                onTap: () {
                  // Handle Option 1
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Option 2'),
                onTap: () {
                  // Handle Option 2
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}