import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../size_constant.dart';

class SnackBarHelper {
  static void showSuccessSnackBar(BuildContext context,
      {required String title, required String message}) {
    _showSnackBar(context,
        title: title,
        message: message,
        backgroundColor: Colors.green,
        icon: LineAwesomeIcons.check_circle);
  }

  static void showWarningSnackBar(BuildContext context,
      {required String title, required String message}) {
    _showSnackBar(context,
        title: title,
        message: message,
        backgroundColor: Colors.orange,
        icon: LineAwesomeIcons.exclamation_circle_solid);
  }

  static void showErrorSnackBar(BuildContext context,
      {required String title, required String message}) {
    _showSnackBar(context,
        title: title,
        message: message,
        backgroundColor: Colors.red.shade600,
        icon: LineAwesomeIcons.times_circle);
  }

  static void showModernSnackBar(BuildContext context,
      {required String title, required String message}) {
    _showSnackBar(context,
        title: title, message: message, backgroundColor: Colors.blueGrey);
  }

  static void _showSnackBar(
    BuildContext context, {
    required String title,
    required String message,
    required Color backgroundColor,
    IconData? icon,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (icon != null) Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(message),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 6),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(SizeConstant.defaultPadding - 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
