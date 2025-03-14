import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int answer = 23;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Scaffold is the main layout widget
      //AppBar is the top bar (This app doesn't have one)
      //Body is the main content
      body: Padding(
        padding: const EdgeInsets.all(35), // add padding to screen
        child: Column(
          children: [
            Spacer(),
            Text(
              'Counter App',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 100),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Your Answer:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 40),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Color(0xFF0957FF),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Spacer(),
                  Text(
                    // stateful widget
                    '$answer',
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'is my answer',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(height: 100),
            Row(
              children: [
                SizedBox(
                  width: 75,
                  height: 75,
                  child: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      setState(() {
                        answer--;
                      });
                    },
                    child: Text(
                      '-',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: 75,
                  height: 75,
                  child: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      // state management basic method
                      setState(() {
                        answer++;
                      });
                    },
                    child: Text(
                      '+',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 130),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
