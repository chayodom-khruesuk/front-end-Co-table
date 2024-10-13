import 'package:co_table/core.dart';
import 'package:co_table/utils/text_constant.dart';
import 'package:co_table/theme/theme_state.dart';
import 'package:flutter/material.dart';

class TableEach extends StatefulWidget {
  final int boxCount;

  const TableEach({super.key, required this.boxCount});

  @override
  TableEachState createState() => TableEachState();
}

class TableEachState extends State<TableEach> {
  late List<bool> _isSelected;
  late List<bool> _isConfirmed;

  @override
  void initState() {
    super.initState();
    _isSelected = List.generate(widget.boxCount, (_) => false);
    _isConfirmed = List.generate(widget.boxCount, (_) => false);
  }

  Widget _buildTableGrid() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 40, right: 40, bottom: 50),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: widget.boxCount,
        itemBuilder: (context, index) {
          return _buildBoxColumn(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: _buildTableGrid(),
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
                  for (int i = 0; i < widget.boxCount; i++) {
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
    return GestureDetector(
      onTap: () {
        if (!_isConfirmed[index]) {
          setState(() {
            _isSelected[index] = !_isSelected[index];
          });
        }
      },
      child: Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: _isConfirmed[index]
              ? const Color(0xFF040261)
              : Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
