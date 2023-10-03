import 'package:flutter/material.dart';
import 'package:im_calculator_flutter/app/model/imc.dart';
import 'package:im_calculator_flutter/app/repositories/imc_repository.dart';
import 'package:im_calculator_flutter/utils/imc_calculator.dart';
import 'package:im_calculator_flutter/utils/validate_fields.dart';

class IMCScreen extends StatefulWidget {
  const IMCScreen({super.key});

  @override
  State<IMCScreen> createState() => _IMCScreenState();
}

class _IMCScreenState extends State<IMCScreen> {
  var weightTextFieldController = TextEditingController();
  var heightTextFieldController = TextEditingController();
  var imcList = <IMC>[];
  late IMCRepository imcRepository;
  var imcCalculator = IMCCalculator();
  bool isWeightValid = true;
  bool isHeightValid = true;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    imcRepository = await IMCRepository.load();
    imcList = imcRepository.getData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Calculadora de IMC")),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            weightTextFieldController.clear();
            heightTextFieldController.text =
                imcList.lastOrNull?.height.toString() ?? "";
            isWeightValid = true;
            isHeightValid = true;
            showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                builder: (BuildContext buildContext) {
                  return StatefulBuilder(
                    builder: (BuildContext context, setState) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Peso:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextField(
                                controller: weightTextFieldController,
                                decoration: InputDecoration(
                                  hintText: "em kg",
                                  errorText: isWeightValid
                                      ? null
                                      : "Digite o peso em kg corretamente",
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(top: 16)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Altura:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextField(
                                controller: heightTextFieldController,
                                decoration: InputDecoration(
                                    hintText: "em metros",
                                    errorText: isWeightValid
                                        ? null
                                        : "Digite a altura em metros corretamente"),
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(top: 16)),
                          Container(
                            color: Theme.of(context).primaryColor,
                            width: double.infinity,
                            child: MaterialButton(
                                onPressed: () {
                                  var weight = double.tryParse(
                                          weightTextFieldController.text) ??
                                      0.0;
                                  var height = double.tryParse(
                                          heightTextFieldController.text) ??
                                      0.0;
                                  var isWeightValid =
                                      ValidateFields.isFieldValid(weight);
                                  var isHeightValid =
                                      ValidateFields.isFieldValid(height);

                                  setState(() {
                                    this.isWeightValid = isWeightValid;
                                    this.isHeightValid = isHeightValid;
                                  });

                                  if (isWeightValid && isHeightValid) {
                                    imcRepository.save(IMC(weight, height));
                                    Navigator.pop(context);
                                    fetchData();
                                  }
                                },
                                child: const Text(
                                  "Salvar",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: imcList.length,
            itemBuilder: ((context, index) {
              var imc = imcList[index];
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        imc.formattedDate(),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Peso: ${imc.weight}"),
                          Text("Altura: ${imcList.last.height}"),
                        ],
                      ),
                      trailing: Text(
                        imcCalculator.getScale(imc),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider()
                  ],
                ),
              );
            })),
      ),
    );
  }
}
