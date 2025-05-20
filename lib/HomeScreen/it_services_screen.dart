import 'package:flutter/material.dart';

class ItServicesScreen extends StatefulWidget {
  const ItServicesScreen({super.key});

  @override
  State<ItServicesScreen> createState() => _ItServicesScreenState();
}

class _ItServicesScreenState extends State<ItServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("It Service"),
      ),
    );
  }
}
