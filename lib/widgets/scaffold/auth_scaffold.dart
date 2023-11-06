import 'package:flutter/material.dart';
import 'package:izobility_mobile/widgets/button/app_bar_back_button.dart';

class AuthScaffold extends StatefulWidget {
  final Widget body;
  final bool isAppBar;
  final double topPadding;

  const AuthScaffold(
      {super.key,
      required this.body,
      this.isAppBar = true, this.topPadding = 32});

  @override
  State<AuthScaffold> createState() => AuthScaffoldState();
}

class AuthScaffoldState extends State<AuthScaffold> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16, widget.topPadding, 16, 0),
      child: GestureDetector(
        onTap: () async => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: widget.isAppBar
              ? AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  leading: AppBarBackButton(),
                  leadingWidth: 36,
                  toolbarHeight: 36,
                )
              : AppBar(toolbarHeight: 0),
          body: widget.body,
        ),
      ),
    ));
  }
}
