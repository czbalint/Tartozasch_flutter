import 'package:flutter/material.dart';
import 'package:flutterhf/UI/GroupView/group.dart';

class SummarizeWidget extends StatelessWidget {
  const SummarizeWidget({Key? key, required this.group}) : super(key: key);
  
  final Group group;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      content: Stack(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          SizedBox(
            height: 410,
            child: Column(
              children: [
                Padding(
                    padding:  const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  const [
                        Text(
                          "Összesítés",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 250,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                                var memberId = group.members[index].id;
                                var memberSpendSum = 0;
                                for (var item in group.receipts) {
                                    if (item.member.id == memberId){
                                      memberSpendSum += item.count;
                                    }
                                }
                                var debt = ((group.sumSpending.toInt() / group.membersCount) - memberSpendSum).round();
                                return Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.3,
                                        child: Text(group.members[index].name),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.centerEnd,
                                        child: Builder(
                                          builder: (context) {
                                            if (debt <= 0) {
                                              return Text(
                                                "+ ${debt.abs().toString()} Ft",
                                                style: const TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold
                                                ),
                                              );
                                            } else {
                                              return Text(
                                                "- ${debt.abs().toString()} Ft",
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,

                                                ),

                                              );
                                            }
                                          }
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                            },
                            separatorBuilder: (context, index) =>
                            const Divider(
                              color: Colors.black,
                              thickness: 1,
                            ),
                            itemCount: group.members.length
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Az egy főre jutó elosztott összeg: "),
                      Text("${(group.sumSpending / group.membersCount).round()} Ft")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("OK"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
