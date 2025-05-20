import 'package:flutter/material.dart';

import '../AppColors/app_colors.dart';
import 'confirm_payment_method.dart';

class VendorPaymentScreen extends StatefulWidget {
  final String name;
  final String phone;
  final String businessName;
  final String category;
  final String city;
  final String experience;

  const VendorPaymentScreen({
    super.key,
    required this.name,
    required this.phone,
    required this.businessName,
    required this.category,
    required this.city,
    required this.experience,
  });

  @override
  State<VendorPaymentScreen> createState() => _VendorPaymentScreenState();
}

class _VendorPaymentScreenState extends State<VendorPaymentScreen> {
  int selectedPackage = 0;
  String selectedPaymentMethod = '';

  // Package details
  final List<Map<String, dynamic>> packages = [
    {
      'name': 'Basic',
      'price': 1999,
      'duration': '1 month',
      'features': [
        'Profile Listing',
        'Customer Inquiries',
        'Basic Analytics',
        '5 Leads Per Month',
      ],
    },
    {
      'name': 'Standard',
      'price': 4999,
      'duration': '3 months',
      'features': [
        'Everything in Basic',
        'Featured Profile',
        'Advanced Analytics',
        '20 Leads Per Month',
        'Customer Reviews',
      ],
    },
    {
      'name': 'Premium',
      'price': 9999,
      'duration': '6 months',
      'features': [
        'Everything in Standard',
        'Priority Listing',
        'Unlimited Leads',
        'Dedicated Support',
        'Promotional Offers',
        'Verified Badge',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Package"),
        backgroundColor: AppColors.appColor,
        foregroundColor: AppColors.whiteTheme,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Package Selection
              _buildSectionTitle("Choose Your Subscription Package"),
              const SizedBox(height: 15),
              _buildPackageSelectionCards(),
              const SizedBox(height: 30),

              // Selected Package Details
              _buildSectionTitle("Package Details"),
              const SizedBox(height: 15),
              _buildPackageDetails(),
              const SizedBox(height: 30),

              // Payment Method Selection
              _buildSectionTitle("Select Payment Method"),
              const SizedBox(height: 15),
              _buildPaymentMethodSelection(height, width),
              const SizedBox(height: 30),

              // Summary
              if (selectedPaymentMethod.isNotEmpty) ...[
                _buildSectionTitle("Summary"),
                const SizedBox(height: 15),
                _buildSummary(),
                const SizedBox(height: 30),

                // Proceed Button
                _buildProceedButton(height, width),
                const SizedBox(height: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildPackageSelectionCards() {
    return Column(
      children: List.generate(
        packages.length,
            (index) => GestureDetector(
          onTap: () {
            setState(() {
              selectedPackage = index;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: selectedPackage == index ? Colors.blue.shade50 : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selectedPackage == index ? AppColors.appColor : Colors.grey.shade300,
                width: selectedPackage == index ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              children: [
                Radio<int>(
                  value: index,
                  groupValue: selectedPackage,
                  activeColor: AppColors.appColor,
                  onChanged: (value) {
                    setState(() {
                      selectedPackage = value!;
                    });
                  },
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        packages[index]['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "₹${packages[index]['price']} for ${packages[index]['duration']}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  selectedPackage == index ? Icons.check_circle : Icons.circle_outlined,
                  color: selectedPackage == index ? AppColors.appColor : Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPackageDetails() {
    final selectedPackageData = packages[selectedPackage];

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedPackageData['name'] + " Package",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.appColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "₹${selectedPackageData['price']}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.appColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Duration: ${selectedPackageData['duration']}",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            "What's included:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ...List.generate(
            selectedPackageData['features'].length,
                (index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    selectedPackageData['features'][index],
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSelection(double height, double width) {
    return Column(
      children: [
        _buildPaymentOption(
          title: "UPI Payment",
          subtitle: "Pay using any UPI app",
          value: "UPI",
          icon: Icons.qr_code,
          imagePath: "assets/images/img_4.png",
          height: height,
          width: width,
        ),
        const SizedBox(height: 15),
        _buildPaymentOption(
          title: "Card Payment",
          subtitle: "Pay using credit/debit card",
          value: "Card",
          icon: Icons.credit_card,
          imagePath: "assets/images/img_3.png",
          height: height,
          width: width,
        ),
      ],
    );
  }

  Widget _buildPaymentOption({
    required String title,
    required String subtitle,
    required String value,
    required IconData icon,
    required String imagePath,
    required double height,
    required double width,
  }) {
    final bool isSelected = selectedPaymentMethod == value;

    return InkWell(
      onTap: () {
        setState(() {
          selectedPaymentMethod = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.appColor : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: selectedPaymentMethod,
              activeColor: AppColors.appColor,
              onChanged: (newValue) {
                setState(() {
                  selectedPaymentMethod = newValue!;
                });
              },
            ),
            const SizedBox(width: 10),
            Icon(icon, size: 28, color: AppColors.appColor),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: height * 0.06,
              width: width * 0.14,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummary() {
    final selectedPackageData = packages[selectedPackage];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _buildSummaryRow("Vendor", widget.name),
          _buildSummaryRow("Business", widget.businessName),
          _buildSummaryRow("Phone", widget.phone),
          _buildSummaryRow("Package", selectedPackageData['name']),
          _buildSummaryRow("Duration", selectedPackageData['duration']),
          _buildSummaryRow("Payment Method", selectedPaymentMethod),
          const Divider(thickness: 1),
          _buildSummaryRow(
            "Total Amount",
            "₹${selectedPackageData['price']}",
            isBold: true,
          ),
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

  Widget _buildProceedButton(double height, double width) {
    return InkWell(
      onTap: () {
        if (selectedPaymentMethod.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please select a payment method"),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          _navigateToPaymentConfirmation();
        }
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
            "Proceed to Pay ₹${packages[selectedPackage]['price']}",
            style: TextStyle(fontSize: 18, color: AppColors.whiteTheme),
          ),
        ),
      ),
    );
  }

  void _navigateToPaymentConfirmation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VendorPaymentConfirmationScreen(
          name: widget.name,
          phone: widget.phone,
          businessName: widget.businessName,
          category: widget.category,
          city: widget.city,
          experience: widget.experience,
          packageName: packages[selectedPackage]['name'],
          packagePrice: packages[selectedPackage]['price'].toString(),
          packageDuration: packages[selectedPackage]['duration'],
          paymentMethod: selectedPaymentMethod,
        ),
      ),
    );
  }
}