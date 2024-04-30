import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SadList extends StatefulWidget {
  // const SadList({super.key});
  final String uid;
  const SadList({Key? key, required this.uid}) : super(key: key);

  @override
  State<SadList> createState() => _SadListState();
}

class _SadListState extends State<SadList> {
  List<dynamic> isChecked = [false, false, false, false, false];
  List<String> sad = [
    "Cry it out",
    "Comforting food",
    "Watch funny clip",
    "Write in a journal",
    "Take a warm bath"
  ];
  List<String> workout = [
    "exp1",
    "exp2",
    "exp3",
    "exp4",
    "exp5",
  ];
  List<String> image = [
    "assets/images/cry.png",
    "assets/images/food.png",
    "assets/images/funnyclip.png",
    "assets/images/journal.png",
    "assets/images/bath.png"
  ];

  int limitValue = 0;
  var userData = {};
  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      userData = userSnap.data()!;
      setState(() {
        isChecked = userData['todaytask'];
        print(userData['todaytask']);
        print("ischeck value: $isChecked");
      });
    } catch (e) {
      print("Error : ${e}");
    }
  }

  setUserTasks(List<dynamic> tasks) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'todaytask': tasks});

      print("updated successfully");
    } catch (e) {
      print(e.toString());
    }
  }

  setUserMoodValue() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    int? tempVal;

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE').format(now).toLowerCase();
    print(formattedDate);

    try {
      var temp = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      limitValue = temp.get('moodValue.${formattedDate}.sad');
      if (temp.exists) {
        tempVal = temp.get('moodValue.${formattedDate}.sad');
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'moodValue.${formattedDate}.sad': (tempVal! + 1)});
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'dayMood.${formattedDate}': "sad"});
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
                            sad[index],
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
                          // setState(() => isChecked[index] = !isChecked[index]);
                          setState(() => {
                                isChecked[index] = !isChecked[index],
                                setUserTasks(isChecked),
                                print(userData['todaytask']),
                                if (isChecked[index] == true && limitValue < 4)
                                  {
                                    setUserMoodValue(),
                                  }
                              });
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
