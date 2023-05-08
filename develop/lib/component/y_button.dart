import 'package:flutter/material.dart';

/// 按钮的样式
enum YButtonStyle {
  // 只有图标
  icon,
  // 只有标题
  title,
  // 图标在右，标题在左
  iconAndTitleRToL,
  // 图标在左，标题在右
  iconAndTitleLToR,
  // 图标在上，标题在下
  iconAndTitleTToB,
  // 图标在下，标题在上
  iconAndTitleBToT,
}

enum YButtonStatus {
  normal,
  selected,
  disable,
}

/// 生成一个指定样式的按钮(如果设置了一般状态，而未设置其他状态的效果，当按钮处于其它状态时，会默认使用一般状态的效果; 如果未设置宽高，会根据内容自动匹配宽高)
class YButton extends StatefulWidget {
  factory YButton.create(
      {GlobalKey? globalKey,
      YButtonStyle? buttonStyle,
      YButtonStatus? buttonStatus,
      VoidCallback? onPress,
      double? width,
      double? height,
      Widget? titleWidget,
      Widget? iconWidget,
      double? spaceBetweenTitleAndIcon,
      Color? backgroundColor,
      BorderRadiusGeometry? boardRadius,
      BoxBorder? border,
      Widget? selectTitleWidget,
      Widget? selectIconWidget,
      Color? selectBackgroundColor,
      BorderRadiusGeometry? selectBoardRadius,
      BoxBorder? selectBorder,
      Widget? disableTitleWidget,
      Widget? disableIconWidget,
      Color? disableBackgroundColor,
      BorderRadiusGeometry? disableBoardRadius,
      BoxBorder? disableBorder,
      EdgeInsetsGeometry? margin}) {
    return YButton(
      globalKey: globalKey ?? GlobalKey(),
      buttonStyle: buttonStyle ?? YButtonStyle.title,
      initialStatus: YButtonStatus.normal,
      onPress: onPress,
      width: width,
      height: height,
      titleWidget: titleWidget,
      iconWidget: iconWidget,
      spaceBetweenTitleAndIcon: spaceBetweenTitleAndIcon ?? 2,
      backgroundColor: backgroundColor,
      boardRadius: boardRadius,
      border: border,
      selectTitleWidget: selectTitleWidget,
      selectIconWidget: selectIconWidget,
      selectBackgroundColor: selectBackgroundColor,
      selectBoardRadius: selectBoardRadius,
      selectBorder: selectBorder,
      disableTitleWidget: disableTitleWidget,
      disableIconWidget: disableIconWidget,
      disableBackgroundColor: disableBackgroundColor,
      disableBoardRadius: disableBoardRadius,
      disableBorder: disableBorder,
      margin: margin,
    );
  }

  const YButton(
      {required this.globalKey,
      required this.buttonStyle,
      required this.initialStatus,
      this.onPress,
      this.width,
      this.height,
      this.titleWidget,
      this.iconWidget,
      this.spaceBetweenTitleAndIcon = 2,
      this.backgroundColor,
      this.boardRadius,
      this.border,
      this.selectTitleWidget,
      this.selectIconWidget,
      this.selectBackgroundColor,
      this.selectBoardRadius,
      this.selectBorder,
      this.disableTitleWidget,
      this.disableIconWidget,
      this.disableBackgroundColor,
      this.disableBoardRadius,
      this.disableBorder,
      this.margin})
      : assert(
          margin == null || width == null,
          '不能同时设置外边距和控件尺寸',
        ),
        assert(
          margin == null || height == null,
          '不能同时设置外边距和控件尺寸',
        ),
        assert(
          margin == null || height == null,
          '不能同时设置外边距和控件尺寸',
        ),
        super(key: globalKey);

  final GlobalKey globalKey;
  final YButtonStyle buttonStyle;
  final YButtonStatus initialStatus;

  // 图标和标题之间的间距
  final double spaceBetweenTitleAndIcon;
  final VoidCallback? onPress;

