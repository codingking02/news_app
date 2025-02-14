import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/provider/settings_provider.dart';
import 'package:news_app/settings/theme/apptheme.dart';
import 'package:provider/provider.dart';

class Searchtextfield extends StatefulWidget {
  const Searchtextfield({
    this.textEditingController,
    required this.onChanged,
    required this.onTap,
    super.key,
  });
  final TextEditingController? textEditingController;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  @override
  State<Searchtextfield> createState() => _SearchtextfieldState();
}

class _SearchtextfieldState extends State<Searchtextfield> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<SettingsProvider>(context).isDark;
    return TextFormField(
      onTap: widget.onTap,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      textInputAction: TextInputAction.done,
      controller: widget.textEditingController,
      onChanged: widget.onChanged,
      cursorColor: isDark ? AppTheme.white : AppTheme.black,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        prefixIcon: SvgPicture.asset(
          isDark ? 'assets/icons/search.svg' : 'assets/icons/search_dark.svg',
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
            color: isDark ? AppTheme.white : AppTheme.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              16.r,
            ),
          ),
          borderSide: BorderSide(
            color: isDark ? AppTheme.white : AppTheme.black,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              16.r,
            ),
          ),
          borderSide: BorderSide(
            color: isDark ? AppTheme.white : AppTheme.black,
          ),
        ),
      ),
    );
  }
}
