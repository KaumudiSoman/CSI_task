import 'dart:convert';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:csi_app/healthtodo.dart';
import 'package:csi_app/personaltodo.dart';
import 'package:csi_app/shoppingtodo.dart';
import 'package:csi_app/worktodo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({Key? key}) : super(key: key);

  @override
  State<ToDoListPage> createState() => ToDoList();
}

class ToDoList extends State<ToDoListPage> {
  String randomQuote = "";
  String quoteAuthor = "";
  final quoteURL = "https://api.quotable.io/quotes/random";

  @override
  void initState() {
    super.initState();
    generateQuote();
  }

  generateQuote() async {
    var response = await http.get(Uri.parse(quoteURL));
    var result = jsonDecode(response.body);
    print(result);
    setState(() {
      randomQuote = result[0]["content"].toString();
      quoteAuthor = result[0]["author"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(222, 208, 130, 27),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.menu,
              color: Colors.black,
              size: 30,
            ),
            SizedBox(
              height: 30,
              width: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset("assets/images/dp.jpeg"),
              ),
            )
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(244, 236, 235, 235),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              randomQuote,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "- $quoteAuthor",
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 70,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(222, 208, 130, 27),
              ),
              height: 120,
              width: 350,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Manage yout time well    ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Image.asset(
                    "assets/images/book.png",
                    height: 80,
                    width: 80,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Categories",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Ink(
                  decoration: const ShapeDecoration(
                    color: Color.fromARGB(222, 208, 130, 27),
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.work_outline),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => WorkToDo()));
                    },
                  ),
                ),
                Ink(
                  decoration: const ShapeDecoration(
                    color: Color.fromARGB(222, 208, 130, 27),
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.person_2_outlined),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const PersonalToDo()));
                    },
                  ),
                ),
                Ink(
                  decoration: const ShapeDecoration(
                    color: Color.fromARGB(222, 208, 130, 27),
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.shopping_bag_outlined),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ShoppingToDo()));
                    },
                  ),
                ),
                Ink(
                  decoration: const ShapeDecoration(
                    color: Color.fromARGB(222, 208, 130, 27),
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.monitor_heart_outlined),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HealthToDo()));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Work",
                  ),
                  Text("Personal"),
                  Text("Shopping"),
                  Text("Health"),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        height: 70,
        backgroundColor: const Color.fromARGB(222, 208, 130, 27),
        activeColor: const Color.fromARGB(244, 236, 235, 235),
        items: const [
          TabItem(icon: Icon(Icons.home_outlined)),
          TabItem(icon: Icon(Icons.calendar_month_outlined)),
          TabItem(icon: Icon(Icons.post_add_outlined)),
          TabItem(icon: Icon(Icons.settings_outlined)),
        ],
        initialActiveIndex: 0,
      ),
    );
  }
}
