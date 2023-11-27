import 'random_map.dart';
import 'visited_countries_provider.dart';//import 'package:example/pages/supported_countries_map.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => VisitedCountriesProvider(),
      child: SMapExampleApp(),
    ),
  );
}

class SMapExampleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Worldmap Example',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: 2, initialIndex: 0, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     var visitedCountriesProvider = Provider.of<VisitedCountriesProvider>(context);
     double progress = visitedCountriesProvider.visitedCount / 151;
    return Scaffold(
        appBar: AppBar(
            title: const Text('Countries World Map',
                style: TextStyle(color: Colors.blue)),
            backgroundColor: Colors.transparent,
            elevation: 0,
           ),
    body: Column(
      children: [
        LinearProgressIndicator(value: progress),
          Expanded(child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              children: [
                //SupportedCountriesMap(),
                RandomWorldMapGenerator(),
                // AfricaContinent()
              ]),
        )
      ]));
  }
}