import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ThemeData(
      /*  brightness: Brightness.light,

        primarySwatch: Colors.blue,
        primaryColor: Colors.white,

        dividerColor: Colors.white54,
        scaffoldBackgroundColor: Colors.white54,*/
        /* light theme settings */
      ),


      /* Dark theme settings */
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.black87,
        brightness: Brightness.dark,
        backgroundColor: Colors.green,
        dividerColor: Colors.purple,
        shadowColor: Colors.white38,
        scaffoldBackgroundColor: Colors.blueGrey,

        /* dark theme settings */
      ),
      /* ThemeMode.system to follow system theme,
         ThemeMode.light for light theme,
         ThemeMode.dark for dark theme
      */
      debugShowCheckedModeBanner: false,
      
      home: const MyHomePage(title: 'Calculator App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

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
  String result = "0", history = "";
  var isThemeBlack ;
  String dummyResult = "0", operand = "";
  double value1 = 0.0, value2 = 0.0;

  String iconText = "Dark";

  Widget buildNumberButton(String text) {
    return Expanded(
        flex: text == '0' ? 2 : 1,
        child: ElevatedButton(

            style: ElevatedButton.styleFrom(
              elevation: 10,
              alignment: text == '0' ? Alignment.centerLeft : Alignment.center,
              primary: isThemeBlack == Brightness.dark  ? Colors.black : Colors.white,
              shape: text == '0'
                  ? RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))
                  : const CircleBorder(),
              padding: text == '0'
                  ? const EdgeInsets.fromLTRB(40, 25, 30, 25)
                  : const EdgeInsets.all(25),
            ),
            onPressed: () => btnPressed(text),
            child: Text(text,
                style: TextStyle( 
                    fontSize: 26,

                    color: isThemeBlack == Brightness.dark  ? Colors.white : Colors.black))));
  }

  Widget buildFunctionButton(String text, bool isDmas) {
    return Expanded(
        child: MaterialButton(
            color: isThemeBlack == Brightness.dark  ? Colors.black26 : Colors.white,
            padding: const EdgeInsets.all(25),
            shape: const CircleBorder(),
            onPressed: () => btnPressed(text),
            child: Text(text,
                style: TextStyle(
                    fontSize: 26,
                    color: isDmas
                        ? Colors.orangeAccent
                        : isThemeBlack == Brightness.dark
                        ? Colors.white60
                            : Colors.black26))));
  }

  btnPressed(String text) {
    if (text == "AC") {
      dummyResult = "0";
      value1 = value2 = 0.0;
      operand = history = "";
    } else if (text == "%") {
      value1 = double.parse(result);
      dummyResult = (value1 / 100).toString();
      history = value1.toString() + "/100";
      value1 = value2 = 0.0;
      operand = "";
    } else if (text == "+/-") {
      value1 = double.parse(result);
      dummyResult = (value1 * (-1)).toString();
      history = value1.toString() + "*(-1)";
      value1 = value2 = 0.0;
      operand = "";
    } else if (text == "/" || text == "*" || text == "-" || text == "+") {
      value1 = double.parse(result);
      operand = text;
      dummyResult = "0";
    } else if (text == ".") {
      if (dummyResult.contains('.')) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Already contain a decimal"),
        ));
      } else {
        dummyResult = dummyResult + text;
      }
    } else if (text == "=") {
      value2 = double.parse(result);
      if (operand == "/") {
        dummyResult = (value1 / value2).toString();
        history = value1.toString() + operand + value2.toString();
      } else if (operand == "*") {
        dummyResult = (value1 * value2).toString();
        history = value1.toString() + operand + value2.toString();
      } else if (operand == "-") {
        dummyResult = (value1 - value2).toString();
        history = value1.toString() + operand + value2.toString();
      } else if (operand == "+") {
        dummyResult = (value1 + value2).toString();
        history = value1.toString() + operand + value2.toString();
      }

      value1 = value2 = 0.0;
      operand = "";
    } else {
      dummyResult = dummyResult + text;
    }
    if (kDebugMode) {
      print(dummyResult);
    }
    setState(() {
      result = double.parse(dummyResult).toString();
    });
  }

  changeTheme() {
    // iconText = isThemeBlack == Brightness.dark  ? "Dark" : "Light";
    // setState(() => isThemeBlack = !isThemeBlack);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    //isThemeBlack =MediaQuery.of(context).platformBrightness == Brightness.dark;
    isThemeBlack =Theme.of(context).brightness;

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
         // color: isThemeBlack == Brightness.dark ? Colors.black45 : Colors.white,
          color: Theme.of(context).primaryColor,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  result,
                  maxLines: 1,
                  style: TextStyle(
                      color: isThemeBlack == Brightness.dark  ? Colors.white : Colors.black,
                      fontSize: 60,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  history,
                  style: TextStyle(
                      color: isThemeBlack == Brightness.dark  ? Colors.white54 : Colors.black45,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                  child: VerticalDivider(
                color: isThemeBlack == Brightness.dark  ? Colors.black45 : Colors.white,
              )),
              Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(children: [
                        buildFunctionButton("AC", false),
                        buildFunctionButton("+/-", false),
                        buildFunctionButton("%", false),
                        buildFunctionButton("/", true)
                      ])),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(children: [
                        buildNumberButton("7"),
                        buildNumberButton("8"),
                        buildNumberButton("9"),
                        buildFunctionButton("*", true)
                      ])),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(children: [
                        buildNumberButton("4"),
                        buildNumberButton("5"),
                        buildNumberButton("6"),
                        buildFunctionButton("-", true)
                      ])),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(children: [
                        buildNumberButton("1"),
                        buildNumberButton("2"),
                        buildNumberButton("3"),
                        buildFunctionButton("+", true)
                      ])),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(children: [
                        buildNumberButton("0"),
                        buildNumberButton("."),
                        buildFunctionButton("=", true)
                      ]))
                ],
              )
            ],
          )),
      /*Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),*/
     /* floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: FloatingActionButton(
            onPressed: () => changeTheme(),
            tooltip: 'Increment',
            backgroundColor: isThemeBlack ? Colors.white : Colors.black,
            child: Text(iconText,
              style: TextStyle(
                  color: isThemeBlack ? Colors.black : Colors.white,
                 ),
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .startTop,*/
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
