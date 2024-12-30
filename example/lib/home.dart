import 'package:sing_plugin_tools/export.dart';

import 'widgets/android_id.dart';
import 'widgets/button.dart';
import 'widgets/cell_item.dart';
import 'widgets/container_linear_gradient.dart';
import 'widgets/device_info.dart';
import 'widgets/idfa.dart';
import 'widgets/image_demo.dart';
import 'widgets/image_text.dart';
import 'widgets/imei.dart';
import 'widgets/line.dart';
import 'widgets/oaid.dart';
import 'widgets/package_info.dart';
import 'widgets/request_phone_state.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();

    Log.init(true);
    Log.e('message');

    SpUtil.write('key', 'value');
    SpUtil.read('key', 'defaultValue');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFEFEFF4),
        appBar: AppBar(title: const Text('Flutter各种插件工具')),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15),
              AndroidId(),
              RequestPhoneState(),
              Imei(),
              Oaid(),
              Idfa(),
              Package(),
              DeviceInfo(),
              CellItem(),
              Button(),
              ImageText(),
              Line(),
              ContainerLinearGradient(),
              ImageDemo(),
            ],
          ),
        ),
      ),
    );
  }
}