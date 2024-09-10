import 'package:flutter/material.dart';

class DraggableSheet extends StatefulWidget {
  final Widget child;
  final bool isVisible;
  final double initialHeight;
  const DraggableSheet({
    Key? key,
    required this.child,
    this.isVisible = false,
    this.initialHeight = 120.0,
  }) : super(key: key);
  @override
  _DraggableSheetState createState() => _DraggableSheetState();
}

class _DraggableSheetState extends State<DraggableSheet> {
  late double _sheetHeight;
  final double _minHeight = 120.0; // Minimum height of the sheet
  late double _maxHeight;

  @override
  void initState() {
    super.initState();
    _sheetHeight = widget.initialHeight;
  }

  @override
  Widget build(BuildContext context) {
    _maxHeight = MediaQuery.of(context).size.height - 0.2;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF2C313F),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: widget.isVisible ? _sheetHeight : 0.0,
          width: MediaQuery.of(context).size.width, // Full width of the screen
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              setState(() {
                // Update sheet height based on drag
                _sheetHeight -=
                    details.primaryDelta! * 2; // Adjust sensitivity here
                if (_sheetHeight < _minHeight) {
                  _sheetHeight = _minHeight;
                } else if (_sheetHeight > _maxHeight) {
                  _sheetHeight = _maxHeight;
                }
              });
            },
            onVerticalDragEnd: (details) {
              // If the drag ends, determine whether to expand or collapse the sheet
              if (_sheetHeight < (_maxHeight - _minHeight) / 2 + _minHeight) {
                setState(() {
                  _sheetHeight = _minHeight;
                });
              } else {
                setState(() {
                  _sheetHeight = _maxHeight;
                });
              }
            },
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                SizedBox(height: 16), // Add padding to the top
                widget.child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
