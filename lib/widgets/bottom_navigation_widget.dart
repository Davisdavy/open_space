import 'package:flutter/material.dart';
import 'package:on_space/constants/app_colors.dart';
import 'package:on_space/features/chat/view/chat_view.dart';
import 'package:on_space/features/driving/view/driving_view.dart';
import 'package:on_space/features/safety/view/safety_view.dart';
import 'package:on_space/features/user/user.dart';
import 'package:on_space/widgets/regular_text_widget.dart';

class BottomNavigationWidget extends StatefulWidget {
   const BottomNavigationWidget({super.key});

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int pageIndex = 0;
  final UserCubit _userCubit = UserCubit();


  @override
  Widget build(BuildContext context) {
    final pages = [
      UserView(userCubit: _userCubit,),
      const DrivingView(),
      const SafetyView(),
      const ChatView(),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: pages[pageIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          decoration:  BoxDecoration(
            color:Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 12,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child:  Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap:(){
                  setState(() {
                    pageIndex = 0;
                  });
                },
                borderRadius: BorderRadius.circular(5),
                child:  SizedBox(
                  height: 50,
                  // /width: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Icon(Icons.map_outlined, color
                          : pageIndex == 0 ? AppColors.blackAppColor
                          : AppColors.greyFontAppColor, size: 24,),
                      const RegularTextWidget(
                        text: 'Location',
                        color: AppColors.blackAppColor,
                        size: 10,),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap:(){
                  setState(() {
                    pageIndex = 1;
                  });
                },
                borderRadius: BorderRadius.circular(5),
                child:  SizedBox(
                  height: 50,
                  // /width: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Icon(Icons.route_outlined, color
                          : pageIndex == 1 ? AppColors.blackAppColor
                          : AppColors.greyFontAppColor, size: 24,),
                      const RegularTextWidget(
                        text: 'Driving',
                        color: AppColors.blackAppColor,
                        size: 10,),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap:(){
                  setState(() {
                    pageIndex = 2;
                  });
                },
                borderRadius: BorderRadius.circular(5),
                child:  SizedBox(
                  height: 50,
                  // /width: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Icon(Icons.safety_check_outlined, color
                          : pageIndex == 2 ? AppColors.blackAppColor
                          : AppColors.greyFontAppColor, size: 24,),
                      const RegularTextWidget(
                        text: 'Safety',
                        color: AppColors.blackAppColor,
                        size: 10,),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap:(){
                  setState(() {
                    pageIndex = 3;
                  });
                },
                borderRadius: BorderRadius.circular(5),
                child:  SizedBox(
                  height: 50,
                  // /width: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Icon(Icons.chat_bubble_outline_outlined, color
                          : pageIndex == 3 ? AppColors.blackAppColor
                          : AppColors.greyFontAppColor, size: 24,),
                      const RegularTextWidget(
                        text: 'Chat',
                        color: AppColors.blackAppColor,
                        size: 10,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
