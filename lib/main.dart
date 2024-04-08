import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showWithExtra = false;
  int totalResult = 0;
  String withExtra = '';
  int modifierCount = 0; // Tracks the cumulative modifier from + and - button presses.

  void rollDice(int buttonIndex) {
    setState(() {
      showWithExtra = true;
      int min = 0, max = 0;
      switch (buttonIndex) {
        case 1: min = 1; max = 4; break;
        case 2: min = 1; max = 6; break;
        case 3: min = 1; max = 8; break;
        case 4: min = 1; max = 10; break;
        case 5: min = 1; max = 12; break;
        case 6: min = 1; max = 20; break;
        case 7: min = 1; max = 100; break;
        case 8: min = 1; max = 2; break;
        // Remove case 8 since it seems to have been used for testing with fixed values.
        default: withExtra = 'win/win'; return;
      }

      int diceRoll = Random().nextInt(max - min + 1) + min;
      // Apply the cumulative modifierCount directly to the dice roll result.
      totalResult = diceRoll + modifierCount; // Now modifierCount directly influences the result.
      withExtra = "R: $diceRoll. \n db: $modifierCount. \n T: $totalResult";
    });
  }

  void addDice() {
    setState(() {
      showWithExtra = true;
      modifierCount += 1; // Increment the modifier count.
      withExtra = "Modifier: +$modifierCount";
    });
  }

  void removeDice() {
    setState(() {
      showWithExtra = true;
      modifierCount -= 1; // Decrement the modifier count.
      withExtra = "Modifier: $modifierCount"; // No need to add - sign, it will be automatically added for negative numbers.
    });
  }

  void clearGame() {
    setState(() {
      showWithExtra = false;
      totalResult = 0;
      modifierCount = 0; // Reset the modifier count as well.
      withExtra = 'Game reset.';
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 5, 5, 5),
        appBar: AppBar(
          title: const Text('Dice Roller',
          style: TextStyle(
            color:  Color.fromARGB(255, 254, 254, 254),
          ),
          ),
          backgroundColor: const Color.fromARGB(255, 25, 28, 28),
        ),
        body: Container(
         
            color: const Color.fromARGB(8, 28, 28, 28),
          child: Column(
            children: <Widget>[
              // First row of buttons
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 12), // Space above the first row of buttons
                child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    // Define the width of the button
                    child:InkWell(
                  onTap: () => rollDice (1),
                child: Image.asset('assets/dice1.png', width: 80, height: 80),
                  
                ),  
                  ),
                  SizedBox(
                    child:InkWell(
                  onTap: () => rollDice(2),
                child: Image.asset('assets/dice2.png', width: 80, height: 80),
                ),  
                  ),
                  SizedBox(
                    child:InkWell(
                  onTap: () => rollDice  (3),
                child: Image.asset('assets/dice3.png', width: 80, height: 80),
                ),  
                  ),
                  SizedBox(
                    
                    child:InkWell(
                  onTap: () => rollDice  (4),
                child: Image.asset('assets/dice4.png', width: 80, height: 80,
                color: Colors.white,),
                ),  
                  ),
                ],
              ),
              ),// Second row of buttons
              
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    // Define the width of the button
                    child:InkWell(
                  onTap: () => rollDice (5),
                child: Image.asset('assets/dice5.png', width: 80, height: 80),
                ),  
                  ),
                  SizedBox(
                    
                    child:InkWell(
                  onTap: () => rollDice (6),
                child: Image.asset('assets/dice6.png', width: 80, height: 80),
                ),  
                  ),
                  SizedBox(
                    
                    child:InkWell(
                  onTap: () => rollDice  (7),
                child: Image.asset('assets/dice7.png', width: 80, height: 80),
                ),  
                  ),
                  SizedBox( 
                    child:InkWell(
                  onTap: () => rollDice (8),
                child: Image.asset('assets/dice8.png', width: 80, height: 80,
                color: Colors.white,),
                ),  
                  ),
                ],
              ),
              ),
               Padding(
  padding: const EdgeInsets.only(top: 60, bottom: 12),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center, // Center vertically in the available space
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
        children: <Widget>[
          Visibility(
  visible: showWithExtra, // Controlled by the showWithExtra state variable
  child: Container(
    padding: const EdgeInsets.all(8), // Add some padding inside the box
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 37, 38, 37), // Light green background for the box
      borderRadius: BorderRadius.circular(10), // Rounded corners
      border: Border.all(
        color: const Color.fromARGB(255, 4, 5, 4), // Green border color
      ),
    ),
    child: Text(
      withExtra, // Display the extra information
      style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 254, 254, 254)),
    ),
  ),
),

          const  SizedBox(width: 20), // Space between text box and button
          ElevatedButton(
            onPressed: clearGame, // Ensure clearGame is correctly defined in your state class
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 13, 14, 14),
            ),
            child: const Text('Clear',
            style: TextStyle(
              color:  Color.fromARGB(255, 254, 254, 254),
            ),
            ),

          ),
        ],
      ),
    ],
  ),
),

              Expanded(
                child: Container(), // Placeholder for the rest of the content
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                    padding: const EdgeInsets.only(left: 12), // Added padding to the left of the Exit button
                    child: SizedBox(
                      height: 60, // Increased height for the "Exit" button
                      width: 60, // Added width to maintain square shape and increase size
                      child: ElevatedButton.icon(
                        onPressed: () {
                          SystemNavigator.pop(); // Exit the app
                        },
                        icon: const Icon(
                          Icons.exit_to_app,
                          size: 30, // Increased icon size
                          color: Colors.white, // Icon color
                        ),
                        label: const Text(''), // Empty label for icon-only button
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 25, 28, 28), // Custom background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Rounded corners with a radius of 10
                          ),
                          padding: EdgeInsets.zero, // Ensure the icon is centered by removing padding
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                   child: Row(
                      mainAxisSize: MainAxisSize.min, // Group the 3 buttons together
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black), // Border color
                            color: const Color.fromARGB(255, 25, 28, 28), // Background color
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.add, color: Colors.white), // Icon color changed to contrast with background
                            onPressed: addDice,
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black), // Border color
                            color: const Color.fromARGB(255, 25, 28, 28), // Background color
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.remove, color: Colors.white), // Icon color changed to contrast with background
                           onPressed: removeDice,
                          ),
                        ),
                      ],
                    ),
                  ),  
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Remove the incomplete code block


