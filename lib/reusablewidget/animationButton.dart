

import 'package:flutter/material.dart';
import 'dart:math' as m;

class AnimationButton extends StatefulWidget {
  final VoidCallback?onclick;
  const AnimationButton({super.key,this.onclick});

  @override
  State<AnimationButton> createState() => _AnimationButtonState();
}

class _AnimationButtonState extends State<AnimationButton> with SingleTickerProviderStateMixin {

  late Animation<double>animation;

  late AnimationController controller;

  @override
  void initState() {
   
    super.initState();
     controller=AnimationController(vsync: this,duration: const Duration(seconds: 1));
    animation=Tween<double>(begin:0,end: 1 ).animate(controller)
    ..addStatusListener((status) { 
      if(status==AnimationStatus.completed){
        widget.onclick?.call();
        controller.reset();
      }


    });
  }

  @override
  void dispose() {
   controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.4,
      child: GestureDetector(
        onLongPressStart: _onlongpresstart,
        onLongPressEnd: _onlongpressend,
        child: AnimatedBuilder(
         animation: controller,
          builder: (context, snapshot) {
            return CustomPaint(
              painter: ArshapePainter(
                progress:animation.value,
                radius:MediaQuery.of(context).size.width,
                color:Colors.pink,
                strokeWidth:6,
            ),
              
               
              );
          }
        ),
      
    ));
  }

  void _onlongpresstart(LongPressStartDetails details) {
    controller.reset();
    controller.forward();

  }

  void _onlongpressend(LongPressEndDetails details) {
    controller.reset();

  }

}

class ArshapePainter  extends CustomPainter{
  late double progress;
  late double radius;
  late Color color;
  late double strokeWidth;

  //private 

  late Paint _linepaint;
  late Paint _solidpaint;
  late Path _path;



  ArshapePainter({required this.color,this.progress=0.5,this.radius=400,this.strokeWidth=4}){
    _linepaint=Paint()
    ..color=color
    ..strokeWidth=strokeWidth
    ..style=PaintingStyle.stroke;

    _solidpaint=Paint()
    ..color=color
    ..style=PaintingStyle.fill;
    

  }



  @override
  void paint(Canvas canvas, Size size) {
    var cardlngth=size.width+4;

    if(radius<=(cardlngth*0.5)+16) radius=cardlngth*0.5+16;
    if(radius>=600) radius=600;

    var arcangle=m.asin((cardlngth*0.5)/radius)*2;
    var startangle=(m.pi+m.pi*0.5)-(arcangle*0.5);
    var progressangle=arcangle*progress;

    //draw in Center

    Offset  center=Offset((cardlngth*0.5)-2, radius+8);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startangle, progressangle, false, _linepaint);
    _path=Path();
    _path.arcTo(Rect.fromCircle(center: center, radius: radius), startangle, arcangle, true);
    _path.lineTo(size.width, size.height);
    _path.lineTo(0, size.height);
    _path.close();

    //draw shaddow

    canvas.drawShadow(_path.shift(Offset(0, 1)), color.withAlpha(100), 3, true);

    //drow path
    canvas.drawPath(_path.shift(const Offset(0, 12)), _solidpaint);
    //  var cordLength = size.width + 4;
    // if(radius <= (cordLength * .5) + 16) radius = (cordLength * .5) + 16;
    // if(radius >= 600) radius = 600;

    // //Define required angles
    // var arcAngle = m.asin((cordLength * .5) / radius) * 2;
    // var startAngle = (m.pi + m.pi * .5) - (arcAngle * .5);
    // var progressAngle = arcAngle * progress;

    // //Define center of the available screen
    // Offset center = Offset((cordLength * .5) - 2, radius + 8);

    // //Draw the line arc
    // canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, progressAngle, false , _linepaint);

    // //Draw the solid arc path
    // _path = Path();
    // _path.arcTo(Rect.fromCircle(center: center, radius: radius), startAngle, arcAngle, true);
    // _path.lineTo(size.width, size.height);
    // _path.lineTo(0, size.height);
    // _path.close();

    // //Draw some shadow over the solid arc
    // canvas.drawShadow(_path.shift(Offset(0,1)), color.withAlpha(100), 3, true);

    // //Draw the solid arc using path
    // canvas.drawPath(_path.shift(Offset(0, 12)), _solidpaint);



  
    
   
  }
 @override
  bool? hitTest(Offset position) {
   
    return _path.contains(position);
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    
    return true;
  }
}