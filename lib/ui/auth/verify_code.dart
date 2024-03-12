import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_asif_taj_tutorials/post/post_screen.dart';

import '../../util/utils.dart';
import '../../widget/round_button.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;

  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;
  final VerificationCodeController = TextEditingController();

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text('Verify'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            TextFormField(
              controller: VerificationCodeController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(hintText: '6 digit code'),
            ),
            SizedBox(
              height: 80,
            ),
            RoundButton(
                title: 'Verify',
                loading: loading,
                onTap: ()async {

                  setState(() {
                    loading=true;
                  });
                  final crendital = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: VerificationCodeController.text.toString());
                  try{

                    await auth.signInWithCredential(crendital);

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
                  }catch(e){
                    setState(() {
                      loading=false;
                    });
                    Utils().toastMessage(e.toString());


                  }
                }),
          ],
        ),
      ),
    );
  }
}
