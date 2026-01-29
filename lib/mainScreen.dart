import 'package:billionaireapp/addtodo.dart';
import 'package:flutter/Material.dart'
    show
        AppBar,
        BuildContext,
        Drawer,
        EdgeInsets,
        Icon,
        Icons,
        InkWell,
        Padding,
        Scaffold,
        State,
        StatefulWidget,
        Text,
        Widget;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  List<String> todoList = ["Drink water", "make dinner", "sleep"];

  void addtodo({required String todoText}) {
    if (todoList.contains(todoText)) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("already exists"),
            content: Text(" this data already exist"),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },

                child: Text("close"),
              ),
            ],
          );
        },
      );
      return;
    }

    setState(() {
      todoList.insert(0, todoText);
    });
    updateLocalData();
    Navigator.pop(context);
  }

  void updateLocalData() async {
    //obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('todoList', todoList);
  }

  void loaddata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    todoList = (prefs.getStringList("todoList") ?? []).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              color: Colors.blueGrey[900],
              height: 100,
              width: double.infinity,
              child: Center(
                child: Text(
                  "Todo App",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                launchUrl(
                  Uri.parse(
                    "https://www.linkedin.com/in/gagan-dehariya-2a1b84254/",
                  ),
                );
              },

              leading: Icon(Icons.account_circle),
              title: Text(
                "about me",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              //mail cion code start here
              onTap: () {
                launchUrl(Uri.parse("mailto:dehataiya@gamil.com"));
              },

              leading: Icon(Icons.mail),
              title: Text(
                "about me",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Todo made by Gagan app'),
        actions: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      height: 200,
                      child: Addtodo(addtodo: addtodo),
                    ),
                  );
                },
              );
            },

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          todoList.removeAt(index);
                        });
                        updateLocalData();
                        Navigator.pop(context);
                      },
                      child: Text("Mark as done"),
                    ),
                  );
                },
              );
            },
            title: Text(todoList[index]),
            trailing: Icon(Icons.arrow_back_ios_new_rounded),
            leading: Icon(Icons.arrow_back),
          );
        },
      ),
    );
  }
}
