// /*
// TODO: here we will place all the things we learnt in doing this project
// TODO: widget build function has the setState function and you need to declare a stful widget for it
// TODO: To access the element from the top class in stlful widget, you will have to use widget keyword
// */
//
import 'package:flutter/material.dart';
//

class ListAtt extends StatefulWidget {
  final List<String> myList;
  ListAtt({required this.myList});

  @override
  State<ListAtt> createState() => _ListAttState();
}

class _ListAttState extends State<ListAtt> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.myList.length, // TODO: remember to access the upper part variable you need to use widget
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            // Set the state to update the selected index
            setState(() {
              _selectedIndex = index;
            });
          },
          child: Container(
            color: _selectedIndex == index ? Colors.grey[200] : null,
            child: ListTile(
              title: Text(widget.myList[index]),
              tileColor: Colors.grey[800],
            ),
          ),
        );
      },
    );
  }
}
List<String> mylis = ['hello', 'how', 'are', 'you'];

class Display extends StatefulWidget {
  static const String id = 'dis';
  const Display({Key? key}) : super(key: key);

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  var guess = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Text('this is my app'),
          Container(
            height: 200, // add a height to the container
            width: double.infinity, // make the container fill the available width
            child: ListAtt(myList: mylis),
          ),
        ],
    );
  }
}

