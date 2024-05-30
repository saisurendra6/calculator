import 'dart:developer';

import 'package:calculator/calc_btn.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

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
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var input = '';
  var result = '';
  int openCnt = 0;

  void calRes(bool isFinal) {
    try {
      Parser parser = Parser();
      Expression exp = parser.parse(input);
      setState(() {
        result = exp.evaluate(EvaluationType.REAL, ContextModel()).toString();
        if (isFinal) {
          input = result;
          result = '';
        }
      });
    } catch (e) {
      log("err: $e");
      if (isFinal) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Invalid Expression")));
      }
    }
  }

  bool isOperand(String val) {
    return (val == '+' || val == '-' || val == '*' || val == '/' || val == '%');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      input,
                      style: const TextStyle(
                        fontSize: 42,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      result,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black54,
                      ),
                    ),
                    const Divider(),
                  ],
                )),
            Expanded(
              flex: 2,
              child: GridView.builder(
                itemCount: calcBtnEleList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  // C
                  if (index == 0) {
                    return Button(
                        color: Colors.lightGreen,
                        val: 'AC',
                        callback: () {
                          setState(() {
                            input = '';
                            result = '';
                          });
                        });
                  }
                  // ( )
                  if (index == 1) {
                    return Button(
                      color: Colors.blueGrey.shade400,
                      val: 'C',
                      callback: () {
                        setState(() {
                          input = input.substring(0, input.length - 1);
                        });
                      },
                    );
                  }
                  if (index == calcBtnEleList.length - 2) {
                    return Button(
                      val: calcBtnEleList[index],
                      callback: () {},
                      color: Colors.transparent,
                    );
                  }
                  // equals
                  if (index == calcBtnEleList.length - 1) {
                    return Button(
                      val: calcBtnEleList[index],
                      callback: () {
                        calRes(true);
                      },
                      color: Colors.amber,
                    );
                  }
                  return Button(
                    color: Colors.grey.shade300,
                    val: calcBtnEleList[index],
                    callback: () {
                      input += calcBtnEleList[index];
                      (isOperand(calcBtnEleList[index]))
                          ? setState(() {})
                          : calRes(false);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
