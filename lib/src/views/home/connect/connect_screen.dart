import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:flutter/material.dart';

import '../../../constants/assets.dart';
import '../../../constants/textstyles.dart';
import '../../../utils/widgets/common_widgets.dart';
import '../connect_request_screen.dart';
import '../profile/profile_screen.dart';
import 'connected_connections_screen.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: backButton(
              context: context,
              image: icArrowLeft,
              onTap: () {
                Navigator.pop(context);
              }),
        ),
        title: Text("Connection Request",
          style: styleSatoshiBold(size: 22, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
          child: Column(
            children: [
              buildDataRowBold(title: 'Connections', text: 'Change', onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder) => const AllConnectionsScreen()));
              }),
              sizedBox16(),
              buildDataRowBold(title: 'Connection Requests', text: 'Change', onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder) => const ConnectionRequestScreen()));
              }),


            ],
          ),
        ),
      ),
    );
  }
}
