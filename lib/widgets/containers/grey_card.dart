import 'package:flutter/material.dart';

class GreyCard extends StatelessWidget {
  final Widget child;
  const GreyCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color.fromRGBO(235, 235, 235, 0.75),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.21),
            spreadRadius: 0,
            blurRadius: 6,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ]
      ),
      child: child,
    );
  }
}
