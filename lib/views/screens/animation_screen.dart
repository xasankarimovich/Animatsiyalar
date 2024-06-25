
import 'package:flutter/material.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<String> _list = ["xasan 1", "xasan 2", "xasan 3"];
  int _nextItemIndex = 4;

  void _addItem() {
    final int index = _list.length;
    _list.insert(index, "xasan $_nextItemIndex");
    _nextItemIndex++;
    _listKey.currentState!.insertItem(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animated List"),
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _list.length,
        itemBuilder: (context, index, animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: ListTile(
              title: Text(_list[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}

