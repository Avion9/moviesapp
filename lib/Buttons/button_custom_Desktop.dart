import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviesapp/pages/Popular_page.dart';
import 'package:moviesapp/widgets/responsive_Layout.dart';

class CustomDesktopDropdownButton2 extends StatelessWidget {
  final String hint;
  //final String? value;
  final List<String> dropdownItems;

  final ValueChanged<String?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset? offset;

  CustomDesktopDropdownButton2({
    required this.hint,
    // this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final width = mediaQueryData.size.width;
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        //To avoid long text overflowing.
        isExpanded: true,
        // value: value,
        items: dropdownItems
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Container(
                    alignment: valueAlignment,
                    child: Text(
                      item,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ))
            .toList(),
        onChanged: onChanged,
        selectedItemBuilder: selectedItemBuilder,
        icon: Padding(
          padding: const EdgeInsets.only(right: 30),
          child: icon ?? const Icon(Icons.menu_rounded, color: Colors.white),
        ),
        iconSize: iconSize ?? 30,
        iconEnabledColor: iconEnabledColor,
        iconDisabledColor: iconDisabledColor,
        buttonHeight: buttonHeight ?? 40,

        buttonWidth: 100,
        buttonPadding: buttonPadding,
        buttonDecoration: buttonDecoration ??
            BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
        buttonElevation: buttonElevation,
        itemHeight: itemHeight ?? 40,
        itemPadding: itemPadding ?? const EdgeInsets.only(left: 14, right: 14),

        //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
        dropdownMaxHeight: dropdownHeight ?? 200,
        dropdownWidth: dropdownWidth ?? 130,
        dropdownPadding: dropdownPadding,
        dropdownDecoration: dropdownDecoration ??
            BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.black.withOpacity(0.2)),
        dropdownElevation: dropdownElevation ?? 8,
        scrollbarRadius: scrollbarRadius ?? const Radius.circular(40),
        scrollbarThickness: scrollbarThickness,
        scrollbarAlwaysShow: scrollbarAlwaysShow,
        //Null or Offset(0, 0) will open just under the button. You can edit as you want.
        offset: const Offset(-40, 0),
        dropdownOverButton: false, //Default is false to show menu below button
      ),
    );
  }
}
