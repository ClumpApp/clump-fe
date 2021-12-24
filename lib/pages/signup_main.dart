import 'package:flutter/material.dart';
import '../constants.dart';
import 'signup_sub.dart';

final List<String> interests = [
  "sports",
  "tv",
  "movies",
  "books",
  "music",
  "science",
  "art",
  "comic",
  "anime"
];
//final List<bool> interestChecks = List.generate(interests.length, (_) => false);

class SignUpMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignUpMain_(),
    );
  }
}

class SignUpMain_ extends StatefulWidget {
  const SignUpMain_({Key? key}) : super(key: key);
  @override
  _SignUpMain createState() => _SignUpMain();
}

class _SignUpMain extends State<SignUpMain_> {
  List<Interest> ints = new List.empty(growable: true);
  bool selectAll = false;
  @override
  void initState() {
    super.initState();
    for (String interest in interests) {
      ints.add(Interest(interest, false));
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
//    return MediaQuery(
//        data: MediaQueryData(),
//        child: MaterialApp(home: Builder(builder: (BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: screenSize.height / 4),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage("assets/images/backgrounds/Clump BG_interests1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
            backgroundColor: blackpurple,
            body: SingleChildScrollView(
                child: Container(
              //padding: EdgeInsets.only(top: screenSize.height / 10),
              width: double.infinity,
              child: Wrap(children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //Checkbox(
                    //    value: selectAll,
                    //    onChanged: (bool? value) {
                    //      setState(() {
                    //        selectAll = value!;
                    //        ints.forEach((element) {
                    //          element.selected = value;
                    //        });
                    //      });
                    //    }),
                    GridView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        return prepareList(index, screenSize);
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemCount: ints.length,
                    ),
                  ],
                ),
                Container(
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpSub()),
                      );
                    },
                    elevation: 0,
                    color: Colors.transparent,
                    height: screenSize.height / 5,
                    child: const Center(
                      child: Text(
                        'Cool!',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ))));
    //})));
  }

  Widget prepareList(int k, Size screenSize) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Hero(
        tag: "text$k",
        child: Material(
          elevation: 0,
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/images/icons/" + interests[k] + ".png"),
                  fit: BoxFit.cover,
                ),
              ),
              width: screenSize.width / 4,
              height: screenSize.width / 4,
              child: Stack(
                children: [
                  Positioned(
                      child: Checkbox(
                    value: ints[k].selected,
                    onChanged: (bool? value) {
                      setState(() {
                        if (!value!) selectAll = false;
                        ints[k].selected = value;
                      });
                    },
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Interest {
  String name;
  bool selected;
  Interest(this.name, this.selected);
}
