part of 'fetchlist_bloc.dart';

// @immutable
sealed class FetchlistState {}

class FetchlistInitial extends FetchlistState {}

class FetchlistLoading extends FetchlistState {}

class FetchlistLoaded extends FetchlistState {
  final List<AlbumModel> album;
  FetchlistLoaded({required this.album});
}

class FetchlistError extends FetchlistState {
  final String msg;
  FetchlistError({required this.msg});
}


