import 'package:sing_plugin_tools/export.dart';

class Button extends StatelessWidget {
  const Button({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SingButton(
        title: 'SingButton', // 按钮文字
        titleTextStyle: const TextStyle(color: Colors.white,fontSize: 16.0), // 按钮样式
        fillColor: const Color(0xFF19B1F4),   // 填充颜色
        highlightColor: const Color(0x40CCCCCC), // 按下颜色
        size: Size(Get.width - 30.w,36.w), // 按钮大小
        elevation: 0, // 阴影
        highlightElevation: 0, // 按下阴影
        side: const BorderSide(color: Colors.transparent,width: 0.2), // 边框
        // sideColor: Colors.transparent, // 传 side 后无效
        // sideWidth: 0.2, // 传 side 后无效
        borderRadius: const BorderRadius.all(Radius.circular(20.0)), // 样式
        // radius: 20.0,  // 传 borderRadius 后无效
        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 3.0),
        margin: EdgeInsets.zero,
        onPressed: ()=> { }, // 点击事件
        onLongPress: ()=> debugPrint('SingButton Long Clicked'),
      ),
    );
  }
}