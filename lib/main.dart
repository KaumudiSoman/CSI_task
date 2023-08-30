import 'package:csi_app/todolistpage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox("workbox");
  await Hive.openBox("personalbox");
  await Hive.openBox("shoppingbox");
  await Hive.openBox("healthbox");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(244, 236, 235, 235),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "FocusList",
                style: TextStyle(
                  color: Color.fromARGB(222, 208, 130, 27),
                  fontWeight: FontWeight.w800,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Image.asset("assets/images/todo.png"),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Welcome to FocusList",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "FocusList will help you stay to organized and perform your tasks much faster",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 50,
              ),
              MaterialButton(
                color: const Color.fromARGB(222, 208, 130, 27),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ToDoListPage()));
                },
                child: const Text("Get Started"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
