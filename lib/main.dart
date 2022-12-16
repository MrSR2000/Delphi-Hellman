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
  int? _privateKey1;
  int? _publicKey1;
  int? _primitiveRoot;
  int? _privateKey2;
  int? _publicKey2;
  int? _secretKey1;
  int? _secretKey2;

  @immutable
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

    Random random = Random();
    int randomPrimitiveRoot = random.nextInt(primitives.length);
    final List<int> primitiveRootList = primitives.toList();
    // print(primitiveRootList);

    setState(() {
      _primitiveRoot = primitiveRootList[randomPrimitiveRoot];
    });

    print(_primitiveRoot);
  }

  getPrivateKey(int user) {
    Random random = Random();
    setState(() {
      if (user == 1) {
        _privateKey1 = random.nextInt(_primeNo!);
      } else if (user == 2) {
        _privateKey2 = random.nextInt(_primeNo!);
      }
    });
    print('the Private Key is $_privateKey1');
    print('the Private Key is $_privateKey2');
  }

  getPublicKey(int user) {
    setState(() {
      if (user == 1) {
        _publicKey1 = (pow(_primitiveRoot!, _privateKey1!)).toInt() % _primeNo!;
      } else if (user == 2) {
        _publicKey2 = (pow(_primitiveRoot!, _privateKey2!)).toInt() % _primeNo!;
      }
    });
    print('the Public Key is $_publicKey1');
    print('the Public Key is $_publicKey2');
  }

  getSecretKey(int user) {
    setState(() {
      if (user == 1) {
        _secretKey1 = (pow(_publicKey2!, _privateKey1!)).toInt() % _primeNo!;
      } else if (user == 2) {
        _secretKey2 = (pow(_publicKey1!, _privateKey2!)).toInt() % _primeNo!;
      }
    });
    print('Secret key of user1 = $_secretKey1');
    print('Secret key of user2 = $_secretKey2');
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
              getPrivateKey(1);
            },
            child: Text('get PrivateKey user 1'),
          ),
          ElevatedButton(
            onPressed: () {
              getPublicKey(1);
            },
            child: Text('get PublicKey user 1'),
          ),
          ElevatedButton(
            onPressed: () {
              getPrivateKey(2);
            },
            child: Text('get PrivateKey user 2'),
          ),
          ElevatedButton(
            onPressed: () {
              getPublicKey(2);
            },
            child: Text('get PublicKey user 2'),
          ),
          ElevatedButton(
            onPressed: () {
              getSecretKey(1);
            },
            child: Text('Get Secret key of user1'),
          ),
          ElevatedButton(
            onPressed: () {
              getSecretKey(2);
            },
            child: Text('Get Secret key of user2'),
          ),
        ],
      ),
    );
  }
}
