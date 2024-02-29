import 'package:flutter/material.dart';
import 'package:para_drivers/globals/global.dart';
import 'package:para_drivers/mainScreens/main_screen.dart';
import 'package:para_drivers/splashScreen/splash_screen.dart';
import 'package:para_drivers/widgets/info_design_ui.dart';

class ProfileTabPage extends StatefulWidget
{
  const ProfileTabPage({Key? key}) : super(key: key);


  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}




class _ProfileTabPageState extends State<ProfileTabPage>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              borderRadius: const BorderRadius.all(Radius.circular(80)),
              elevation: 10,
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.20,
                backgroundColor: Colors.white60,
                child: Icon(
                    Icons.add_a_photo_outlined,
                    size: MediaQuery.of(context).size.width * 0.20,
                    color: Colors.black
                ),
              ),
            ),


            const SizedBox(height: 40,),
            Text(
              onlineDriverData.name!,
              style: const TextStyle(
                fontSize: 25.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15,),

            Text(
              titleStarsRatings + "  Driver",
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20,),
            const Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: Divider(
                color: Colors.grey,
                thickness: 2,
              ),
            ),

            const SizedBox(height: 38.0,),

            InfoDesignUIWidget(
              textInfo: onlineDriverData.email!,
              iconData: Icons.email,
            ),

            InfoDesignUIWidget(
              textInfo: onlineDriverData.vehicle_model!,
              iconData: Icons.electric_rickshaw_outlined,
            ),

            const SizedBox(height: 20,),

            ElevatedButton(
                onPressed: ()
                {
                  //MyApp.restartApp(context);
                  fAuth.signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(
                      color: Colors.white
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
