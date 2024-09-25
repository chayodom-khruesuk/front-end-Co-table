import 'package:flutter/material.dart';
import '../../widget/search.dart';
import 'body_home_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text("welcome"),
        ),
        const Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            "welcome",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.only(
              left: 36,
              top: 28,
              right: 36,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: const Column(
              children: [
                SearchWidget(),
                SizedBox(height: 20),
                Expanded(child: BodyHomePage()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
