import 'package:bloc/bloc.dart';
import 'package:machine_test/src/data/models/product_model.dart';
import 'package:machine_test/src/domain/repositories/firebase/firebase_repo.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {

    on<ProductFetchEvent>((event, emit) async {
      emit(ProductLoading()); // Emit loading state

      try {
        final productsList = await fetchProducts();
        emit(ProductLoaded());
        emit(state.copyWith(
            productList: productsList,
          defaultProductList: productsList
        ));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<AddProductEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        await addProduct(event.productName, event.measurement, event.price);
        emit(ProductAddedSuccessfully());
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<ProductSearchEvent>((event, emit) async {
      final currentState = state;

      List<Product>? filteredList = currentState.defaultProductList;

      if (event.query.isNotEmpty) {
        filteredList = currentState.defaultProductList?.where((item) =>
            item.name.toLowerCase().contains(event.query.toLowerCase())
        ).toList();
      }

      emit(currentState.copyWith(productList: filteredList));
    });



  }

}
