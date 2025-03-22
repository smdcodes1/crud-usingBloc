import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_example/model.dart';
import 'package:bloc_example/services/api_repository.dart';


part 'fetchlist_event.dart';
part 'fetchlist_state.dart';

class FetchlistBloc extends Bloc<FetchlistEvent, FetchlistState> {
  FetchlistBloc() : super(FetchlistInitial()) {
    on<FetchlistEvent>((event, emit) async {
     if (event is Fetchlists) {
       emit(FetchlistLoading());
      try {
        final list= await ApiRepository().fetchPost();
        emit(FetchlistLoaded(album: list!));
      } catch (e) {
        emit(FetchlistError(msg: e.toString()));
      }
     }
    });
  }
}
