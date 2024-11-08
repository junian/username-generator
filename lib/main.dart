import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:username_generator/app_states/main_app_state.dart';
import 'package:username_generator/pages/favorites_page.dart';
import 'package:username_generator/widgets/big_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Username Generator',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}



class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    
    Widget page;
    if(selectedIndex == 0) {
      page = GeneratorPage();
    } else if (selectedIndex == 1)
      // ignore: curly_braces_in_flow_control_structures
      page = FavoritesPage();
    else {
      throw UnimplementedError('no Widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home), 
                    label: Text('Home')
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite), 
                    label: Text('Favorites')
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value){
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon = appState.favorites.contains(pair) 
      ? Icons.favorite
      : Icons.favorite_border;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigCard(pair: pair),
            SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    appState.toogleFavorite();
                  }, 
                  icon: Icon(icon),
                  label: Text('Like')
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: (){
                    appState.getNext();
                  }, 
                  child: Text('Next')
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
