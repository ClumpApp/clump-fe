import 'package:flutter/material.dart';
import '../constants.dart';
import 'signup_sub.dart';
import '../util/client.dart';

class Interest {
  final String uuid;
  final String title;
  final String picture;
  bool selected;

  Interest({
    required this.uuid,
    required this.title,
    required this.picture,
    this.selected = false,
  });

  factory Interest.fromJson(Map<String, dynamic> json) {
    return Interest(
        uuid: json['uuid'], title: json['title'], picture: json['picture']);
  }

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'title': title,
        'picture': picture,
      };
}

List<Interest> interestList = [];

Future<bool> getInterests() async {
  var interests = await Client.instance.getAll(endpoint: "/interests");
  for (var interestJSON in interests) {
    interestList.add(Interest.fromJson(interestJSON));
  }
  return true;
}

Future<bool> saveInterests() async {
  List<Map<String, dynamic>> selectedInterestList = [];
  for (var interest in interestList) {
    if (interest.selected) {
      selectedInterestList.add(interest.toJson());
    }
  }
  return Client.instance
      .postAll(data: selectedInterestList, endpoint: "/users/interests");
}

class SignUpMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
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
  @override
  void initState() {
    getInterests().then((value) => setState(() {
          interestList;
        }));
    super.initState();
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
                    GridView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        return prepareList(interestList[index], screenSize);
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4),
                      itemCount: interestList.length,
                    ),
                  ],
                ),
                MaterialButton(
                  onPressed: () {
                    saveInterests().then((value) => {
                          if (value)
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpSub()),
                              )
                            }
                          else
                            {
                              // There should not be such case
                            }
                        });
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
              ]),
            ))));
    //})));
  }

  Widget prepareList(Interest interest, Size screenSize) {
    var tag = interest.title;
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Hero(
        tag: "text$tag",
        child: Material(
          elevation: 0,
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(interest.picture),
                  fit: BoxFit.cover,
                ),
              ),
              width: screenSize.width / 4,
              height: screenSize.width / 4,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Checkbox(
                            value: interest.selected,
                            onChanged: (bool? value) {
                              setState(() {
                                interest.selected = value!;
                              });
                            },
                          )))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
