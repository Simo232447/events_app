import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback myfunction;
  final bool nightMode;


  CustomButton({required this.title, required this.myfunction, required this.nightMode });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: PhysicalModel(
        elevation: 8,
        borderRadius: BorderRadius.circular(10),
        color: nightMode  ? Colors.indigoAccent : Colors.cyan,
        child:

        /// 1 GestureDetector()

        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
            ),
            height:120,
            width: 150,
            child: Center(child: Text(title , style: TextStyle(color: nightMode ? Colors.white : Colors.black),)),
          ),
          onTap: myfunction,
        ),
      ),
    );
  }
}
