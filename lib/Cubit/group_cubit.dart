import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/animation.dart';

import '../Database/Groups/data_source.dart';
import '../UI/GroupView/group.dart';


abstract class GroupState extends Equatable {
    const GroupState();
}

class GroupInit extends GroupState {
  const GroupInit();

  @override
  List<Object?> get props => [];
}

class GroupInsertState extends GroupState {
  final List<Group> groups;
  final int newItemIndex;

  const GroupInsertState(this.groups, this.newItemIndex);

  @override
  List<Object?> get props => [groups, newItemIndex];

}

class GroupLoadedState extends GroupState {
  final List<Group> groups;

  const GroupLoadedState(this.groups);

  @override
  List<Object?> get props => [groups];
}

class GroupLoadState extends GroupState {
  @override
  List<Object?> get props => [];
}

class GroupRemoveState extends GroupState {
  final List<Group> groups;
  final int removedIndex;
  final Group removedGroup;

  const GroupRemoveState(this.groups, this.removedIndex, this.removedGroup);

  @override
  List<Object?> get props => [groups];
}

class GroupCubit extends Cubit<GroupState> {
  
  final DataSource dataSource;

  GroupCubit(this.dataSource) : super(const GroupInit()){
      emitAllActiveGroups();
  }

  Future<List<Group>> getAllActiveGroups() async {
      return dataSource.getAllActiveGroup();
  }
  
  Future<void> addGroup(String groupName) async {
      Group newGroup = Group(title: groupName, membersCount: 0, startDate: DateTime.now(), sumSpending: 0, archive: false );
      await dataSource.upsertGroup(newGroup);
      final groups = await getAllActiveGroups();
      emit(GroupInsertState(groups, groups.length - 1));
  }

  Future<void> removeGroup(Group group) async {
      var groups = await getAllActiveGroups();
      var removedIdx = groups.indexOf(group);
      var removedGroup = groups.removeAt(removedIdx);
      await dataSource.deleteGroup(group);
      groups = await getAllActiveGroups();
      emit(GroupRemoveState(groups, removedIdx, removedGroup));
  }
  
  Future<void> archiveGroup(Group group) async {
    var groups = await getAllActiveGroups();
    var removedIdx = groups.indexOf(group);
    var removedGroup = groups.removeAt(removedIdx);
    group.archive = true;
    await dataSource.upsertGroup(group);
    groups = await getAllActiveGroups();
    emit(GroupRemoveState(groups, removedIdx, removedGroup));
  }

  Future<void> emitAllActiveGroups() async {
      emit(GroupLoadState());
      final allGroups = await getAllActiveGroups();
      emit(GroupLoadedState(allGroups));
  }
}