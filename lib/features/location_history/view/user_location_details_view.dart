import 'package:flutter/material.dart';
import 'package:on_space/constants/app_colors.dart';
import 'package:on_space/widgets/custom_button_widget.dart';
import 'package:on_space/widgets/regular_text_widget.dart';

class UserLocationDetailsView extends StatefulWidget {
  const UserLocationDetailsView({required this.itemName,
  required this.currentLocation, required this.imageURl,
    required this.streetName,
    required this.locationId,super.key,});
  final String itemName;
  final String imageURl;
  final String locationId;
  final String streetName;
  final String currentLocation;

  @override
  State<UserLocationDetailsView> createState() =>
      _UserLocationDetailsViewState();
}

class _UserLocationDetailsViewState extends State<UserLocationDetailsView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: RegularTextWidget(
          text: widget.itemName,
          color: AppColors.blackAppColor,
          fontWeight: FontWeight.w700,
          size: 22,
        ),
        centerTitle: true,
        leading:  Padding(
          padding: const EdgeInsets.only(left: 10),
          child:  CustomButtonWidget(
            onTap: (){
              Navigator.of(context).pop();
            },
            widget: const Icon(Icons.arrow_back_ios,
              color: AppColors.blackAppColor, size: 18,),
            height: 45,
            width: 45,
          ),
        ),
        actions: const [
           Padding(
             padding: EdgeInsets.only(right: 10),
             child: CustomButtonWidget(
              widget: Icon(
                Icons.location_on_outlined,
                color: AppColors.whiteAppColor,),
              height: 45,
              color: AppColors.blackAppColor,
              width: 45,
                       ),
           ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 90,
                  backgroundImage: NetworkImage(widget.imageURl),
                ),
              ),
              const SizedBox(height: 15,),
              Container(
                height: 60,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.whiteAppColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.greyFontAppColor),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(Icons.info_outline,
                          size: 18,
                          color: AppColors.blackAppColor,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryAppColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,
                              vertical: 5,),
                          child: RegularTextWidget(text: widget.locationId,
                            color: AppColors.blackAppColor,
                            fontWeight: FontWeight.w700,),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.greyFontAppColor),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(Icons.chat_bubble_outline_outlined,
                          size: 18,
                          color: AppColors.blackAppColor,),
                      ),
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                height: 120,
                width: size.width,
                decoration: BoxDecoration(
                  color: AppColors.whiteAppColor,
                  borderRadius: BorderRadius.circular(10),

                ),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,
                      vertical: 10,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const RegularTextWidget(
                        text: 'Now is',
                        color: AppColors.blackAppColor,
                        fontWeight: FontWeight.w700,
                        size: 28,
                      ),
                      const SizedBox(height: 10,),
                      RegularTextWidget(
                        text: widget.currentLocation,
                        color: AppColors.blackAppColor,
                        size: 18,
                      ),
                      const SizedBox(height: 10,),
                      RegularTextWidget(
                        text: widget.streetName,
                        color: AppColors.blackAppColor,
                        size: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                height: 120,
                width: size.width,
                decoration: BoxDecoration(
                  color: AppColors.whiteAppColor,
                  borderRadius: BorderRadius.circular(10),

                ),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,
                      vertical: 10,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const RegularTextWidget(
                        text: 'Last update',
                        color: AppColors.blackAppColor,
                        fontWeight: FontWeight.w700,
                        size: 28,
                      ),
                      const SizedBox(height: 10,),
                      RegularTextWidget(
                        text: widget.currentLocation,
                        color: AppColors.blackAppColor,
                        size: 18,
                      ),
                      const SizedBox(height: 10,),
                      RegularTextWidget(
                        text: widget.streetName,
                        color: AppColors.blackAppColor,
                        size: 16,
                        fontWeight: FontWeight.w700,
                      ),
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
