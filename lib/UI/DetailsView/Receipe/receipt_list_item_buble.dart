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
              margin: EdgeInsets.symmetric(vertical: 30),
              width: 300,
              height: 80,
              child: Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54, width: 3),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white54
                    ),
                  ),

                  Text(widget.receipt.name)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
