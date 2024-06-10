import 'package:bloc/bloc.dart';
import 'package:firstly/data/remotDs/product_remote_data_source.dart';
import 'package:firstly/presintations/bloc/products_event.dart';
import 'package:firstly/presintations/bloc/products_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRemoteDs remoteDs;

  ProductBloc(this.remoteDs) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      try {
        if (event is AddProduct) {
          emit(ProductLoadingState());
          await remoteDs.addProduct(event.product);
          add(GetProduct());
        } else if (event is AddProductToCart) {
          emit(ProductLoadingState());
          await remoteDs.addToCart(event.product);
          add(GetProduct());
        } else if (event is AddProductToFavorites) {
          emit(ProductLoadingState());
          await remoteDs.addToFavorites(event.product);
          add(GetProduct());
        } else if (event is GetProduct) {
          emit(ProductLoadingState());
          final products = await remoteDs.getProduct();
          emit(ProductLoaded(products: products));
        } else if (event is GetCartProduct) {
          emit(ProductLoadingState());
          final products = await remoteDs.getCartProduct();
          emit(ProductLoaded(products: products));
        } else if (event is GetFavoriteProduct) {
          emit(ProductLoadingState());
          final products = await remoteDs.getFavoriteProducts();
          emit(ProductLoaded(products: products));
        } else if (event is RemoveProduct) {
          emit(ProductLoadingState());
          await remoteDs.removeProduct(event.id);
          add(GetProduct());
        } else if (event is RemoveProductFromCart) {
          emit(ProductLoadingState());
          //   await remoteDs.updateProduct(event.product.copyWith(isInCart: false));

          await remoteDs.removeProductFromCart(event.id);
          final products = await remoteDs.getCartProduct();
          emit(ProductLoaded(
              products: products)); // Emit new state with updated cart products
        } else if (event is RemoveProductFromFavorites) {
          emit(ProductLoadingState());
          await remoteDs.removeFromFavorites(event.id);
          add(GetFavoriteProduct());
        } else if (event is UpdateProduct) {
          emit(ProductLoadingState());
          await remoteDs.updateProduct(event.product);
          add(GetProduct());
        } else if (event is UpdateCartProduct) {
          emit(ProductLoadingState());
          await remoteDs.updateCartProduct(event.product);
          add(GetCartProduct());
        }
      } catch (e) {
        emit(ProductErrorState(errorMessage: e.toString()));
      }
    });
  }
}
