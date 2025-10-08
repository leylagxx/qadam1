import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

/// OTP input widget for entering verification codes
class OtpInput extends StatefulWidget {
  /// Number of OTP digits
  final int length;
  
  /// Callback when OTP changes
  final ValueChanged<String>? onChanged;
  
  /// Callback when OTP is completed
  final ValueChanged<String>? onCompleted;
  
  /// Initial OTP value
  final String? initialValue;
  
  /// Whether the input is enabled
  final bool enabled;
  
  /// Whether to auto-focus the first field
  final bool autoFocus;

  const OtpInput({
    super.key,
    this.length = 5,
    this.onChanged,
    this.onCompleted,
    this.initialValue,
    this.enabled = true,
    this.autoFocus = true,
  });

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  String _currentCode = '';

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.length,
      (index) => TextEditingController(),
    );
    _focusNodes = List.generate(
      widget.length,
      (index) => FocusNode(),
    );
    
    if (widget.initialValue != null) {
      _currentCode = widget.initialValue!;
      for (int i = 0; i < widget.initialValue!.length && i < widget.length; i++) {
        _controllers[i].text = widget.initialValue![i];
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  /// Handle text change in OTP field
  void _onTextChanged(int index, String value) {
    if (value.length > 1) {
      // Handle paste operation
      _handlePaste(index, value);
    } else {
      // Handle single character input
      _handleSingleInput(index, value);
    }
    
    // Count only non-empty characters
    final filledDigits = _currentCode.replaceAll(' ', '').length;
    
    widget.onChanged?.call(_currentCode);
    
    if (filledDigits == widget.length) {
      widget.onCompleted?.call(_currentCode);
    }
  }

  /// Handle paste operation
  void _handlePaste(int index, String value) {
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    
    for (int i = 0; i < digitsOnly.length && index + i < widget.length; i++) {
      _controllers[index + i].text = digitsOnly[i];
      _updateCurrentCode(index + i, digitsOnly[i]);
    }
    
    // Focus the next empty field or the last field
    final nextIndex = (index + digitsOnly.length).clamp(0, widget.length - 1);
    _focusNodes[nextIndex].requestFocus();
  }

  /// Handle single character input
  void _handleSingleInput(int index, String value) {
    _updateCurrentCode(index, value);
    
    if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty) {
      // Handle backspace - clear current field and move to previous
      _updateCurrentCode(index, '');
    }
  }

  /// Update current code string
  void _updateCurrentCode(int index, String value) {
    // Create a list of characters for easier manipulation
    List<String> codeList = _currentCode.split('');
    
    // Ensure the list is long enough
    while (codeList.length <= index) {
      codeList.add('');
    }
    
    // Update the character at the specific index
    codeList[index] = value;
    
    // Rebuild the current code string
    _currentCode = codeList.join('');
    
    // Remove any trailing empty characters
    _currentCode = _currentCode.replaceAll(RegExp(r'$'), '').trim();
  }

  /// Handle backspace
  void _onBackspace(int index) {
    if (_controllers[index].text.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        widget.length,
        (index) => SizedBox(
          width: 50.w,
          height: 50.w,
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(1),
            ],
            style: AppTypography.bodyLarge.copyWith(
              color: colorScheme.onSurface,
            ),
            enabled: widget.enabled,
            autofocus: widget.autoFocus && index == 0,
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: colorScheme.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) => _onTextChanged(index, value),
            onSubmitted: (value) => _onBackspace(index),
          ),
        ),
      ),
    );
  }
}
