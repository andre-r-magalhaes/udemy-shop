import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_shop/widgets/app_drawer.dart';
import 'package:udemy_shop/widgets/cart_count.dart';
import '../models/cart.dart';
import '../models/product_list.dart';
import '../widgets/product_grid.dart';

enum FilterOptions { Favorites, All }

class ProductsOverviewView extends StatefulWidget {
  ProductsOverviewView({super.key});

  @override
  State<ProductsOverviewView> createState() => _ProductsOverviewViewState();
}

class _ProductsOverviewViewState extends State<ProductsOverviewView> {
  bool _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                value: FilterOptions.Favorites,
                child: Text("Somente favoritos"),
              ),
              PopupMenuItem(value: FilterOptions.All, child: Text("Todos")),
            ],
            onSelected: (value) => {
              setState(() {
                if (value == FilterOptions.Favorites) {
                  _showFavoritesOnly = true;
                } else {
                  _showFavoritesOnly = false;
                }
              }),
            },
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
              icon: Icon(Icons.shopping_cart),
            ),
            builder: (ctx, cart, child) =>
                CartCount(value: cart.itemCount.toString(), child: child!),
          ),
        ],
      ),
      body: ProductGrid(showFavoritesOnly: _showFavoritesOnly),
      drawer: AppDrawer(),
    );
  }
}
