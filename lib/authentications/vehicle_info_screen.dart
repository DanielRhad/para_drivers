import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:para_drivers/authentications/login_screen.dart';
import 'package:para_drivers/globals/global.dart';


class VehicleInfoScreen extends StatefulWidget
{

  @override
  _VehicleInfoScreenState createState() => _VehicleInfoScreenState();
}



class _VehicleInfoScreenState extends State<VehicleInfoScreen>
{
  TextEditingController vehicleModelTextEditingController = TextEditingController();
  TextEditingController vehicleColorTextEditingController = TextEditingController();
  TextEditingController plateNumberTextEditingController = TextEditingController();


  saveVehicleInfo()
  {
    Map driverVehicleInfoMap =
    {
      "vehicle_model": vehicleModelTextEditingController.text.trim(),
      "vehicle_color": vehicleColorTextEditingController.text.trim(),
      "plate_number": plateNumberTextEditingController.text.trim(),
    };

    DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
    driversRef.child(currentFirebaseUser!.uid).child("vehicle_details").set(driverVehicleInfoMap);

    Fluttertoast.showToast(msg: "Vehicle Details has been saved, Congratulations.");
    Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
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
                "Write Car Details",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.lightGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20,),

              TextField(
                controller: vehicleModelTextEditingController,
                style: const TextStyle(
                    color: Colors.white
                ),
                decoration: const InputDecoration(
                  labelText: "Vehicle Model",
                  hintText: "Vehicle Model",
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

              const SizedBox(height: 15,),

              TextField(
                controller: vehicleColorTextEditingController,
                style: const TextStyle(
                    color: Colors.white
                ),
                decoration: const InputDecoration(
                  labelText: "Vehicle Color",
                  hintText: "Vehicle Color",
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

              const SizedBox(height: 15,),

              TextField(
                controller: plateNumberTextEditingController,
                style: const TextStyle(
                    color: Colors.white
                ),
                decoration: const InputDecoration(
                  labelText: "Plate Number",
                  hintText: "Plate Number",
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
                  if(vehicleModelTextEditingController.text.isNotEmpty
                      && vehicleColorTextEditingController.text.isNotEmpty
                      && plateNumberTextEditingController.text.isNotEmpty)
                  {
                    saveVehicleInfo();
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                  padding: EdgeInsets.symmetric(horizontal: 125, vertical: 15),
                ),
                child: const Text(
                  "Save Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
