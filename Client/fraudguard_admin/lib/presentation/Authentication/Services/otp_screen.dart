import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../dashboard_screen/dashboard_screen.dart';

class OTPScreen extends StatefulWidget {
  final String verificationId;
  const OTPScreen({super.key, required this.verificationId});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();
  
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Image.asset("assets/images/otpimage.jpg"),
            const Text(
              "OTP Verification",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "You will receive a 6 digit code to verify your phone number",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: otpController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "+91 1234567890",
                  labelText: "Enter the Phone Number",
                ),
              ),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        final credential = PhoneAuthProvider.credential(
                          verificationId: widget.verificationId,
                          smsCode: otpController.text,
                        );
                        await FirebaseAuth.instance
                            .signInWithCredential(credential);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DashboardScreen(),
                          ),
                        );
                      } catch (e) {
                        print(e);
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: const Text(
                      "Verify",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}