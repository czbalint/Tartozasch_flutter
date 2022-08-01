import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
import 'floor_group.dart';
import 'floor_group_dao.dart';

part 'floor_group_database.g.dart';

@Database(
  version: 1,
  entities: [
    FloorGroup,
  ],
)
abstract class FloorGroupDatabse extends FloorDatabase{
  FloorGroupDao get groupDao;
}