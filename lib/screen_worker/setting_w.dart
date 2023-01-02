import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class setting_w extends StatefulWidget {
  const setting_w({super.key});

  @override
  State<setting_w> createState() => _setting_wState();
}

class _setting_wState extends State<setting_w> {
  File? _imagefile;
  final ImagePicker _picker = ImagePicker();
  // PickedFile _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '설정',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              CircleAvatar(
                maxRadius: 50,
                minRadius: 50,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: _imagefile != null
                        ? Image.file(
                            _imagefile!,
                            width: 300,
                            height: 300,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/profile.png',
                            fit: BoxFit.cover,
                          )),
              ),
              Row(
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: IconButton(
                          onPressed: () {
                            _pickFromGallery();
                          },
                          icon: Icon(Icons.photo_album))),
                  Align(
                      alignment: Alignment.center,
                      child: IconButton(
                        onPressed: () {
                          _takeImageFromCamera();
                        },
                        icon: Icon(Icons.camera_alt_rounded),
                      )),
                ],
              ),
            ],
          ),
        ));
  }

  _pickFromGallery() async {
    PickedFile? image = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 100);
    setState(() {
      _imagefile = File(image!.path);
    });
  }

  _takeImageFromCamera() async {
    PickedFile? image = await ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 100);
    setState(() {
      _imagefile = File(image!.path);
    });
  }
}
