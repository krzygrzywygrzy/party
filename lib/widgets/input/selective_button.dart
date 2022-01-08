import 'package:flutter/material.dart';

class SelectiveButton extends StatelessWidget {
  const SelectiveButton({
    Key? key,
    required this.caption,
    this.selected,
    this.onTap,
  }) : super(key: key);

  final bool? selected;
  final String caption;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: selected == true ? 2 : 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(caption),
        ),
      ),
    );
  }
}
