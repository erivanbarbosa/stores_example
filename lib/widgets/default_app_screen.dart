import 'package:flutter/material.dart';

import 'package:redesprou_boilerplate_name/widgets/default_appbar.dart';
import 'package:redesprou_boilerplate_name/widgets/generic_circular_progress_indicator.dart';

class DefaultAppScreen extends StatelessWidget {
  final String screenTitle;
  List<Widget> screenBody;
  final bool loading;
  final Alignment contentAlign;

  DefaultAppScreen({
    Key? key,
    required this.screenTitle,
    required this.screenBody,
    this.loading = false,
    this.contentAlign = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
    );
  }

  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: DefaultAppBar(
        title: screenTitle,
      ),
    );
  }

  _buildBody() {
    return Stack(
      children: [
        Material(
            color: Colors.white,
            child: Align(
              alignment: contentAlign,
              child: SingleChildScrollView(
                child: loading
                    ? Container(height: 300, child: GenericCircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: screenBody,
                        ),
                      ),
              ),
            ))
      ],
    );
  }
}
