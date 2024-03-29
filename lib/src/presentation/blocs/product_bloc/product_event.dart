part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {}

class ProductFetchEvent extends ProductEvent {}

class ProductAddedSuccessfully extends ProductState {}

class AddProductEvent extends ProductEvent {
  final String productName;
  final String measurement;
  final double price;

  AddProductEvent({required this.productName, required this.measurement, required this.price});
}

class ProductError extends ProductState {
  final String errorMessage;

  ProductError(this.errorMessage);
}

class ProductSearchEvent extends ProductEvent {
  final String query;
  ProductSearchEvent({required this.query});
}