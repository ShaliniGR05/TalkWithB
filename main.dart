
import 'package:fd/home.dart';
import 'package:flutter/material.dart';


void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      routes: {
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD1CCE5),
      body: Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/first_flower2.png',
                width: 173,
                height: 201,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              Text(
                "Let's connect with TalkwithB!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'InriaSans',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Container(
                width: 300,
                padding: EdgeInsets.all(16),
                color: Color(0xFFD1CCE5),
                child: Text(
                  'Bluetooth-based chat app that allows seamless, offline communication and file sharing between devices, anytime, anywhere.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'InriaSans',
                  ),
                ),
              ),
              SizedBox(height: 20),
              MouseRegion(
                onEnter: (_) => setState(() {
                  _isHovering = true;
                }),
                onExit: (_) => setState(() {
                  _isHovering = false;
                }),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()), // Navigate to the new page
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFA594DE),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontFamily: 'InriaSans',
                    ),
                    elevation: _isHovering ? 10 : 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Adjust the radius here
                    ),
                  ),
                  child: Text("Get Started"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
