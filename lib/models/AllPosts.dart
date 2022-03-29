import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lmn_neston/database/GetPosts_api.dart';
import 'package:lmn_neston/models/CreatePost.dart';

class PostProvider extends ChangeNotifier {
  List<CreatePost> _products = <CreatePost>[];
  String? _searchText = '';

  List<CreatePost> get products => <CreatePost>[..._products];

  // List<CreatePost> filterdProducts() {
  //   List<CreatePost> _tempProducts = <CreatePost>[];
  //   if (_searchText == null || _searchText!.isEmpty) {
  //     return <CreatePost>[..._products];
  //   }
  //   _tempProducts = _products
  //       .where((element) {
  //         return (element.title.toLowerCase().contains(_searchText!) ||
  //             element.description.toLowerCase().contains(_searchText!));
  //       })
  //       .cast<CreatePost>()
  //       .toList();
  //   return _tempProducts;
  // }

  void init() async {
    if (_products.isNotEmpty) return;
    await _load();
    if (kDebugMode) {
      print('Print: product provider, No. of product: ${_products.length}');
    }
  }

  Future<void> refresh() async {
    await _load();
  }

  onSearch(String? value) {
    _searchText = value!.toLowerCase();
    notifyListeners();
  }

  Future<void> _load() async {
    _products = await GetPostsAPI().getProducts();
    notifyListeners();
  }
}
