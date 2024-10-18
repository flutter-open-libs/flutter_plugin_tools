import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sing_plugin_tools/export.dart';
import 'dart:async';

import 'package:sing_plugin_tools/method_channel/sing_plugin_tools.dart';
import 'package:sing_plugin_tools/widgets/sing_cell_item.dart';
import 'package:sing_plugin_tools/widgets/sing_button.dart';
import 'package:sing_plugin_tools/widgets/sing_img_txt_item.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return GetMaterialApp(
          title: 'Flutter Plugins',
          supportedLocales: const [
            Locale('zh', 'CN'), // 中文简体
          ],
          locale: const Locale('zh', 'CN'),
          theme: ThemeData(
              brightness: Brightness.light,//深色还是浅色,也就是暗黑模式还是正常模式 电池栏颜色
              primaryColor: Colors.black,//顶部导航栏和状态栏的颜色修改，需要用到这个属性，类型 Color。
              colorScheme: const ColorScheme.light().copyWith(primary: Colors.white),
              primarySwatch: Colors.green,
              appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                  scrolledUnderElevation: 0.0,
                  centerTitle: true
              )

          ),
          debugShowCheckedModeBanner:false, // 隐藏debug标识
          // initialRoute:AppPages.INITIAL,
          // getPages:AppPages.routes,
          // initialBinding: AppBinding(),
          home: const Home(),
          builder: EasyLoading.init(builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling), /// 设置文字大小不随系统设置改变
              child: widget!,
            );
          }),
          defaultTransition: Transition.cupertino, // https://blog.csdn.net/yang_6799/article/details/131966520
        );
      }
    );
  }
}
