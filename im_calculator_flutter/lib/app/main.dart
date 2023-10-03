import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:im_calculator_flutter/app/model/imc.dart';
import 'package:im_calculator_flutter/app/my_app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(IMCAdapter());
  runApp(const MyApp());
}
