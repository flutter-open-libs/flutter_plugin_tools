import 'package:flutter/material.dart';
import 'package:sing_plugin_tools/export.dart';

class TopBg extends StatelessWidget {
  const TopBg({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.width / 2,
      decoration:  BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColor.main,
            const Color(0xfff2f6ff)
          ],
        ),
      ),
    );
  }
}
