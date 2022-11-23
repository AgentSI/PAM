import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function callback;

  const Button({
    Key? key,
    required this.text,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 82.0,
      height: 88.0,
      child: TextButton(style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)
              ),
              backgroundColor: text == "=" ? const Color.fromRGBO(17, 153, 142, 1) : Colors.white),
        child: Text(text, style: TextStyle(
            fontSize: 32,
            color: text == "C" ? const Color.fromRGBO(255, 136, 125, 1) :
                   text == "=" ? const Color.fromRGBO(238, 240, 242, 1) : const Color.fromRGBO(169, 167, 167, 1),
            fontFamily: 'SF Pro Text',
            fontWeight: FontWeight.w500)
        ),
        onPressed: () => callback(text)
      )
    );
  }
}

class ButtonBack extends StatelessWidget {
  final Function callback;

  const ButtonBack({
    Key? key,
    required this.callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170.0,
      height: 88.0,
      child: TextButton(style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4)
          ),
          padding: const EdgeInsets.only(left:90.0)),
        child: Image.asset('assets/backspace.png'),
        onPressed: () => callback("")
      )
    );
  }
}

class ButtonOp extends StatelessWidget {
  final Function callback;
  final String text;
  final Image img;

  const ButtonOp({
    Key? key,
    required this.text,
    required this.img,
    required this.callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 82.0,
        height: 88.0,
        child: TextButton(style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4)
            )),
            child: img,
            onPressed: () => callback(text)
        )
    );
  }
}