import 'package:flutter/material.dart';

class GeneralStyleContainer extends StatelessWidget {
  final Widget? child;
  GeneralStyleContainer({ Key? key, this.child,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.grey[300]
        ),
        child: child?? Container()
      ),
    );
  }
}