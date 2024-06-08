import 'package:flutter/material.dart';
import 'package:gougoule_ai_flutter/login/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://txfchfvopdrdyxxjwuyz.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR4ZmNoZnZvcGRyZHl4eGp3dXl6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTc3Nzk4NjksImV4cCI6MjAzMzM1NTg2OX0.FdvKqzMNYW1f00xz1_8ljobeh6QzRCeLfExQuLIftTs',
  );

  final supabase = Supabase.instance.client;
  var isLoggedIn = supabase.auth.currentUser == null ? false : true;

  runApp(MyApp(loggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.loggedIn});

  final bool loggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gougoule AI',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: loggedIn ? MyHomePage() : logInPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: 
      Text("hello")
    );
  }
}