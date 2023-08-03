import 'dart:math';

import 'package:rupee_elf/util/random_util.dart';

class ProductItem {
  final String id;
  final String imageUrl;
  final String productName;
  final String score;
  final String loanAmount;
  const ProductItem({
    required this.id,
    required this.imageUrl,
    required this.productName,
    this.score = '5.0',
    required this.loanAmount,
  });
}

const List<String> _scores = ['4.8', '4.9', '5.0'];

// scores[]
List<ProductItem> productItemData = [
  ProductItem(
    id: RandomUtil.generateRandomString(10),
    imageUrl:
        'https://gmedia.playstation.com/is/image/SIEPDC/spider-man-2-reveal-attack-4K-legal_2022-en-12dec22?\$1600px\$',
    productName: '第一个',
    score: _scores[Random().nextInt(3) + 0],
    loanAmount: '₹ 20,000',
  ),
  ProductItem(
    id: RandomUtil.generateRandomString(10),
    imageUrl:
        'https://gmedia.playstation.com/is/image/SIEPDC/spider-man-2-reveal-attack-4K-legal_2022-en-12dec22?\$1600px\$',
    productName: '第二个',
    score: _scores[Random().nextInt(3) + 0],
    loanAmount: '₹ 20,000',
  ),
  ProductItem(
    id: RandomUtil.generateRandomString(10),
    imageUrl:
        'https://gmedia.playstation.com/is/image/SIEPDC/spider-man-2-reveal-attack-4K-legal_2022-en-12dec22?\$1600px\$',
    productName: '第三个',
    score: _scores[Random().nextInt(3) + 0],
    loanAmount: '₹ 20,000',
  ),
  ProductItem(
    id: RandomUtil.generateRandomString(10),
    imageUrl:
        'https://gmedia.playstation.com/is/image/SIEPDC/spider-man-2-reveal-attack-4K-legal_2022-en-12dec22?\$1600px\$',
    productName: '第四个',
    score: _scores[Random().nextInt(3) + 0],
    loanAmount: '₹ 20,000',
  ),
  ProductItem(
    id: RandomUtil.generateRandomString(10),
    imageUrl:
        'https://gmedia.playstation.com/is/image/SIEPDC/spider-man-2-reveal-attack-4K-legal_2022-en-12dec22?\$1600px\$',
    productName: '第五个',
    score: _scores[Random().nextInt(3) + 0],
    loanAmount: '₹ 20,000',
  ),
  ProductItem(
    id: RandomUtil.generateRandomString(10),
    imageUrl:
        'https://gmedia.playstation.com/is/image/SIEPDC/spider-man-2-reveal-attack-4K-legal_2022-en-12dec22?\$1600px\$',
    productName: '第六个',
    score: _scores[Random().nextInt(3) + 0],
    loanAmount: '₹ 20,000',
  )
];
