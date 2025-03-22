import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_example/item_model.dart';
import 'package:bloc_example/services/item_repository.dart';


part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemRepository itemRepository;

  ItemBloc(this.itemRepository) : super(ItemInitial()) {
    on<LoadItems>(_onLoadItems);
    on<AddItem>(_onAddItems);
    on<DeleteItem>(_onDeleteItems);
    on<UpdateItem>(_onUpdateItems);
  }

Future<void> _onLoadItems(LoadItems event, Emitter<ItemState> emit) async {
  emit(ItemLoading());
  try {
    final items= await itemRepository.fetchItems();
    emit(ItemLoaded(items: items));
  } catch (e) {
    emit(ItemError(message: e.toString()));
  }
}

Future<void> _onAddItems(AddItem event, Emitter<ItemState> emit) async {
 emit(ItemLoading());
 try {
   await itemRepository.addItem(event.item);
   final items= await itemRepository.fetchItems();
   emit(ItemLoaded(items: items));
 } catch (e) {
  emit(ItemError(message: e.toString())); 
 }
}

Future<void> _onUpdateItems(UpdateItem event, Emitter<ItemState> emit) async {
 emit(ItemLoading());
 try {
   await itemRepository.updateItem(event.updatedItem);
   final items= await itemRepository.fetchItems();
   emit(ItemLoaded(items: items));
 } catch (e) {
  emit(ItemError(message: e.toString())); 
 }
}


Future<void> _onDeleteItems(DeleteItem event, Emitter<ItemState> emit) async {
 emit(ItemLoading());
 try {
   await itemRepository.deleteItem(event.id);
   final items= await itemRepository.fetchItems();
   emit(ItemLoaded(items: items)); 
 } catch (e) {
   emit(ItemError(message: e.toString()));
 }
}

}
