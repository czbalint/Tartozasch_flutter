import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterhf/Cubit/receipt_cubit.dart';
import 'package:flutterhf/UI/DetailsView/Receipe/add_new_receipt_dialog.dart';
import 'package:flutterhf/UI/DetailsView/Member/member.dart';
import 'package:flutterhf/UI/DetailsView/Receipe/receipe.dart';
import 'package:flutterhf/UI/DetailsView/Receipe/receipt_list_item.dart';
import 'package:flutterhf/UI/DetailsView/Receipe/receipt_list_item_buble.dart';

class ReceiptListWidget extends StatefulWidget {
  const ReceiptListWidget({Key? key, required this.members, required this.archive}) : super(key: key);

  final List<Member> members;
  final bool archive;

  @override
  State<ReceiptListWidget> createState() => _ReceiptListWidgetState();
}

class _ReceiptListWidgetState extends State<ReceiptListWidget> {
  final GlobalKey<AnimatedListState> receiptListKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Row(
          children: [
            SizedBox(
              height: 400,
              width: MediaQuery.of(context).size.width,
              child:  Scaffold(
                  body: DecoratedBox(
                    decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                   // color: Color.fromARGB(255, 232, 232, 232)
                    ),
                    child: BlocBuilder<ReceiptCubit, ReceiptCubitState>(
                      builder: (context, state) {
                        if (state is ReceiptRemove) {
                          receiptListKey.currentState!.removeItem(state.index, (context, animation) =>
                            ReceiptListItem(receipt: state.removed, archive: widget.archive, animation: animation,)
                          );
                          return _renderList(state.receipts, state.receipts.length);
                        }

                        if (state is ReceiptInsert) {
                          receiptListKey.currentState?.insertItem(state.newIndex);

                          return _renderList(state.receipts, state.newIndex);
                        }

                        if (state is ReceiptLoaded) {
                          return _renderList(state.receipts, state.receipts.length);
                        }

                        if (state is ReceiptLoad){
                          return Container();
                        }


                        return Container();
                      }
                    ),
                  ),
                  floatingActionButton: Builder(
                    builder: (context) {
                      if (!widget.archive) {
                        return FloatingActionButton(
                          onPressed: () {
                              if (widget.members.isEmpty){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: const Text("Még nem adtál hozzá embereket!"),
                                      action: SnackBarAction(
                                        label: 'OK',
                                        onPressed: () {},
                                      ),
                                  )
                                );
                                return;
                              }
                              // showDialog(context: context, builder: (BuildContext context) {
                              //     return AddNewReceiptDialog(members: widget.members);
                              // });
                              Navigator.pushNamed(
                                  context,
                                  "/receiptAddPage",
                                arguments: widget.members
                              );
                          },
                          tooltip: "Új fogyasztás hozzáadása",
                          backgroundColor: Colors.blue,
                          child: const Icon(Icons.receipt_long_outlined),
                       );
                      }
                      return Container();
                    }
                  ),
                ),
              ),
          ],
    );
  }

  Widget _renderList(List<Receipt> receipts, int initCount) {
    if (receipts.isNotEmpty) {
      return AnimatedList(
        key: receiptListKey,
        initialItemCount: initCount,
        itemBuilder: (context, index, animation) {
         // return ReceiptListItem(receipt: receipts[index], archive: widget.archive, animation: animation,);
          return ReceiptItemBubble(receipt: receipts[index], archive: widget.archive, animation: animation);
        },
      );
    }
    return Container(
      alignment: Alignment.center,
      child: const Text(
        "Még nem adtál hozzá fogyasztást!",
        style: TextStyle(
            fontSize: 20
        ),
      ),
    );
  }

}
