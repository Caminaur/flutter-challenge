import 'package:flutter/material.dart';

class RowHeader extends StatelessWidget {
  const RowHeader({
    Key? key,
    required this.headerStyle,
  }) : super(key: key);

  final TextStyle? headerStyle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width / 4,
            child: Center(child: Text('Name', style: headerStyle)),
          ),
          SizedBox(
            width: size.width / 4,
            child: Center(child: Text('Height', style: headerStyle)),
          ),
          SizedBox(
            width: size.width / 4,
            child: Center(child: Text('Weight', style: headerStyle)),
          ),
          SizedBox(
            width: size.width / 4,
            child: Center(child: Text('Gender', style: headerStyle)),
          ),
        ],
      ),
    );
  }
}
