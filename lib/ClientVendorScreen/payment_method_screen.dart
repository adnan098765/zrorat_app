import 'package:flutter/material.dart';
import 'dart:async';

import '../AppColors/app_colors.dart';

class PaymentConfirmationScreen extends StatefulWidget {
  final String clientName;
  final String phoneNumber;
  final String budget;
  final String paymentMethod;

  const PaymentConfirmationScreen({
    super.key,
    required this.clientName,
    required this.phoneNumber,
    required this.budget,
    required this.paymentMethod,
  });

  @override
  State<PaymentConfirmationScreen> createState() => _PaymentConfirmationScreenState();
}

class _PaymentConfirmationScreenState extends State<PaymentConfirmationScreen> {
  bool _isProcessing = true;
  bool _isConfirmed = false;
  late Timer _timer;
  int _countdown = 3;

  @override
  void initState() {
    super.initState();
    // Simulate payment processing with a timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _isProcessing = false;
          _isConfirmed = true;
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Confirmation"),
        backgroundColor: AppColors.appColor,
        foregroundColor: AppColors.whiteTheme,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              _buildPaymentStatusWidget(),
              const SizedBox(height: 30),
              _buildOrderSummary(),
              const SizedBox(height: 30),
              if (_isConfirmed) _buildActionButtons(context, width, height),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentStatusWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
        color: _isProcessing
            ? Colors.blue.shade50
            : _isConfirmed
            ? Colors.green.shade50
            : Colors.red.shade50,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          _isProcessing
              ? const CircularProgressIndicator()
              : Icon(
            _isConfirmed ? Icons.check_circle : Icons.error,
            color: _isConfirmed ? Colors.green : Colors.red,
            size: 80,
          ),
          const SizedBox(height: 20),
          Text(
            _isProcessing
                ? "Processing Payment..."
                : _isConfirmed
                ? "Payment Confirmed!"
                : "Payment Failed",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: _isProcessing
                  ? Colors.blue.shade700
                  : _isConfirmed
                  ? Colors.green.shade700
                  : Colors.red.shade700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _isProcessing
                ? "Please wait while we confirm your payment..."
                : _isConfirmed
                ? "Your order has been successfully placed"
                : "There was an issue with your payment",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Order Summary",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildSummaryRow("Client Name", widget.clientName),
          _buildSummaryRow("Phone Number", widget.phoneNumber),
          _buildSummaryRow("Budget", "Rs${widget.budget}"),
          _buildSummaryRow("Payment Method", widget.paymentMethod),
          const Divider(thickness: 1),
          _buildSummaryRow("Order ID", "#OD${DateTime.now().millisecondsSinceEpoch.toString().substring(5, 13)}", isBold: true),
          _buildSummaryRow("Order Date", _getFormattedDate(), isBold: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, double width, double height) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // Navigate to order tracking or home screen
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/orderTracking', // Replace with your actual route name
                  (route) => false,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.appColor,
            minimumSize: Size(width, height * 0.06),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            "Track Your Order",
            style: TextStyle(
              fontSize: 18,
              color: AppColors.whiteTheme,
            ),
          ),
        ),
        const SizedBox(height: 15),
        OutlinedButton(
          onPressed: () {
            // Navigate back to home screen
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/HomeScreen', // Replace with your actual route name
                  (route) => false,
            );
          },
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppColors.appColor),
            minimumSize: Size(width, height * 0.06),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            "Return to Home",
            style: TextStyle(
              fontSize: 18,
              color: AppColors.appColor,
            ),
          ),
        ),
      ],
    );
  }

  String _getFormattedDate() {
    final now = DateTime.now();
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return "${now.day} ${months[now.month - 1]}, ${now.year}";
  }
}