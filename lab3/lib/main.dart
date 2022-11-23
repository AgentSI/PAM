import 'package:flutter/material.dart';
import 'package:lab3/widget/button.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: MyHomePage(),
        debugShowCheckedModeBanner: false
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _equation = "";
  String _result = "";

  void click (String text) {
    setState(() => _result += text);
  }

  void allClear (String text) {
    setState(() {
      _equation = "";
      _result = "";
    });
  }

  void clear (String text) {
    setState(() => _result = "");
  }

  void evaluate (String text) {
    var expression = _result.replaceAll('÷', '/').replaceAll('×', '*');
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    String equal = exp.evaluate(EvaluationType.REAL, cm).toString();
    if (equal.endsWith('.0')) {
      equal = equal.substring(0, equal.length - 2);
    }
    setState(() {
      _equation = _result;
      _result = equal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Calculator", style: TextStyle(
            color: Color.fromRGBO(37, 44, 50, 1),
            fontWeight: FontWeight.w600,
            fontFamily: 'SF Pro Text',
            fontSize: 24)
        )
      ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(right: 12.0, left: 12.0),
              alignment: const Alignment(1 ,1),
              child: Text(_equation, style: const TextStyle(
                  fontSize: 32,
                  fontFamily: 'Inter',
                  color: Color.fromRGBO(150, 150, 150, 1))
              )
            ),
            Container(
              padding: const EdgeInsets.all(12.0),
              alignment: const Alignment(1 ,1),
              child: Text(_result, style: const TextStyle(
                  fontSize: 32,
                  fontFamily: 'Inter',
                  color: Color.fromRGBO(150, 150, 150, 1))
              )
            ),
            const SizedBox(height: 30),
            const Divider(
              height: 0,
              color: Color.fromRGBO(238, 240, 242, 1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Button(
                  text: "C",
                  callback: allClear
                ),
                ButtonBack(
                  callback: clear
                ),
                ButtonOp(
                    text: "÷",
                    img: Image.asset('assets/divide.png'),
                    callback: click
                )]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Button(
                  text: "7",
                  callback: click
                ),
                Button(
                  text: "8",
                  callback: click
                ),
                Button(
                  text: "9",
                  callback: click
                ),
                ButtonOp(
                    text: "×",
                    img: Image.asset('assets/x.png'),
                    callback: click
                )]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Button(
                  text: "4",
                  callback: click
                ),
                Button(
                  text: "5",
                  callback: click
                ),
                Button(
                  text: "6",
                  callback: click
                ),
                ButtonOp(
                    text: "-",
                    img: Image.asset('assets/minus.png'),
                    callback: click
                )]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Button(
                  text: "1",
                  callback: click
                ),
                Button(
                  text: "2",
                  callback: click
                ),
                Button(
                  text: "3",
                  callback: click
                ),
                ButtonOp(
                  text: "+",
                  img: Image.asset('assets/plus.png'),
                  callback: click
                )]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const SizedBox(
                  width: 85,
                  height: 65
                ),
                Button(
                  text: "0",
                  callback: click
                ),
                Button(
                  text: ".",
                  callback: click
                ),
                Button(
                  text: "=",
                  callback: evaluate
                )]
            )]
        )
    );
  }
}