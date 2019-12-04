import 'dart:io';

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import './main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  final hoverFile = File("");
  print(hoverFile.absolute);
  Hive.init(hoverFile.absolute.path);
  runApp(MyApp());
}
