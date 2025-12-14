import 'package:dalil_2020_app/core/validators/app_validators.dart';
import 'package:flutter/material.dart';
import '../../core/app_assets.dart';
import '../../core/shared/widgets/custom_field_text.dart';

// class PasswordStrengthWidget extends StatelessWidget {
//   const PasswordStrengthWidget(
//       {super.key,
//       this.checkStrength = false,
//       required this.controller,
//       this.validator,
//       required this.cubit,
//       this.errorText,
//       required this.isRequired,
//       this.label,
//       this.color});
//   final bool checkStrength;
//   final TextEditingController controller;
//   final String? Function(String?)? validator;
//   final String? errorText;
//   final cubit;
//   final bool isRequired;
//   final String? label;
//   final Color? color;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomFieldText(
//           iconColor: color,
//           labelText: label,
//           isRequired: isRequired,
//           errorText: errorText,
//           validator: (value) {
//             if (validator != null) {
//               return validator!(value);
//             } else {
//               return AppValidators.required(value);
//             }
//           },
//           onChanged: (p0) {
//             p0 = cubit.passwordController.text;
//             cubit.checkPasswordStrength(p0);
//           },
//           obscureText: cubit.obscurePassword,
//           iconStart: AppIcons.password,
//           iconEnd:
//               cubit.obscurePassword ? AppIcons.eyeClosed : AppIcons.eyeOpen,
//           keyboardType: TextInputType.visiblePassword,
//           iconEndTap: () => cubit.updateObscurePassword(),
//           controller: controller,
//         ),
//         checkStrength == true
//             ? Padding(
//                 padding: const EdgeInsets.only(right: 170, left: 10),
//                 child: LinearProgressIndicator(
//                   value: cubit.passStrength,
//                   backgroundColor: Colors.red,
//                   valueColor:
//                       AlwaysStoppedAnimation<Color>(cubit.strengthColor),
//                 ),
//               )
//             : const SizedBox()
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../core/app_assets.dart';
import '../../core/shared/widgets/custom_field_text.dart';
import '../../core/validators/app_validators.dart';

class PasswordStrengthWidget extends StatefulWidget {
  const PasswordStrengthWidget({
    super.key,
    this.checkStrength = false,
    required this.controller,
    this.validator,
    required this.cubit,
    this.errorText,
    required this.isRequired,
    this.label,
    this.color,
  });

  final bool checkStrength;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? errorText;
  final cubit;
  final bool isRequired;
  final String? label;
  final Color? color;

  @override
  State<PasswordStrengthWidget> createState() => _PasswordStrengthWidgetState();
}

class _PasswordStrengthWidgetState extends State<PasswordStrengthWidget> {
  bool _obscure = true; // 🔥 PER FIELD STATE

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomFieldText(
          controller: widget.controller,
          obscureText: _obscure,
          labelText: widget.label,
          isRequired: widget.isRequired,
          errorText: widget.errorText,
          iconColor: widget.color,
          iconStart: AppIcons.password,
          iconEnd: _obscure ? AppIcons.eyeClosed : AppIcons.eyeOpen,
          iconEndTap: () {
            setState(() {
              _obscure = !_obscure;
            });
          },
          keyboardType: TextInputType.visiblePassword,
          validator: widget.validator ?? AppValidators.required,
          onChanged: (value) {
            if (widget.checkStrength) {
              widget.cubit.checkPasswordStrength(value);
            }
          },
        ),
        if (widget.checkStrength)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 10, right: 170),
            child: LinearProgressIndicator(
              value: widget.cubit.passStrength,
              backgroundColor: Colors.red.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                widget.cubit.strengthColor,
              ),
            ),
          ),
      ],
    );
  }
}
