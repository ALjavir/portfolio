import 'package:flutter/material.dart';
import 'package:portfolio/style/font_style.dart';

class ContractpageMain extends StatefulWidget {
  const ContractpageMain({super.key});

  @override
  State<ContractpageMain> createState() => _ContractpageMainState();
}

class _ContractpageMainState extends State<ContractpageMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        "data",
        style: Fontstyle.primaryFont(48, Colors.red, FontWeight.bold),
      ),
    );
  }
}
