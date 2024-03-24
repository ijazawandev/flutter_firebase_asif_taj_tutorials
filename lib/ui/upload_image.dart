import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_asif_taj_tutorials/util/utils.dart';
import 'package:flutter_firebase_asif_taj_tutorials/widget/round_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  bool loading=false;
  File? _image;

  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
DatabaseReference databaseRef=FirebaseDatabase.instance.ref('Post');
  

  Future getImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('no image');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text('Upload Image Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: () {
                getImageGallery();
              },
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: _image != null
                    ? Image.file(_image!.absolute)
                    : Icon(Icons.image),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          RoundButton(

              title: 'upload',
              loading: loading,
              onTap: () async {
                  setState(() {
                    loading=true;
                  });
                firebase_storage.Reference ref = firebase_storage
                    .FirebaseStorage.instance
                    .ref('/foldername' + DateTime.now().millisecond.toString());
                firebase_storage.UploadTask uploadtask =
                    ref.putFile(_image!.absolute);

                 Future.value(uploadtask).then((value)async{
                  var  newUrl= await ref.getDownloadURL();
                  databaseRef.child('i').set({
                    'id':'2335',
                    'title':newUrl.toString(),
                  }).then((value){
                    setState(() {
                      loading=false;
                    });

                  }).onError((error, stackTrace) {
                    setState(() {
                      loading=false;
                    });

                  });
                  Utils().toastMessage('uploaded');

                }).onError((error, stackTrace){
                  Utils().toastMessage(error.toString());
                  setState(() {
                    loading=false;
                  });
                });

              })
        ],
      ),
    );
  }
}
