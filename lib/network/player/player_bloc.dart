/*This file is part of Medito App.

Medito App is free software: you can redistribute it and/or modify
it under the terms of the Affero GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Medito App is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
Affero GNU General Public License for more details.

You should have received a copy of the Affero GNU General Public License
along with Medito App. If not, see <https://www.gnu.org/licenses/>.*/

import 'dart:async';

import 'package:Medito/network/api_response.dart';
import 'package:Medito/network/player/player_repo.dart';
import 'package:Medito/network/session_options/background_sounds.dart';
import 'package:audio_service/audio_service.dart';

class PlayerBloc {
  PlayerRepository? _repo;
  @Deprecated('Use backgroundSoundsProvider instead')
  StreamController<ApiResponse<BackgroundSoundsResponse>>?
      bgSoundsListController;

  PlayerBloc() {
    _repo = PlayerRepository();
    bgSoundsListController = StreamController.broadcast();
  }

  @Deprecated('Use backgroundSoundsProvider instead')
  Future<void> fetchBackgroundSounds() async {
    try {
      var sounds = await _repo?.fetchBackgroundSounds(true);
      bgSoundsListController?.sink.add(ApiResponse.completed(sounds));
    } catch (e) {
      bgSoundsListController?.sink.add(ApiResponse.error(e.toString()));
    }
  }

  void postRating(int rating, MediaItem mediaItem){
    _repo?.postRating(rating, mediaItem);
  }

  void dispose() {
    bgSoundsListController?.close();
  }
}

