import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class setting_m extends StatefulWidget {
  const setting_m({super.key});

  @override
  State<setting_m> createState() => _setting_wState();
}

class _setting_wState extends State<setting_m> {
  File? _imagefile;
  final ImagePicker _picker = ImagePicker();
  // PickedFile _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          elevation: 0,
          backgroundColor: Color(0xffe8c869),
          title: Text(
            '설정',
            style: TextStyle(color: Colors.white,),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                maxRadius: 75,
                minRadius: 50,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
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
                    )
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextButton(onPressed:() {},
                    child:
                    Text('로그아웃',
                      style: TextStyle(fontSize: 20,color:
                      Color(0xffBCBCBC),
                        decoration: TextDecoration.underline,
                        decorationThickness: 1.5,
                      ),
                    )
                ),
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
