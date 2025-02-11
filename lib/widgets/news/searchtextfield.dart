import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/theme/apptheme.dart';

class Searchtextfield extends StatefulWidget {
  const Searchtextfield({
    this.textEditingController,
    required this.onChanged,
    super.key,
  });
  final TextEditingController? textEditingController;
  final void Function(String)? onChanged;

  @override
  State<Searchtextfield> createState() => _SearchtextfieldState();
}

class _SearchtextfieldState extends State<Searchtextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      textInputAction: TextInputAction.done,
      controller: widget.textEditingController,
      onChanged: widget.onChanged,
      cursorColor: AppTheme.white,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        prefixIcon: SvgPicture.asset(
          'assets/icons/search.svg',
          fit: BoxFit.scaleDown,
        ),
        hintText: 'Search',
        hintStyle: Theme.of(context).textTheme.bodyLarge,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              16.r,
            ),
          ),
          borderSide: BorderSide(
            color: AppTheme.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              16.r,
            ),
          ),
          borderSide: BorderSide(
            color: AppTheme.white,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              16.r,
            ),
          ),
          borderSide: BorderSide(
            color: AppTheme.white,
          ),
        ),
      ),
    );
  }
}
