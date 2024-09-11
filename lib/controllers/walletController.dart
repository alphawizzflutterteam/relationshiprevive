import 'package:AstroGuru/model/amount_model.dart';
import 'package:get/get.dart';
import 'package:AstroGuru/utils/global.dart' as global;

import '../utils/services/api_helper.dart';

class WalletController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAmount();
  }

  APIHelper apiHelper = APIHelper();
  List payment = [
    '50',
    '100',
    '200',
    '300',
    '500',
    '1000',
    '2000',
    '3000',
    '4000',
    '8000',
    '15000',
    '20000',
    '50000',
    '100000'
  ];
  List rechrage = ['50', '100', '200', '300', '500', '1000', '2000', '3000'];

  var paymentAmount = <AmountModel>[];

  late final List<AmountModel> tempPaymentAmount;

  bool isChashbackMsg = true;
  bool isWallet = false;

  updateChashbackStatus() {
    isChashbackMsg = false;
    update();
  }

  updateWallet() {
    isWallet = !isWallet;
    update();
  }

  subUpdateAmount(int amount, int index) {
    if (paymentAmount[index].amount! > tempPaymentAmount[index].amount!)
      paymentAmount[index].amount =
          (paymentAmount[index].amount! - tempPaymentAmount[index].amount!);
    update();
  }

  addUpdateAmount(int amount, int index) {
    paymentAmount[index].amount =
        (paymentAmount[index].amount! + tempPaymentAmount[index].amount!);
    update();
  }

  getAmount() async {
    try {
      await global.checkBody().then((result) async {
        if (result) {
          await apiHelper.getpaymentAmount().then((result) {
            if (result.status == "200") {
              paymentAmount = result.recordList;
              tempPaymentAmount = result.recordList;

              payment.clear();
              rechrage.clear();
              //  tempPaymentAmount.clear();
              for (int i = 0; i < paymentAmount.length; i++) {
                payment.add(paymentAmount[i].amount.toString());
                rechrage.add(paymentAmount[i].amount.toString());
                // tempPaymentAmount.add(paymentAmount[i]);
              }
              update();
            } else {
              global.showToast(
                message: 'Failed to get amount',
                textColor: global.textColor,
                bgColor: global.toastBackGoundColor,
              );
            }
          });
        }
      });
    } catch (e) {
      print("Exception in  getAmount:-" + e.toString());
    }
  }
}
