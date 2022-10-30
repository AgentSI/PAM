import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 2',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(title: 'Lab 2'),
      debugShowCheckedModeBanner: false
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
  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  //  fun for count the number of words containing the letter "A" or "a"
  String count(String str) {
    int wordsCount = 0;
    List words = str.split(' ');
    for (var word in words) {
      if (word.contains('a') || word.contains('A')) {
        wordsCount += 1;
      }
    }
    return wordsCount.toString();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called for instance
    return Scaffold(
        backgroundColor: const Color.fromRGBO(250, 212, 188, 1),
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title)
        ),
        body: FooterView(
            footer: Footer(
                backgroundColor: const Color.fromRGBO(250, 212, 188, 1),
                child: const Text('© Develop by Ivanova Evghenia',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10, color: Color.fromRGBO(53, 36, 7, 1))
                )
            ),
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Text('Count the number of words containing the letter "A" or "a"',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Color.fromRGBO(53, 36, 7, 1))
                  )
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 15, left: 50, right: 50),
                  child: TextField(
                      controller: myController,
                      decoration: const InputDecoration(
                          hintText: 'Input text here',
                          hintStyle: TextStyle(color: Color.fromRGBO(53, 36, 7, 1))
                      ),
                      style: const TextStyle(fontSize: 20, color: Color.fromRGBO(53, 36, 7, 1))
                  )
              ),
              Image.asset('assets/img.png')
            ]
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      // Retrieve the text the that user has entered by using the TextEditingController.
                      content: Text(count(myController.text)),
                        contentTextStyle: const TextStyle(color: Color.fromRGBO(53, 36, 7, 1))
                    );
                  }
                  );
              },
            child: const Icon(Icons.search_sharp)
        )
    );
  }
}