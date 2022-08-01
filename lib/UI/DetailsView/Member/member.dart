import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

class Member {
  final int id;
  final String name;
  final String? avatar;
  final Color? color;
  List<Debit> debits = List<Debit>.empty(growable: true);

  Member({required this.avatar, required this.color, required this.name}) : id = Random().nextInt(1000) + 7000;

  Member.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'],
        name = jsonMap['name'],
        avatar = jsonMap['avatar'],
        color = (jsonMap['color'] as String?)?.toColor(),
        debits = (json.decode(jsonMap['debits']) as List).map((debit) => Debit.fromJson(debit)).toList();


  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'avatar' : avatar,
    'color' : color.toString(),
    'debits' : jsonEncode(debits)
  };

  void addDebit(Member member, double count, int receiptId, bool income) {
    var newDebit = Debit(member.id, count, receiptId, income);
    debits.add(newDebit);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Member &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          avatar == other.avatar &&
          color == other.color;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ avatar.hashCode ^ color.hashCode;
}

extension StringToColor on String {
  Color? toColor () {
      if (this == "null") return null;
      String valueString = split('(0x')[1].split(')')[0];
      int value = int.parse(valueString, radix: 16);
      return Color(value);
  }
}

class Debit {
  final int memberId;
  final double count;
  final int receiptId;
  final bool income;

  Debit(this.memberId, this.count, this.receiptId, this.income);

  Debit.fromJson(Map<String, dynamic> jsonMap)
      : memberId = jsonMap['memberId'],
        count = jsonMap['count'],
        receiptId = jsonMap['receiptId'],
        income = jsonMap['income'];

  Map<String, dynamic> toJson() => {
      'memberId' : memberId,
      'count' : count,
      'receiptId' : receiptId,
      'income' : income
  };
}
