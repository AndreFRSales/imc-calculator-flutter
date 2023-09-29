import 'package:im_calculator_flutter/utils/date_formatter.dart';

class IMC {
  double _weight = 0.0;
  double _height = 0.0;
  final DateTime _created = DateTime.now();
  static final Map<double, String> _imcScale = {
    16: "Magreza grave",
    17: "Magreza moderada",
    18.5: "Saudável",
    25: "Sobrepeso",
    30: "Obesidade Grau I",
    35: "Obesidade Grau II",
    40: "Obesidade Mórbida"
  };

  IMC(this._weight, this._height);

  double get height => _height;
  double get weight => _weight;
  String formattedDate() => DateFormatter.formatDate(_created);

  double _calculate() => _weight / (_height * _height);

  String getScale() {
    var imc = _calculate();
    String scale = _imcScale[_imcScale.keys.first] ?? "";
    for (var key in _imcScale.keys) {
      if (imc >= key) {
        scale = _imcScale[key] ?? "";
      } else {
        break;
      }
    }
    return scale;
  }
}
