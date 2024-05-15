import 'package:e_kyc/core/colors.dart';
import 'package:e_kyc/features/national_id/presentation/pages/create_national_id.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String routeName = "HomePage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Page"),
        backgroundColor: PRIMARY_GREEN,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40,),
          Text(
            "Welcome to our E-KYC Application.",
            textAlign: TextAlign.center,
            style: GoogleFonts.acme(
                fontWeight: FontWeight.bold, fontSize: 30, color: TEXT_COLOR_1),
          ),
          const SizedBox(height: 20,),
          _headerDesign(context),
        ],
      ),
    );
  }
  _headerDesign(context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          color: CARD_COLOR,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black, width: 1), // Border color and width
            borderRadius: BorderRadius.circular(10), // Border radius
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Here you can Manage your National ID Card",
                    textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
                const SizedBox(height: 30,),
                Text(
                    "If you do not have an national id, click bellow to create one",
                    textAlign: TextAlign.center,style: GoogleFonts.gabriela(color: TEXT_COLOR_2,fontWeight: FontWeight.w700),),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, CreateNationalIdCardPage.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_GREEN, // Background color
                  ),
                  child: const Text(
                    "Create National ID",
                    textAlign: TextAlign.center,
                  ),
                ),
              const SizedBox(height: 30,),
              Text(
                    "If you want to view your National Id Card, click button bellow",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.gabriela(color: TEXT_COLOR_2,fontWeight: FontWeight.w700)),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, CreateNationalIdCardPage.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_GREEN, // Background color
                  ),
                  child: const Text(
                    "View your National ID",
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
