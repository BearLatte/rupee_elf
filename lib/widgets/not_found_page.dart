import 'package:flutter/material.dart';
import 'base_view_widget.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseViewWidget(
      title: '404',
      child: Center(
        child: Text(
          'Not Found!',
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
    );
  }
}
