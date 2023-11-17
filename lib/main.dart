import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trust_app/app.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  if (Platform.isWindows) {
    WindowManager.instance.setMinimumSize(const Size(1000, 600));
  }
  runApp(const MyApp());
}



