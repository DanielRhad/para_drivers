import 'package:flutter/material.dart';
import 'package:para_drivers/globals/global.dart';
import 'package:para_drivers/infoHandler/app_info.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

class RatingsTabPage extends StatefulWidget
{
  const RatingsTabPage({Key? key}) : super(key: key);

  @override
  State<RatingsTabPage> createState() => _RatingsTabPageState();
}



class _RatingsTabPageState extends State<RatingsTabPage>
{
  double ratingsNumber = 0;


  @override
  void initState() {
    super.initState();

    getRatingsNumber();
  }

  getRatingsNumber()
  {
    setState(() {
      ratingsNumber = double.parse(Provider.of<AppInfo>(context, listen: false).driverAverageRatings);
    });

    setupRatingsTitle();
  }

  setupRatingsTitle()
  {
    if(ratingsNumber == 1)
    {
      setState(() {
        titleStarsRatings = "Very Bad";
      });
    }

    if(ratingsNumber == 2)
    {
      setState(() {
        titleStarsRatings = "Bad";
      });
    }

    if(ratingsNumber == 3)
    {
      setState(() {
        titleStarsRatings = "Good";
      });
    }

    if(ratingsNumber == 4)
    {
      setState(() {
        titleStarsRatings = "Very Good";
      });
    }

    if(ratingsNumber == 5)
    {
      setState(() {
        titleStarsRatings = "Excellent";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        backgroundColor: Colors.grey,
        child: Container(
          margin: const EdgeInsets.all(8),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const SizedBox(height: 22.0,),

              const Text(
                "Your Ratings",
                style: TextStyle(
                  fontSize: 22,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 22.0,),

              const Divider(height: 4.0, thickness: 4.0, color: Colors.grey),

              const SizedBox(height: 22.0,),

              SmoothStarRating(
                rating: ratingsNumber,
                allowHalfRating: false,
                starCount: 5,
                color: Colors.yellow,
                borderColor: Colors.yellow,
                size: 46,
              ),

              const SizedBox(height: 12.0,),

              Text(
                titleStarsRatings,
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),

              const SizedBox(height: 18.0,),
            ],
          ),
        ),
      ),
    );
  }
}
