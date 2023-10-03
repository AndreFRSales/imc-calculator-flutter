import 'package:hive/hive.dart';
import 'package:im_calculator_flutter/app/model/imc.dart';

class IMCRepository {
  static const String _boxKey = 'imc_repo';
  static late Box _box;

  static Future<IMCRepository> load() async {
    if (Hive.isBoxOpen(_boxKey)) {
      _box = Hive.box(_boxKey);
    } else {
      _box = await Hive.openBox(_boxKey);
    }

    return IMCRepository._create();
  }

  IMCRepository._create();

  save(IMC imc) {
    _box.add(imc);
  }

  List<IMC> getData() {
    return _box.values.cast<IMC>().toList();
  }
}
