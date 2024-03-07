import 'package:flutter/material.dart';



class Intro3 extends StatefulWidget {
  final Function onBackTap;
  const Intro3({Key? key, required this.onBackTap}) : super(key: key);

  @override
  State<Intro3> createState() => _Intro3State();
}

class _Intro3State extends State<Intro3> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.red,

    );
  }
}

class Intro4 extends StatelessWidget {
  final Function onBackTap;
  const Intro4({super.key, required this.onBackTap});

  @override
  Widget build(BuildContext context) {
    return const  Scaffold(
      backgroundColor: Colors.grey,
    );
  }
}
class Intro6 extends StatelessWidget {
  final Function onBackTap;
  const Intro6({super.key, required this.onBackTap});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.grey,
    );
  }
}

class Intro5 extends StatelessWidget {
  final Function onBackTap;
  const Intro5({super.key, required this.onBackTap});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.grey,
    );
  }
}


class IntroFinal extends StatelessWidget {
  final Function onBackTap;
  const IntroFinal({super.key, required this.onBackTap});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.grey,
    );
  }
}



