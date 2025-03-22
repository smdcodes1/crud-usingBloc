part of 'item_bloc.dart';

// @immutable
sealed class ItemEvent {}

class LoadItems extends ItemEvent {}

class AddItem extends ItemEvent {
  final Item item;
  AddItem({required this.item});
}

class UpdateItem extends ItemEvent {
  final Item updatedItem;
  UpdateItem({required this.updatedItem});
}

class DeleteItem extends ItemEvent {
  final String id;
  DeleteItem({required this.id});
}
