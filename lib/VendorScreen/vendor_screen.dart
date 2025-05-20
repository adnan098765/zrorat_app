import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zarorat_app/VendorScreen/vendor_payment_screen.dart';
import 'dart:io';

import '../AppColors/app_colors.dart';
import '../Widgets/custom_textfield.dart';

class VendorScreen extends StatefulWidget {
  const VendorScreen({super.key});

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();

  // For category selection
  final List<String> categories = [
    'Advertising ',
    'IT Services',
    'Architectural',
    'Nutritionist',
    'Fabrication',
    'BPO Services',
    // 'Cook',
    // 'Gardener',
    // 'Tailor',
    'Other'
  ];

  // For city selection
  final List<String> cities = [
    'Karachi',
    'Lahore',
    'Islamabad',
    'Peshawar',
    'Quetta',
    'Multan',
    'Faisalabad',
    'Rawalpindi',
    'Hyderabad',
    'Other'
  ];

  String? selectedCategory;
  String? selectedCity;
  File? profileImage;
  File? businessImage;
  bool termsAccepted = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Vendor Registration"),
        backgroundColor: AppColors.appColor,
        foregroundColor: AppColors.whiteTheme,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Personal Information",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                _buildImagePicker(
                  title: "Profile Picture",
                  onPick: () => _pickImage(true),
                  imageFile: profileImage,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  controller: nameController,
                  hintText: "Full Name",
                  prefixIcon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: phoneController,
                  hintText: "Phone Number",
                  prefixIcon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your phone number";
                    }
                    return null;
                  },
                ),
                _buildDropdown(
                  hint: "Select City",
                  value: selectedCity,
                  items: cities,
                  onChanged: (value) {
                    setState(() {
                      selectedCity = value;
                    });
                  },
                  prefixIcon: Icons.location_city,
                ),
                const SizedBox(height: 25),
                const Text(
                  "Business Information",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                _buildImagePicker(
                  title: "Business Logo/Image",
                  onPick: () => _pickImage(false),
                  imageFile: businessImage,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  controller: businessNameController,
                  hintText: "Business Name",
                  prefixIcon: Icons.business,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your business name";
                    }
                    return null;
                  },
                ),
                _buildDropdown(
                  hint: "Select Service Category",
                  value: selectedCategory,
                  items: categories,
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                  prefixIcon: Icons.category,
                ),
                CustomTextField(
                  controller: experienceController,
                  hintText: "Years of Experience",
                  prefixIcon: Icons.work,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your experience";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                _buildTermsAndConditions(),
                const SizedBox(height: 25),
                _buildRegisterButton(context, height, width),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker({
    required String title,
    required VoidCallback onPick,
    required File? imageFile,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: onPick,
          child: Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: imageFile != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                imageFile,
                fit: BoxFit.cover,
              ),
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_a_photo,
                  size: 40,
                  color: AppColors.appColor,
                ),
                const SizedBox(height: 10),
                Text(
                  "Upload Image",
                  style: TextStyle(
                    color: AppColors.appColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    required IconData prefixIcon,
  }) {
    return Container(
      // margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
        color: Colors.white,
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon, color: AppColors.appColor),
          border: InputBorder.none,
        ),
        hint: Text(hint),
        value: value,
        isExpanded: true,
        validator: (value) => value == null ? "Please select an option" : null,
        items: items.map((String item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Row(
      children: [
        Checkbox(
          value: termsAccepted,
          activeColor: AppColors.appColor,
          onChanged: (value) {
            setState(() {
              termsAccepted = value ?? false;
            });
          },
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              text: "I agree to the ",
              style: TextStyle(color: Colors.grey[700]),
              children: [
                TextSpan(
                  text: "Terms & Conditions",
                  style: TextStyle(
                    color: AppColors.appColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: " and "),
                TextSpan(
                  text: "Privacy Policy",
                  style: TextStyle(
                    color: AppColors.appColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton(BuildContext context, double height, double width) {
    return InkWell(
      onTap: () {
        if (_formKey.currentState!.validate() && _validateExtraFields()) {
          _navigateToPaymentScreen();
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
            "Register & Continue to Payment",
            style: TextStyle(fontSize: 18, color: AppColors.whiteTheme),
          ),
        ),
      ),
    );
  }

  bool _validateExtraFields() {
    if (!termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please accept the terms and conditions"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    if (selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a service category"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    if (selectedCity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a city"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    return true;
  }

  void _pickImage(bool isProfile) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        if (isProfile) {
          profileImage = File(image.path);
        } else {
          businessImage = File(image.path);
        }
      });
    }
  }

  void _navigateToPaymentScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VendorPaymentScreen(
          name: nameController.text,
          phone: phoneController.text,
          businessName: businessNameController.text,
          category: selectedCategory!,
          city: selectedCity!,
          experience: experienceController.text,
        ),
      ),
    );
  }
}