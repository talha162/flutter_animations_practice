import 'dart:math';

import 'package:flutter/material.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Animations"),
        ),
        body: HomePage(),
      ),
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) {
                  return ImplicitAnimation();
                },)
                );
              },
              child: Text("Implicit Animation")
          ),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) { return ExplicitAnimation();}));
          },
              child: Text("Explicit Animation")
          )
        ],
      ),
    );
  }
}

class ImplicitAnimation extends StatefulWidget {
  const ImplicitAnimation({Key? key}) : super(key: key);

  @override
  State<ImplicitAnimation> createState() => _ImplicitAnimationState();
}

class _ImplicitAnimationState extends State<ImplicitAnimation> {
  double _height=100;
  double _width=100;
  double _rotation=0;
  double _opacity=1;
  Color _color=Colors.red;
  double randomNumberMinMax(double min, double max){
    double randomminmax = min + Random().nextDouble()* (max - min);
    //generate random number within minimum and maximum value
    return randomminmax;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        appBar: AppBar(title: Text("Implicit")),
        body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 AnimatedOpacity(
                   opacity:_opacity,
                   duration: Duration(seconds:1),
                   child: AnimatedContainer(
                     duration:Duration(seconds:1),
                      height:_height,
                      width:_width,
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(_rotation),
                      color:_color,
                      // curve: Curves.bounceInOut,
                      child: Center(child: Text("Implicit")),
                    ),
                 ),

                ElevatedButton(onPressed: (){
                  setState(() {
                    _height=randomNumberMinMax(40, 150);
                  });
                }, child: Text("Change Height"),),
                ElevatedButton(onPressed: (){
                  setState(() {
                    _width=randomNumberMinMax(40, 150);
                  });
                }, child: Text("Change Width"),),
                ElevatedButton(onPressed: (){
                  setState(() {
                    _color=Colors.primaries[Random().nextInt(Colors.primaries.length)];
                  });
                }, child: Text("Change Color"),),
                ElevatedButton(onPressed: (){
                  setState(() {
                    _rotation=randomNumberMinMax(0, 360);
                  });
                }, child: Text("Rotation"),),
                ElevatedButton(onPressed: (){
                  setState(() {
                    _opacity=randomNumberMinMax(0.1, 1);
                  });
                }, child: Text("Change Opacity"),),
              ]
          ),
        ),

      ),
    );
  }
}

class ExplicitAnimation extends StatefulWidget {
  const ExplicitAnimation({Key? key}) : super(key: key);

  @override
  State<ExplicitAnimation> createState() => _ExplicitAnimationState();
}

class _ExplicitAnimationState extends State<ExplicitAnimation> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  void initState(){
    super.initState();
//ticker is instance,ticker is an object that calls function on every frame
_animationController=AnimationController(vsync: this,duration:Duration(seconds: 1) );
    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:
             Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   RotationTransition(
                     // Tween gives us intermediate values between two values like colors
                     // , integers, alignments and almost anything you can think of.
                     turns: Tween<double>(begin: 0,end: 1).animate(_animationController),//how to interpiloate btw two vales
                     alignment: Alignment.center,
                     child: Center(
                       child: Container(
                         color:Colors.blue,
                        height:100,
                        width:100,
                        child: Center(child: Text("Explicit",style: TextStyle(color: Colors.white),)),
            ),
                     ),
                   ),
                   AlignTransition(alignment: Tween<AlignmentGeometry>(begin: Alignment.bottomLeft, end: Alignment.bottomRight,).animate(
                       _animationController,
                   ),
                        child:
                     Container(
                     color:Colors.blue,
                     height:100,
                     width:100,
                     child: Center(child: Text("Explicit",style: TextStyle(color: Colors.white),)),
                   ),
                   )
                 ],
               ),
             ),
        appBar: AppBar(title: Text("Explicit")),


      ),
    );
  }
}
