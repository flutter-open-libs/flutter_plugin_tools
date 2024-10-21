import 'package:sing_plugin_tools/export.dart';

class ImageDemo extends StatefulWidget {
  const ImageDemo({super.key});

  @override
  State<ImageDemo> createState() => _ImageState();
}

class _ImageState extends State<ImageDemo> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: decorationWhiteRadius8,
          margin: EdgeInsets.all(15.w),
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('图片'),
              SizedBox(height: 5.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SingImage('images/image.webp',width: 40.w),
                  SingImage('images/image.webp',width: 40.w,cornerRadius:8.w),
                  SingImage('images/image.webp',width: 40.w - 2.w,cornerRadius:8.w,borderWidth: 1.w,borderColor: AppColor.green),
                  SingImage('images/image.webp',width: 40.w,isCircle: true),
                  SingImage('images/image.webp',width: 40.w - 2.w,isCircle: true,borderWidth: 1.w,borderColor: AppColor.green),
                  SingImage('https://img0.baidu.com/it/u=2216461753,1800921572&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500',width: 40.w,isCircle: true),
                  SingImage('https://img0.baidu.com/it/u=2216461753,1800921572&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500',width: 40.w - 2.w,isCircle: true,borderWidth: 1.w,borderColor: AppColor.green),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}