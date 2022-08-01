import 'package:floor/floor.dart';

@Entity(tableName: "groups")
class FloorGroup{
  @PrimaryKey(autoGenerate: true)
  int? id;
  String title;
  String startDate;
  int membersCount;
  double sumSpending;
  bool archive;

  String members;
  String receipts;

  FloorGroup({
    this.id,
    required this.title,
    required this.startDate,
    required this.membersCount,
    required this.sumSpending,
    required this.archive,
    required this.members,
    required this.receipts
  });
}