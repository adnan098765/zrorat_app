import 'package:flutter/material.dart';

import '../AppColors/app_colors.dart';
import '../ClientVendorScreen/payment_method_screen.dart';
import '../Widgets/custom_textfield.dart';

class ClientRegistrationScreen extends StatefulWidget {
  const ClientRegistrationScreen({super.key});

  @override
  State<ClientRegistrationScreen> createState() => _ClientRegistrationScreenState();
}

class _ClientRegistrationScreenState extends State<ClientRegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  String selectedPaymentMethod = '';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Client Registration"),
        backgroundColor: AppColors.appColor,
        foregroundColor: AppColors.whiteTheme,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextField(
                controller: nameController,
                hintText: "Name",
                prefixIcon: Icons.person,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: phoneController,
                hintText: "Phone",
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: budgetController,
                hintText: "Budget",
                prefixIcon: Icons.attach_money,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  _showPaymentMethodsBottomSheet(context, height, width);
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
                      selectedPaymentMethod.isEmpty ? "Select Payment Method" : "Change Payment Method",
                      style: TextStyle(fontSize: 20, color: AppColors.whiteTheme),
                    ),
                  ),
                ),
              ),
              if (selectedPaymentMethod.isNotEmpty) ...[
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        selectedPaymentMethod == "UPI" ? Icons.qr_code : Icons.credit_card,
                        color: AppColors.appColor,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Selected Payment Method",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          Text(
                            selectedPaymentMethod,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: _proceedToPayment,
                  child: Container(
                    height: height * 0.06,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.appColor,
                    ),
                    child: Center(
                      child: Text(
                        "Confirm and Pay",
                        style: TextStyle(fontSize: 20, color: AppColors.whiteTheme),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showPaymentMethodsBottomSheet(BuildContext context, double height, double width) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: height * 0.5,
          width: width,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.whiteTheme,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select Payment Method",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Choose your preferred payment option",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              _buildPaymentOption(
                title: "UPI Payment",
                description: "Pay using any UPI app",
                icon: Icons.qr_code,
                onTap: () {
                  setState(() {
                    selectedPaymentMethod = "UPI";
                  });
                  Navigator.pop(context);
                },
                height: height,
                width: width,
                imagePath: "assets/images/img_4.png",
              ),
              const SizedBox(height: 15),
              _buildPaymentOption(
                title: "Card Payment",
                description: "Pay using credit/debit card",
                icon: Icons.credit_card,
                onTap: () {
                  setState(() {
                    selectedPaymentMethod = "Card";
                  });
                  Navigator.pop(context);
                },
                height: height,
                width: width,
                imagePath: "assets/images/img_3.png",
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPaymentOption({
    required String title,
    required String description,
    required IconData icon,
    required Function() onTap,
    required double height,
    required double width,
    required String imagePath,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, size: 32, color: AppColors.appColor),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: height * 0.08,
              width: width * 0.15,
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

  void _proceedToPayment() {
    // Input validation
    if (nameController.text.isEmpty) {
      _showValidationError("Please enter your name");
      return;
    }
    if (phoneController.text.isEmpty) {
      _showValidationError("Please enter your phone number");
      return;
    }
    if (budgetController.text.isEmpty) {
      _showValidationError("Please enter your budget");
      return;
    }

    // Navigate to payment confirmation screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentConfirmationScreen(
          clientName: nameController.text,
          phoneNumber: phoneController.text,
          budget: budgetController.text,
          paymentMethod: selectedPaymentMethod,
        ),
      ),
    );
  }

  void _showValidationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}