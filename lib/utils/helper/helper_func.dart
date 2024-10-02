import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../size_constant.dart';

class SnackBarHelper {
  static void showSuccessSnackBar(BuildContext context,
      {required String title,
      required String message,
      Duration duration = const Duration(seconds: 3)}) {
    _showSnackBar(context,
        title: title,
        message: message,
        backgroundColor: Colors.green,
        icon: LineAwesomeIcons.check_circle,
        duration: duration);
  }

  static void showWarningSnackBar(BuildContext context,
      {required String title,
      required String message,
      Duration duration = const Duration(seconds: 3)}) {
    _showSnackBar(context,
        title: title,
        message: message,
        backgroundColor: Colors.orange,
        icon: LineAwesomeIcons.exclamation_circle_solid,
        duration: duration);
  }

  static void showErrorSnackBar(BuildContext context,
      {required String title,
      required String message,
      Duration duration = const Duration(seconds: 3)}) {
    _showSnackBar(context,
        title: title,
        message: message,
        backgroundColor: Colors.red.shade600,
        icon: LineAwesomeIcons.times_circle,
        duration: duration);
  }

  static void showModernSnackBar(BuildContext context,
      {required String title,
      required String message,
      Duration duration = const Duration(seconds: 3)}) {
    _showSnackBar(context,
        title: title,
        message: message,
        backgroundColor: Colors.blueGrey,
        duration: duration);
  }

  static void _showSnackBar(
    BuildContext context, {
    required String title,
    required String message,
    required Color backgroundColor,
    IconData? icon,
    required Duration duration,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        final scaffoldMessenger = ScaffoldMessenger.of(context);
        scaffoldMessenger.showSnackBar(
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
                      Text(
                        title,
                        style: GoogleFonts.notoSansThai(
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(message, style: GoogleFonts.notoSansThai()),
                    ],
                  ),
                ),
              ],
            ),
            backgroundColor: backgroundColor,
            duration: duration,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(SizeConstant.defaultPadding - 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            action: SnackBarAction(
              label: 'X',
              textColor: Colors.white,
              onPressed: () {
                scaffoldMessenger.hideCurrentSnackBar();
              },
            ),
          ),
        );
      }
    });
  }
}
