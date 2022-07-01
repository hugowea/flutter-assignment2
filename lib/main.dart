import 'dart:async';
import 'dart:convert';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'logic/jokes.dart';
import 'pages/jokes_page.dart';
import 'pages/favorite.dart';

Future<Jokes> fetchJokes() async {
  final response = await http.get(
    Uri.parse('https://api.chucknorris.io/jokes/random'),
  );

  if (response.statusCode == 200) {
    return Jokes.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load joke');
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'CHUCKNORRIS.IO',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List<Jokes> saved = [];

class _MyHomePageState extends State<MyHomePage> {
  late Future<Jokes> _futureJokes;
  late List<Widget> _pages;
  late Widget _jokespage;
  late Widget _favorite;
  late int _selectedIndex;
  late Widget _currentPage;

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _currentPage = _pages[_selectedIndex];
    });
  }

  @override
  void initState() {
    super.initState();
    _jokespage = const JokesPageStateful();
    _favorite = const FavoriteStateful();
    _pages = [_jokespage, _favorite];
    _currentPage = _jokespage;
    _selectedIndex = 0;
    _futureJokes = fetchJokes();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CHUCKNORRIS.IO',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Align(
            alignment: Alignment.center,
            child: Text('CHUCKNORRIS.IO'),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            )
          ],
          centerTitle: true,
        ),
        body: _currentPage,
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.brown,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
