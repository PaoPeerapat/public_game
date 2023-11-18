import 'dart:convert';

import '../models/game.dart';
import '../services/api.caller.dart';



class GameRepository {
  Future<List<Game>> getGame() async {
    try {
      var result = await ApiCaller().get('game?_embed=reviews');
      List list = jsonDecode(result);
      List<Game> gameList =
      list.map<Game>((item) => Game.fromJson(item)).toList();
      return gameList;
    } catch (e) {
      // TODO:
      rethrow;
    }
  }

  Future<void> AddGame({required String name, required double price, required double rating}) async {
    try {
      var result = await ApiCaller().post('game', params: {'name': name, 'price': price});
      // เปลี่ยน 'peice' เป็น 'price' ที่ถูกต้อง
    } catch (e) {
      // TODO:
      rethrow;
    }
  }
}


