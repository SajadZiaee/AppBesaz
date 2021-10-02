import 'package:appbesaz/modules/UserAccountModule/%20entities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zarinpal/zarinpal.dart';

/// [planId] is the id of requested plan.
/// if payment was successful, plan must be activated for [thisUser].

class ZarinPalTest extends StatefulWidget {
  int planId;
  ZarinPalTest({required this.planId});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ZarinPalTestState();
  }
}

class ZarinPalTestState extends State<ZarinPalTest> {
  PaymentRequest _paymentRequest = PaymentRequest()
    ..setIsSandBox(
        true) // if your application is in developer mode, then set the sandBox as True otherwise set sandBox as false
    ..setMerchantID("123456789123456789123456789123456789")
    ..setCallbackURL("callBackURL");

  void pay() {
    _paymentRequest.setAuthority('Ali');
    ZarinPal().startPayment(_paymentRequest,
        (int? status, String? paymentGatewayUri) {
      if (status == 100) {
        var _paymentUrl = paymentGatewayUri; // launch URL in browser
        launch(_paymentUrl!);
      } else {
        // problem.
        print('problem occured');
      }
    });
  }

  void verify() {
    print(_paymentRequest.getVerificationPaymentURL());
    ZarinPal().verificationPayment("OK", "Ali", _paymentRequest,
        (isPaymentSuccess, refID, paymentRequest) {
      if (!isPaymentSuccess) {
        int roleId = Plan.findPlanById(widget.planId)!.roleId;
        int daysPurchased = Plan.findPlanById(widget.planId)!.days;
        thisUser.purchase(roleId, daysPurchased);
        print('payment was successful, role changed');
      } else {
        // payment was unsuccessful.
        print('payment was unsuccessful');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool clicked = true;
    // TODO: implement build
    _paymentRequest.setAmount(Plan.findPlanById(widget.planId)!.amount);
    _paymentRequest
        .setDescription(Plan.findPlanById(widget.planId)!.description);
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            child: Text('پرداخت کن'),
            onPressed: () {
              setState(() {
                clicked = true;
              });
              pay();
            },
          ),
          (clicked)
              ? ElevatedButton(
                  onPressed: () {
                    verify();
                    Navigator.pop(context);
                  },
                  child: Text('در صورت پرداخت موفق کلیک کنید'))
              : Container(),
        ]),
      ),
    );
  }
}
