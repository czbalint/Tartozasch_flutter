import 'package:flutterhf/UI/DetailsView/Receipe/receipe.dart';

import '../DetailsView/Member/member.dart';

class Group {
  final int? id;
  final String title;
  final DateTime startDate;
  int membersCount;
  double sumSpending;
  bool archive;

  final List<Member> members;
  final List<Receipt> receipts;

  Group({
    this.id,
    required this.title,
    required this.membersCount,
    required this.startDate,
    required this.sumSpending,
    required this.archive,
  }) :
    members = List<Member>.empty(growable: true),
    receipts = List<Receipt>.empty(growable: true);

  Group.fromDb({
    this.id,
    required this.title,
    required this.startDate,
    required this.members,
    required this.receipts,
    required this.sumSpending,
    required this.archive,
    required this.membersCount,
  });



  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Group &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          startDate == other.startDate;

  @override
  int get hashCode => title.hashCode ^ startDate.hashCode;
}