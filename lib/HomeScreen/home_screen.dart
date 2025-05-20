import 'package:flutter/material.dart';
import 'package:zarorat_app/AppColors/app_colors.dart';
import 'package:zarorat_app/HomeScreen/architectural_screen.dart';
import 'package:zarorat_app/HomeScreen/bpo_service_screen.dart';
import 'package:zarorat_app/HomeScreen/fabrications_screen.dart';
import 'package:zarorat_app/HomeScreen/it_services_screen.dart';
import 'package:zarorat_app/HomeScreen/nutrionist_screen.dart';

import 'advertising_screen.dart';
import 'it_service_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> catimages = [
    "assets/images/img.png",
    "assets/images/img.png",
    "assets/images/img.png",
    "assets/images/img.png",
    "assets/images/img.png",
    "assets/images/img.png",
  ];
  final List<String> catservices = [
    "Advertising\nBlue Lines Art",
    "IT Services\nBlue Lines Tech",
    "Architectural",
    "Nutritionist",
    "Fabrication",
    "BPO Services",
  ];
  void navigateToNextScreen(int index) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => AdvertisingScreen()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => ITServiceScreen()));
        break;
      case 2:
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ArchitecturalScreen()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>NutrionistScreen()));
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>FabricationsScreen()));
      case 5:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BpoServiceScreen()));

      default:
      // Optional: show a snackbar or fallback screen
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.sheetBlack,
        title: const Text("Select your category"),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double height = constraints.maxHeight;
          double width = constraints.maxWidth;

          return Column(
            children: [
              SizedBox(
                height: height * 0.4,
                width: width,
                child: Image.asset(
                  "assets/images/img.png",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: height*0.03,),
              Expanded(
                child: GridView.builder(
                  itemCount: catimages.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: width > 600 ? 6 : 2, // 3 columns on larger screens
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 3 / 2, // height/width ratio
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        navigateToNextScreen(index);
                      },
                      child: Container(
                        height: height*0.16,
                        padding: const EdgeInsets.all(8),
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
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(catimages[index]),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              flex: 2,
                              child: Text(
                                catservices[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: width * 0.035,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
