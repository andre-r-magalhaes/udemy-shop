import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_shop/models/product_list.dart';
import 'package:udemy_shop/utils/app_routes.dart';
import 'package:udemy_shop/widgets/app_drawer.dart';

import '../widgets/product_item.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductList>(context, listen: false).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.product_form);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.itemsCount,
            itemBuilder: (ctx, i) => Column(
              children: [
                ProductItem(product: products.items[i]),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
