
import 'package:flutter/material.dart';

class YEqualSpaceLabel extends StatelessWidget {
  const YEqualSpaceLabel({Key? key, required this.text, required this.width, required this.style}) : super(key: key);
  final String text;
  final double width;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _getChildren(),
    ),);
  }

  List<Widget> _getChildren() {
    List<Widget> result = [];
    for (int index = 0; index < text.length; index++) {
      final currentCharacter = text.substring(index, index + 1);
      final textWidget = Text(currentCharacter, style: style,);
      result.add(textWidget);
    }
    return result;
  }
}
