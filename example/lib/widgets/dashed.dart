import 'package:sing_plugin_tools/export.dart';

class Dashed extends StatelessWidget {
  const Dashed({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width - 30,
      margin: EdgeInsets.symmetric(vertical: 15.w,horizontal: 15.w),
      padding: EdgeInsets.all(12.w),
      decoration: decorationWhiteRadius8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('红色虚线'),
          const SizedBox(height: 5.0),
          SingDashedLine(
            color: Colors.red,
            dashWidth: 5.0,
            dashSpace: 3.0,
            width: 100.0,       // 可选参数，默认为200.0
          )
        ],
      ),
    );
  }
}