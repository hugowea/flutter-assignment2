import 'package:flutter/material.dart';

import '../../main.dart';
import '../logic/jokes.dart';

class JokesPageStateful extends StatefulWidget {
  const JokesPageStateful({Key? key}) : super(key: key);

  @override
  State<JokesPageStateful> createState() => JokesPage();
}

class JokesPage extends State<JokesPageStateful> {
  late Future<Jokes> _futureJokes = fetchJokes();
  late Color _initColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chuck Norris jokes',
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home: Scaffold(
            body: FutureBuilder<Jokes>(
          future: _futureJokes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: SafeArea(
                        left: true,
                        right: true,
                        minimum: const EdgeInsets.all(16.0),
                        child: Text(
                          snapshot.data!.value,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: _initColor,
                              ),
                              onPressed: () async {
                                saved.add(await _futureJokes);
                                setState(() {
                                  _initColor = Colors.brown;
                                });
                              })),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _futureJokes = fetchJokes();
                              _initColor = Colors.grey;
                            });
                          },
                          child: const Text('Next'),
                        ),
                      )
                    ]),
                  ]);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        )));
  }
}
