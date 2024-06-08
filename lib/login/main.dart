import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gougoule_ai_flutter/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class logInPage extends StatefulWidget {
  const logInPage({super.key});

  @override
  State<logInPage> createState() => _logInPageState();
}

class _logInPageState extends State<logInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: 
      Padding(
        padding: const EdgeInsets.all(40),
        child: AutofillGroup(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              emailInput(context),
              Container(height: 20,),
              passwordInput(context),
              Container(height: 40,),
              loginButton(context),
              Text("Please use the website if you want to sign up or reset your password", style: TextStyle(color: Colors.grey),)
            ],
          )
        ) 
      )
    );
  }

  Widget emailInput(BuildContext context) {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: "Email",
        border: OutlineInputBorder(),
        hintText: "Username"
      ),
      keyboardType: TextInputType.emailAddress,
      autofillHints: [AutofillHints.username],
    );
  }

  Widget passwordInput(BuildContext context) {
    return TextField(
      controller: _passwordController,
      decoration: const InputDecoration(
        labelText: "Password",
        border: OutlineInputBorder(),
        hintText: "Password"
      ),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      autofillHints: [AutofillHints.password],
    );
  }

  Widget loginButton(BuildContext context) {
    return OutlinedButton(
      child: const Text("Login", style: TextStyle(fontSize: 20)),
      onPressed: () {
        login(context, _emailController.text, _passwordController.text);
      },
      style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(40)),
    );
  }
}

Future<void> login(BuildContext context, email, password) async {
  final supabase = Supabase.instance.client;

  try {
    final AuthResponse res = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final Session? session = res.session;
    final User? user = res.user;

    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }
  catch (e) {
    alert(context, "Error", e.toString());
  }
  
}

void alert(BuildContext context, String title, String text) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Ok'),
        ),
      ],
    ),
  );
}