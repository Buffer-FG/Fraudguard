// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';

// import '../../../core/app_export.dart';

// class LoginFormWidget extends StatefulWidget {
//   final Function(String email, String password, String role) onLogin;
//   final bool isLoading;

//   const LoginFormWidget({
//     Key? key,
//     required this.onLogin,
//     required this.isLoading,
//   }) : super(key: key);

//   @override
//   State<LoginFormWidget> createState() => _LoginFormWidgetState();
// }

// class _LoginFormWidgetState extends State<LoginFormWidget> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _isPasswordVisible = false;
//   String _selectedRole = 'Fraud Detection Officer';

//   final List<String> _roles = [
//     'Fraud Detection Officer',
//     'Bank Security Admin',
//     'Compliance Officer',
//   ];

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   bool get _isFormValid {
//     return _emailController.text.isNotEmpty &&
//         _passwordController.text.isNotEmpty &&
//         _emailController.text.contains('@') &&
//         _passwordController.text.length >= 6;
//   }

//   String? _validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Email is required';
//     }
//     if (!value.contains('@') || !value.contains('.')) {
//       return 'Please enter a valid email address';
//     }
//     return null;
//   }

//   String? _validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Password is required';
//     }
//     if (value.length < 6) {
//       return 'Password must be at least 6 characters';
//     }
//     return null;
//   }

//   void _handleLogin() {
//     if (_formKey.currentState!.validate() && _isFormValid) {
//       widget.onLogin(
//           _emailController.text, _passwordController.text, _selectedRole);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // Email/Username Field
//           TextFormField(
//             controller: _emailController,
//             keyboardType: TextInputType.emailAddress,
//             enabled: !widget.isLoading,
//             decoration: InputDecoration(
//               labelText: 'Email / Username',
//               hintText: 'Enter your email or username',
//               prefixIcon: Padding(
//                 padding: EdgeInsets.all(3.w),
//                 child: CustomIconWidget(
//                   iconName: 'person',
//                   color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
//                   size: 5.w,
//                 ),
//               ),
//             ),
//             validator: _validateEmail,
//             onChanged: (value) => setState(() {}),
//           ),

//           SizedBox(height: 2.h),

//           // Password Field
//           TextFormField(
//             controller: _passwordController,
//             obscureText: !_isPasswordVisible,
//             enabled: !widget.isLoading,
//             decoration: InputDecoration(
//               labelText: 'Password',
//               hintText: 'Enter your password',
//               prefixIcon: Padding(
//                 padding: EdgeInsets.all(3.w),
//                 child: CustomIconWidget(
//                   iconName: 'lock',
//                   color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
//                   size: 5.w,
//                 ),
//               ),
//               suffixIcon: IconButton(
//                 onPressed: widget.isLoading
//                     ? null
//                     : () {
//                         setState(() {
//                           _isPasswordVisible = !_isPasswordVisible;
//                         });
//                       },
//                 icon: CustomIconWidget(
//                   iconName:
//                       _isPasswordVisible ? 'visibility_off' : 'visibility',
//                   color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
//                   size: 5.w,
//                 ),
//               ),
//             ),
//             validator: _validatePassword,
//             onChanged: (value) => setState(() {}),
//           ),

//           SizedBox(height: 2.h),

//           // Role Selection Dropdown
//           DropdownButtonFormField<String>(
//             value: _selectedRole,
//             decoration: InputDecoration(
//               labelText: 'Role',
//               prefixIcon: Padding(
//                 padding: EdgeInsets.all(3.w),
//                 child: CustomIconWidget(
//                   iconName: 'badge',
//                   color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
//                   size: 5.w,
//                 ),
//               ),
//             ),
//             items: _roles.map((String role) {
//               return DropdownMenuItem<String>(
//                 value: role,
//                 child: Text(
//                   role,
//                   style: AppTheme.lightTheme.textTheme.bodyMedium,
//                 ),
//               );
//             }).toList(),
//             onChanged: widget.isLoading
//                 ? null
//                 : (String? newValue) {
//                     if (newValue != null) {
//                       setState(() {
//                         _selectedRole = newValue;
//                       });
//                     }
//                   },
//           ),

//           SizedBox(height: 1.h),

//           // Forgot Password Link
//           Align(
//             alignment: Alignment.centerRight,
//             child: TextButton(
//               onPressed: widget.isLoading
//                   ? null
//                   : () {
//                       // Handle forgot password
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content:
//                               Text('Password reset link sent to your email'),
//                         ),
//                       );
//                     },
//               child: Text(
//                 'Forgot Password?',
//                 style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
//                   color: AppTheme.lightTheme.colorScheme.primary,
//                 ),
//               ),
//             ),
//           ),

//           SizedBox(height: 3.h),

//           // Secure Login Button
//           SizedBox(
//             height: 6.h,
//             child: ElevatedButton(
//               onPressed:
//                   (_isFormValid && !widget.isLoading) ? _handleLogin : null,
//               child: widget.isLoading
//                   ? Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           width: 4.w,
//                           height: 4.w,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             valueColor: AlwaysStoppedAnimation<Color>(
//                               AppTheme.lightTheme.colorScheme.onPrimary,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 2.w),
//                         Text(
//                           'Authenticating...',
//                           style: AppTheme.lightTheme.textTheme.labelLarge
//                               ?.copyWith(
//                             color: AppTheme.lightTheme.colorScheme.onPrimary,
//                           ),
//                         ),
//                       ],
//                     )
//                   : Text(
//                       'Secure Login',
//                       style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
//                         color: AppTheme.lightTheme.colorScheme.onPrimary,
//                       ),
//                     ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
