import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:username_generator/app_states/main_app_state.dart';
import 'package:username_generator/widgets/big_card.dart';

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
