import 'package:flutter/material.dart';

class BpoServiceScreen extends StatefulWidget {
  const BpoServiceScreen({super.key});

  @override
  State<BpoServiceScreen> createState() => _BpoServiceScreenState();
}

class _BpoServiceScreenState extends State<BpoServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BPO"),
      ),
    );
  }
}
