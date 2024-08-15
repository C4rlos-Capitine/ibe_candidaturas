import 'package:device_preview/device_preview.dart';
//import 'package:example/screens/gallery_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/views/help_center.dart';
import 'package:ibe_candidaturas/views/home.dart';


class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Set to `true` to see the full possibilities of the iOS Developer Screen
    final bool runCupertinoApp = false;

    if (runCupertinoApp) {
    } else {
      return MaterialApp(
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        title: 'Settings UI Demo',
        home: MyHomePage(title: 'IBE - Portal do Candidato',),
      );
    }
  }
}