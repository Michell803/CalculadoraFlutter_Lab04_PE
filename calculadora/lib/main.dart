import 'package:flutter/material.dart';

void main() => runApp(CalculadoraApp());

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Flutter',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _output = '';
  String _buffer = '';
  double _num1 = 0.0;
  String _operation = '';
  bool _isOperationShown = false;

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _output = '';
        _buffer = '';
        _num1 = 0.0;
        _operation = '';
        _isOperationShown = false;
      } else if (buttonText == '+' || buttonText == '-' || buttonText == '*' || buttonText == '/') {
        if (_buffer.isNotEmpty || _output.endsWith('-')) {
          _num1 = double.parse(_buffer.isEmpty ? _output : _buffer);
          _operation = buttonText;
          _isOperationShown = true;
          _output = '$_num1 $_operation';
          _buffer = '';
        }
      } else if (buttonText == '=') {
        if (_buffer.isNotEmpty && _isOperationShown) {
          double num2 = double.parse(_buffer);
          double result = 0.0;
          switch (_operation) {
            case '+':
              result = _num1 + num2;
              break;
            case '-':
              result = _num1 - num2;
              break;
            case '*':
              result = _num1 * num2;
              break;
            case '/':
              result = _num1 / num2;
              break;
          }
          _output = '$_num1 $_operation $_buffer = $result';
          _isOperationShown = false;
          _buffer = result.toString();
        }
      } else {
        _buffer += buttonText;
        _output = _isOperationShown ? '$_output$_buffer' : _buffer;
      }
    });
  }


  Widget _buildButton(String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      child: ElevatedButton(
        onPressed: () => _buttonPressed(buttonText),
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.all(20.0),
            child: Text(
              _output,
              style: TextStyle(fontSize: 36.0),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              children: <Widget>[
                _buildButton('7', 1, Colors.blueGrey[300]!),
                _buildButton('8', 1, Colors.blueGrey[300]!),
                _buildButton('9', 1, Colors.blueGrey[300]!),
                _buildButton('/', 1, Colors.indigo),
                _buildButton('4', 1, Colors.blueGrey[300]!),
                _buildButton('5', 1, Colors.blueGrey[300]!),
                _buildButton('6', 1, Colors.blueGrey[300]!),
                _buildButton('*', 1, Colors.indigo),
                _buildButton('1', 1, Colors.blueGrey[300]!),
                _buildButton('2', 1, Colors.blueGrey[300]!),
                _buildButton('3', 1, Colors.blueGrey[300]!),
                _buildButton('-', 1, Colors.indigo),
                _buildButton('0', 1, Colors.blueGrey[300]!),
                _buildButton('C', 1, Colors.blueGrey[300]!),
                _buildButton('=', 1, Colors.indigo),
                _buildButton('+', 1, Colors.indigo),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
