


import 'package:flexible_structures/widgets/utils/flexible_if_not_null.dart';
import 'package:flutter/cupertino.dart';

part 'package:flexible_structures/widgets/layout/partitioned/partitioned_element.dart';


class PartitionedView extends StatelessWidget {
  final List<PartitionedElement> children;
  final Function(List<Widget> children) parent;
  final int? aroundSpace;
  final bool usePartitionColor;

  PartitionedView({
    super.key,
    required this.children,
    required this.parent,
     this.aroundSpace,
    this.usePartitionColor=false,

  });

  // gets the implicit partition
  double calculateTotalPartition(List<PartitionedElement> elements) {
    return elements
        .where((element) => element.partition != null)
        .fold<double>(0, (sum, element) => sum + (element.partition ?? 0));
  }

  // gets the remaining space, given the maximum is 100
  double calculateRemainingSpace(double totalPartition) {
    return (100.0 - totalPartition) - (aroundSpace ?? 0);
  }

  // generates children based on the fields above
  List<Widget> generateFlexibleWidgets(
      BuildContext context,
      List<PartitionedElement> elements, double totalPartition, double remainingSpace) {

    int quantityOfImplicitPartitions =
        elements.where((element) => element.partition == null).length;

    int defaultFlex = (remainingSpace / quantityOfImplicitPartitions).toInt();

    List<Widget> elementFlexibles = elements.map((element) {
      int flex = (element.partition ?? defaultFlex);

      Widget widget = Container(
        color:
        usePartitionColor ?
        element.color : null,
        child: NullSafeFlexible(
          flex: flex,

          child: element.build(context),
        ),
      );

      return widget;
    }).toList();

    if(aroundSpace != null) {
      elementFlexibles.insert(0, NullSafeFlexible(flex: aroundSpace!, useSpaceWhenEmpty: true,child: null,));
      elementFlexibles.add(
        NullSafeFlexible(flex: aroundSpace!, useSpaceWhenEmpty: true,child: null,)
      );
    }
    return elementFlexibles;
  }

  @override
  Widget build(BuildContext context) {
    double totalPartition = calculateTotalPartition(children);
    double remainingSpace = calculateRemainingSpace(totalPartition);
    List<Widget> flexibleWidgets = generateFlexibleWidgets(context,
        children, totalPartition, remainingSpace);

    return parent(flexibleWidgets);
  }
}

 










