import 'package:flutter/material.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({
    required this.visibility,
    required this.message,
    super.key,
  });

  final bool visibility;
  final String message;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      height: visibility ? 60 : 0,
      color: Colors.black.withOpacity(0.1),
      child: Center(
        child: Text(
          message,
        ),
      ),
    );
  }
}
