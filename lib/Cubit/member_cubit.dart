import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterhf/Database/Groups/data_source.dart';
import 'package:flutterhf/UI/GroupView/group.dart';

import '../UI/DetailsView/Member/member.dart';

abstract class MemberCubitState extends Equatable {
  const MemberCubitState();
}

class MemberInit extends MemberCubitState {
  const MemberInit();

  @override
  List<Object?> get props => [];
}

class MemberLoad extends MemberCubitState {

  @override
  List<Object?> get props => throw UnimplementedError();
}

class MemberLoaded extends MemberCubitState {
  final List<Member> members;

  const MemberLoaded(this.members);

  @override
  List<Object?> get props => [members];
}

class MemberRemove extends MemberCubitState {
  final Member removed;
  final int index;
  final List<Member> members;

  const MemberRemove(this.removed, this.index, this.members);

  @override
  List<Object?> get props => [removed, index, members];
}

class MemberCubit extends Cubit<MemberCubitState> {
  MemberCubit(this.dataSource) : super(const MemberInit());

  final DataSource dataSource;
  late Group group;

  Future<void> refreshGroup(Group newGroup) async {
    group = newGroup;
    emit(MemberLoaded(group.members));
  }

  Future<void> addMember(String name, String avatar, Color color) async {
    emit(MemberLoad());
    group.members.add(Member(name: name, color: color, avatar: avatar));
    group.membersCount = group.members.length;
    await dataSource.upsertGroup(group);
    emit(MemberLoaded(group.members));
  }

  Future<void> removeMember(Member member) async {
    emit(MemberLoad());
    group.membersCount--;
    var removedIndex = group.members.indexOf(member);
    group.members.remove(member);
    emit(MemberRemove(member, removedIndex, group.members));
    await dataSource.upsertGroup(group);
    emit(MemberLoaded(group.members));
  }
}