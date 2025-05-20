import 'package:flutter/material.dart';
import 'package:zarorat_app/AppColors/app_colors.dart';
import 'package:zarorat_app/ClientVendorScreen/client_vendor_screen.dart';
import 'package:zarorat_app/HomeScreen/architectural_screen.dart';
import 'package:zarorat_app/HomeScreen/bpo_service_screen.dart';
import 'package:zarorat_app/HomeScreen/fabrications_screen.dart';
import 'package:zarorat_app/HomeScreen/it_services_screen.dart';
import 'package:zarorat_app/HomeScreen/nutrionist_screen.dart';

class AdvertisingScreen extends StatefulWidget {
  const AdvertisingScreen({super.key});

  @override
  State<AdvertisingScreen> createState() => _AdvertisingScreenState();
}

class _AdvertisingScreenState extends State<AdvertisingScreen> {
  final List<String> catimages = [
    "assets/images/img.png",
    "assets/images/img.png",
    "assets/images/img.png",
    "assets/images/img.png",
    "assets/images/img.png",
    "assets/images/img.png",
    "assets/images/img.png",
    "assets/images/img.png",
  ];
  final List<String> catservices = [
    "Acrylic Signs",
    "Neon Signs",
    "Flex Signs",
    "S.Steel Signs",
    "Laser Signs",
    "LED Signs",
    "Reflector signs",
    "Metal Signs",
  ];

  void navigateToNextScreen(int index) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => ClientVendorScreen()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => ItServicesScreen()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ArchitecturalScreen()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>NutrionistScreen()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>FabricationsScreen()));
        break;
      case 5:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BpoServiceScreen()));
        break;
      default:
      // Optional: show a snack bar or fallback screen
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.sheetBlack,
        title: const Text("Advertising"),
        centerTitle: true,
      ),
      // Use SafeArea to respect device notches and status bars
      body: SafeArea(
        child: Container(
          // Ensure the container fills the entire available space
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: screenSize.height * 0.02),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: GridView.builder(
                    // Add physics for better scrolling behavior
                    physics: const BouncingScrollPhysics(),
                    itemCount: catimages.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: screenSize.width > 600 ? 4 : 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      // Adjust the aspect ratio based on screen size
                      childAspectRatio: screenSize.width > 600 ? 1.0 : 0.85,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          navigateToNextScreen(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(2, 2),
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(catimages[index]),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      catservices[index],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}