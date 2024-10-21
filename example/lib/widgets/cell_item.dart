import 'package:sing_plugin_tools/export.dart';

class CellItem extends StatefulWidget {
  const CellItem({super.key});

  @override
  State<CellItem> createState() => _CellItemState();
}

class _CellItemState extends State<CellItem> {
  var textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.text = '我是副标题';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: SingCellItem(
          backgroundColor: Colors.white, // 背景颜色，默认透明
          height: 56.0, // item 的高度
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          assetPath: 'assets/images/example.png', // 前面 icon 的 asset 路径，为空则不展示
          iconSize: const Size(28.0,28.0), // 前面 icon 的大小，assetPath 为空则不展示
          gap: 12.0, // icon 和标题的间距
          title: '我是Item', // 标题
          titleTextStyle: const TextStyle(color: Color(0xFF131732), fontSize: 16.0), // 标题样式
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2))), // 边框的样式，默认底部一条线
          onTap: ()=> print('点击主标题'), // item 的点击事件
          // separator: Container(width: 200.0,height: 1.0,color: Colors.grey), // 自定义的装饰，正常是一根线，在 decoration 满足不了的情况下自定义，比如项左右有边距。当然其他 widget 也可以
          showNext: true, // 是否显示右侧箭头
          nextIcon: const Icon(Icons.arrow_forward_ios,size: 16.0,color:Colors.grey), // 右侧的箭头，可以是任何 Widget

          showSub: true, // 是否显示副标题，副标题是一个 TextField
          focusNode: FocusNode(), // 控制副标题的副控件 KeyboardListener
          controller: textController, // TextField 的 controller ，可以设置文字，取值也通过他
          subTitleTextStyle: const TextStyle(color: Color(0xFF131732), fontSize: 14.0), // 副标题样式
          subTitleHint: '请输入副标题', // 副标题的提示语
          subTitleHintTextStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),// 副标题的提示语的样式
          subTitleContentPadding: const EdgeInsets.symmetric(vertical: 12.0), // 副标题的 ContentPadding
          readOnly:false, // 副标题 TextField 的是否能编辑
          onSubTap: ()=> print('点击副标题'), // 副标题点击事件
          customWidget: Container( // 自定义的 Widget ，在副标题之后，箭头之前，自己控制间距
            decoration: const BoxDecoration(
              color: Color(0xffE9F7FE),
              borderRadius: BorderRadius.all(Radius.circular(8.0))
            ),
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            child: const Text('  自定义  ',style: TextStyle(color: Colors.grey,fontSize: 12.0))
          )
      ),
    );
  }
}