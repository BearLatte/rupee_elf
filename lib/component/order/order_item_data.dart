import 'package:rupee_elf/component/order/order_item_list_page.dart';

class OrderItem {
  final String imgUrl;
  final String loanName;
  final OrderType type;
  final String loanDate;
  final String loanAmount;
  final String orderNumber;

  const OrderItem({
    required this.imgUrl,
    required this.loanName,
    required this.type,
    required this.loanDate,
    required this.loanAmount,
    required this.orderNumber,
  });
}

const List<OrderItem> orderItemData = [
  OrderItem(
    imgUrl:
        'https://leaderonomics-storage.s3.ap-southeast-1.amazonaws.com/spiderman_g278aca1a7640_50ebb7_ee6ce2e13f.jpg',
    loanName: 'Freecash',
    type: OrderType.pending,
    loanDate: '30-12-2020',
    loanAmount: '₹ 3000.00',
    orderNumber: 'JKD1232312312312312312',
  ),
  OrderItem(
    imgUrl:
        'https://news.agentm.tw/wp-content/uploads/s-507b0799f15865812fb00fa339c3c1b30ec34ba8.jpg',
    loanName: 'Freecash',
    type: OrderType.disbursing,
    loanDate: '30-12-2020',
    loanAmount: '₹ 3000.00',
    orderNumber: 'JKD1232312312312312312',
  ),
  OrderItem(
    imgUrl:
        'https://media.gq.com.tw/photos/5dbc2bb12551d4000869e61a/master/w_1600%2Cc_limit/2019050869223889.jpg',
    loanName: 'Freecash',
    type: OrderType.unrepay,
    loanDate: '30-12-2020',
    loanAmount: '₹ 3000.00',
    orderNumber: 'JKD1232312312312312312',
  ),
  OrderItem(
    imgUrl:
        'https://cdn.wowscreen.com.tw/uploadfile/202007/goods_023379_313675.jpg',
    loanName: 'Freecash',
    type: OrderType.denied,
    loanDate: '30-12-2020',
    loanAmount: '₹ 3000.00',
    orderNumber: 'JKD1232312312312312312',
  ),
  OrderItem(
    imgUrl:
        'https://media.gq.com.tw/photos/5dbc27d22551d4000869e16b/3:2/w_1600%2Cc_limit/2019050674544721.jpg',
    loanName: 'Freecash',
    type: OrderType.disbursingFail,
    loanDate: '30-12-2020',
    loanAmount: '₹ 3000.00',
    orderNumber: 'JKD1232312312312312312',
  ),
  OrderItem(
    imgUrl:
        'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/%E4%B8%8B%E8%BC%89-1-1553139514.jpg?crop=0.495xw:0.852xh;0.505xw,0&resize=640:*',
    loanName: 'Freecash',
    type: OrderType.overdue,
    loanDate: '30-12-2020',
    loanAmount: '₹ 3000.00',
    orderNumber: 'JKD1232312312312312312',
  ),
  OrderItem(
    imgUrl:
        'https://pgw.udn.com.tw/gw/photo.php?u=https://uc.udn.com.tw/photo/2021/11/23/realtime/14618202.jpg&x=0&y=0&sw=0&sh=0&sl=W&fw=800&exp=3600',
    loanName: 'Freecash',
    type: OrderType.repaied,
    loanDate: '30-12-2020',
    loanAmount: '₹ 3000.00',
    orderNumber: 'JKD1232312312312312312',
  ),
];
