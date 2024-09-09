import 'package:flutter/material.dart';

import '../../theme/widget/clip_path.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipPath(
        clipper: CustomClipPath(),
        child: Container(
          color: Colors.blue,
        ),
      ),
    );
  }
}
