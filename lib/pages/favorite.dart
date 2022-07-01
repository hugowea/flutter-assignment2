import 'package:flutter/material.dart';
import 'package:hhh/logic/jokes.dart';

import '../main.dart';

class FavoriteStateful extends StatefulWidget {
  const FavoriteStateful({Key? key}) : super(key: key);

  @override
  State<FavoriteStateful> createState() => Favorite();
}

class Favorite extends State<FavoriteStateful> {
  List filteredList = [];
  @override
  void initState() {
    super.initState();
    filteredList = saved;
  }

  void filter(String inputString) {
    filteredList = saved
        .where((i) => i.value.toLowerCase().contains(inputString))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.all(20),
          child: TextField(
              decoration: InputDecoration(
                hintText: 'Search ',
                hintStyle: TextStyle(
                  fontSize: 14,
                ),
              ),
              onChanged: (text) {
                text = text.toLowerCase();
                filter(text);
              })),
      Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: filteredList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    child: Row(children: <Widget>[
                  Expanded(
                      child: Card(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 15, bottom: 15, right: 15),
                        child: Text(
                          filteredList[index].value,
                          textAlign: TextAlign.start,
                        )),
                  )),
                  TextButton(
                      onPressed: () {
                        saved.remove(saved[index]);
                      },
                      child: Text("Delete"))
                ]));
              }))
    ]);
  }
}
