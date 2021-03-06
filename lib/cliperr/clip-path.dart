import 'package:flutter/material.dart';

class CustomClipperWidget extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height);
    var firstEndPoint = Offset(size.width * 0.5, size.height - 30);
    var firstControlPoint = Offset(size.width * 0.25, size.height - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    var secondEndPoint = Offset(size.width, size.height - 80);
    var secondControl = Offset(size.width * 0.75, size.height - 10);
    path.quadraticBezierTo(secondControl.dx, secondControl.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
