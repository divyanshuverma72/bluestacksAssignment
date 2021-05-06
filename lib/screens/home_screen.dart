import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<JsonData> futureData;
  Future<UserDetails> futureUserDetailsData;
  String globalCursor = "";

  @override
  void initState() {
    super.initState();
    futureData = fetchData(globalCursor);
    futureUserDetailsData = fetchUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () => null,
        ),
        title: Text('Flyingwolf',
            style: TextStyle(color: Colors.black, fontSize: 16)),
        elevation: 0,
        backgroundColor: Colors.blueGrey[50],
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder<UserDetails>(
              future: futureUserDetailsData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  UserDetails data = snapshot.data;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.network(data.profile_url),
                        ),
                        radius: 40.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(data.name,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                            Container(
                                height: 45,
                                width: 180,
                                margin: EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(data.points,
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 20)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Elo rating',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13)),
                                    ),
                                  ],
                                ),
                                //color: Colors.blueAccent, if you use boxdecoration we use colr inside that boxDecoration, otherwise it results in error
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(30.0),
                                ))
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default show a loading spinner.
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Container(
              height: 90,
              width: double.infinity,
              margin: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.yellow[800],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('34',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          ),
                          Text('Tournaments',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                          Text('played',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('09',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          ),
                          Text('Tournaments',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                          Text('won',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.red[700],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('26%',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          ),
                          Text('Winning',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                          Text('percentage',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              //color: Colors.blueAccent, if you use boxdecoration we use colr inside that boxDecoration, otherwise it results in error
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(30.0),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text('Recommended for you',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black, fontSize: 20)),
          ),
          Expanded(
            child: FutureBuilder<JsonData>(
              future: futureData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  JsonData data = snapshot.data;

                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        globalCursor = data.cursor;

                        return Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                            height: 150,
                            color: Colors.blueGrey[50],
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: Container(
                                    height: 85,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(data.results
                                            .elementAt(index)
                                            .coverUrl),
                                      ),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.0),
                                        topRight: Radius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 20.0),
                                    child: Container(
                                      height: 35.0,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            data.results.elementAt(index).name,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15)),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 20.0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 35.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(30.0),
                                            bottomRight: Radius.circular(30.0)),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                            data.results
                                                .elementAt(index)
                                                .gameName,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default show a loading spinner.
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future<JsonData> fetchData(String cursor) async {
  final response = await http.get(
      'http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=100&status=all');
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    JsonData rest = JsonData.fromJson(data);
    return rest;
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class JsonData {
  final List<Result> results;
  String cursor = "";

  JsonData({this.results, this.cursor});

  factory JsonData.fromJson(Map<String, dynamic> data) {
    var list = data['data']['tournaments'] as List;
    List<Result> resultList = list.map((e) => Result.fromJson(e)).toList();

    return JsonData(results: resultList, cursor: data['data']['cursor']);
  }
}

class Result {
  final String gameName;
  final String name;
  final String coverUrl;

  Result({this.gameName, this.name, this.coverUrl});

  factory Result.fromJson(Map<String, dynamic> result) {
    return Result(
        gameName: result['game_name'],
        name: result['name'],
        coverUrl: result['cover_url']);
  }
}

Future<UserDetails> fetchUserDetails() async {
  final response = await http
      .get('https://mocki.io/v1/81cb8f31-a7e5-4ae9-bb4b-eab129bbf03d');
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    UserDetails userDetails = UserDetails.fromJson(data);
    return userDetails;
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class UserDetails {
  final String name;
  final String points;
  final String profile_url;

  UserDetails({this.name, this.points, this.profile_url});

  factory UserDetails.fromJson(Map<String, dynamic> result) {
    return UserDetails(
        name: result['name'],
        points: result['points'],
        profile_url: result['image_url']);
  }
}
