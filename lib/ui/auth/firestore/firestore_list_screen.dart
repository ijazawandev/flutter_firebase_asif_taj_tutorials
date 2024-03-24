import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

//import 'package:flutter_firebase_asif_taj_tutorials/post/add_posts.dart';
import 'package:flutter_firebase_asif_taj_tutorials/ui/auth/login_screen.dart';
import 'package:flutter_firebase_asif_taj_tutorials/util/utils.dart';

import 'add_firestore_data.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({super.key});

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final fireStore = FirebaseFirestore.instance.collection('users').snapshots();
  final ref1 = FirebaseFirestore.instance.collection('id');
  final auth = FirebaseAuth.instance;
  final searchFilter = TextEditingController();
  final editController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ref.onValue.listen((event) {});
    // ref.onValue.listen((event) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Center(child: Text('Fire Store')),
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });
            },
            icon: Icon(Icons.logout_outlined),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
              stream: fireStore,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Some Error');
                }
                print('Length: ${snapshot.data!.docs.length}');
                print('Data: ${snapshot.data}');
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                        ref1.doc(snapshot.data!.docs[index]['id'].toString())
                            .update({
                          'title': 'Ijaz ahmad'
                        }).then((value) {
                          Utils().toastMessage('updated');
                        })
                            .onError((error, stackTrace) {
                          Utils().toastMessage(error.toString());
                        });
                        // /  ref1.doc(snapshot.data!.docs[index]['id'].toString()).update({
                        //     'title':'asif taj subscribe'
                        //   }).then((value) {
                        //     Utils().toastMessage('updated');
                        //   }).onError((error, stackTrace) {
                        //     Utils().toastMessage(error.toString());
                        //   });
                         },
                        title: Text(
                            snapshot.data!.docs[index]['title'].toString()),
                        subtitle:
                            Text(snapshot.data!.docs[index]['id'].toString()),
                      );
                    },
                  ),
                );
              }),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: 10,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         title: Text('asd'),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddFireStoreDataScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    editController.text = title;
    // Navigator.pop(context);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update'),
          content: Container(
            child: TextField(
              controller: editController,
              decoration: InputDecoration(hintText: 'Edit'),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Update')),
          ],
        );
      },
    );
  }
}
