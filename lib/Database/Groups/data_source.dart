import 'dart:convert';

import 'package:flutterhf/Database/Groups/group_repository.dart';
import 'package:flutterhf/UI/DetailsView/Member/member.dart';
import 'package:flutterhf/UI/GroupView/group.dart';

import '../../UI/DetailsView/Receipe/receipe.dart';
import 'floor_group.dart';

class DataSource {
  final GroupRepository<FloorGroup> database;

  DataSource(this.database);

  Future<void> init() async {
    await database.init();
  }

  Future<List<Group>> getAllActiveGroup() async {
      final groups = await database.getAllActiveGroup();
      return groups.map((floorGroup) => floorGroup.toDomainModel()).toList();
  }

  Future<List<Group>> getAllArchiveGroup() async {
    final groups = await database.getAllArchiveGroup();
    return groups.map((floorGroup) => floorGroup.toDomainModel()).toList();
  }

  Future<Group> getGroup(int id) async {
    final floorGroup = await database.getGroup(id);
    return floorGroup.toDomainModel();
  }

  Future<void> upsertGroup(Group group) async {
    return database.upsertGroup(group.toDbModel());
  }

  Future<void> deleteGroup(Group group) async {
    return database.deleteGroup(group.toDbModel());
  }
}

extension GroupToFloorGroup on Group {
  FloorGroup toDbModel() {
    return FloorGroup(
        id: id,
        title: title,
        startDate: startDate.toString(),
        membersCount: membersCount,
        sumSpending: sumSpending,
        archive: archive,
        members: jsonEncode(members),
        receipts: jsonEncode(receipts)
    );
  }
}

extension FloorGroupToGroup on FloorGroup {
  Group toDomainModel() {
    return Group.fromDb(
        id: id,
        title: title,
        membersCount: membersCount,
        startDate: DateTime.parse(startDate),
        sumSpending: sumSpending,
        archive: archive,
        members: (json.decode(members) as List).map((member) => Member.fromJson(member)).toList(),
        receipts: (json.decode(receipts) as List).map((receipt) => Receipt.fromJson(receipt)).toList()
    );
  }
}