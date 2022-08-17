import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../UI/DetailsView/Member/member.dart';

abstract class NewReceiptCubitState extends Equatable {
  const NewReceiptCubitState();
}

class NewReceiptInit extends NewReceiptCubitState{
  const NewReceiptInit();

  @override
  List<Object?> get props => [];
}

class NewReceiptAddMember extends NewReceiptCubitState{
  const NewReceiptAddMember(this.members, this.newIndex);

  final List<Member> members;
  final int newIndex;

  @override
  List<Object?> get props => [members, newIndex];
}

class NewReceiptRemoveMember extends NewReceiptCubitState{
  const NewReceiptRemoveMember(this.members);

  final List<Member> members;

  @override
  List<Object?> get props => [members];
}

class NewReceiptLoad extends NewReceiptCubitState{
  const NewReceiptLoad();

  @override
  List<Object?> get props => [];
}

class NewReceiptCubit extends Cubit<NewReceiptCubitState> {
  NewReceiptCubit() :
        _selectedMembers = List<Member>.empty(growable: true),
        super(const NewReceiptInit()) {
    emit(const NewReceiptInit());
  }

  final List<Member> _selectedMembers;
  List<Member> get members => _selectedMembers;

  void reloadList(){
    _selectedMembers.clear();
    emit(const NewReceiptInit());
  }

  void addMember(Member member){
    emit(const NewReceiptLoad());
    _selectedMembers.add(member);
    emit(NewReceiptAddMember(_selectedMembers, _selectedMembers.indexOf(member)));
  }

  void removeMember(Member member){
    emit(const NewReceiptLoad());
    _selectedMembers.remove(member);
    emit(NewReceiptRemoveMember(_selectedMembers));
  }
}
