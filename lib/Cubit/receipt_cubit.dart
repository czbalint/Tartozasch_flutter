import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterhf/Database/Groups/data_source.dart';
import 'package:flutterhf/UI/DetailsView/Receipe/receipe.dart';

import '../UI/DetailsView/Member/member.dart';
import '../UI/GroupView/group.dart';

abstract class ReceiptCubitState extends Equatable {
  const ReceiptCubitState();
}

class ReceiptInit extends ReceiptCubitState {
  const ReceiptInit();

  @override
  List<Object?> get props => [];
}

class ReceiptLoad extends ReceiptCubitState{
  
  @override
  List<Object?> get props => [];
}

class ReceiptLoaded extends ReceiptCubitState {
  final List<Receipt> receipts;

  const ReceiptLoaded(this.receipts);

  @override
  List<Object?> get props => [receipts];
}

class ReceiptRemove extends ReceiptCubitState {
  final Receipt removed;
  final int index;
  final List<Receipt> receipts;

  const ReceiptRemove(this.removed, this.index, this.receipts);

  @override
  List<Object?> get props => [];
}

class ReceiptCubit extends Cubit<ReceiptCubitState> {

  final DataSource dataSource;

  late Group group;

  ReceiptCubit(this.dataSource) : super(const ReceiptInit());

  Future<void> refreshGroup(Group newGroup) async {
    group = newGroup;
    emit(ReceiptLoaded(group.receipts));
  }

  Future<int> addNewReceipt(String name, Member member, int count, List<Member> payingMembers) async {
    emit(ReceiptLoad());
    var newReceipt = Receipt(name: name, member: member, count: count, payingMembers: payingMembers);
    group.receipts.add(newReceipt);
    group.sumSpending += count;
    for (var pm in payingMembers) {
      if (pm.id != member.id) {
        member.addDebit(pm, count / payingMembers.length, newReceipt.id, true);
      }
      pm.addDebit(member, count / payingMembers.length, newReceipt.id, false);
    }
    await dataSource.upsertGroup(group);
    emit(ReceiptLoaded(group.receipts));
    return newReceipt.id;
  }

  Future<void> removeReceipt(Receipt receipt) async {
    emit(ReceiptLoad());
    group.sumSpending -= receipt.count;
    var removedIndex = group.receipts.indexOf(receipt);
    group.receipts.remove(receipt);
    emit(ReceiptRemove(receipt, removedIndex, group.receipts));
    await dataSource.upsertGroup(group);
    emit(ReceiptLoaded(group.receipts));
  }
}