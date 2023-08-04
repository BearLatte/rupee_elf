import 'package:flutter/material.dart';
import 'package:rupee_elf/util/Constants.dart';

class GenderSelector extends StatefulWidget {
  final double height;
  final String? selectedValue;
  final void Function(String)? onValueChanged;
  final void Function()? onTap;
  const GenderSelector({
    super.key,
    required this.height,
    this.selectedValue,
    this.onValueChanged,
    this.onTap,
  });

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  late String _selectedValue;
  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final List<String> genderList = ['male', 'female'];
    return Container(
      height: widget.height,
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(children: [
        SizedBox(
          width: 86.0,
          child: Text(
            'Gender',
            style: TextStyle(
              fontSize: 16.0,
              color: Constants.themeTextColor,
            ),
          ),
        ),
        Expanded(
            child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: List.generate(genderList.length, (index) {
            return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedValue = genderList[index];
                  });
                  if (widget.onTap != null) {
                    widget.onTap!();
                  }
                  if (widget.onValueChanged != null) {
                    widget.onValueChanged!(genderList[index]);
                  }
                },
                child: Container(
                  height: widget.height,
                  width: 110.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1.0,
                        color: genderList.indexOf(_selectedValue) == index
                            ? Constants.themeColor
                            : Constants.dividerColor,
                      ),
                    ),
                  ),
                  child: Text(
                    genderList[index],
                    style: TextStyle(
                        fontSize: 16.0,
                        color: genderList.indexOf(_selectedValue) == index
                            ? Constants.themeColor
                            : Constants.seconaryTextColor),
                  ),
                ));
          }).toList(),
        )),
      ]),
    );
  }
}
