import 'package:e_kyc/features/auth/presentation/provider/user_token_provider.dart';
import 'package:e_kyc/features/auth/presentation/widgets/input_text_widget.dart';
import 'package:e_kyc/features/national_id/domain/entities/national_id_entity.dart';
import 'package:e_kyc/features/national_id/presentation/bloc/national_id_bloc.dart';
import 'package:e_kyc/features/national_id/presentation/pages/submit_national_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../core/colors.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../data/models/national_id_image_data_model.dart';
import '../../domain/entities/server_entity.dart';
import '../server_bloc/server_bloc.dart';

class CreateNationalIdPage extends StatefulWidget {
  const CreateNationalIdPage({super.key});

  static const String routeName = "CreateNationalIdPage";

  @override
  State<CreateNationalIdPage> createState() => _CreateNationalIdPageState();
}

class _CreateNationalIdPageState extends State<CreateNationalIdPage> {
  XFile? _imageFile;

  String? _base64Image;

  NationalIdImageDataModel? _responseText;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    UserTokenProvider userTokenProvider =
        Provider.of<UserTokenProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Create Your NID"),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_GREEN,
        onPressed: () {
          _responseText = null;
          setState(() {
            _pickImage();
          });
        },
        child: const Icon(Icons.add_photo_alternate_outlined),
      ),
      backgroundColor: BACKGROUND_2,
      body: SafeArea(
        child: _imageFile != null
            ? Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      'This is your National ID',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.acme(
                          fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Make Sure the picture is clear',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.acme(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Container(
                    width: 350,
                    height: 220,
                    color: BACKGROUND_2,
                    child: Image.file(
                      File(_imageFile!.path),
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  _isLoading
                      ? Center(
                          child: Text(
                            'The Process Might take several minuets',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.acme(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 20,
                  ),
                  _isLoading
                      ? CircularProgressIndicator() // Show circular progress indicator while loading
                      : _responseText == null
                          ? Center(
                              child: MaterialButton(
                                minWidth: 200,
                                onPressed: () async {
                                  /// ToDo - Extract Image by ML Algorithm ( Using flask API ).
                                  // ServerEntity server =
                                  //     ServerEntity(localHostServer: "");
                                  // BlocProvider.of<ServerBloc>(context).add(
                                  //     GetServerLinkEvent(serverEntity: server));
                                  _responseText = await _triggerServer(
                                      context);
                                  print(
                                      "The response has been returned is : $_responseText");
                                },
                                color: PRIMARY_GREEN,
                                child: const Text(
                                  "Extract Image",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            )
                          : _responseText!.ocrData[0] ==
                                  "Not Egyptian ID , please try again..."
                              ? const Text(
                                  "This is not a National ID, please upload valid one")
                              : (_responseText!.ocrData[0] ==
                                      "The picture is not clear enough , please take a close , high resolution and clear picture")
                                  ? const Text(
                                      "Please take a clear National ID image")
                                  : Center(
                                      child: MaterialButton(
                                        minWidth: 200,
                                        onPressed: () {
                                          /// ToDo - Use Create National ID API.

                                          NationalIdEntity nationalId =
                                              NationalIdEntity(
                                                  firstName:
                                                      _responseText!.ocrData[0],
                                                  lastName:
                                                      _responseText!.ocrData[1],
                                                  nationalId:
                                                      _responseText!.ocrData[2],
                                                  birthday:
                                                      _responseText!.ocrData[3],
                                                  address:
                                                      _responseText!.ocrData[4],
                                                  gender:
                                                      _responseText!.ocrData[5],
                                                  image: _base64Image!,
                                                  status: "PENDING",
                                                  contractAmount: 250);

                                          Navigator.pushNamed(context, SubmitNationalIdPage.routeName,arguments: nationalId);
                                        },
                                        color: PRIMARY_GREEN,
                                        child: const Text(
                                          "Submit",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'No image selected',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.acme(
                          fontSize: 28, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      'Please Take a picture for your National ID Card',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.aBeeZee(
                          fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
      ),
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

  Future<NationalIdImageDataModel> _triggerServer(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    String baseUrl = "https://a486-154-178-73-62.ngrok-free.app/flutter";
    NationalIdImageDataModel res;
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(baseUrl),
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
