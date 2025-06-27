import 'package:fitness_application/Databease/DataBase_Functions.dart';
import 'package:fitness_application/Databease/class.dart';
import 'package:fitness_application/Load/signuppage.dart';
import 'package:fitness_application/Load/uihelper.dart';
import 'package:fitness_application/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



class LoginPage extends StatefulWidget {
  final bool signcheck;
  const LoginPage({super.key,required this.signcheck});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> getUserData() async {
    var user = await data_metter.readData('SELECT * FROM users');
    if (user.isNotEmpty) {
      print('==== $user ----------------------------------------------');
      // double? userweight;
      // double? userheight;
      // double? usertype;
      // double? userage;
      // double? userpassword;
      // double? useremail;
      // double? username;
      Map<String, dynamic> userData = user.first;
      // Future.delayed(Duration(seconds: 1),(){
      //
      // });
      username = userData['username'];
      userpassword = userData['userpassword'];
      userweight = userData['userweight'].toString();
      userheight = userData['userheight'].toString();
      usertype = userData['usertype'];
      userage = userData['userage'].toString();
      useremail = userData['useremail'];
      if(userController.text == userData['username'] && passwordController.text == userData['userpassword']) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    }
    else if(user.isEmpty)
      {
        print('==== Error Get Data ----------------------------------------------');
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(userController, "User Name", Icons.person, false,
              TextInputType.emailAddress, false),
          UiHelper.CustomTextField(passwordController, "Password",
              Icons.password, true, TextInputType.text, true),
          SizedBox(height: 30),
          UiHelper.CustomButton(() {
            getUserData();
          }, "Login"),
          SizedBox(
            height: 20,
          ),
          widget.signcheck != true? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already Have an Account?",
                style: TextStyle(fontSize: 16),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                child: Text(
                   "Sign Up",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ):Text(''),
            ],
      ),
    );
  }
}
