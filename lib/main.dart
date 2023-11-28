import 'random_map.dart';
import 'visited_countries_provider.dart'; //import 'package:example/pages/supported_countries_map.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "user_information.dart";
import "data_manager.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: " AIzaSyDLlP3QyKHV31A66o-aJTEbluHsEqWUG3E ",
    appId: "1:354516721530:android:7fc6d14624f5d1be8880c3",
    messagingSenderId: "354516721530",
    projectId: "travelmap-9d849",
  ));
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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            // Check if the user is logged in
            if (snapshot.hasData) {
              // Use a FutureBuilder to load and wait for the visited countries
              // Use a FutureBuilder to load and wait for the visited countries
              return FutureBuilder(
                future: FirestoreService().loadVisitedCountries(),
                builder: (context,
                    AsyncSnapshot<Set<String>> visitedCountriesSnapshot) {
                  if (visitedCountriesSnapshot.connectionState ==
                      ConnectionState.done) {
                    // Data is loaded, set the visited countries in the provider
                    if (visitedCountriesSnapshot.hasData) {
                      // Check for data and error
                      Provider.of<VisitedCountriesProvider>(context,
                              listen: false)
                          .setVisitedCountries(visitedCountriesSnapshot.data!);
                      return MyHomePage();
                    } else if (visitedCountriesSnapshot.hasError) {
                      // Handle error, possibly show an error message or a retry button
                      return Scaffold(
                        body: Center(
                          child:
                              Text('Error: ${visitedCountriesSnapshot.error}'),
                        ),
                      );
                    }
                  }
                  // By default, show a loading spinner
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                },
              );
            } else {
              // User is not logged in, show the login screen
              print("ahjahahahahahahabiiisss");
              return const LoginScreen();
            }
          }
          // Waiting for authentication state to be available
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
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
    controller = TabController(length: 1, initialIndex: 0, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var visitedCountriesProvider =
        Provider.of<VisitedCountriesProvider>(context);
    double progress = visitedCountriesProvider.visitedCount / 151;
    double progressPercentage = progress * 100;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Countries World Map',
              style: TextStyle(color: Colors.blue)),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: UserInformationDrawer(),
        body: Column(children: [
          LinearProgressIndicator(value: progress),
          Text('${progressPercentage.toStringAsFixed(2)} % du monde exploré !'),
          Expanded(
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                children: [
                  WorldMapGenerator(),
                ]),
          )
        ]));
  }
}
