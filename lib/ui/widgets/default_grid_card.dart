import 'package:flutter/material.dart';

class DefaultGridCard extends StatelessWidget {
  final String id;
  final String title;
  final String? subTitle;
  final String? trailingText;
  final String? trailingTextTitle;
  final void Function()? onCardTap;
  final void Function()? onTapEdit;
  final void Function()? onTapDelete;
  const DefaultGridCard({
    super.key,
    required this.id,
    required this.title,
    this.subTitle,
    this.trailingText,
    this.trailingTextTitle,
    this.onCardTap,
    this.onTapEdit,
    this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
          side: const BorderSide(color: Colors.black54, width: 1),
        ),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                subTitle ?? '',
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: trailingTextTitle,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: trailingText,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                      onTap: onTapEdit,
                      child: Icon(
                        Icons.edit,
                        color: Colors.grey[700],
                      )),
                  InkWell(
                    onTap: onTapDelete,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
