import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_dev_x/feature/album/model/album_model.dart';
import 'package:fun_dev_x/feature/album/state/album_state.dart';
import 'package:http/http.dart' as http;

class AlbumCubit extends Cubit<AlbumState> {
  AlbumCubit() : super(AlbumInitialState());

  Future<void> getAlbums() async {
    emit(AlbumLoadingState());

    try {
      final url = Uri.parse("https://jsonplaceholder.typicode.com/albums");
      final response = await http.get(url);
      print("response statusCode : ${response.statusCode}");
      print("response body : ${response.body}");
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        final albums = data.map((item) => AlbumModel.fromJson(item)).toList();
        emit(AlbumLoadedState(albums));
      } else {
        emit(AlbumErrorState("status code = ${response.statusCode}"));
      }
    } catch (e) {
      emit(AlbumErrorState("error = $e"));
    }
  }
}
