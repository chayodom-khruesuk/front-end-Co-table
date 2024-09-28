import 'package:flutter/material.dart';
import '../../core.dart';
import 'table_history.dart';

class BodyHomePage extends StatelessWidget {
  const BodyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const double boxHeight = 177;

    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.13),
      child: Column(
        children: [
          ...List.generate(4, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TableHistory(boxName: 'Box ${index + 1}'),
                  ),
                );
              },
              child: Container(
                height: boxHeight,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  gradient: ThemeState.appTheme,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Box ${index + 1}'),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
