import 'dart:ui';

import 'package:flutter/material.dart';

class BlurDialog extends StatelessWidget {
  final Widget child;

  const BlurDialog({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Dialog(
        backgroundColor: Colors.white.withOpacity(0.9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: child,
      ),
    );
  }
}
