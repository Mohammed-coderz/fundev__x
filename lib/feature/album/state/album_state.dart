import '../model/album_model.dart';

abstract class AlbumState {}

class AlbumInitialState extends AlbumState {}

class AlbumLoadingState extends AlbumState {}

class AlbumLoadedState extends AlbumState {
  final List<AlbumModel> albums;

  AlbumLoadedState(this.albums);
}

class AlbumErrorState extends AlbumState {
  final String errorMessage;

  AlbumErrorState(this.errorMessage);
}
