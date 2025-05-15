import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'history.dart';
import 'profile.dart';

void main() => runApp(const CupertinoTabBarApp());

class CupertinoTabBarApp extends StatelessWidget {
  const CupertinoTabBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: CupertinoTabBarExample(),
    );
  }
}

class CupertinoTabBarExample extends StatefulWidget {
  const CupertinoTabBarExample({super.key});

  @override
  _CupertinoTabBarExampleState createState() => _CupertinoTabBarExampleState();
}

class _CupertinoTabBarExampleState extends State<CupertinoTabBarExample> {
  List<String> history = [];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.blueGrey,
        activeColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.calendar),
            label: 'Calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.time),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Profile',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            switch (index) {
              case 0:
                return CalculatorScreen(
                  onCalculate: (expression, result) {
                    setState(() {
                      history.add("$expression = $result");
                    });
                  },
                );
              case 1:
                return HistoryScreen(history: history);
              case 2:
                return ProfileScreen();
              default:
                return Center(child: Text('Unknown Tab'));
            }
          },
        );
      },
    );
  }
}

// ======================== MODIFIED CALCULATOR ========================
class CalculatorScreen extends StatefulWidget {
  final Function(String, String) onCalculate;
  const CalculatorScreen({required this.onCalculate, Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String expression = "";
  String result = "0";

  void onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        expression = "";
        result = "0";
      } else if (value == "=") {
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = "${exp.evaluate(EvaluationType.REAL, cm)}";
          widget.onCalculate(expression, result);
        } catch (e) {
          result = "Error";
        }
      } else {
        expression += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text("Modern Calculator")),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(expression.isEmpty ? "0" : expression, style: TextStyle(fontSize: 28, color: Colors.blueGrey)),
              SizedBox(height: 20),
              Text(result, style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
              SizedBox(height: 20),
              buildButtonGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtonGrid() {
    final buttons = ["7", "8", "9", "/", "4", "5", "6", "*", "1", "2", "3", "-", "C", "0", "=", "+"];
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.3,
      ),
      itemCount: buttons.length,
      itemBuilder: (context, index) {
        return buildButton(buttons[index]);
      },
    );
  }

  Widget buildButton(String value) {
    bool isOperator = "+-*/=".contains(value);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CupertinoButton(
        color: isOperator ? Color.fromARGB(255, 60, 197, 32) : Colors.blueGrey[200],
        onPressed: () => onButtonPressed(value),
        child: Text(value, style: TextStyle(fontSize: 26, color: Colors.white)),
        padding: EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
