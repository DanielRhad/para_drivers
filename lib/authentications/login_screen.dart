import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:para_drivers/authentications/signup_screen.dart';
import 'package:para_drivers/globals/global.dart';
import 'package:para_drivers/main.dart';
import 'package:para_drivers/splashScreen/splash_screen.dart';
import 'package:para_drivers/widgets/block_dialog.dart';
import 'package:para_drivers/widgets/error_dialog.dart';
import 'package:para_drivers/widgets/login_dialog.dart';
import 'package:para_drivers/widgets/progress_dialog.dart';



class LoginScreen extends StatefulWidget
{

  @override
  _LoginScreenState createState() => _LoginScreenState();
}




class _LoginScreenState extends State<LoginScreen>
{
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();


  validateForm()
  {
    if(!emailTextEditingController.text.contains("@"))
    {
      Fluttertoast.showToast(msg: "Email address is not Valid.");
    }
    else if(passwordTextEditingController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Password is required.");
    }
    else
    {
      loginDriverNow();
    }
  }

  loginDriverNow() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message: "Processing, Please wait...",);
        }
    );

    final User? firebaseUser = (
        await fAuth.signInWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error Occurred, Please input correct email and password.");
        })
    ).user;


    if(firebaseUser != null)
    {
      readDataAndSetDataLocally(firebaseUser);
      readDataAndSetDataUsingDatabase(firebaseUser);
    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occurred during Login.");
    }
  }

  Future readDataAndSetDataUsingDatabase(User firebaseUser) async
  {
    FirebaseDatabase.instance.ref()
        .child("drivers")
        .child(firebaseUser.uid)
        .get();

    Navigator.pop(context);
  }



  Future readDataAndSetDataLocally(User firebaseUser) async
  {
    await FirebaseFirestore.instance.collection("drivers")
        .doc(firebaseUser.uid)
        .get()
        .then((snapshot) async {
      if(snapshot.exists)
      {
        if(snapshot.data()!["status"] == "approved")
        {


          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));

        }
        else if(snapshot.data()!["status"] == "unverified")
        {
          fAuth.signOut();
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (c)
              {
                return LoginDialog(
                    message: "Admin has not yet verified your account, You must provide a copy of needed requirements to be a member of Para Drivers." + "\n" +
                    "" + "\n" +
                    "Below are the following requirements:" + "\n" +
                    "" + "\n" +
                    "* Barangay Clearance" + "\n" +
                    "* Driver's License" + "\n" +
                    "* NBI Clearance"
                );
              }
          );
          // Fluttertoast.showToast(msg: "Admin has not yet verified your account.");
        }
        else
        {
          fAuth.signOut();
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (c)
              {
                return BlockDialog(
                    message: "Admin has Blocked your account,due to your recent violation. Please report to us as soon as possible for your account to be eligible to use again." + "\n" +
                        "" + "\n" +
                        "Thank you for your cooperation"
                );
              }
          );
          //Fluttertoast.showToast(msg: "Admin has Blocked your account,due to your recent violation.");
        }
      }
      else
      {
        Fluttertoast.showToast(msg: "No record exists with this email.");
        fAuth.signOut();
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [

              const SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                    "images/1.gif",
                    width: 200,
                    height: 200,
                ),
              ),

              const SizedBox(height: 10,),

              const Text(
                "Login as a Driver",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.lightGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20,),

              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                    color: Colors.white
                ),
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Email",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(height: 20,),

              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(
                    color: Colors.white
                ),
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "Password",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(height: 50,),

              ElevatedButton(
                onPressed: ()
                {
                  validateForm();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                  padding: EdgeInsets.symmetric(horizontal: 140, vertical: 15),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),

              const SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Do not have an account?",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  const SizedBox(width: 4,),
                  TextButton(
                    child: const Text(
                      "Register Now.",
                      style: TextStyle(
                          color: Colors.lightGreen,
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> SignUpScreen()));
                    },
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
