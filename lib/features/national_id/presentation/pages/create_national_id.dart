import 'dart:convert';
import 'dart:io';
import 'package:e_kyc/features/national_id/domain/entities/national_id_entity.dart';
import 'package:e_kyc/features/national_id/presentation/pages/make_sure.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../../../core/colors.dart';

class CreateNationalIdCardPage extends StatefulWidget {
  const CreateNationalIdCardPage({super.key});

  static const String routeName = "CreateNationalIdCardPage";

  @override
  State<CreateNationalIdCardPage> createState() =>
      _CreateNationalIdCardPageState();
}

class _CreateNationalIdCardPageState extends State<CreateNationalIdCardPage> {
  XFile? _imageFile;
  String? _base64Image;
  String? _responseText;
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
                  ): const SizedBox(),
                  const SizedBox(
                    height: 20,
                  ),
                  _isLoading
                      ? CircularProgressIndicator() // Show circular progress indicator while loading
                      : _responseText == null
                      ? Center(
                          child: MaterialButton(
                            minWidth: 200,
                            onPressed: () {
                              /// ToDo - Extract Image by ML Algorithm ( Using flask API ).
                              _triggerServer();
                            },
                            color: PRIMARY_GREEN,
                            child: const Text(
                              "Extract Image",
                              style: TextStyle(color: Colors.white,fontSize: 20),
                            ),
                          ),
                        )
                      : Center(
                          child: MaterialButton(
                            minWidth: 200,
                            onPressed: () {
                              /// ToDo - Use Create National ID API.
                              List<String> decodedResponse =
                                  _fetchResponseToArray(_responseText!);
                              NationalIdEntity nationalId = NationalIdEntity(
                                  firstName: decodedResponse[0],
                                  lastName: decodedResponse[1],
                                  nationalId: decodedResponse[2],
                                  birthday: decodedResponse[3],
                                  address: decodedResponse[4],
                                  gender: decodedResponse[5],
                                  image: _base64Image!,
                                  status: "PENDING",
                                  contractAmount: 250);

                              Navigator.pushNamed(context, Makesure.routeName,
                                  arguments: nationalId);
                            },
                            color: PRIMARY_GREEN,
                            child: const Text(
                              "Submit",
                              style: TextStyle(color: Colors.white,fontSize: 20),
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

  Future<void> _triggerServer() async {
    setState(() {
      _isLoading = true;
    });
    var url =
        'https://1b79-154-178-42-195.ngrok-free.app/flutter'; // Replace with your Flask server URL
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
      setState(() {
        _responseText = _decodeUnicodeEscape(responseData);
      });
      Map<String, dynamic> jsonData = json.decode(_responseText!);
      List<dynamic> ocrData = jsonData['ocr_data'];
      List<String> dataArray =
          ocrData.map((dynamic item) => item.toString().trim()).toList();
    } else {
      setState(() {
        _responseText = 'Error: ${response.reasonPhrase}';
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  String _decodeUnicodeEscape(String input) {
    return input.replaceAllMapped(RegExp(r'\\u[0-9a-fA-F]{4}'), (match) {
      return String.fromCharCode(
          int.parse(match.group(0)!.substring(2), radix: 16));
    });
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