  // 控件宽度
  final double? width;

  // 控件高度
  final double? height;

  // 外边距
  final EdgeInsetsGeometry? margin;

  /// 一般状态的UI效果
  final Widget? titleWidget;
  final Widget? iconWidget;
  final Color? backgroundColor;
  final BorderRadiusGeometry? boardRadius;
  final BoxBorder? border;

  /// 选中状态的UI效果
  final Widget? selectTitleWidget;
  final Widget? selectIconWidget;
  final Color? selectBackgroundColor;
  final BorderRadiusGeometry? selectBoardRadius;
  final BoxBorder? selectBorder;

  /// 不可能点击状态的UI效果
  final Widget? disableTitleWidget;
  final Widget? disableIconWidget;
  final Color? disableBackgroundColor;
  final BorderRadiusGeometry? disableBoardRadius;
  final BoxBorder? disableBorder;

  @override
  State<YButton> createState() => _YButtonState();

  /// 修改按钮状态
  void changeButtonStatus(YButtonStatus buttonStatus) {
    _YButtonState state = globalKey.currentState as _YButtonState;
    state.changeButtonStatus(buttonStatus);
  }
}

class _YButtonState extends State<YButton> {
  late YButtonStatus _buttonStatus;

  /// 修改按钮状态
  void changeButtonStatus(YButtonStatus buttonStatus) {
    _buttonStatus = buttonStatus;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _buttonStatus = widget.initialStatus;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: _getContent(),
      onTap: () {
        _buttonClicked();
      },
    );
  }

  void _buttonClicked() {
    switch (_buttonStatus) {
      case YButtonStatus.normal:
        _buttonStatus = YButtonStatus.selected;
        setState(() {});
        break;
      case YButtonStatus.selected:
        _buttonStatus = YButtonStatus.normal;
        setState(() {});
        break;
      case YButtonStatus.disable:
        break;
    }
    if (widget.onPress != null) {
      widget.onPress!();
    }
  }

  // 获取内容视图
  Widget _getContent() {
    Widget result;

    switch (widget.buttonStyle) {
      case YButtonStyle.title:
        result = _justTitle();
        break;
      case YButtonStyle.icon:
        result = _justIcon();
        break;
      default:
        result = _iconAndTitle();
        break;
    }
    return result;
  }

  // 仅显示标题
  Widget _justTitle() {
    if (widget.titleWidget == null) return Container();
    Widget usedTitleWidget = widget.titleWidget!;

    final decoration = _getBoxDecoration();

    usedTitleWidget = Container(
      alignment: Alignment.center,
      width: widget.width,
      height: widget.height,
      decoration: decoration,
      child: Container(
        margin: widget.margin,
        child: usedTitleWidget,
      ),
    );

    return usedTitleWidget;
  }

  // 仅显示icon
  Widget _justIcon() {
    if (widget.iconWidget == null) return Container();
    Widget usedIconWidget = widget.iconWidget!;

    final decoration = _getBoxDecoration();
    usedIconWidget = Container(
      width: widget.width,
      height: widget.height,
      decoration: decoration,
      child: Container(
        margin: widget.margin,
        child: usedIconWidget,
      ),
    );

    return usedIconWidget;
  }

  // icon和title都需要显示
  Widget _iconAndTitle() {
    if (widget.iconWidget == null || widget.titleWidget == null) {
      return Container();
    }

    Widget usedTitleWidget = _getTitleWidget()!;
    Widget usedIconWidget = _getIconWidget()!;

    final decoration = _getBoxDecoration();
    Widget result = _getIconAndTitleContent(usedTitleWidget, usedIconWidget);
    result = Container(
      width: widget.width,
      height: widget.height,
      decoration: decoration,
      child: Container(margin: widget.margin, child: result),
    );
    return result;
  }

  Widget? _getTitleWidget() {
    Widget? titleWidget = widget.titleWidget;
    switch (_buttonStatus) {
      case YButtonStatus.normal:
        break;
      case YButtonStatus.selected:
        titleWidget = widget.selectTitleWidget ?? titleWidget;
        break;
      case YButtonStatus.disable:
        titleWidget = widget.disableTitleWidget ?? titleWidget;
        break;
    }
    return titleWidget;
  }

  Widget? _getIconWidget() {
    Widget? iconWidget = widget.iconWidget;
    switch (_buttonStatus) {
      case YButtonStatus.normal:
        break;
      case YButtonStatus.selected:
        iconWidget = widget.selectIconWidget ?? iconWidget;
        break;
      case YButtonStatus.disable:
        iconWidget = widget.disableIconWidget ?? iconWidget;
        break;
    }
    return iconWidget;
  }

  // 获取装饰视图
  BoxDecoration? _getBoxDecoration() {
    Color? backgroundColor = widget.backgroundColor;
    BorderRadiusGeometry? boardRadius = widget.boardRadius;
    BoxBorder? border = widget.border;

    switch (_buttonStatus) {
      case YButtonStatus.normal:
        break;
      case YButtonStatus.selected:
        backgroundColor = _getBackgroundColor(widget.selectBackgroundColor);
        boardRadius = _getBorderRadius(widget.selectBoardRadius);
        border = _getBorder(widget.selectBorder);
        break;
      case YButtonStatus.disable:
        backgroundColor = _getBackgroundColor(widget.disableBackgroundColor);
        boardRadius = _getBorderRadius(widget.disableBoardRadius);
        border = _getBorder(widget.disableBorder);
        break;
    }
    if (backgroundColor != null || boardRadius != null || border != null) {
      return BoxDecoration(
          color: backgroundColor, borderRadius: boardRadius, border: border);
    }
    return null;
  }

  // 获取背景色
  Color? _getBackgroundColor(Color? giveColor) {
    return giveColor ?? widget.backgroundColor;
  }

  // 获取圆角
  BorderRadiusGeometry? _getBorderRadius(
      BorderRadiusGeometry? giveBorderRadius) {
    return giveBorderRadius ?? widget.boardRadius;
  }

  // 获取边框
  BoxBorder? _getBorder(BoxBorder? giveBorder) {
    return giveBorder ?? widget.border;
  }

  /// 获取同时有图标和标题时图标和标题的组合的视图
  Widget _getIconAndTitleContent(Widget titleWidget, Widget iconWidget) {
    Widget result;
    // 因为执行此方法的前提条件式同时有图标和标题，所以switch中只处理同时有图标和标题的情况即可
    List<Widget> children;
    switch (widget.buttonStyle) {
      case YButtonStyle.iconAndTitleRToL:
        children = [
          titleWidget,
          SizedBox(
            height: widget.spaceBetweenTitleAndIcon,
          ),
          iconWidget
        ];
        break;
      case YButtonStyle.iconAndTitleBToT:
        children = [
          titleWidget,
          SizedBox(
            width: widget.spaceBetweenTitleAndIcon,
          ),
          iconWidget
        ];
        break;
      case YButtonStyle.iconAndTitleTToB:
        children = [
          iconWidget,
          SizedBox(
            height: widget.spaceBetweenTitleAndIcon,
          ),
          titleWidget
        ];
        break;
      case YButtonStyle.iconAndTitleLToR:
        children = [
          iconWidget,
          SizedBox(
            width: widget.spaceBetweenTitleAndIcon,
          ),
          titleWidget
        ];
        break;
      default:
        children = [];
        break;
    }

    switch (widget.buttonStyle) {
      case YButtonStyle.iconAndTitleRToL:
      case YButtonStyle.iconAndTitleLToR:
        result = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        );
        break;
      case YButtonStyle.iconAndTitleTToB:
      case YButtonStyle.iconAndTitleBToT:
        result = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: children,
        );
        break;
      default:
        result = Container();
        break;
    }
    return result;
  }

}
