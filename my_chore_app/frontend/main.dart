import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dashboard.dart';
//import 'profile.dart';
//import 'settings.dart';
//import 'chore_list_item.dart';
import 'chore_creation.dart';

void main() => runApp(const MaterialApp(
      title: "Chore Mate",
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chore Manager App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider(
              create: (context) => ChoreBloc(), // Create the ChoreBloc
              child: Dashboard(), // Update the name of the widget
            ),
        '/chore/create': (context) => BlocProvider.value(
              value: BlocProvider.of<ChoreBloc>(
                  context), // Provide the existing ChoreBloc
              child: const ChoreCreation(),
            ),
        // Add routes for other screens here
      },
    );
  }
}

// Define the ChoreBloc
class ChoreBloc extends Bloc<ChoreEvent, ChoreState> {
  ChoreBloc() : super(ChoreInitial());

  @override
  Stream<ChoreState> mapEventToState(ChoreEvent event) async* {
    if (event is LoadChores) {
      // Handle loading chores from the backend
      try {
        // Make an HTTP request to fetch chores
        // Replace with your actual backend API call
        final chores = await fetchChoresFromBackend();
        yield ChoreLoadSuccess(chores);
      } catch (e) {
        yield ChoreLoadFailure('Failed to load chores');
      }
    } else if (event is CreateChore) {
      // Handle creating a new chore
      try {
        // Make an HTTP request to create a chore
        // Replace with your actual backend API call
        final createdChore = await createChoreInBackend(event.choreData);
        yield ChoreCreateSuccess(createdChore);
      } catch (e) {
        yield ChoreCreateFailure('Failed to create chore');
      }
    }
    // Add more event handling logic as needed
  }
}

// Define ChoreEvent and ChoreState classes
abstract class ChoreEvent {}

abstract class ChoreState {}

class LoadChores extends ChoreEvent {}

class CreateChore extends ChoreEvent {
  final Map<String, dynamic> choreData;

  CreateChore(this.choreData);
}

class ChoreInitial extends ChoreState {}

class ChoreLoadSuccess extends ChoreState {
  final List<Chore> chores;

  ChoreLoadSuccess(this.chores);
}

class ChoreLoadFailure extends ChoreState {
  final String error;

  ChoreLoadFailure(this.error);
}

class ChoreCreateSuccess extends ChoreState {
  final Chore createdChore;

  ChoreCreateSuccess(this.createdChore);
}

class ChoreCreateFailure extends ChoreState {
  final String error;

  ChoreCreateFailure(this.error);
}

// Define the Chore model class
class Chore {
  final String id;
  final String choreName;
  final String assignedTo;
  final bool completed;

  Chore.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        choreName = json['choreName'],
        assignedTo = json['assignedTo'],
        completed = json['completed'];

  Chore({
    required this.id,
    required this.choreName,
    required this.assignedTo,
    required this.completed,
  });
}

// Define functions to interact with the backend
Future<List<Chore>> fetchChoresFromBackend() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:5000/chores'));

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON.
    var data = jsonDecode(response.body);
    List<Chore> chores = [];
    for (Map<String, dynamic> choreMap in data) {
      chores.add(Chore.fromJson(choreMap));
    }
    return chores;
  } else {
    // If the server did not return a 200 OK response, throw an exception.
    throw Exception('Failed to load chores');
  }
}

Future<Chore> createChoreInBackend(Map<String, dynamic> choreData) async {
  final response = await http.post(
    Uri.parse('https://http://127.0.0.1:5000/chores'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(choreData),
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON.
    var data = jsonDecode(response.body);
    return Chore.fromJson(data);
  } else {
    // If the server did not return a 200 OK response, throw an exception.
    throw Exception('Failed to create chore');
  }
}
