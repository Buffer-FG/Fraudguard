// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:sizer/sizer.dart';

// import '../../../core/app_export.dart';

// class TwoFactorAuthWidget extends StatefulWidget {
//   final Function(String code) onCodeSubmit;
//   final VoidCallback onCancel;
//   final VoidCallback onResendCode;

//   const TwoFactorAuthWidget({
//     Key? key,
//     required this.onCodeSubmit,
//     required this.onCancel,
//     required this.onResendCode,
//   }) : super(key: key);

//   @override
//   State<TwoFactorAuthWidget> createState() => _TwoFactorAuthWidgetState();
// }

// class _TwoFactorAuthWidgetState extends State<TwoFactorAuthWidget> {
//   final List<TextEditingController> _controllers =
//       List.generate(6, (index) => TextEditingController());
//   final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
//   bool _isLoading = false;
//   int _resendCountdown = 0;

//   @override
//   void initState() {
//     super.initState();
//     _startResendCountdown();
//   }

//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     for (var focusNode in _focusNodes) {
//       focusNode.dispose();
//     }
//     super.dispose();
//   }

//   void _startResendCountdown() {
//     setState(() {
//       _resendCountdown = 30;
//     });

//     Future.doWhile(() async {
//       await Future.delayed(const Duration(seconds: 1));
//       if (mounted) {
//         setState(() {
//           _resendCountdown--;
//         });
//         return _resendCountdown > 0;
//       }
//       return false;
//     });
//   }

//   void _onCodeChanged(String value, int index) {
//     if (value.isNotEmpty && index < 5) {
//       _focusNodes[index + 1].requestFocus();
//     }

//     // Check if all fields are filled
//     String code = _controllers.map((controller) => controller.text).join();
//     if (code.length == 6) {
//       _submitCode(code);
//     }
//   }

//   void _onBackspace(int index) {
//     if (index > 0 && _controllers[index].text.isEmpty) {
//       _focusNodes[index - 1].requestFocus();
//     }
//   }

//   void _submitCode(String code) {
//     setState(() {
//       _isLoading = true;
//     });

//     widget.onCodeSubmit(code);
//   }

//   void _clearFields() {
//     for (var controller in _controllers) {
//       controller.clear();
//     }
//     _focusNodes[0].requestFocus();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         padding: EdgeInsets.all(6.w),
//         decoration: BoxDecoration(
//             color: AppTheme.lightTheme.colorScheme.surface,
//             borderRadius:
//                 const BorderRadius.vertical(top: Radius.circular(24))),
//         child: Column(mainAxisSize: MainAxisSize.min, children: [
//           // Handle bar
//           Container(
//               width: 12.w,
//               height: 0.5.h,
//               decoration: BoxDecoration(
//                   color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
//                       .withValues(alpha: 0.3),
//                   borderRadius: BorderRadius.circular(2))),

//           SizedBox(height: 4.h),

//           // Security Icon
//           Container(
//               width: 16.w,
//               height: 16.w,
//               decoration: BoxDecoration(
//                   color: AppTheme.lightTheme.colorScheme.primary
//                       .withValues(alpha: 0.1),
//                   shape: BoxShape.circle),
//               child: Center(
//                   child: CustomIconWidget(
//                       iconName: 'security',
//                       color: AppTheme.lightTheme.colorScheme.primary,
//                       size: 8.w))),

//           SizedBox(height: 3.h),

//           // Title
//           Text('Two-Factor Authentication',
//               style: AppTheme.lightTheme.textTheme.headlineSmall
//                   ?.copyWith(fontWeight: FontWeight.w600),
//               textAlign: TextAlign.center),

//           SizedBox(height: 1.h),

//           // Description
//           Text('Enter the 6-digit code sent to your registered device',
//               style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
//                   color: AppTheme.lightTheme.colorScheme.onSurfaceVariant),
//               textAlign: TextAlign.center),

//           SizedBox(height: 4.h),

//           // Code Input Fields
//           Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: List.generate(6, (index) {
//                 return SizedBox(
//                     width: 12.w,
//                     height: 6.h,
//                     child: TextFormField(
//                         controller: _controllers[index],
//                         focusNode: _focusNodes[index],
//                         enabled: !_isLoading,
//                         textAlign: TextAlign.center,
//                         keyboardType: TextInputType.number,
//                         maxLength: 1,
//                         style: AppTheme.lightTheme.textTheme.headlineSmall
//                             ?.copyWith(fontWeight: FontWeight.w600),
//                         decoration: InputDecoration(
//                             counterText: '',
//                             contentPadding: EdgeInsets.zero,
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                                 borderSide: BorderSide(
//                                     color: AppTheme
//                                         .lightTheme.colorScheme.outline)),
//                             focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                                 borderSide: BorderSide(
//                                     color:
//                                         AppTheme.lightTheme.colorScheme.primary,
//                                     width: 2))),
//                         inputFormatters: [
//                           FilteringTextInputFormatter.digitsOnly,
//                         ],
//                         onChanged: (value) => _onCodeChanged(value, index),
//                         onTap: () {
//                           _controllers[index].selection =
//                               TextSelection.fromPosition(TextPosition(
//                                   offset: _controllers[index].text.length));
//                         }));
//               })),

//           SizedBox(height: 4.h),

//           // Resend Code
//           Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Text("Didn't receive the code? ",
//                 style: AppTheme.lightTheme.textTheme.bodyMedium),
//             TextButton(
//                 onPressed: (_resendCountdown == 0 && !_isLoading)
//                     ? () {
//                         widget.onResendCode();
//                         _startResendCountdown();
//                         _clearFields();
//                       }
//                     : null,
//                 child: Text(
//                     _resendCountdown > 0
//                         ? 'Resend in ${_resendCountdown}s'
//                         : 'Resend Code',
//                     style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
//                         color: _resendCountdown > 0
//                             ? AppTheme.lightTheme.colorScheme.onSurfaceVariant
//                             : AppTheme.lightTheme.colorScheme.primary))),
//           ]),

//           SizedBox(height: 2.h),

//           // Action Buttons
//           Row(children: [
//             Expanded(
//                 child: OutlinedButton(
//                     onPressed: _isLoading ? null : widget.onCancel,
//                     child: Text('Cancel'))),
//             SizedBox(width: 4.w),
//             Expanded(
//                 child: ElevatedButton(
//                     onPressed: _isLoading
//                         ? null
//                         : () {
//                             String code = _controllers
//                                 .map((controller) => controller.text)
//                                 .join();
//                             if (code.length == 6) {
//                               _submitCode(code);
//                             }
//                           },
//                     child: _isLoading
//                         ? SizedBox(
//                             width: 4.w,
//                             height: 4.w,
//                             child: CircularProgressIndicator(
//                                 strokeWidth: 2,
//                                 valueColor: AlwaysStoppedAnimation<Color>(
//                                     AppTheme.lightTheme.colorScheme.onPrimary)))
//                         : Text('Verify'))),
//           ]),

//           SizedBox(height: 2.h),
//         ]));
//   }
// }
