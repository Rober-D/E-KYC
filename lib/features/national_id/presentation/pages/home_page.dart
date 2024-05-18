import 'package:e_kyc/core/colors.dart';
import 'package:e_kyc/features/auth/presentation/provider/user_token_provider.dart';
import 'package:e_kyc/features/national_id/domain/entities/server_entity.dart';
import 'package:e_kyc/features/national_id/presentation/bloc/national_id_bloc.dart';
import 'package:e_kyc/features/national_id/presentation/pages/create_national_id.dart';
import 'package:e_kyc/features/national_id/presentation/pages/view_national_id_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/util.dart';
import '../../domain/entities/national_id_entity.dart';
import '../server_bloc/server_bloc.dart';

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
                  onPressed: () async {
                    /// ToDo - Check if the user has a national id or not.
                    // ServerEntity server = ServerEntity(localHostServer: "");
                    // BlocProvider.of<ServerBloc>(context)
                    //     .add(GetServerLinkEvent(serverEntity: server));
                    var nid = await BlocProvider.of<NationalIdBloc>(context)
                        .getNationalIdUseCase
                        .nationalIdRepository
                        .getNationalId(
                        userNationalId:
                        userTokenProvider.userLoggedIn!.nationalId!,
                        userToken: userTokenProvider.token!);

                    nid.fold((failure) {
                      Navigator.pushNamed(
                          context, CreateNationalIdPage.routeName);
                    }, (r){
                      Navigator.pushNamed(
                          context, CreateNationalIdPage.routeName);

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Attention'),
                            content: const Text('You already have an NID Card. Go and view it.'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                              ),
                            ],
                          );
                        },
                      );
                    });
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
                    var nid = await BlocProvider.of<NationalIdBloc>(context)
                        .getNationalIdUseCase
                        .nationalIdRepository
                        .getNationalId(
                            userNationalId:
                                userTokenProvider.userLoggedIn!.nationalId!,
                            userToken: userTokenProvider.token!);

                    nid.fold((failure) {
                      SnackBarMessage snackbar = SnackBarMessage();
                      snackbar.showErrorSnackBar(
                          msg:
                              "There is No NID Card Match this NID Number",
                          context: context);
                    }, (success) {
                      BlocProvider.of<NationalIdBloc>(context).add(GetNationalIdEvent(nationalId: success.nationalId, token: userTokenProvider.token!,nationalIdEntity: success));
                      Navigator.pushNamed(
                          context, ViewNationalIdPage.routeName);
                    });
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
