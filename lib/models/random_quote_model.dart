// To parse this JSON data, do
//
//     final randomQuoteModel = randomQuoteModelFromJson(jsonString);

import 'dart:convert';

List<RandomQuoteModel> randomQuoteModelFromJson(String str) =>
    List<RandomQuoteModel>.from(
        json.decode(str).map((x) => RandomQuoteModel.fromJson(x)));

String randomQuoteModelToJson(List<RandomQuoteModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RandomQuoteModel {
  final String quote;
  final String author;
  final String h;

  RandomQuoteModel({
    required this.quote,
    required this.author,
    required this.h,
  });

  factory RandomQuoteModel.fromJson(Map<String, dynamic> json) =>
      RandomQuoteModel(
        quote: json["q"],
        author: json["a"],
        h: json["h"],
      );

  Map<String, dynamic> toJson() => {
        "q": quote,
        "a": author,
        "h": h,
      };

  // Factory method untuk parsing dari List JSON
  static RandomQuoteModel fromJsonList(List<dynamic> jsonList) {
    return RandomQuoteModel.fromJson(jsonList.first);
  }
}
