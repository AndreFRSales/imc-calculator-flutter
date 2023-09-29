import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im_calculator_flutter/screen/imc_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const IMCScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
