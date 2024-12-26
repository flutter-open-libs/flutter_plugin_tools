import 'package:flutter/material.dart';

// 封装的列表项，上图+下文字，支持title
class SingImgTxtItem extends StatelessWidget {
  const SingImgTxtItem(
    this.list, {
    super.key,
    this.padding,
    this.margin,
    this.title,
    this.titleGap,
    this.titleTextStyle,
    this.decoration,
    this.iconSize = const Size(28.0, 28.0),
    this.gap,
    this.textStyle,
    this.crossAxisCount = 4,
    this.crossAxisSpacing = 10.0,
    this.mainAxisSpacing = 10.0,
    this.childAspectRatio = 1.0,
    this.physics = null,
    this.shrinkWrap = true,
  });

  final List<ImgTxtBean> list; // 必传的 list 列表
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final String? title; // 标题文字
  final double? titleGap; // 标题与图标的间距
  final TextStyle? titleTextStyle; // 标题文字样式
  final BoxDecoration? decoration; // 外背景
  final Size iconSize; // 图标大小
  final double? gap; // 文字和图标的间距
  final TextStyle? textStyle; // 文字样式
  final int crossAxisCount; // 每行有几个
  final double crossAxisSpacing;// 列间距
  final double mainAxisSpacing; // 行间距
  final double childAspectRatio; // 宽高比
  final ScrollPhysics? physics;
  final bool shrinkWrap;


  @override
  Widget build(BuildContext context) {
    var hang = (list.length / crossAxisCount).ceil(); // 有几行
    return Container(
      padding: padding ?? EdgeInsets.zero,
      decoration: decoration ??
          const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
      margin: margin ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
              visible: title != null,
              child: Text('$title',
                  style: titleTextStyle ??
                      const TextStyle(
                          color: Color(0xff131732), fontSize: 16.0))),
          Visibility(
              visible: title != null, child: SizedBox(height: titleGap ?? 0.0)),
          GridView.builder(
            physics: physics ?? NeverScrollableScrollPhysics(),
            shrinkWrap: shrinkWrap,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: list.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: list[index].onTap ?? () => debugPrint('没有点击事件'),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Image.asset(list[index].assetPath,
                      width: iconSize.width, height: iconSize.height,package: list[index].package),
                  SizedBox(height: gap ?? 0.0),
                  Text(list[index].title,
                      style: textStyle ??
                          const TextStyle(
                              color: Color(0xff131732), fontSize: 16.0)),
                ]),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ImgTxtBean {
  String assetPath;
  String title;
  String? package;
  final GestureTapCallback? onTap;

  ImgTxtBean(this.assetPath, this.title, {this.onTap,this.package});
}
