import 'package:flutter/material.dart';
import '../../../core/app_export.dart'; // ignore: must_be_immutable

class ChipviewpersonaItemWidget extends StatelessWidget {
  final String text;
  const ChipviewpersonaItemWidget({super.key, this.text = 'Personal growth'});

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
        text,
        style: TextStyle(
          color: theme.colorScheme.primary,
          fontSize: 12.fSize,
          fontFamily: 'Abhaya Libre ExtraBold',
          fontWeight: FontWeight.w800,
        ),
      ),
      selected: false,
      backgroundColor: theme.colorScheme.onPrimary.withOpacity(1),
      selectedColor: theme.colorScheme.onPrimary.withOpacity(1),
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
