import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter/material.dart';
import 'package:countries_world_map/countries_world_map.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Countries World Map Example'),
        ),
        body: Center(
          child: SimpleMap(
            // String of instructions to draw the map.
            instructions:SMapWorld.instructions,
            // Default color for all countries.
            defaultColor: Colors.grey,

            // Matching class to specify custom colors for each area.
            colors: const SMapWorldColors(
              uS: Colors.green,   // This makes USA green
              cN: Colors.green,   // This makes China green
              rU: Colors.green,   // This makes Russia green
            ).toMap(),

            // Callback details of what area is being touched, giving you the ID, name, and tap details
            callback: (id, name, tapdetails) {
               print(id); // Prints the ID of the country that was tapped
            },
          ),
        ),
      ),
    );
  }
}
