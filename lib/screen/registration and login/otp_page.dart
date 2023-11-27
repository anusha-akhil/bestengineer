import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/registrationController.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove("cid");
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 10),
            child: Row(
              children: [
                Text(
                  "Enter OTP :",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                )
              ],
            ),
          ),
          PinputExample(),
        ],
      ),
    );
  }
}

class PinputExample extends StatefulWidget {
  const PinputExample({Key? key}) : super(key: key);

  @override
  State<PinputExample> createState() => _PinputExampleState();
}

class _PinputExampleState extends State<PinputExample> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    /// Optionally you can use form to validate the Pinput
    return Form(
      key: formKey,
      child: Consumer<RegistrationController>(
        builder: (BuildContext context, RegistrationController value,
                Widget? child) =>
            Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Directionality(
              // Specify direction if desired
              textDirection: TextDirection.ltr,
              child: Pinput(
                controller: pinController,
                focusNode: focusNode,
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsUserConsentApi,
                listenForMultipleSmsOnAndroid: true,
                defaultPinTheme: defaultPinTheme,
                separatorBuilder: (index) => const SizedBox(width: 8),
                // validator: (value) {
                //   return value == '2222' ? null : 'Pin is incorrect';
                // },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {
                  debugPrint('onCompleted: $pin');
                },
                onChanged: (value) {
                  debugPrint('onChanged: $value');
                },
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      width: 22,
                      height: 1,
                      color: focusedBorderColor,
                    ),
                  ],
                ),
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Container(
              width: size.width * 0.4,
              height: size.height * 0.05,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    Provider.of<RegistrationController>(context, listen: false)
                        .otpValidation(pinController.text, context);
                  },
                  label: Text(
                    "SUBMIT",
                    style: GoogleFonts.aBeeZee(
                      textStyle: Theme.of(context).textTheme.bodyText2,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: P_Settings.whiteColor,
                    ),
                  ),
                  icon: value.isLoading
                      ? Container(
                          width: 24,
                          height: 24,
                          padding: const EdgeInsets.all(2.0),
                          child: CircularProgressIndicator(
                            color: P_Settings.whiteColor,
                            strokeWidth: 3,
                          ),
                        )
                      : Icon(
                          Icons.arrow_back,
                          color: P_Settings.whiteColor,
                        ),
                  style: ElevatedButton.styleFrom(
                    primary: P_Settings.loginPagetheme,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // <-- Radius
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
