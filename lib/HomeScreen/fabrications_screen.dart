import 'package:flutter/material.dart';

class FabricationsScreen extends StatefulWidget {
  const FabricationsScreen({super.key});

  @override
  State<FabricationsScreen> createState() => _FabricationsScreenState();
}

class _FabricationsScreenState extends State<FabricationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fabrications"),
      ),
    );
  }
}
