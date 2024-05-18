import 'dart:convert';
import 'dart:io';
import 'package:e_kyc/features/national_id/data/models/national_id_image_data_model.dart';
import 'package:e_kyc/features/national_id/domain/entities/national_id_entity.dart';
import 'package:e_kyc/features/national_id/domain/entities/server_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../../../core/colors.dart';
import '../../../auth/presentation/widgets/input_text_widget.dart';
import '../bloc/national_id_bloc.dart';
import '../server_bloc/server_bloc.dart';

class ViewNationalIdPage extends StatefulWidget {
  const ViewNationalIdPage({super.key});

  static const String routeName = "ViewNationalIdPage";

  @override
  State<ViewNationalIdPage> createState() =>
      _ViewNationalIdPageState();
}

class _ViewNationalIdPageState extends State<ViewNationalIdPage> {
  XFile? _imageFile;
  String? _base64Image;
  NationalIdImageDataModel? _responseText;
  bool _isLoading = false ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_2,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Create National ID Card"),
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
      body: BlocBuilder<NationalIdBloc, NationalIdState>(
        builder: (context, state) {
          if (state is LoadingNationalIdState) {
            return Center(child: CircularProgressIndicator(color: PRIMARY_GREEN,));
          } else if (state is LoadedNationalIdState) {
            NationalIdEntity nid = state.nationalId;
            return  SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    InputTextWidget(
                        inputController: TextEditingController(text: nid.firstName),
                        hintText: "",
                        icon: Icon(
                          Icons.person_outline,
                          color: PRIMARY_ORANGE,
                        ),
                        isPassword: false,
                        readOnly: true,
                        forNumbersOrCalenderOrGender: 0,
                        isArabicDirection: true),
                    const SizedBox(
                      height: 20,
                    ),
                    InputTextWidget(
                        inputController: TextEditingController(text: nid.lastName),
                        hintText: "",
                        icon: Icon(
                          Icons.person_outline,
                          color: PRIMARY_ORANGE,
                        ),
                        isPassword: false,
                        readOnly: true,
                        forNumbersOrCalenderOrGender: 0,
                        isArabicDirection: true),
                    const SizedBox(
                      height: 20,
                    ),
                    InputTextWidget(
                        inputController: TextEditingController(text: nid.address),
                        hintText: "",
                        icon: Icon(
                          Icons.person_outline,
                          color: PRIMARY_ORANGE,
                        ),
                        isPassword: false,
                        readOnly: true,
                        forNumbersOrCalenderOrGender: 0,
                        isArabicDirection: true),
                    const SizedBox(
                      height: 20,
                    ),
                    InputTextWidget(
                        inputController: TextEditingController(text: nid.nationalId),
                        hintText: "",
                        icon: Icon(
                          Icons.person_outline,
                          color: PRIMARY_ORANGE,
                        ),
                        isPassword: false,
                        readOnly: true,
                        forNumbersOrCalenderOrGender: 0,
                        isArabicDirection: true),
                    const SizedBox(
                      height: 20,
                    ),
                    InputTextWidget(
                        inputController: TextEditingController(text: nid.birthday),
                        hintText: "",
                        icon: Icon(
                          Icons.person_outline,
                          color: PRIMARY_ORANGE,
                        ),
                        isPassword: false,
                        readOnly: true,
                        forNumbersOrCalenderOrGender: 0,
                        isArabicDirection: true),
                    const SizedBox(
                      height: 20,
                    ),
                    InputTextWidget(
                        inputController: TextEditingController(text: nid.gender),
                        hintText: "",
                        icon: Icon(
                          Icons.person_outline,
                          color: PRIMARY_ORANGE,
                        ),
                        isPassword: false,
                        readOnly: true,
                        forNumbersOrCalenderOrGender: 0,
                        isArabicDirection: true),
                  ],
                ),
              ),
            );
          } else if (state is NationalIdErrorState) {
            return Center(
              child: Text('Error: ${state.errorMsg}'),
            );
          } else {
            return const Center(
              child: Text('You already have a National ID Card...'),
            );
          }
        },
      )
    );
  }

  Future<void> _pickImage() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Choose an option',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: PRIMARY_ORANGE,
                ),
                title: const Text(
                  'Pick from Gallery',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      _imageFile = image;
                    });
                    final imageBytes = File(_imageFile!.path).readAsBytesSync();
                    _base64Image = base64Encode(imageBytes);
                  } else {
                    print("There is no Image detected.");
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt, color: PRIMARY_ORANGE),
                title: const Text(
                  'Take a Photo',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  final image =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (image != null) {
                    setState(() {
                      _imageFile = image;
                    });
                    final imageBytes = File(_imageFile!.path).readAsBytesSync();
                    _base64Image = base64Encode(imageBytes);
                    print("^DONE^ $_base64Image ^DONE^");
                    print("^DONE^");
                  } else {
                    print("There is no Image detected.");
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<NationalIdImageDataModel> _triggerServer(BuildContext context,String url) async {
    setState(() {
      _isLoading = true;
    });
    NationalIdImageDataModel res;
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'file',
        _imageFile!.readAsBytes().asStream(),
        await _imageFile!.length(),
        filename: "file",
      ),
    );
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseData = await response.stream.bytesToString();
      res = _decodeUnicodeEscape(responseData);
      setState(() {});
    } else {
        String responseData = await response.stream.bytesToString();
        res = _decodeUnicodeEscape(responseData);
        setState(() {});

    }
    setState(() {
      _isLoading = false;
    });
    return res;
  }

  NationalIdImageDataModel _decodeUnicodeEscape(String input) {
    Map<String, dynamic> decodedJson = json.decode(input);
    return NationalIdImageDataModel.fromJson(decodedJson);
  }

  List<String> _fetchResponseToArray(String response) {
    String decoded = "";
    // Decode the JSON string
    Map<String, dynamic> jsonData = json.decode(response);
    List<dynamic> ocrData = jsonData['ocr_data'];
    List<String> dataArray =
        ocrData.map((dynamic item) => item.toString().trim()).toList();
    return dataArray;
  }
}
