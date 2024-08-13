import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'home_page.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0x00DF6352)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Demo Home Page'),
      
    );
  }
}

