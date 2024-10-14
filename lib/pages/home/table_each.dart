import 'package:co_table/core.dart';
import 'package:co_table/utils/text_constant.dart';
import 'package:co_table/theme/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';

class TableEach extends StatelessWidget {
  const TableEach({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TableBloc, TableState>(
      builder: (context, state) {
        if (state is ReadyTableState) {
          return _TableEachContent(boxCount: state.tableList.length);
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

class _TableEachContent extends StatefulWidget {
  final int boxCount;

  const _TableEachContent({required this.boxCount});

  @override
  _TableEachContentState createState() => _TableEachContentState();
}

class _TableEachContentState extends State<_TableEachContent> {
  late List<bool> _isSelected;
  late List<bool> _isConfirmed;

  @override
  void initState() {
    super.initState();
    _isSelected = List.generate(widget.boxCount, (_) => false);
    _isConfirmed = List.generate(widget.boxCount, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 30, left: 40, right: 40, bottom: 90),
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
                return _buildBoxItem(index);
              },
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _buildConfirmButton(),
        ),
      ],
    );
  }

  Widget _buildBoxItem(int index) {
    return GestureDetector(
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
        decoration: BoxDecoration(
          color: _isConfirmed[index]
              ? const Color(0xFF040261)
              : Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            '${index + 1}',
            style: TextStyle(
              color: _isConfirmed[index] ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            for (int i = 1; i < widget.boxCount; i++) {
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
    );
  }
}
