import 'package:sing_plugin_tools/export.dart';

class ImageText extends StatelessWidget {
  const ImageText({super.key});

  @override
  Widget build(BuildContext context) {
    var list = [
      ImgTxtBean('assets/images/example.png', '标签1', onTap: () => debugPrint('标签1')),
      ImgTxtBean('assets/images/example.png', '标签2', onTap: () => debugPrint('标签2')),
      ImgTxtBean('assets/images/example.png', '标签3', onTap: () => debugPrint('标签3')),
      ImgTxtBean('assets/images/example.png', '标签4', onTap: () => debugPrint('标签4')),
    ];
    return  SingImgTxtItem(
      list,
      title: '我的标题',
      textStyle: text_333333_14,
      titleGap: 15.0,
      gap: 1.0,
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      padding: const EdgeInsets.all(15.0),
      iconSize: const Size(25.0,25.0),
      childAspectRatio: 1,
      crossAxisCount:4,
      backgroundDecoration: decorationWhiteRadius10.copyWith(color: Colors.teal),
    );
  }
}