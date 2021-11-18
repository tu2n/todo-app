import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptySignage extends StatelessWidget {
  final String description;
  final String asset;

  const EmptySignage({Key key,
    @required this.description,
    @required this.asset
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          asset,
          height: 200,
        ),
        const SizedBox(height: 10,),
        Text(description, style: const TextStyle(color: Colors.grey),),
      ],
    );
  }
}
