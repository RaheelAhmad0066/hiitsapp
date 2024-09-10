import 'package:flutter/material.dart';

class draggableBottomSheet extends StatelessWidget {
//   const draggableBottomSheet({super.key});

//   @override
//   State<draggableBottomSheet> createState() => _draggableBottomSheet();
// }

// class _draggableBottomSheet extends State<draggableBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.3,
        minChildSize: 0.1,
        maxChildSize: 0.8,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
              color: Colors.white,
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: 30,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text("Item"),
                    );
                  }));
          // )
        });
  }
}
