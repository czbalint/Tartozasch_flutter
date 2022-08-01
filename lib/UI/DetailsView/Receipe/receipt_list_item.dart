import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterhf/UI/DetailsView/Receipe/receipe.dart';

import '../../../Cubit/receipt_cubit.dart';

class ReceiptListItem extends StatelessWidget {
  final Receipt receipt;
  final bool archive;
  final Animation<double> animation;

  const ReceiptListItem({Key? key, required this.receipt, required this.archive, required this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailsCubit = context.read<ReceiptCubit>();
    return  SizeTransition(
      sizeFactor: animation,
      child: Slidable(
        key: UniqueKey(),
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          dismissible: DismissiblePane(
            onDismissed: () {
                detailsCubit.removeReceipt(receipt);
            },
            confirmDismiss: () {
              return confirmDelete(context);
            },
            closeOnCancel: true,
          ),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {
                if (!archive) {
                  detailsCubit.removeReceipt(receipt);
                }
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Törlés',
            ),
            SlidableAction(
              onPressed: (BuildContext context) {

              },
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: "Szerkesztés",
            )
          ],
        ),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {

              },
              backgroundColor: Colors.cyan,
              foregroundColor: Colors.white,
              icon: Icons.info,
              label: 'Info',
            ),
          ],
        ),
        child: Material(
          color: const Color.fromARGB(255, 232, 232, 232),
          child: InkWell(
            onLongPress: () {
              if (!archive) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Biztos szeretnéd törölni a ${receipt.name} nevű fogyasztást?"),
                      action: SnackBarAction(
                          label: "OK",
                          onPressed: () => detailsCubit.removeReceipt(receipt)),
                    )
                );
              }
            },
            splashColor: Colors.red,
            child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: const [
                                Text(
                                  "Megnevezés",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                receipt.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: const [
                                Text(
                                  "Fizette",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                receipt.member.name,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: const [
                                Text(
                                  "Összeg",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "${receipt.count.toString()} Ft",
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> confirmDelete(BuildContext context) async {
    bool val = false;
    await ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Biztos szeretnéd törölni a ${receipt.name} nevű fogyasztást?"),
          action: SnackBarAction(
              label: "OK",
              onPressed: () => {}
          ),
        )
    ).closed.then((value) => value.name == 'action' ? val = true : val = false);

    return Future(() => val);
  }

}
