import 'dart:convert';
import 'dart:math';

import 'package:flutterhf/UI/DetailsView/Member/member.dart';

class Receipt{
  final int id;
  final String name;
  final Member member;
  final int count;
  List<Member> payingMembers = List<Member>.empty(growable: true);

  Receipt({required this.name, required this.member, required this.count, required this.payingMembers}) : id = Random().nextInt(1000) + 6000;

  Receipt.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'],
        name = jsonMap['name'],
        member = Member.fromJson(jsonMap['member']),
        count = jsonMap['count'],
        payingMembers = (json.decode(jsonMap['payingMembers']) as List).map((member) => Member.fromJson(member)).toList();

  Map<String, dynamic> toJson() => {
      'id' : id,
      'name' : name,
      'member' : member,
      'count' : count,
      'payingMembers' : jsonEncode(payingMembers)
  };
}