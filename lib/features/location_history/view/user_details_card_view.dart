import 'package:flutter/material.dart';
import 'package:on_space/constants/app_colors.dart';
import 'package:on_space/widgets/custom_button_widget.dart';
import 'package:on_space/widgets/regular_text_widget.dart';
class UserDetailsCardView extends StatelessWidget {

  const UserDetailsCardView({required this.itemCount,
  required this.onTap, required this.imageUrl,
  required this.streetName,
    required this.itemName,
    required this.index,
    required this.timeAgo,super.key,});
  final int itemCount;
  final String itemName;
  final String streetName;
  final String timeAgo;
  final String imageUrl;
  final VoidCallback onTap;
  final int index;
  // final bool isAllActive;
  //
  // final bool isPeopleActive;
  //
  // final bool isItemsActive;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 200,
      width: size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image:AssetImage('assets/images/card_background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child:  Column(
        children: [
          const  SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 15, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                            color: Colors.green.withOpacity(0.4),),
                        child: const Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 12,
                              vertical: 2,),
                          child: RegularTextWidget(
                            text: 'All',
                            fontWeight: FontWeight.w700,
                            color: AppColors.blackAppColor, ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green.withOpacity(0.4),),
                        child: const Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 12,
                              vertical: 2,),
                          child: RegularTextWidget(
                            text: 'People',
                            fontWeight: FontWeight.w700,
                            color: AppColors.blackAppColor, ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green.withOpacity(0.4),),
                        child: const Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 12,
                              vertical: 2,),
                          child: RegularTextWidget(
                            text: 'Items',
                            fontWeight: FontWeight.w700,
                            color: AppColors.blackAppColor, ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.more_horiz_outlined,
                  color: AppColors.blackAppColor,),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Flexible(
            child: SizedBox(
              child: MediaQuery.removePadding(
                context: context,
                removeBottom: true,
                removeTop: true,
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: itemCount,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    return SizedBox(
                      height: 50,
                      width: size.width,
                      child:  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(imageUrl),
                                  radius: 20,
                                ),
                                const SizedBox(width: 8,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RegularTextWidget(
                                      text: itemName,
                                      color: AppColors.blackAppColor,
                                      fontWeight: FontWeight.w700,
                                      size: 15,
                                    ),
                                    const SizedBox(height: 2,),
                                    RegularTextWidget(
                                      text: streetName,
                                      color: AppColors.blackAppColor,
                                      size: 15,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                RegularTextWidget(
                                  text: 'Updated $timeAgo min ago',
                                  color: AppColors.blackAppColor, size: 12,),
                                const SizedBox(width: 5,),
                                CustomButtonWidget(
                                  onTap: onTap,
                                  height: 30,
                                  width: 30,
                                  color: AppColors.blackAppColor,
                                  widget: const Icon(
                                    Icons.location_on_outlined,
                                    color: AppColors.whiteAppColor,),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
