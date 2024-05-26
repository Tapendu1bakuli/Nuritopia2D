import 'package:flutter/material.dart';
import 'package:get/get.dart';

showAlertDialogForLogOut() {
  Get.dialog(
          AlertDialog(
     insetPadding: EdgeInsets.only(left: 180, bottom: 50, right: 10),
    titlePadding: EdgeInsets.zero,
    contentPadding: EdgeInsets.zero,
    title: ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.primary.withOpacity(0.2),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 12,
              ),
              Container(
                height: 12,
              ),
              Text(
                "abcd",
                style: Get
                    .textTheme
                    .titleSmall!
                    .copyWith(fontFamily: "NunitoSansBold"),
                textAlign: TextAlign.center,
              ),
              Container(
                height: 12,
              ),
              Text(
                "abcd",
                style: Get
                    .textTheme
                    .labelSmall!
                    .copyWith(fontFamily: "NunitoSansBold"),
                textAlign: TextAlign.center,
              ),
              Container(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 24),
                    backgroundColor: Get.theme.colorScheme.primary),
                child: Text(
                  "Edit Profile",
                  style: Get.textTheme.labelLarge?.copyWith(
                    color: Get.theme.colorScheme.onPrimary,
                    fontFamily: "NunitoSansBold",
                  ),
                ),
              ),
              Container(
                height: 12,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Divider(color: Get.theme.colorScheme.outline),
              ),
              Container(
                height: 26,
              ),
              GestureDetector(
                onTap: (){
                  if(Get.isOverlaysOpen){
                    Get.back();
                    Get.back();
                  }else{
                    Get.back();

                  }

                },
                child: Text(
                  "Logout",
                  style: Get.textTheme.labelLarge?.copyWith(
                    color: Get.theme.colorScheme.primary,
                    fontFamily: "NunitoSansBold",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(height: 25,)
            ],
          ),
        ),
      ),
    ),
  ),
  );
}