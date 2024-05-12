import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class OcrMlPage extends StatefulWidget {
  const OcrMlPage({super.key});

  @override
  State<OcrMlPage> createState() => _OcrMlPageState();
}

class _OcrMlPageState extends State<OcrMlPage> {

  XFile? _imageFile;
  String? _base64Image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OCR Machine test"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /// ToDo - Pick Image from Camera or Gallery.
          /// ToDo - Convert it to base64.
          _pickImageFromGallery();
          /// ToDo - Store it in MongoDB.
        },
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: MaterialButton(
                onPressed: () {
                  /// ToDo - Extract Image by ML Algorithm ( Using flask API ).
                },
                color: Colors.green,
                child: const Text("Extract Image",style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async{
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image != null){
      setState(() {
        _imageFile = image;
      });
      final imageBytes = File(_imageFile!.path).readAsBytesSync();
      _base64Image = base64Encode(imageBytes);
      print("^DONE^ $_base64Image ^DONE^");
      print("^DONE^");
    }else{
      print("There is no Image detected.");
    }
  }
}
