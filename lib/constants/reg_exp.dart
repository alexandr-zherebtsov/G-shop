import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

const String emailReg = r'^([a-z0-9_-]+\.)*[a-z0-9_-]+@[a-z0-9_-]+(\.[a-z0-9_-]+)*\.[a-z]{2,6}$';
const String phoneReg = r'^(\+?)((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}$';
const String numberReg = r'[0-9]';

final maskFormatter = MaskTextInputFormatter(mask: '+## (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});
