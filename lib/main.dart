import 'package:flutter/material.dart';
import 'dart:math';

void main(){
  runApp( const LoanApp() );
}


class LoanApp extends StatefulWidget {
  const LoanApp({super.key});

  @override
  State<LoanApp> createState() => _LoanState();
}


class _LoanState extends State<LoanApp> {
  double months = 1;
  double loan = 0;

  final amountController = TextEditingController();
  final percentController = TextEditingController();


  void calculate() {
    setState(() {
      double amount = double.tryParse(amountController.text) ?? 0;
      double annualPercent = double.tryParse(percentController.text) ?? 0;
      double months = this.months.floorToDouble();

      double monthlyPercent = (annualPercent / 100) / 12;

      if (monthlyPercent > 0) {
        loan = (monthlyPercent * amount) / (1 - pow((1 + monthlyPercent), -months));
        loan.toStringAsFixed(2);
      } else {
        loan = amount / months;
        loan.toStringAsFixed(2);
      }
      loan = double.parse(loan.toStringAsFixed(2));
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,

          title: const Text(
            "Loan Calculator",

            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),

          centerTitle: true,
          toolbarHeight: 100.0,
        ),

        bottomNavigationBar: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () => calculate(),

                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  fixedSize: const Size(double.infinity, 50),
                ),
                child: const Text('Calculate'),

              ),
            ),
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(5),
          child: Column(children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Enter Amount:",
                style: TextStyle(fontSize: 15),
              ),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Amount",
                  suffixIcon: Icon(Icons.euro_outlined),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2
                    )
                  )
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Enter number of Months:",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Slider(
              value: months,
              min: 1,
              max: 60,
              divisions: 60,
              activeColor: Colors.blue,
              inactiveColor: Colors.grey,
              label: '${months.toInt()} months',
              onChanged: (double? value) {
                setState(() {
                  months = value!;
                });
              },
            ),

            const SizedBox(
              height: 20,
            ),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Enter % per month::",
                style: TextStyle(fontSize: 15),
              ),
            ),
            TextField(
              controller: percentController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Percent",
                  suffixIcon: Icon(Icons.percent_outlined),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2
                    )
                  )
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Container(
              padding: const EdgeInsets.all(0),
              alignment: const Alignment(0, 0),
              height: 300,
              width: double.infinity,

              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: const Center(
                      child: Text(
                        'You will pay this amount monthly',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    child: Center(
                      child: Text(
                        '$loan€',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],),
        ),
      ),
    );
  }
}

