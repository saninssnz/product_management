part of 'product_bloc.dart';

class ProductState {
  List<Product>? productList;
  List<Product>? defaultProductList;

  ProductState({
    this.productList,
    this.defaultProductList,
  });

  ProductState copyWith({
    List<Product>? productList,
    List<Product>? defaultProductList,
  }) {
    return ProductState(
      productList: productList ?? this.productList,
      defaultProductList: defaultProductList ?? this.defaultProductList,
    );
  }
}

final class ProductInitial extends ProductState {
  ProductInitial()
      : super(
    productList: [],
    defaultProductList: [],
  );
}
