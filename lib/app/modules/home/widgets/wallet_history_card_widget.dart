import 'package:flutter/material.dart';
import 'package:nuritopia2d/utils/utils.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/image_utils/image_utils.dart';

class WalletHistoryCardWidget extends StatelessWidget {
  WalletHistoryCardWidget(
      {Key? key,
      this.image,
      this.message,
      this.amount,
      this.createdAt,
      this.paymentStatus,
      this.status,
      this.transactionId,
      this.updatedAt})
      : super(key: key);
  String? image;
  String? message;
  String? transactionId;
  String? status;
  int? amount;
  String? createdAt;
  String? updatedAt;
  String? paymentStatus;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Row(
          children: [
            Container(
                height: 37,
                width: 37,
                // padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: CustomColor.primaryBlue),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    image ?? ImageUtils.payment,
                    color: CustomColor.white,
                  ),
                )),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        message!.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.textStyleRegular
                            .apply(fontSizeFactor: 0.8),
                      ),
                      Container(
                        width: 10,
                      ),
                      // Text(transactionId??"",
                      //     overflow: TextOverflow.ellipsis,
                      //     style: TextStyles.textStyleSemiBold
                      //         .apply(color: Colors.black)),
                      const Spacer(),
                      status != "debit"
                          ? const Icon(
                              Icons.add,
                              size: 15,
                              color: Colors.black,
                            )
                          : const Icon(
                              Icons.remove,
                              size: 15,
                              color: Colors.black,
                            ),
                      redHeartCurrency(
                        amount.toString(),
                        ImageUtils.whiteHeartImage,
                        TextStyles.drawerSubTitleBold
                            .copyWith(color: CustomColor.primaryBlack),
                      ),
                      // Text(
                      //   "$amount",
                      //   overflow: TextOverflow.ellipsis,
                      //   style: /*model.status.toLowerCase().trim() ==
                      //             "c"
                      //             ? */TextStyles.textStyleSemiBold
                      //       .apply(color: Colors.black),
                      //   // : TextStyles.textStyleSemiBold.apply(
                      //   // color: CustomColor.colorTextDebit),
                      // ),
                      // Text(" TOS",
                      //     overflow: TextOverflow.ellipsis,
                      //     style: /*model.status.toLowerCase().trim() ==
                      //               "c"
                      //               ? */TextStyles.textStyleSemiBold
                      //         .apply(color: Colors.black)
                      /*: TextStyles.textStyleSemiBold.apply(
                                    color: CustomColor.colorTextDebit)*/
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(createdAt ?? "",
                          style: TextStyles.textStyleRegular.apply(
                            fontSizeFactor: 0.9,
                          )),
                      const SizedBox(width: 4),
                      const Icon(Icons.circle, size: 5),
                      const SizedBox(width: 4),
                      Text(updatedAt ?? "",
                          style: TextStyles.textStyleRegular.apply(
                            fontSizeFactor: 0.9,
                          )),
                      const Spacer(),
                      Text(paymentStatus ?? "",
                          style: TextStyles.textStyleRegular
                              .apply(fontSizeFactor: 0.9, color: Colors.black))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
