import 'package:currency_converter/core/constants/keys.dart';
import 'package:currency_converter/core/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import 'core/utils/entry_point.dart';
import 'features/supported_currencies/data/models/currency_model/currency_model.dart';

Future<void> main() async {
  setupGetIt();
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  Hive.registerAdapter(CurrencyModelAdapter());
  await Hive.openBox(Keys.currencyBoxKey);
  runApp(const EntryPoint());
}
