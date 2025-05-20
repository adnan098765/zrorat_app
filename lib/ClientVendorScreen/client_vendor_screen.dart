import 'package:flutter/material.dart';
import 'package:zarorat_app/AppColors/app_colors.dart';
import 'package:zarorat_app/ClentRegistration/client_registration_screen.dart';
import 'package:zarorat_app/VendorScreen/vendor_screen.dart';

class ClientVendorScreen extends StatefulWidget {
  const ClientVendorScreen({super.key});

  @override
  State<ClientVendorScreen> createState() => _ClientVendorScreenState();
}

class _ClientVendorScreenState extends State<ClientVendorScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteTheme,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Who Are You?",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.appColor,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildRoleCard(
                  title: "Client",
                  icon: Icons.person_outline,
                  gradient: LinearGradient(colors: [Colors.purple, Colors.deepPurple]),
                  onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientRegistrationScreen()));
                  },
                ),
                _buildRoleCard(
                  title: "Vendor",
                  icon: Icons.store_mall_directory_outlined,
                  gradient: LinearGradient(colors: [Colors.teal, Colors.green]),
                  onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>VendorScreen()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required String title,
    required IconData icon,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 160,
        width: 150,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(4, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
