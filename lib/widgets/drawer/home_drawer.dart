import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/settings/theme/apptheme.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({required this.onTap, super.key});
  void Function(BuildContext) onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 166.h,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: AppTheme.white),
          child: Text(
            'News App',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppTheme.black,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  onTap(context);
                  Navigator.of(context).pop();
                },
                child: Row(
                  spacing: 8.w,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/home.svg',
                    ),
                    Text(
                      'Go To Home',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Divider(
                color: AppTheme.white,
              ),
              Row(
                spacing: 8.w,
                children: [
                  SvgPicture.asset(
                    'assets/icons/roller.svg',
                  ),
                  Text(
                    'Theme',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.white),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    icon: SvgPicture.asset(
                      'assets/icons/arrowdown.svg',
                    ),
                    padding: EdgeInsets.zero,
                    value: 'Dark',
                    isExpanded: true,
                    dropdownColor: AppTheme.black,
                    menuWidth: 200.w,
                    items: [
                      DropdownMenuItem(
                        value: 'Dark',
                        child: Text(
                          'Dark',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Light',
                        child: Text(
                          'Light',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Divider(
                color: AppTheme.white,
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                spacing: 8.w,
                children: [
                  SvgPicture.asset(
                    'assets/icons/earth.svg',
                  ),
                  Text(
                    'Language',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.white),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    icon: SvgPicture.asset(
                      'assets/icons/arrowdown.svg',
                    ),
                    padding: EdgeInsets.zero,
                    value: 'English',
                    isExpanded: true,
                    dropdownColor: AppTheme.black,
                    menuWidth: 200.w,
                    items: [
                      DropdownMenuItem(
                        value: 'English',
                        child: Text(
                          'English',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Arabic',
                        child: Text(
                          'Arabic',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
