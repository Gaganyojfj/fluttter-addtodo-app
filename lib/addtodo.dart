import 'package:flutter/Material.dart';

class Addtodo extends StatefulWidget {
  void Function({required String todoText}) addtodo;
  Addtodo({super.key, required this.addtodo});

  @override
  State<Addtodo> createState() => _AddtodoState();
}

TextEditingController todoText = TextEditingController();

class _AddtodoState extends State<Addtodo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('add todo:'),
        TextField(
          onSubmitted: (value) {
            if (todoText.text == "") {
            } else {
              widget.addtodo(todoText: todoText.text);
            }

            todoText.text = "";
          },
          autofocus: true,
          controller: todoText,
          decoration: InputDecoration(
            hintText: "type your name ",
            //labelText: "username",
            // icon: Icon(Icons.import_contacts),
          ),
        ),

        ElevatedButton(
          onPressed: () {
            if (todoText.text == "") {
            } else {
              widget.addtodo(todoText: todoText.text);
            }

            todoText.text = "";
          },
          child: Text("add"),
        ),
      ],
    );
  }
}
