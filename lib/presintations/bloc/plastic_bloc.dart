import 'package:bloc/bloc.dart';
import 'package:firstly/data/remotDs/plastic-remot-ds.dart';
import 'package:firstly/presintations/bloc/plastic_event.dart';
import 'package:firstly/presintations/bloc/plastic_state.dart';

class PlasticBloc extends Bloc<PlasticEvent, PlasticState> {
  final PlasticRemoteDs remoteDs;

  PlasticBloc(this.remoteDs) : super(PlasticInitial()) {
    on<PlasticEvent>((event, emit) async {
      try {
        if (event is AddPlastic) {
          emit(PlasticLoadingState());
          await remoteDs.addPlastic(event.product);
          add(GetPlastic());
        } else if (event is AddProductToCart) {
          emit(PlasticLoadingState());
          await remoteDs.addToCart(event.product);
          add(GetPlastic());
        } else if (event is AddProductToFavorites) {
          emit(PlasticLoadingState());
          await remoteDs.addToFavorites(event.product);
          add(GetPlastic());
        } else if (event is GetPlastic) {
          emit(PlasticLoadingState());
          final products = await remoteDs.getPlastic();
          emit(PlasticLoaded(products: products));
        } else if (event is GetCartProduct) {
          emit(PlasticLoadingState());
          final products = await remoteDs.getCartProduct();
          emit(PlasticLoaded(products: products));
        } else if (event is GetFavoriteProduct) {
          emit(PlasticLoadingState());
          final products = await remoteDs.getFavoriteProducts();
          emit(PlasticLoaded(products: products));
        } else if (event is RemovePlastic) {
          emit(PlasticLoadingState());
          await remoteDs.removePlastic(event.id);
          add(GetPlastic());
        } else if (event is RemoveProductFromCart) {
          emit(PlasticLoadingState());
          await remoteDs.removeProductFromCart(event.id);
          add(GetCartProduct());
        } else if (event is RemoveProductFromFavorites) {
          emit(PlasticLoadingState());
          await remoteDs.removeFromFavorites(event.id);
          add(GetFavoriteProduct());
        } else if (event is UpdatePlastic) {
          emit(PlasticLoadingState());
          await remoteDs.updatePlastic(event.product);
          add(GetPlastic());
        } else if (event is UpdateCartProduct) {
          emit(PlasticLoadingState());
          await remoteDs.updateCartProduct(event.product);
          add(GetCartProduct());
        }
      } catch (e) {
        emit(PlasticErrorState(errorMessage: e.toString()));
      }
    });
  }
}
