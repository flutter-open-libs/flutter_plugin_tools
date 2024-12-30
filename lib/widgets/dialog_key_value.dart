import 'package:sing_plugin_tools/export.dart';

/// 弹窗，key+value，
class DialogKeyValue extends StatelessWidget {
  final Map<String, dynamic>? map; // key为服务端的code value为显示的值
  final Callback callback;

  const DialogKeyValue(this.map,this.callback ,{super.key});

  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.only(left: 15.w,right: 15.w, top: 6.w,bottom: 6.w+bottomPadding),
      decoration: BoxDecoration(
       color: AppColor.white,
       borderRadius: BorderRadius.vertical(top: Radius.circular(8.w)),
     ),
      child: ListView.separated(
       shrinkWrap:true,
       padding: EdgeInsets.zero,
       itemCount: map?.length ?? 0,
       separatorBuilder: (BuildContext context, int index) => Container(color: AppColor.line.withOpacity(0.2),height: 0.8),
       itemBuilder: (BuildContext context, int index) {
         var key = map?.keys.toList()[index];
         var value = map?.values.toList()[index];
         return InkWell(
           onTap: () => {
             callback('$key',value),
             Get.back()
           },
           child: SizedBox(
             height: 40.w,
             child: Align(alignment : Alignment.centerLeft,
                 child: Text('$value',style: text_131732_14)),
           ),
         );
       },
     ),
   );
  }
}

typedef Callback = void Function(String code,String value);