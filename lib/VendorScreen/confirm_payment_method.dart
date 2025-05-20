import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math'; // For generating vendor ID

import '../AppColors/app_colors.dart';

class VendorPaymentConfirmationScreen extends StatefulWidget {
  final String name;
  final String phone;
  final String businessName;
  final String category;
  final String city;
  final String experience;
  final String packageName;
  final String packagePrice;
  final String packageDuration;
  final String paymentMethod;

  const VendorPaymentConfirmationScreen({
    super.key,
    required this.name,
    required this.phone,
    required this.businessName,
    required this.category,
    required this.city,
    required this.experience,
    required this.packageName,
    required this.packagePrice,
    required this.packageDuration,
    required this.paymentMethod,
  });

  @override
  State<VendorPaymentConfirmationScreen> createState() => _VendorPaymentConfirmationScreenState();
}

class _VendorPaymentConfirmationScreenState extends State<VendorPaymentConfirmationScreen> {
  bool _isProcessing = true;
  bool _isConfirmed = false;
  late Timer _timer;
  int _countdown = 3;
  late String _vendorId;

  @override
  void initState() {
    super.initState();
    // Generate a unique vendor ID
    _vendorId = _generateVendorId();

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

  // Generate a unique vendor ID
  String _generateVendorId() {
    final random = Random();
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return 'VEND${List.generate(6, (_) => chars[random.nextInt(chars.length)]).join()}';
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
              _buildSubscriptionSummary(),
              const SizedBox(height: 30),
              if (_isConfirmed) _buildActionButtons(context, height, width),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentStatusWidget() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          _isProcessing
              ? Column(
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.appColor),
              ),
              const SizedBox(height: 20),
              Text(
                "Processing Payment... ($_countdown)",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Please wait while we process your payment.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )
              : Column(
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 60,
              ),
              const SizedBox(height: 20),
              const Text(
                "Payment Confirmed!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Your subscription is now active. Vendor ID: $_vendorId",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Subscription Summary",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          _buildSummaryRow("Vendor Name", widget.name),
          _buildSummaryRow("Business Name", widget.businessName),
          _buildSummaryRow("Phone", widget.phone),
          _buildSummaryRow("Category", widget.category),
          _buildSummaryRow("City", widget.city),
          _buildSummaryRow("Experience", widget.experience),
          _buildSummaryRow("Package", widget.packageName),
          _buildSummaryRow("Duration", widget.packageDuration),
          _buildSummaryRow("Payment Method", widget.paymentMethod),
          const Divider(thickness: 1),
          _buildSummaryRow("Total Amount", "Rs${widget.packagePrice}", isBold: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, double height, double width) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const VendorDashboardScreen(),
            //   ),
            //       (route) => false,
            // );
          },
          child: Container(
            height: height * 0.06,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.appColor,
            ),
            child: Center(
              child: Text(
                "Go to Dashboard",
                style: TextStyle(fontSize: 18, color: AppColors.whiteTheme),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        TextButton(
          onPressed: () {
            // Implement receipt download logic here
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Receipt download initiated"),
                backgroundColor: Colors.green,
              ),
            );
          },
          child: Text(
            "Download Receipt",
            style: TextStyle(
              fontSize: 16,
              color: AppColors.appColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}