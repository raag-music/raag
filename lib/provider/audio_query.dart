/*
 *  This file is part of BlackHole (https://github.com/Sangwan5688/BlackHole).
 * 
 * BlackHole is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * BlackHole is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with BlackHole.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * Copyright (c) 2021-2022, Ankit Sangwan
 */

import 'dart:io';
import 'dart:typed_data';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:raag/provider/audio_helper.dart';

class OfflineAudioQuery {
  static OnAudioQuery audioQuery = OnAudioQuery();
  static final RegExp avoid = RegExp(r'[\.\\\*\:\"\?#/;\|]');

  static Future<void> requestPermission() async {
    while (!await audioQuery.permissionsStatus()) {
      await audioQuery.permissionsRequest();
    }
  }

  Future<List<SongModel>> getSongs({
    SongSortType? sortType,
    OrderType? orderType,
    String? path,
  }) async {
    return audioQuery.querySongs(
      sortType: sortType ?? SongSortType.DATE_ADDED,
      orderType: orderType ?? OrderType.DESC_OR_GREATER,
      uriType: UriType.EXTERNAL,
      path: path,
    );
  }

  Future<Uint8List?> getAlbumArt(
          {required int id, int quality = 100, int size = 150}) =>
      audioQuery.queryArtwork(id, ArtworkType.AUDIO,
          quality: quality, size: size);

  Future<List<PlaylistModel>> getPlaylists() async {
    return audioQuery.queryPlaylists();
  }

  Future<bool> createPlaylist({required String name}) async {
    name.replaceAll(avoid, '').replaceAll('  ', ' ');
    return audioQuery.createPlaylist(name);
  }

  Future<bool> removePlaylist({required int playlistId}) async {
    return audioQuery.removePlaylist(playlistId);
  }

  Future<bool> addToPlaylist({
    required int playlistId,
    required int audioId,
  }) async {
    return audioQuery.addToPlaylist(playlistId, audioId);
  }

  Future<bool> removeFromPlaylist({
    required int playlistId,
    required int audioId,
  }) async {
    return audioQuery.removeFromPlaylist(playlistId, audioId);
  }

  Future<bool> renamePlaylist({
    required int playlistId,
    required String newName,
  }) async {
    return audioQuery.renamePlaylist(playlistId, newName);
  }

  Future<List<SongModel>> getPlaylistSongs(
    int playlistId, {
    SongSortType? sortType,
    OrderType? orderType,
    String? path,
  }) async {
    return audioQuery.queryAudiosFrom(
      AudiosFromType.PLAYLIST,
      playlistId,
      sortType: sortType ?? SongSortType.DATE_ADDED,
      orderType: orderType ?? OrderType.DESC_OR_GREATER,
    );
  }

  Future<List<AlbumModel>> getAlbums({
    AlbumSortType? sortType,
    OrderType? orderType,
  }) async {
    return audioQuery.queryAlbums(
      sortType: sortType,
      orderType: orderType,
      uriType: UriType.EXTERNAL,
    );
  }

  Future<List<ArtistModel>> getArtists({
    ArtistSortType? sortType,
    OrderType? orderType,
  }) async {
    return audioQuery.queryArtists(
      sortType: sortType,
      orderType: orderType,
      uriType: UriType.EXTERNAL,
    );
  }

  Future<List<GenreModel>> getGenres({
    GenreSortType? sortType,
    OrderType? orderType,
  }) async {
    return audioQuery.queryGenres(
      sortType: sortType,
      orderType: orderType,
      uriType: UriType.EXTERNAL,
    );
  }

  static Future<String> imageQuery(SongModel song) async {
    final Uint8List? _imageBytes = await audioQuery.queryArtwork(
      song.id,
      ArtworkType.AUDIO,
      format: ArtworkFormat.JPEG,
      size: 200,
      quality: 100,
    );
    if (_imageBytes == null || _imageBytes.isEmpty)
      return (await getDefaultArt()).path;

    final File file =
        File('${appDirectory.path}/${song.id}_${song.displayNameWOExt}.jpg');
    if (!await file.exists()) {
      await file.create();
      file.writeAsBytesSync(_imageBytes);
    }
    return file.path;
  }
}
