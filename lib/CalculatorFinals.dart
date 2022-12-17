import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorFinals extends StatefulWidget {

  @override
  State<CalculatorFinals> createState() => _CalculatorFinalsState();
}

class _CalculatorFinalsState extends State<CalculatorFinals> {
  String userInput = "";
  String result = "0";

  List<String> buttonList = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '=',
];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFbdbdbd),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.centerRight,
                  child: Text(userInput,
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  alignment: Alignment.centerRight,
                  child: Text(result,
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: GridView.builder(
                itemCount: buttonList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (BuildContext context, int index){
                    return CustomButton(buttonList[index]);
                  },
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget CustomButton(String text) {
    return  InkWell(
      splashColor: Colors.blueAccent,
      onTap: (){
        setState(() {
          handleButtons(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: getBgColor(text),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              spreadRadius: 0,
              offset: Offset(-3, -3),
            ),
          ]
      ),
        child: Center(
          child: Text(text,
            style: TextStyle(
              color: getColor(text),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
  getColor(String text) {
    if(text == "/" || text == "*" || text == "+" || text == "-" || text == "C" || text == "(" || text == ")") {
      return Color.fromARGB(255, 255, 99, 71);
    }
    return Colors.white;
  }

  getBgColor(String text) {
    if(text == "AC") {
      return Color.fromARGB(100, 255, 0, 0);
    }
    if(text == "=") {
      return Color.fromARGB(255, 46,139,87);
    }
    return Color(0xFF152238);
  }

  handleButtons(String text) {
     if(text == "AC") {
       userInput = "";
       result = "0";
       return;
     }
     if(text == "C"){
       if(userInput.isNotEmpty) {
         userInput = userInput.substring(0, userInput.length - 1);
         return;
       }else {
         return null;
       }
     }

     if(text == "=") {
       result = calculate();
       userInput = result;
       if( userInput.endsWith(".0")) {
         userInput = userInput.replaceAll(".0", "");
       }
       if(result.endsWith(".0")) {
         result = result .replaceAll(".0", "");
         return;
       }
     }

     userInput = userInput + text;
  }

  String calculate() {
    try{
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    }catch(e) {
      return "Syntax Error";
    }
  }
}
