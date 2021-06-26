import 'dart:math';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Map<String, bool> score = {};
  final Map<String, Color> choises = {
    "🍎": Colors.red,
    "🍏": Colors.yellow,
    "🍋": Colors.orange,
    "🍀": Colors.green,
    "📘": Colors.blue,
    "🟤": Colors.brown,
    "🍆": Colors.purple,
  };
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("your score"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: choises.keys.map((element) {
                return Expanded(
                    child: Draggable<String>(
                        child: Movable(score[element] == true ? "✔️" : element),
                        data: element,
                        childWhenDragging: Movable("🦁"),
                        feedback: Text(
                          element,
                          style: TextStyle(fontSize: 60),
                        )));
              }).toList()),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: choises.keys.map((element) {
              return buildTarget(element);
            }).toList()
              ..shuffle(Random(index)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            score.clear();
            index++;
          });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget buildTarget(element) {
    return DragTarget<String>(
      builder: (context, incoming, regected) {
        if (score[element] == true) {
          return Container(
            color: Colors.white,
            child: Text("congratulations"),
            alignment: Alignment.center,
            height: 80,
            width: 200,
          );
        } else {
          return Container(
            color: choises[element],
            height: 80,
            width: 200,
          );
        }
      },
      onWillAccept: (data) => data == element,
      onAccept: (data) {
        setState(() {
          score[element] = true;
        });
      },
      onLeave: (data) {},
    );
  }
}

class Movable extends StatelessWidget {
  String emoji;
  Movable(this.emoji);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        child: Text(emoji, style: TextStyle(fontSize: 60, color: Colors.black)),
        alignment: Alignment.center,
        height: 50,
        padding: EdgeInsets.all(15),
      ),
    );
  }
}
