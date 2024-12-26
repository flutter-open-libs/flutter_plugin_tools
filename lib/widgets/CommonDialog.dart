import 'package:sing_plugin_tools/export.dart';

// 公共弹窗 Dialog
class CommonDialog extends StatelessWidget {
  final contentWidget; // 两个必填写一个
  final contentStr; // 两个必填写一个

  final noFun;
  final yesFun;
  final noStr;
  final yesStr;
  final titleStr;
  final canCancel;
  final hintNo;
  final hintYes;
  final clickYesToDissmiss; // 点击确定按钮关闭弹窗？
  final clickNoToDissmiss; // 点击确定按钮关闭弹窗？

  const CommonDialog({
    this.contentWidget,
    this.contentStr,
    this.noFun,
    this.yesFun,
    this.noStr,
    this.yesStr,
    this.titleStr,
    this.canCancel = true,
    this.hintNo = false,
    this.hintYes = false,
    this.clickYesToDissmiss = true,
    this.clickNoToDissmiss = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canCancel,
      child: AlertDialog(
        elevation:0,
        insetPadding:EdgeInsets.symmetric(horizontal: 30.w),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.w)),
        titlePadding: EdgeInsets.zero,
        title: getTitle(),
        contentPadding: EdgeInsets.only(left: 0.w,right: 0.w,top: 0.w),
        content: getContent(),
        actionsPadding: EdgeInsets.symmetric(vertical: 6.w),
        actions: getActions(),
      ),
    );
  }

  // 标题
  Widget getTitle(){
    return Container(
      width: Get.width - 30.w,
        padding: EdgeInsets.symmetric(horizontal : 15.w,vertical: 10.w),
        decoration: BoxDecoration(
          color: AppColor.main.withOpacity(0.1),
          borderRadius: BorderRadius.vertical(top: Radius.circular(4.w)),
        ),
        child: Text(titleStr ?? '温馨提示',style: text_main_18b)
    );
  }

// 内容
  Widget getContent(){
    return Container(
      padding: EdgeInsets.only(left: 25.w,right: 25.w,top: 25.w),
      // color: Colors.white,
      constraints: BoxConstraints(
          maxHeight: Get.height / 3 * 2 // 设置最大高度为200
      ),
      child: contentWidget ?? Text('$contentStr',style: text_grey_14),
    );
  }

// 按钮
  List<Widget> getActions(){
    var yes = yesStr ?? '确定';
    var no = noStr ?? '取消';
    return [
      Visibility(
        visible: !hintNo,
        child: RawMaterialButton(
            constraints: BoxConstraints.tightFor(width: ('$no'.length + 2) * 14, height: 30.w),
            child: Text(no,style: text_grey_14),
            onPressed: ()=> {
              if(noFun != null) {
                noFun()
              },
              if(clickNoToDissmiss){
                Get.back()
              }
            }
        ),
      ),
      Visibility(
        visible: !hintYes,
        child: RawMaterialButton(
          constraints: BoxConstraints.tightFor(width: ('$yes'.length + 2) * 14, height: 30.w),
          child: Text(yes,style: text_main_14),
          onPressed: ()=> {
            if(yesFun != null) {
              yesFun()
            },
            if(clickYesToDissmiss){
              Get.back()
            }
          },
        ),
      ),
      SizedBox(width: 10.w),
    ];
  }
}
