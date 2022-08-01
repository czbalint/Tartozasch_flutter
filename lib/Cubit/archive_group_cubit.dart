import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../Database/Groups/data_source.dart';
import '../UI/GroupView/group.dart';

abstract class ArchiveGroupState extends Equatable {
  const ArchiveGroupState();
}

class ArchiveInit extends ArchiveGroupState {
  const ArchiveInit();

  @override
  List<Object?> get props => [];
}

class LoadArchiveState extends ArchiveGroupState {
  @override
  List<Object?> get props => [];
}

class LoadedArchiveState extends ArchiveGroupState {
  final List<Group> groups;

  const LoadedArchiveState(this.groups);

  @override
  List<Object?> get props => [groups];
}

class ArchiveCubit extends Cubit<ArchiveGroupState>{

  final DataSource dataSource;

  ArchiveCubit(this.dataSource) : super(const ArchiveInit()){
      emitAllArchiveGroup();
  }

  Future<List<Group>> getAllArchiveGroup() async {
    return dataSource.getAllArchiveGroup();
  }

  Future<void> emitAllArchiveGroup() async {
    emit(LoadArchiveState());
    final archiveGroups = await getAllArchiveGroup();
    emit(LoadedArchiveState(archiveGroups));
  }
}

