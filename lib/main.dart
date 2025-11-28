import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
    // ↓ Add this.
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
  // for like button
  var favorites = <WordPair>[];
  void toggleFavorite(){
    if(favorites.contains(current)){
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
  void toggleDeleteFavorite(WordPair current){
    if(favorites.contains(current)){
      favorites.remove(current);
    }
    notifyListeners();

  }
}

// for SideBar
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
// for SideBar
class _MyHomePageState extends State<MyHomePage> {

  var selectedIndex = 0;
    
  @override
  
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
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
      }
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [          
          Expanded(
            flex: 3,
            child: HistoryListView(),
          ),
          SizedBox(height: 20),
          BigCard(pair: pair),
          SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
    );

    return Card(
      elevation: 5,
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: AnimatedSize(
          duration: Duration(milliseconds: 200),
          child: Wrap(          
            children: [
              Text(
                pair.first,
                style: style.copyWith(fontWeight: FontWeight.w200),
              ),Text(
                pair.second,
                style: style.copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// View for the favorites page
class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    if(appState.favorites.isEmpty){
      return Center(
        child: Text('No favorites yet.'),
      );
    }
    
  return ListView(
    children: [
      Padding(
        padding: const EdgeInsets.all(20),
        child: Text('You have ${appState.favorites.length} favorites:'),
      ),
      for (var pair in appState.favorites)
        ListTile(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  appState.toggleDeleteFavorite(pair);                  
                },
                icon: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.primary,),
              ),
              SizedBox(width: 5),
              Text(pair.asLowerCase),
            ],
          ),
        ),
    ],
  );
    
  }
}
// View for the history list  
class HistoryListView extends StatelessWidget {
  const HistoryListView({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    var appState = context.watch<MyAppState>();
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.secondary,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    if(appState.favorites.isEmpty){
        return Center(
          child: Text('No favorites yet.'),
        );
    }else{
          return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [                
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
                for (var pair in appState.favorites)
                TextButton(
                  child: Row(                  
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.favorite, 
                      color: theme.colorScheme.primary,
                      ),
                      SizedBox(width: 5),
                      Text(pair.asLowerCase, style: style),
                    ],
                  ),
                  onPressed: () => {
                    appState.current = pair,                    
                  },

                ),
            ],
          ),
        ],
      );
    }


  }
}