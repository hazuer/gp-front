import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MessageDialog extends ModalRoute {
  
  //final List<Widget> children;
  final String textError;


  MessageDialog({ required this.textError});

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration =>  Duration(milliseconds: 250);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 8,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding:  EdgeInsets.all(15.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15.h,),
              Image(image: AssetImage("assets/images/logo_login.png"), width: MediaQuery.of(context).size.width*.26,),
              SizedBox(height: 25.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(textError.toString(), textAlign: TextAlign.center,),
              ),
              SizedBox(height: 15.h,),
            ],
          ),
        )
      ),
    );
  }


  @override
  Widget buildTransitions(BuildContext context,  Animation<double>  animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}

