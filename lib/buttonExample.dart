import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Common Bar Demo',
      home: const ButtonDemoPage(),
    );
  }
}

class ButtonDemoPage extends StatelessWidget {
  const ButtonDemoPage({super.key});

  void showMessage(String msg) {
    Fluttertoast.showToast(
      msg: "This is a toast+ $msg",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16,
    );
    print(msg);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fluter button demo")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showMessage("Floating Action Button click"),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => showMessage("Eleveted button click"),
              child: const Text("Eleveted Button"),
            ),
            const SizedBox(height: 10),

            TextButton(
              onPressed: () => showMessage("Text button click"),
              child: const Text("Text Button"),
            ),

            const SizedBox(height: 10),

            OutlinedButton(
              onPressed: () => showMessage("Outline button click"),
              child: const Text("Outline Button"),
            ),

            const SizedBox(height: 10),

            IconButton(
              onPressed: () => showMessage("Icon button click"),
              icon: const Icon(Icons.thumb_up),
              color: Colors.blue,
            ),

            const SizedBox(height: 10),

            MaterialButton(
              onPressed: () => showMessage("MaterialButton click"),
              color: const Color.fromARGB(255, 241, 204, 16),
              textColor: Colors.white,
              child: const Text("Materia Buttonl"),
            ),

            const SizedBox(height: 10),

            InkWell(
              onTap: () => showMessage("MaterialButton click"),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(child: Text("Custom inkwell button", style:  TextStyle(color: Colors.white),
                ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}