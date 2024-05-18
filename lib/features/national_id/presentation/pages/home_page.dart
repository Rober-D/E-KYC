import 'package:e_kyc/core/colors.dart';
import 'package:e_kyc/features/auth/presentation/provider/user_token_provider.dart';
import 'package:e_kyc/features/national_id/domain/entities/national_id_entity.dart';
import 'package:e_kyc/features/national_id/presentation/bloc/national_id_bloc.dart';
import 'package:e_kyc/features/national_id/presentation/pages/create_national_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/util.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String routeName = "HomePage";

  @override
  Widget build(BuildContext context) {
    UserTokenProvider userTokenProvider =
        Provider.of<UserTokenProvider>(context);
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
          const SizedBox(
            height: 40,
          ),
          Text(
            "Welcome to our E-KYC Application.",
            textAlign: TextAlign.center,
            style: GoogleFonts.acme(
                fontWeight: FontWeight.bold, fontSize: 30, color: TEXT_COLOR_1),
          ),
          const SizedBox(
            height: 20,
          ),
          _headerDesign(context),
        ],
      ),
    );
  }

  _headerDesign(context) {
    UserTokenProvider userTokenProvider =
        Provider.of<UserTokenProvider>(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          color: CARD_COLOR,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black, width: 1),
            // Border color and width
            borderRadius: BorderRadius.circular(10), // Border radius
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Here you can Manage your National ID Card",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "If you do not have an national id, click bellow to create one",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.gabriela(
                      color: TEXT_COLOR_2, fontWeight: FontWeight.w700),
                ),
                ElevatedButton(
                  onPressed: () {
                    /// ToDo - Check if the user has a national id or not.
                    BlocProvider.of<NationalIdBloc>(context).add(
                        GetNationalIdEvent(
                            nationalId:
                                userTokenProvider.userLoggedIn!.nationalId!,
                            token: userTokenProvider.token!));
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
                const SizedBox(
                  height: 30,
                ),
                Text(
                    "If you want to view your National Id Card, click button bellow",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.gabriela(
                        color: TEXT_COLOR_2, fontWeight: FontWeight.w700)),
                ElevatedButton(
                  onPressed: () async {
                    print("Username : ${userTokenProvider.userLoggedIn!.userName!}");
                    print("NID : ${userTokenProvider.userLoggedIn!.nationalId!}");
                    print("BD : ${userTokenProvider.userLoggedIn!.birthdate!}");
                    NationalIdEntity nid =
                        await BlocProvider.of<NationalIdBloc>(context)
                            .getNationalIdUseCase
                            .nationalIdRepository
                            .getNationalId(
                                userNationalId:
                                    userTokenProvider.userLoggedIn!.nationalId!,
                                userToken: userTokenProvider.token!);
                    if (nid.id == "There is no NID for this username") {
                      SnackBarMessage snackbar = SnackBarMessage();
                      snackbar.showErrorSnackBar(
                          msg: nid.nationalId, context: context);
                    } else {
                      Navigator.pushReplacementNamed(
                          context, CreateNationalIdCardPage.routeName);
                    }
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
