



part of "partitioned_view.dart";


class PartitionedElement extends StatelessWidget {
  final int? partition;
  final Widget? child;
  final Color? color;
  const PartitionedElement({super.key,
  required this.partition,
    this.color,
    required  this.child,});

  @override
  Widget build(BuildContext context) {
    return child ?? Container();
  }
}
