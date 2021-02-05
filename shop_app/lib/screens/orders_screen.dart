import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  @override
  void initState() {
    // Future.delayed(Duration.zero).then((_) async {
    // _isLoading = true;
    // //await
    // Provider.of<Orders>(context, listen: false).fetchAndSetOrders().then((_) {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });

    // });
    super.initState();
  }

  //254. 8:40초 까지 함. 한 5분전 돌려서 다시 이해하기.. 위에 initState안쓰고 FutureBuilder로 대체해서
  // ... 로딩창 띄우는 방법 설명하는 부분임, 그리고 컨슈머 뭐였더라?
  @override
  Widget build(BuildContext context) {
    print('building orders');
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.error != null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Consumer<Orders>(
                  builder: (ctx, orderData, child) => ListView.builder(
                      itemCount: orderData.orders.length,
                      itemBuilder: (ctx, i) => OrderItem(
                            orderData.orders[i],
                          )),
                );
              }
            }
          }),
    );
  }
}
