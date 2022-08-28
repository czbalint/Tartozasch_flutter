import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterhf/UI/DetailsView/Receipe/receipe.dart';

class ReceiptItemBubble extends StatefulWidget {
  const ReceiptItemBubble({Key? key, required this.receipt, required this.archive, required this.animation}) : super(key: key);

  final Receipt receipt;
  final bool archive;
  final Animation<double> animation;

  @override
  State<ReceiptItemBubble> createState() => _ReceiptItemBubbleState();
}

class _ReceiptItemBubbleState extends State<ReceiptItemBubble> {
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: widget.animation,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(

          children: [
            Container(
              //margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),

              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(),
                  ),

                  Container(
                    width: 300,
                    height: 80,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54, width: 3),
                      borderRadius: BorderRadius.circular(30),
                     // color: Colors.white54
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(27),
                        onTap: () {},
                        splashColor: Theme.of(context).splashColor,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 2),
                                      child: Text(
                                        widget.receipt.name,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 5),
                                      child: Text(
                                        "Megnevezés",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 2),
                                      child: Text(
                                        widget.receipt.count.toString() + " Ft",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 5),
                                      child: Text(
                                        "Összeg",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
