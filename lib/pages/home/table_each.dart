import 'package:co_table/core.dart';
import 'package:co_table/utils/text_constant.dart';
import 'package:co_table/theme/theme_state.dart';
import 'package:flutter/material.dart';

class TableEach extends StatefulWidget {
  const TableEach({super.key});

  @override
  TableEachState createState() => TableEachState();
}

class TableEachState extends State<TableEach> {
  static const int n = 24;
  final List<bool> _isSelected = List.generate(n, (_) => false);
  final List<bool> _isConfirmed = List.generate(n, (_) => false);

  Widget _buildTableRow(int startIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildEmptyColumn(),
        _buildBoxColumn(startIndex),
        _buildBoxColumn(startIndex + 1),
        _buildEmptyColumn(),
        _buildEmptyColumn(),
        _buildBoxColumn(startIndex + 2),
        _buildBoxColumn(startIndex + 3),
        _buildEmptyColumn(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 275)),
              Column(
                children: [
                  _buildTableRow(0),
                  const SizedBox(height: 10),
                  _buildTableRow(4),
                  const SizedBox(height: 10),
                  _buildTableRow(8),
                  const SizedBox(height: 10),
                  _buildTableRow(12),
                  const SizedBox(height: 10),
                  _buildTableRow(16),
                  const SizedBox(height: 10),
                  _buildTableRow(20),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  for (int i = 0; i < n; i++) {
                    if (_isSelected[i]) {
                      _isConfirmed[i] = true;
                      _isSelected[i] = false;
                    }
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeState.buttonSelectTheme.colors[0],
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: Text(
                TextConstant.textSelect,
                style: TextStyle(
                  fontSize: 20,
                  color: ThemeState.lightTheme.colors[0],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBoxColumn(int index) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (!_isConfirmed[index]) {
              setState(() {
                _isSelected[index] = !_isSelected[index];
              });
            }
          },
          child: Container(
            width: 60,
            height: 60,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: _isConfirmed[index]
                  ? const Color(0xFF040261)
                  : _isSelected[index]
                      ? const Color(0xFF39B070)
                      : const Color(0xFFD7D5D5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyColumn() {
    return const SizedBox(width: 20);
  }
}
