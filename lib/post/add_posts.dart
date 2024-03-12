import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_asif_taj_tutorials/util/utils.dart';
import 'package:flutter_firebase_asif_taj_tutorials/widget/round_button.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final postController=TextEditingController();
  bool loading=false;
  final databaseref=FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30,),
            TextFormField(
              maxLines: 4,
              controller: postController,
              decoration: InputDecoration(

                hintText: 'What is your password',
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 30,),
            RoundButton(title: 'Add',
                loading: loading,
                onTap: (){
              setState(() {
                loading=true;
              });
              databaseref.child(DateTime.now().millisecondsSinceEpoch.toString()).set({
                'title':postController.text.toString()
              }).then((value){
                Utils().toastMessage('Post Added');
                loading=true;


              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
                setState(() {
                  loading=true;
                });
              });


            })

          ],
        ),
      ),
    );
  }
}
