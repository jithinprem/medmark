import 'package:flutter/material.dart';
import 'package:medmark/test.dart';

//global variable
int selectedIndex = 0; // to see which column is selected



class ListAtt extends StatefulWidget {
  final List<Widget> myList;
  ListAtt({required this.myList});

  @override
  State<ListAtt> createState() => _ListAttState();
}

class _ListAttState extends State<ListAtt> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.myList.length, // TODO: remember to access the upper part variable you need to use widget
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            // Set the state to update the selected index
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            color: selectedIndex == index ? Color(0xB541644A) : null,
            child: widget.myList[index],
          ),
        );
      },
    );
  }
}