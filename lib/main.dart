import 'package:flutter/material.dart';

void main() => runApp(GSTCalculatorApp());

class GSTCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GST Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GSTCalculatorHomePage(),
    );
  }
}

class GSTCalculatorHomePage extends StatefulWidget {
  @override
  _GSTCalculatorHomePageState createState() => _GSTCalculatorHomePageState();
}

class _GSTCalculatorHomePageState extends State<GSTCalculatorHomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _gstRateController = TextEditingController();
  double _gstAmount = 0.0;
  double _totalAmount = 0.0;

  void _calculateGST() {
    if (_formKey.currentState!.validate()) {
      double amount = double.parse(_amountController.text);
      double gstRate = double.parse(_gstRateController.text);

      setState(() {
        _gstAmount = amount * gstRate / 100;
        _totalAmount = amount + _gstAmount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GST Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _gstRateController,
                decoration: InputDecoration(labelText: 'GST Rate (%)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a GST rate';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateGST,
                child: Text('Calculate'),
              ),
              SizedBox(height: 20),
              Text('GST Amount: $_gstAmount'),
              Text('Total Amount: $_totalAmount'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _gstRateController.dispose();
    super.dispose();
  }
}
