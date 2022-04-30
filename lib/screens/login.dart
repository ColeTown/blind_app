import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blind_app/main.dart';
import 'package:blind_app/database/database.dart';
import 'navBar.dart';
import '../python/pythonapi.dart';

var py = Python();

getResponse(String userId) async{

   await py.getResponse(userId);

}

class LoginPage extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  String authErrorText = '';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 60.0),
              // child: Center(
              //   child: Container(
              //       width: 200,
              //       height: 150,
              //       /*decoration: BoxDecoration(
              //           color: Colors.red,
              //           borderRadius: BorderRadius.circular(50.0)),*/
              //       child: Image.asset('asset/images/flutter-logo.png')),
              // ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                  authErrorText,
                  style: const TextStyle(color: Colors.red))
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: pwController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            FlatButton(
              onPressed: (){
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () async {
                  getResponse(localUserId);
                  if(await db.authUser(emailController.text, pwController.text)){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => NavBar()));
                  }
                  else{
                    setState(() {
                      authErrorText = 'Unrecognized email or password.';
                    });
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            const Text('New User? Create Account')
          ],
        ),
      ),
    );
  }
}