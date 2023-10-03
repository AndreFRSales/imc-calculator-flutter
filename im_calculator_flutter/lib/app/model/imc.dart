import 'package:hive/hive.dart';
import 'package:im_calculator_flutter/utils/date_formatter.dart';

part 'imc.g.dart';

@HiveType(typeId: 0)
class IMC extends HiveObject {
  @HiveField(0)
  double _weight = 0.0;
  @HiveField(1)
  double _height = 0.0;
  @HiveField(2)
  final DateTime _created = DateTime.now();

  IMC(this._weight, this._height);

  double get height => _height;
  double get weight => _weight;
  String formattedDate() => DateFormatter.formatDate(_created);
}
