import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String displayText = '';
  double firstNum = 0;
  double secondNum = 0;
  String result = '0';
  String operator = '';
  String finalResult = '0';

  // Function to handle button press
  void buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        // Reset all values when clear button is pressed
        displayText = '';
        firstNum = 0;
        secondNum = 0;
        result = '';
        operator = '';
        finalResult = '';
      } else if (value == '+' || value == '-' || value == '*' || value == '/') {
        // Store first number and operator
        firstNum = double.parse(result.isEmpty ? '0' : result);
        operator = value;
        result = '';
      } else if (value == '=') {
        // Perform calculation when equal sign is pressed
        secondNum = double.parse(result);
        if (operator == '+') {
          finalResult = (firstNum + secondNum).toString();
        } else if (operator == '-') {
          finalResult = (firstNum - secondNum).toString();
        } else if (operator == '*') {
          finalResult = (firstNum * secondNum).toString();
        } else if (operator == '/') {
          if (secondNum == 0) {
            finalResult = 'Error'; // Handle divide by zero
          } else {
            finalResult = (firstNum / secondNum).toString();
          }
        }
        result = finalResult;
      } else {
        // Handle number input: Remove leading 0
        if (result == '0') {
          result = value; // Replace the initial 0 with the new number
        } else {
          result += value; // Append new numbers
        }
      }

      displayText = result.isEmpty ? '' : result; // Show empty string instead of 0
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: Text(
              displayText,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton('7'),
                  calcButton('8'),
                  calcButton('9'),
                  calcButton('/'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton('4'),
                  calcButton('5'),
                  calcButton('6'),
                  calcButton('*'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton('1'),
                  calcButton('2'),
                  calcButton('3'),
                  calcButton('-'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton('C'),
                  calcButton('0'),
                  calcButton('='),
                  calcButton('+'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget for calculator buttons
  Widget calcButton(String value) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => buttonPressed(value),
          child: Text(
            value,
            style: TextStyle(fontSize: 28),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(22),
          ),
        ),
      ),
    );
  }
}
