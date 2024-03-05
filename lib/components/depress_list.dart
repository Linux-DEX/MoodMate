// ? to store the data when ever the page is changed we can use shared_preference package. or directly we can save the data in firebase 
import 'package:flutter/material.dart';

class Depress extends StatefulWidget {
  const Depress({super.key});

  @override
  State<Depress> createState() => _DepressState();
}

class _DepressState extends State<Depress> {
  List<bool> isChecked = [false, false, false, false, false];
  List<String> depress = [
    "Get some sunlight", 
    "Do a small chore", 
    "Listen to music", 
    "Watch a movie",
    "Take a walk outside"
  ];
  List<String> workout = [
    "exp1",
    "exp2",
    "exp3",
    "exp4",
    "exp5",
  ];
  List<String> image = [
    "assets/images/sunlight.png",
    "assets/images/cleaning.png", 
    "assets/images/listenmusic.png", 
    "assets/images/movie.png",
    "assets/images/walkoutside.png"
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 50.0,
                        height: 50.0,
                        color: Colors.transparent,
                        child: Image.asset(image[index]),
                      ),
                      SizedBox(width: 5.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            depress[index],
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(workout[index]),
                        ],
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Checkbox(
                        value: isChecked[index],
                        onChanged: (newValue) {
                          setState(() => isChecked[index] = !isChecked[index]);
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
