import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class studentModel {
  @HiveField(0)
  int? index;

  @HiveField(1)
  late final String name;
  @HiveField(2)
  late final String age;
  @HiveField(3)
  late final String number;
  @HiveField(4)
  late final String email;
  @HiveField(5)
  late final String image;
  studentModel(
      {required this.name,
      required this.age,
      required this.number,
      required this.email,
      this.index,
      required this.image});
}
