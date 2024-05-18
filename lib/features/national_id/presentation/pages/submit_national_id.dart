import 'package:e_kyc/features/auth/presentation/provider/user_token_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../core/colors.dart';
import '../../../auth/presentation/widgets/input_text_widget.dart';
import '../../domain/entities/national_id_entity.dart';
import '../bloc/national_id_bloc.dart';

class SubmitNationalIdPage extends StatelessWidget {
  const SubmitNationalIdPage({super.key});
  static const String routeName = "SubmitNationalIdPage";

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as NationalIdEntity;

    TextEditingController firstNameController =
    TextEditingController(text: argument.firstName);
    TextEditingController lastNameController =
    TextEditingController(text: argument.lastName);
    TextEditingController addressController =
    TextEditingController(text: argument.address);
    TextEditingController nationalIdController =
    TextEditingController(text: argument.nationalId);
    TextEditingController birthdateController =
    TextEditingController(text: argument.birthday);
    TextEditingController genderController =
    TextEditingController(text: argument.gender);

    UserTokenProvider userTokenProvider = Provider.of<UserTokenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Your NID Data"),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              InputTextWidget(
                  inputController: firstNameController,
                  hintText: "",
                  icon: Icon(
                    Icons.person_outline,
                    color: PRIMARY_ORANGE,
                  ),
                  isPassword: false,
                  readOnly: false,
                  forNumbersOrCalenderOrGender: 0,
                  isArabicDirection: true),
              const SizedBox(
                height: 20,
              ),
              InputTextWidget(
                  inputController: lastNameController,
                  hintText: "",
                  icon: Icon(
                    Icons.person_outline,
                    color: PRIMARY_ORANGE,
                  ),
                  isPassword: false,
                  readOnly: false,
                  forNumbersOrCalenderOrGender: 0,
                  isArabicDirection: true),
              const SizedBox(
                height: 20,
              ),
              InputTextWidget(
                  inputController: addressController,
                  hintText: "",
                  icon: Icon(
                    Icons.person_outline,
                    color: PRIMARY_ORANGE,
                  ),
                  isPassword: false,
                  readOnly: false,
                  forNumbersOrCalenderOrGender: 0,
                  isArabicDirection: true),
              const SizedBox(
                height: 20,
              ),
              InputTextWidget(
                  inputController: nationalIdController,
                  hintText: "",
                  icon: Icon(
                    Icons.person_outline,
                    color: PRIMARY_ORANGE,
                  ),
                  isPassword: false,
                  readOnly: false,
                  forNumbersOrCalenderOrGender: 0,
                  isArabicDirection: true),
              const SizedBox(
                height: 20,
              ),
              InputTextWidget(
                  inputController: birthdateController,
                  hintText: "",
                  icon: Icon(
                    Icons.person_outline,
                    color: PRIMARY_ORANGE,
                  ),
                  isPassword: false,
                  readOnly: false,
                  forNumbersOrCalenderOrGender: 0,
                  isArabicDirection: true),
              const SizedBox(
                height: 20,
              ),
              InputTextWidget(
                  inputController: genderController,
                  hintText: "",
                  icon: Icon(
                    Icons.person_outline,
                    color: PRIMARY_ORANGE,
                  ),
                  isPassword: false,
                  readOnly: false,
                  forNumbersOrCalenderOrGender: 0,
                  isArabicDirection: true),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                minWidth: 200,
                onPressed: () {
                  BlocProvider.of<NationalIdBloc>(context).add(
                      CreateNationalIdEvent(
                          newNationalIdCard: argument,
                          token: userTokenProvider.token!));
                },
                color: PRIMARY_ORANGE,
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
