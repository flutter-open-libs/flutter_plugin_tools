import 'package:sing_plugin_tools/export.dart';

class Line extends StatelessWidget {
  const Line({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width - 30,
      margin: EdgeInsets.symmetric(vertical: 15.w,horizontal: 15.w),
      padding: EdgeInsets.all(12.w),
      decoration: decorationWhiteRadius8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('垂直分割线',style: text_333333_12),
              SizedBox(height: 5.w),
              Row(children: [
                LineVertical(20.w,width: 1.w),
                SizedBox(width: 5.w),
                LineVertical(20.w,width: 1.w, color: Colors.red),
                SizedBox(width: 5.w),
                LineVertical(20.w,width: 4.w, color: Colors.red),
                SizedBox(width: 5.w),
                LineVertical(20.w,width: 4.w, color: Colors.red, radius: 2.w)
              ])
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('水平分割线',style: text_333333_12),
              SizedBox(height: 5.w),
              Column(children: [
                LineHorizontal(width: 50.w,height: 1.w),
                SizedBox(height: 5.w),
                LineHorizontal(width: 50.w,height: 1.w,color: Colors.red),
                SizedBox(height: 5.w),
                LineHorizontal(width: 50.w,height: 4.w,color: Colors.red),
                SizedBox(height: 5.w),
                LineHorizontal(width: 50.w,height: 4.w,color: Colors.red,radius: 2.w),
              ])
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('虚线',style: text_333333_12),
              SizedBox(height: 5.w),
              Column(children: [
                SingDashedLine(width: 50.w),
                SizedBox(height: 5.w),
                SingDashedLine(width: 50.w, color: Colors.red),
                SizedBox(height: 5.w),
                SingDashedLine(width: 50.w, color: Colors.red,dashWidth: 15.w,dashHeight: 4.w,isRound: false, dashSpace: 6.w),
                SizedBox(height: 5.w),
                SingDashedLine(width: 50.w, color: Colors.red,dashWidth: 15.w,dashHeight: 4.w,isRound: true, dashSpace: 6.w),
              ])
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('虚线边框',style: text_333333_12),
              SizedBox(height: 5.w),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: SingDashedLineBorder.all(width: 1, color: Colors.blue),
                      color: const Color(0xffe9f5fe),
                      shape: BoxShape.circle,
                    )
                  ),
                  SizedBox(width: 5.w),
                  Container(
                    width: 20,
                    height: 20,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      border: SingDashedLineBorder(
                        top:BorderSide(color: Colors.red, width : 1),
                        left:BorderSide(color: Colors.blue, width : 1),
                        right:BorderSide(color: Colors.pinkAccent, width : 1),
                        bottom:BorderSide(color: Colors.black, width : 1),
                      ),
                    ),
                ),
              ])
            ],
          ),
        ],
      ),
    );
  }
}