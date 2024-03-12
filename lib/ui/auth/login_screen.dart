import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_asif_taj_tutorials/post/post_screen.dart';
import 'package:flutter_firebase_asif_taj_tutorials/ui/auth/login_with_phone_number.dart';
import 'package:flutter_firebase_asif_taj_tutorials/ui/auth/signup_screen.dart';
import 'package:flutter_firebase_asif_taj_tutorials/util/utils.dart';
import 'package:flutter_firebase_asif_taj_tutorials/widget/round_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetail();
  }

  void getUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    if (email != null && password != null) {
      emailController.text = email;
      passwordController.text = password;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text.toString())
        .then((value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', emailController.text);
      prefs.setString('password', passwordController.text);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => PostScreen()));
      setState(() {
        loading = false;
      });
      Utils().toastMessage('User signed in successfully.');
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  suffixIcon: Icon(Icons.alternate_email),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter email';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'password',
                  suffixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              RoundButton(
                title: 'Login',
                onTap: () {
                  if (_formkey.currentState!.validate());
                  login();
                },
              ),
              SizedBox(
                height: 30,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostScreen()),
                        );
                      },
                      child: Text('Sign Up')),
                ],
              ),
              SizedBox(height: 30,),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>  LoginWithPhoneNumber()));
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text('Login with phone'),
                  ),
                ),
              )
            ],

          ),
        ),
      ),
    );
  }
}
