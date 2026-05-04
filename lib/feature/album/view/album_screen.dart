import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_dev_x/feature/album/cubit/album_cubit.dart';
import 'package:fun_dev_x/feature/album/state/album_state.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Albums"), centerTitle: true),
      body: BlocBuilder<AlbumCubit, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AlbumErrorState) {
            return Center(
              child: Column(
                children: [
                  Text(state.errorMessage),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AlbumCubit>().getAlbums();
                    },
                    child: Text("try again"),
                  ),
                ],
              ),
            );
          } else if (state is AlbumLoadedState) {
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<AlbumCubit>().getAlbums();
              },
              child: ListView.builder(
                itemCount: state.albums.length,
                itemBuilder: (context, index) {
                  final album = state.albums[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(child: Text(album.id.toString())),
                      title: Text(album.title ?? "-"),
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(child: Text("no state"));
          }
        },
      ),
    );
  }
}
