import 'package:flutter/material.dart';

/// 封装的列表项
class SingButton extends StatelessWidget {

  const SingButton({
    super.key,
    this.title = 'SingButton',
    this.titleTextStyle,
    this.fillColor = const Color(0xFF19B1F4),
    this.highlightColor,
    this.size,
    this.elevation = 0,
    this.highlightElevation = 0,
    this.side,
    this.sideColor = Colors.transparent,
    this.sideWidth = 0.2,
    this.borderRadius,
    this.radius,
    this.padding,
    this.margin,
    this.onPressed,
    this.onLongPress,
  });

  final String title; /// 文字
  final TextStyle? titleTextStyle; /// 文字样式
  final Color fillColor; /// 填充颜色
  final Color? highlightColor; /// 按下颜色
  final Size? size; /// 按钮的大小
  final double elevation;
  final double highlightElevation;
  final BorderSide? side; /// 按钮边框
  final Color sideColor; /// 按钮边框颜色，传 side 之后无效，
  final double sideWidth; /// 按钮边框宽度，传 side 之后无效，
  final BorderRadiusGeometry? borderRadius; /// 按钮样式的圆角
  final double? radius; /// 按钮样式的圆角，不传的话为高度的一半，传 borderRadius 之后无效，
  final EdgeInsetsGeometry? padding; /// 内边距
  final EdgeInsetsGeometry? margin; /// 外边距
  final VoidCallback? onPressed; /// 点击回调
  final VoidCallback? onLongPress; /// 长按回调
  ///
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: margin ?? EdgeInsets.zero,
      child: RawMaterialButton(
        fillColor: fillColor,
        elevation:elevation,
        padding: padding ?? EdgeInsets.zero,
        highlightColor:highlightColor ?? Theme.of(context).highlightColor,
        highlightElevation:highlightElevation,
        shape: RoundedRectangleBorder(
            side: side ?? BorderSide(color: sideColor,width: sideWidth),
            borderRadius : _getBorderRadius()
        ),
        constraints: _getConstraints(),
        onPressed: onPressed ?? ()=> debugPrint('SingButton Clicked'),
        onLongPress: onPressed ?? ()=> debugPrint('SingButton Clicked'),
        child: Text(title,style: titleTextStyle ?? const TextStyle(color: Colors.white,fontSize: 16.0)),
      ),
    );
  }

  BoxConstraints _getConstraints(){
    if(size == null){
      return const BoxConstraints(minWidth: 88.0, minHeight: 36.0);
    }else{
      return BoxConstraints(minWidth: size!.width, minHeight: size!.height);
    }
  }

  BorderRadiusGeometry _getBorderRadius(){
    if(borderRadius != null){
      return borderRadius!;
    }else if(radius != null){
      return BorderRadius.all(Radius.circular(radius!));
    }else if(size != null){
      return BorderRadius.all(Radius.circular(size!.height / 2));
    } else{
      return const BorderRadius.all(Radius.circular(36.0 / 2));
    }
  }
}
