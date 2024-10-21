import 'dart:io';
import 'dart:ui';

import '../export.dart';

/// assets图片的路径规则必须是 assets/images/xxx.png,且传入不带‘assets/’，例如：images/xxx.png
class SingImage extends StatelessWidget {

  /// 图片地址
  String imagePath = "";
  /// 图片宽
  double? width;
  /// 图片高
  double? height;

  double marginLeft;
  double marginRight;
  double marginTop;
  double marginBottom;
  double margin;

  double cornerRadius;
  double borderWidth;
  Color borderColor;
  bool isCircle;
  Color backgroundColor;
  Color? color;
  VoidCallback? onClick;
  /// 只有 asset 图片会有
  String? package;
  /// 网络图片
  PlaceholderWidgetBuilder? placeholder;
  LoadingErrorWidgetBuilder? errorWidget;

  SingImage(this.imagePath, { super.key,
    this.width,
    this.height,
    this.marginBottom = 0,
    this.marginRight = 0,
    this.marginTop = 0,
    this.marginLeft = 0,
    this.margin = 0,
    this.cornerRadius = 0,
    this.isCircle = false,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0,
    this.backgroundColor = Colors.transparent,
    this.color,
    this.onClick,
  }) {
    if (margin > 0) {
      marginLeft = margin;
      marginTop = margin;
      marginRight = margin;
      marginBottom = margin;
    }

    if (isCircle) {
      cornerRadius = width ?? 0 / 2;
    }

    if(height == null && width != null){
      height = width;
    }
    onClick ??= () {};
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(marginLeft, marginTop, marginRight, marginBottom),
      decoration: BoxDecoration(
        border: Border.all(width: borderWidth, color: borderColor),
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(cornerRadius+borderWidth)),
      ),
      child: GestureDetector(
        onTap: onClick,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
          child: getImage()
        ),
      ));
  }

  Widget getImage() {
    if (imagePath.startsWith('http')) { //网络图片
      return CachedNetworkImage(
        imageUrl: imagePath,
        width: width,
        height: height,
        fit: BoxFit.cover,
        color: color,
        placeholder: placeholder,
        errorWidget: errorWidget,
      );
    } else if (imagePath.startsWith('images')) { // 项目内图片
      return Image.asset('assets/$imagePath',
        width: width,
        height: height,
        fit: BoxFit.cover,
        color: color,
        package: package,
      );
    } else { //加载手机里面的图片
      return Image.file(File(imagePath),
        width: width,
        height: height,
        fit: BoxFit.cover,
        color: color,
      );
    }
  }
}