import 'package:flutter/material.dart';

class DefaultGridCard extends StatelessWidget {
  final String id;
  final String title;
  final String subTitle;
  final String? trailingText;
  final String? trailingTextTitle;
  final void Function()? onCardTap;
  final List<Widget> actions;
  const DefaultGridCard({
    super.key,
    required this.id,
    required this.title,
    this.subTitle = '',
    this.trailingText,
    this.trailingTextTitle,
    this.onCardTap,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
        side: const BorderSide(color: Colors.black54, width: 1),
      ),
      elevation: 1,
      child: InkWell(
        onTap: onCardTap,
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
                subTitle,
              ),
              Text.rich(
                TextSpan(
                  children: [
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
                children: actions,
              )
            ],
          ),
        ),
      ),
    );
  }
}
