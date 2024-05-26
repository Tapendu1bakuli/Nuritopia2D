import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuritopia2d/app/modules/wallet/controller/wallet_controller.dart';
import 'package:nuritopia2d/utils/text_utils/app_strings.dart';
import '../../../../common/widgets/Loader.dart';
import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/image_utils/image_utils.dart';
import '../../../../utils/utils.dart';
import '../../home/controller/home_controller.dart';
import '../../home/widgets/wallet_history_card_widget.dart';

class WalletHistoryView extends StatelessWidget {
  WalletHistoryView({Key? key}) : super(key: key);
  WalletController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetX<WalletController>(initState: (state) {
      Future.delayed(const Duration(milliseconds: 200), () async {
        await controller.getTransactionHistory(controller.currentPage);
      });
    }, builder: (_) {
      return Scaffold(
        backgroundColor: CustomColor.fillOffWhiteColor,
        body: Stack(
          children: [
            controller.transactionList.isNotEmpty
                ? ListView.builder(
                    controller: controller.scrollControllerForWalletHistory,
                    shrinkWrap: true,
                    itemCount: controller.transactionList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return WalletHistoryCardWidget(
                        image:
                            controller.transactionList[index].message == "topup"
                                ? ImageUtils.payment
                                : controller.transactionList[index].message!
                                            .toUpperCase() ==
                                        "VOTE"
                                    ? ImageUtils.voteIcon
                                    : ImageUtils.wallet,
                        message: controller.transactionList[index].message,
                        transactionId:
                            controller.transactionList[index].transactionId,
                        status: controller.transactionList[index].status,
                        amount: controller.transactionList[index].amount,
                        createdAt: formatDate(
                            controller.transactionList[index].createdAt ?? ""),
                        updatedAt: formatDate(
                            controller.transactionList[index].updatedAt ?? ""),
                        paymentStatus:
                            controller.transactionList[index].paymentStatus,
                      );
                    })
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  ScreenConstant.defaultHeightTwentyThree),
                          height: ScreenConstant.screenHeightEighth,
                          decoration: BoxDecoration(
                              color: CustomColor.fillOffWhiteColor),
                          child: Image.asset(
                            ImageUtils.deleteIcon,
                            color: CustomColor.primaryBlue,
                          ),
                        ),
                        Text(
                          AppStrings.empty,
                          style: TextStyles.hintTextStyle,
                        ),
                      ],
                    ),
                  ),
            Visibility(
              child: Loader(
                text: "",
              ),
              visible: controller.isLoading.value,
            )
          ],
        ),
      );
    });
  }
}
