import 'package:flutter/material.dart';

/// 封装的列表项
class SingCellItem extends StatelessWidget {

  const SingCellItem({
    super.key,
    this.backgroundColor,
    this.height = 56.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0,vertical: 0.0),
    this.assetPath = '', // 如果为空这不显示图标
    this.iconSize = const Size(28.0,28.0),
    this.gap = 12.0,
    this.text = 'CellItem',
    this.textColor = const Color(0xff131732),
    this.textSize = 16.0,
    this.decoration,
    this.onTap,
    this.separator,
    this.showNext = false,
    this.nextIcon,
  });

  final Color? backgroundColor; /// 背景颜色
  final double height; /// Item的高度
  final EdgeInsetsGeometry padding; /// Item的padding
  final String assetPath; /// asset图标的路径
  final Size iconSize; /// 图标的大小
  final double gap; /// 图标和文字的间距
  final String text; /// 文字
  final Color textColor; /// 文字颜色
  final double textSize; /// 文字大小
  final BoxDecoration? decoration; /// item的装饰
  final GestureTapCallback? onTap; /// item的点击回调
  final Widget? separator; /// 自定义的装饰，正常是一根线，在 decoration 满足不了的情况下自定义，比如项左右有边距。当然其他 widget 也可以
  final bool showNext; /// 是否展示右侧的箭头
  final Widget? nextIcon; /// 自定义的右侧icon

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: backgroundColor ?? Colors.white,
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
                  Image.asset(assetPath, width: iconSize.width, height: iconSize.height),
                if (assetPath.isNotEmpty)
                  SizedBox(width: gap),
                Text(text,style: TextStyle(color: textColor, fontSize: textSize)),
                if (showNext)
                  Expanded(child: Container()),
                if (showNext)
                  nextIcon ?? const Icon(Icons.arrow_forward_ios,size: 16.0,color:Colors.grey),
              ]),
            ),
          ),

          separator ?? Container()
        ],
      ),
    );
  }

  Decoration _getDecoration(){
    if(separator != null){ // 自定义了分割线
      return const BoxDecoration();
    }
    if(decoration != null){
      return decoration!;
    }
    return const BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.grey, width: 0.2),
      ),
    );
  }
}
