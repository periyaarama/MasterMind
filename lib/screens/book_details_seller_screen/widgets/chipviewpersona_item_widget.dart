import 'package:flutter/material.dart';
import '../../../core/app_export.dart'; // ignore: must_be_immutable

class ChipviewpersonaItemWidget extends StatelessWidget {
  const ChipviewpersonaItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 7.v,
      ),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(
        "Personal growth",
        style: TextStyle(
          color: appTheme.blueGray50,
          fontSize: 12.fSize,
          fontFamily: 'Abhaya Libre ExtraBold',
          fontWeight: FontWeight.w800,
        ),
      ),
      selected: false,
      backgroundColor: theme.colorScheme.primaryContainer,
      selectedColor: theme.colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(
          8.h,
        ),
      ),
      onSelected: (value) {},
    );
  }
}
