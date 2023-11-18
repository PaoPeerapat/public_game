import 'review.dart';
import 'package:collection/collection.dart';

import 'review.dart';

class Game {
  final int id;
  final String name;
  final double price;
  final double averageRating;
  final List<Review> reviews;

  Game({
    required this.id,
    required this.name,
    required this.price,
    required this.averageRating,
    required this.reviews,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    List<Review> reviews = (json['reviews'] as List<dynamic>)
        .where((review) => review['gameId'] == json['id'])
        .map<Review>((item) => Review.fromJson(item))
        .toList();

    var averageRating = 0.0;
    if (reviews.isNotEmpty) {
      averageRating = reviews.map((review) => review.rating).average ?? 0.0;
    }

    return Game(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      averageRating: averageRating,
      reviews: reviews, // ปรับเปลี่ยนที่นี่เพื่อรับค่า List ของ Reviews
    );
  }
}


