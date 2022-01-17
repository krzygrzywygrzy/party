import 'package:flutter/material.dart';

class ElevatedCard extends StatelessWidget {
  const ElevatedCard({
    Key? key,
    required Widget child,
    void Function()? onClick,
    double? height,
  })  : _child = child,
        _onClick = onClick,
        _height = height,
        super(key: key);

  final Widget _child;
  final void Function()? _onClick;
  final double? _height;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: _height,
        child: GestureDetector(
          onTap: _onClick,
          child: Material(
            elevation: 2,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: _child,
          ),
        ),
      ),
    );
  }
}
