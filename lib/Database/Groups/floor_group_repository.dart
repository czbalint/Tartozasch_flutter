
import 'package:flutterhf/Database/Groups/floor_group.dart';
import 'package:flutterhf/Database/Groups/floor_group_dao.dart';
import 'package:flutterhf/Database/Groups/floor_group_database.dart';
import 'package:flutterhf/Database/Groups/group_repository.dart';
import 'package:flutterhf/UI/GroupView/group.dart';

class FloorGroupRepository implements GroupRepository<FloorGroup> {
  late FloorGroupDao groupDao;

  @override
  Future<void> init() async {
    final database = await $FloorFloorGroupDatabse
        .databaseBuilder("floor_cash.db")
        .build();
    groupDao = database.groupDao;
  }

  @override
  Future<void> deleteGroup(FloorGroup group) {
   return groupDao.deleteGroup(group.id ?? -1);
  }

  @override
  Future<List<FloorGroup>> getAllActiveGroup(){
    return groupDao.getAllActiveGroup();
  }

  @override
  Future<FloorGroup> getGroup(int id) async {
    final group = await groupDao.getGroup(id);
    if (group == null){
      throw Exception("Invalid ID");
    } else {
      return group;
    }
  }

  @override
  Future<void> upsertGroup(FloorGroup group) {
      return groupDao.upsertTodo(group);
  }

  @override
  Future<List<FloorGroup>> getAllArchiveGroup() {
    return groupDao.getAllArchiveGroup();
  }

}

