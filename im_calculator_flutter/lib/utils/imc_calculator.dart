import 'package:im_calculator_flutter/app/model/imc.dart';

class IMCCalculator {
  static final Map<double, String> _imcScale = {
    16: "Magreza grave",
    17: "Magreza moderada",
    18.5: "Saudável",
    25: "Sobrepeso",
    30: "Obesidade Grau I",
    35: "Obesidade Grau II",
    40: "Obesidade Mórbida"
  };

  double _calculate(IMC imc) => imc.weight / (imc.height * imc.height);

  String getScale(IMC imcPerson) {
    var imc = _calculate(imcPerson);
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
