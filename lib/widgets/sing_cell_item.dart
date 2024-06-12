import 'package:flutter/material.dart';

// 封装的列表项
class SingCellItem extends StatelessWidget {
  const SingCellItem({
    super.key,
    this.backgroundColor,
    this.height = 56.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
    this.assetPath = '', // 如果为空这不显示图标
    this.iconSize = const Size(28.0, 28.0),
    this.gap = 12.0,
    this.title = 'CellItem',
    this.titleTextStyle,
    this.decoration,
    this.onTap,
    this.separator,
    this.showNext = false,
    this.nextIcon,
    this.focusNode,
    this.controller,
    this.subTitleTextStyle,
    this.subTitleHint = '',
    this.subTitleHintTextStyle,
    this.subTitleContentPadding,
    this.readOnly = true,
    this.onSubTap,
    this.showSub = true,
    this.customWidget,
  });

  final Color? backgroundColor; // 背景颜色
  final double height; // Item的高度
  final EdgeInsetsGeometry padding; // Item的padding
  final String assetPath; // asset图标的路径
  final Size iconSize; // 图标的大小
  final double gap; // 图标和文字的间距
  final String title; // 文字
  final TextStyle? titleTextStyle; // 文字样式
  final BoxDecoration? decoration; // item的装饰
  final GestureTapCallback? onTap; // item的点击回调
  final Widget?
      separator; // 自定义的装饰，正常是一根线，在 decoration 满足不了的情况下自定义，比如项左右有边距。当然其他 widget 也可以
  final bool showNext; // 是否展示右侧的箭头
  final Widget? nextIcon; // 自定义的右侧icon

  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextStyle? subTitleTextStyle; // 副标题文字样式
  final String subTitleHint; // 副标题提示文字
  final TextStyle? subTitleHintTextStyle; // 副标题提示样式
  final EdgeInsets? subTitleContentPadding;
  final bool readOnly; // 副标题是否不能输入
  final GestureTapCallback? onSubTap; // 副标题点击
  final bool showSub; // 是否显示副标题

  final Widget? customWidget; // 自定义的右侧 Widget，在副标题后，箭头前，自己控制边距

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Colors.transparent,
      child: Column(
        children: [
          InkWell(
            onTap: onTap ?? () => debugPrint('SingCellItem clicked'),
            child: Container(
              decoration: _getDecoration(),
              height: height,
              padding: padding,
              child: Row(children: [
                if (assetPath.isNotEmpty)
                  Image.asset(assetPath,
                      width: iconSize.width, height: iconSize.height),
                if (assetPath.isNotEmpty) SizedBox(width: gap),
                Text(title,
                    style: titleTextStyle ??
                        const TextStyle(
                            color: Color(0xFF131732), fontSize: 16.0)),
                SizedBox(width: gap),
                if (showSub)
                  Expanded(
                    child: KeyboardListener(
                      focusNode: focusNode ?? FocusNode(),
                      child: _getTextField(),
                    ),
                  ),
                if (!showSub)
                  Expanded(
                    child: Container(),
                  ),
                if (customWidget != null) customWidget!,
                if (showNext)
                  InkWell(
                    onTap: onSubTap ??
                        onTap ??
                        () => debugPrint('SingCellItem sub arrow'),
                    child: nextIcon ??
                        const Icon(Icons.arrow_forward_ios,
                            size: 16.0, color: Colors.grey),
                  ),
              ]),
            ),
          ),
          separator ?? Container()
        ],
      ),
    );
  }

  Decoration _getDecoration() {
    if (separator != null) {
      // 自定义了分割线
      return const BoxDecoration();
    }
    if (decoration != null) {
      return decoration!;
    }
    return const BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.grey, width: 0.2),
      ),
    );
  }

  TextField _getTextField() {
    return TextField(
      onTap: onSubTap ?? () => debugPrint('SingCellItem sub clicked'),
      readOnly: readOnly,
      controller: controller ?? TextEditingController(),
      textAlign: TextAlign.end,
      style: subTitleTextStyle ??
          const TextStyle(color: Color(0xFF131732), fontSize: 14.0),
      decoration: InputDecoration(
        prefixText: "  ",
        isDense: true,
        contentPadding: subTitleContentPadding ??
            const EdgeInsets.symmetric(vertical: 12.0),
        counterText: "",
        // 去掉底部计数
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
        //无焦点时状态
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
        //有焦点时状态
        hintText: subTitleHint,
        hintStyle: subTitleHintTextStyle ??
            const TextStyle(color: Colors.grey, fontSize: 14.0),
      ),
    );
  }
}
