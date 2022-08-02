import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

MaskTextInputFormatter phoneMask = new MaskTextInputFormatter(mask: '(##) # ####-####', filter: {"#": RegExp(r'[0-9]')});

MaskTextInputFormatter zipMask = new MaskTextInputFormatter(mask: '##.###-###', filter: {"#": RegExp(r'[0-9]')});

MaskTextInputFormatter cpfMask = new MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});

MaskTextInputFormatter monthYearMask = new MaskTextInputFormatter(mask: '##/####', filter: {"#": RegExp(r'[0-9]')});
