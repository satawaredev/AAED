import 'package:flutter/material.dart';

class Movie {
  String title;

  String age;

  String categorires;

  String image;

  String subtitle;

  double rating;

  String technology;

  DateTime date;

  Movie(
      {@required this.title,
      @required this.image,
      @required this.subtitle,
      @required this.age,
      @required this.rating,
      @required this.date,
      @required this.categorires,
      @required this.technology});
}

final List<Movie> movies = [
  Movie(
      title: 'Water Sounds',
      image:
          'assets/images/iSounds1.jpg',
      subtitle: 'Water Sounds',
      age: 'R',
      rating: 8,
      date: DateTime(2019),
      categorires: 'Crime, Drama, Thriller',
      technology: 'DataSat, Dolby Digital '),
  Movie(
      title: 'Animal Sounds',
      image:
          'assets/images/iSounds2.jpg',
      subtitle: 'Animal Sounds',
      age: '18+',
      rating: 8.7,
      date: DateTime(2019),
      categorires: 'Crime, Drama, Thriller',
      technology: 'DataSat, Dolby Digital '),
  Movie(
      title: 'Music Instruments',
      image:
          'assets/images/iSounds3.jpg',
      subtitle: 'Music Instruments',
      age: 'PG-13',
      rating: 8.5,
      date: DateTime(2019),
      categorires: ' Action, Adventure, Drama',
      technology: 'DataSat, Dolby Digital '),
  Movie(
      title: 'Natural Sounds',
      image:
          'assets/images/iSounds4.jpg',
      subtitle: 'Natural Sounds',
      age: 'R',
      rating: 7.7,
      date: DateTime(2019),
      categorires: 'Drama, Comedy-drama',
      technology: 'DataSat, Dolby Digital '),
];
