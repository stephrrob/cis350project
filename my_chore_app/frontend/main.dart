import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chore_bloc.dart'; // Import your ChoreBloc

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ChoreBloc choreBloc = ChoreBloc(); // Initialize the ChoreBloc

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
              create: (context) => choreBloc,
              child: Dashboard(),
            ),
        '/chore/create': (context) => BlocProvider.value(
              value: choreBloc,
              child: ChoreCreation(),
            ),
        // Add routes for other screens here
      },
    );
  }

  @override
  void dispose() {
    choreBloc.close(); // Close the ChoreBloc when the app is disposed
    super.dispose();
  }
}
