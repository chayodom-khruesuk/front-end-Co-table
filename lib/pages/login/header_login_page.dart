import 'package:flutter/material.dart';

import '../../utils/image_constant.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 42),
      child: Column(
        children: [
          SizedBox(
            height: 106,
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Image.asset(ImageConstant.imgGroup),
              ],
            ),
          )
        ],
      ),
    );
  }
}
