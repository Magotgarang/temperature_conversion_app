import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TemperatureConverterScreen(),
    );
  }
}

class TemperatureConverterScreen extends StatefulWidget {
  @override
  _TemperatureConverterScreenState createState() =>
      _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState
    extends State<TemperatureConverterScreen> {
  String? selectedConversion;
  double? inputTemperature;
  String result = '';
  List<String> history = [];

  void convertTemperature() {
    if (inputTemperature != null && selectedConversion != null) {
      double convertedTemperature;
      if (selectedConversion == 'F to C') {
        convertedTemperature = (inputTemperature! - 32) * 5 / 9;
        result =
        '${inputTemperature!.toStringAsFixed(2)} °F => ${convertedTemperature.toStringAsFixed(2)} °C';
      } else {
        convertedTemperature = (inputTemperature! * 9 / 5) + 32;
        result =
        '${inputTemperature!.toStringAsFixed(2)} °C => ${convertedTemperature.toStringAsFixed(2)} °F';
      }
      history.insert(0, result);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: selectedConversion,
              hint: Text('Select Conversion'),
              items: <String>['F to C', 'C to F']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedConversion = value;
                  result = '';
                });
              },
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Temperature'),
              onChanged: (value) {
                inputTemperature = double.tryParse(value);
                setState(() {
                  result = '';
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                convertTemperature();
              },
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
              result,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Conversion History:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(history[index]),
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
