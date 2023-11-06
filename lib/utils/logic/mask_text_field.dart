import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppMask {
  static final maskCardFormatter = MaskTextInputFormatter(
      mask: '#### #### #### ####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  static final maskDateFormatter = MaskTextInputFormatter(
      mask: '##/##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  static final maskCvvFormatter = MaskTextInputFormatter(
      mask: '###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  static final maskVerificationCodeFormatter = MaskTextInputFormatter(
      mask: '####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  static final maskDatetimeFormatter = MaskTextInputFormatter(
      mask: '####-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  static final maskPhoneFormatter = MaskTextInputFormatter(
      mask: '(###)-###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
}
