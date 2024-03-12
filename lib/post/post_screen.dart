import 'dart:ffi';
import 'dart:js_interop';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_asif_taj_tutorials/post/add_posts.dart';
import 'package:flutter_firebase_asif_taj_tutorials/ui/auth/login_screen.dart';
import 'package:flutter_firebase_asif_taj_tutorials/util/utils.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchFilter = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.onValue.listen((event) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Center(child: Text('Post')),
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });
            },
            icon: Icon(Icons.logout_outlined),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: searchFilter,
              decoration: InputDecoration(
                  hintText: 'Seach', border: OutlineInputBorder()),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                defaultChild: Text('Loading'),
                itemBuilder: (context, snapshot, animation, index) {
                  final title = Text(snapshot.child('title').value.toString());
                  if (searchFilter.text.isEmpty) {
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                    );
                  }else if(true){
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                    );

                  }else{
                    return Container();
                  }
                }),
          ),

          // Expanded(
          //   child: StreamBuilder(
          //               stream: ref.onValue,
          //               builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          //   Map<dynamic,dynamic> map=snapshot.data!.snapshot.value as dynamic;
          //   List<dynamic>list=[];
          //   list.clear();
          //   list=map.values.toList();
          //   if(!snapshot.hasData){
          //     return CircularProgressIndicator();
          //
          //   }else{
          //
          //   }
          //   return ListView.builder(
          //       itemCount: snapshot.data?.snapshot.children.length,
          //       itemBuilder: (context, index) {
          //     return ListTile(
          //       title: Text(list[index]['title']),
          //        subtitle: Text(list[index]['id']),
          //     );
          //   });
          //               }, // stream: null, // stream error//
          //             ),
          // ),

          // ListTile(
          //   title: Text('Hello'),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPostScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
