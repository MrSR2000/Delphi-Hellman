import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int? _primeNo;

  @override
  int getRandomInt() {
    var now = new DateTime.now();
    Random rnd1 = new Random();
    Random rnd2 = new Random(now.millisecondsSinceEpoch);
    int min = 10, max = 100;
    return (min + rnd1.nextInt(max - min));
  }

  bool isPrime(num) {
    if (num <= 1) return false;
    if (num <= 3) return true;
    for (var i = 2; i < num; i++) {
      if (num % i == 0) {
        return false;
      }
    }
    return true;
  }

  getRandomPrimeNumber() {
    Random random = new Random();
    var x = random.nextInt(100);
    while (!isPrime(x)) {
      x = getRandomInt();
    }
    setState(() {
      _primeNo = x;
    });
  }

  @override
  void initState() {
    getRandomPrimeNumber();
    super.initState();
  }

  getprimitveSet() {
    Set<int> primitives = Set();

    int n = _primeNo!;

    for (int i = 1; i < n; i++) {
      Set<int> cal = Set();

      for (int j = 1; j < n; j++) {
        int nn = ((pow(i, j)) % n).toInt();
        // print(i);
        // print(nn);
        cal.add(nn);
      }
      if (cal.length == n - 1) {
        primitives.add(i);
      }
      // print('calculated values are $cal');
      // print(cal.length);

    }
    print('the primitive set is $primitives');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delphi Hellman'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: getprimitveSet,
            child: Text('get primitive set'),
          ),
          ElevatedButton(
            onPressed: () {
              print('the random prime no is $_primeNo');
            },
            child: Text('get primitive set'),
          )
        ],
      ),
    );
  }
}
