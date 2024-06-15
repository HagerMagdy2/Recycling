import 'package:bloc/bloc.dart';
import 'package:firstly/data/models/product.dart';
import 'package:firstly/data/remotDs/product_remote_data_source.dart';
import 'package:firstly/presintations/bloc/products_event.dart';
import 'package:firstly/presintations/bloc/products_state.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ProductRemoteDs remoteDs;

  CartBloc(this.remoteDs) : super(CartInitial()) {
    on<CartEvent>((event, emit) async {
      try {
        if (event is AddProductToCart) {
          emit(CartLoadingState());
          await remoteDs.addToCart(event.cartProduct);
          add(GetCartProduct());
          // add(GetProduct());
        } else if (event is GetCartProduct) {
          emit(CartLoadingState());
          final cartProducts = await remoteDs.getCartProduct();
          emit(CartLoaded(
            cartProducts: cartProducts,
          ));
        } else if (event is RemoveProductFromCart) {
          emit(CartLoadingState());
          //   await remoteDs.updateProduct(event.product.copyWith(isInCart: false));

          await remoteDs.removeProductFromCart(event.id);
          final products = await remoteDs.getCartProduct();
          emit(CartLoaded(
              cartProducts:
                  products)); // Emit new state with updated cart products
        } else if (event is UpdateCartProduct) {
          emit(CartLoadingState());
          await remoteDs.updateCartProduct(event.cartProducts);
          add(GetCartProduct());
        }
      } catch (e) {
        emit(CartErrorState(errorMessage: e.toString()));
      }
    });
  }
}
