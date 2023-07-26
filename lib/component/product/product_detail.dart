import 'package:flutter/material.dart';
import 'package:rupee_elf/widgets/base_view_widget.dart';

class ProductDetailPage extends StatelessWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BaseViewWidget(title: 'Detail$productId');
  }
}
