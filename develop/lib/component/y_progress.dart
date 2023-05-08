import 'package:flutter/material.dart';

class YProgressView extends StatelessWidget {
  const YProgressView({
    Key? key,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.progressHeight,
    required this.progress,
    required this.cornerRadius,
    this.minProgress = 0.01,
  }) : super(key: key);

  // 背景色
  final Color backgroundColor;
  // 前景色
  final Color foregroundColor;
  // 进度条高度
  final double progressHeight;
  // 进度
  final double progress;
  // 圆角
  final double cornerRadius;
  // 最小显示的进度条：小于此进度且不为0的时候，会展示一个向左对齐的小圆点进度
  final double? minProgress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: progressHeight,
      child: Stack(children: [
        FractionallySizedBox(
          alignment: Alignment.topLeft,
          widthFactor: 1,
          heightFactor: 1,
          child: Container(
            height: progressHeight,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(cornerRadius),
            ),
          ),
        ),
        Visibility(
          visible: progress > 0.01,
          child: FractionallySizedBox(
            alignment: Alignment.topLeft,
            widthFactor: progress,
            heightFactor: 1,
            child: Container(
              height: progressHeight,
              decoration: BoxDecoration(
                color: foregroundColor,
                borderRadius: BorderRadius.circular(cornerRadius),
              ),
            ),
          ),
        ),
        Visibility(
          visible: progress <= 0.01 && progress > 0,
          child: Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: progressHeight,
              height: progressHeight,
              decoration: BoxDecoration(
                color: foregroundColor,
                borderRadius: BorderRadius.circular(cornerRadius),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
