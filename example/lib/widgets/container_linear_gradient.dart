import 'package:sing_plugin_tools/export.dart';

class ContainerLinearGradient extends StatelessWidget {
  const ContainerLinearGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return SingContainerLinearGradient(
      width: Get.width - 30.w,
      height: 80.w,
      padding: EdgeInsets.all(12.w),
      radius: 8.w,
      colors: [AppColor.main, const Color(0xff00ffff)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      child: const Text('渐变背景的 Container\nSingContainerLinearGradient',style: TextStyle(color: Colors.white))
    );
  }
}