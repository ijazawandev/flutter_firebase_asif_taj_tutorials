import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_firebase_asif_taj_tutorials/ui/auth/firestore/firestore_list_screen.dart';
import 'package:flutter_firebase_asif_taj_tutorials/util/utils.dart';
import 'package:flutter_firebase_asif_taj_tutorials/widget/round_button.dart';

class AddFireStoreDataScreen extends StatefulWidget {
  const AddFireStoreDataScreen({super.key});

  @override
  State<AddFireStoreDataScreen> createState() => _AddFireStoreDataScreenState();
}

class _AddFireStoreDataScreenState extends State<AddFireStoreDataScreen> {


  final postController = TextEditingController();
  bool loading = false;
 // final databaseref = FirebaseDatabase.instance.ref('Post');
  final fireStore = FirebaseFirestore.instance.collection('users');

  // static var instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text('Add Fire Strore Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              maxLines: 4,
              controller: postController,
              decoration: InputDecoration(
                  hintText: 'What is your password',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(
                title: 'Add',
                loading: loading,
                onTap: () {
                  setState(() {
                    loading = true;

                  });
                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  fireStore.doc(id)..set({
                    'title':postController.text.toString(),
                    'id':id,

                  }).then((  value ){
                    setState(() {
                      loading=false ;
                    });
                    Utils().toastMessage('ost added');
                  }).onError((error, stackTrace){
                    setState(() {
                      loading=false;
                    });
                    Utils().toastMessage(error.toString());
                  });

                  //String id = DateTime.now().millisecondsSinceEpoch.toString();
                  // databaseref.child(id).set({
                  //   'id': id,
                  //   'title': postController.text.toString(),
                  // }).then((value) {
                  //   Utils().toastMessage('Post Added');
                  //   print(postController.text);
                  //   loading = false;
                  //   Navigator.pop(context);
                  // }).onError((error, stackTrace) {
                  //   Utils().toastMessage(error.toString());
                  //   setState(() {
                  //     loading = true;
                  //   });
               //   });
                })
          ],
        ),
      ),
    );
  }

  Future<void> showMyDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update'),
            content: Container(
              child: TextField(),
            ),
            actions: [],
          );
        });
  }
}
