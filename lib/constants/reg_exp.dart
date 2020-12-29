import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final String emailReg = r'^([a-z0-9_-]+\.)*[a-z0-9_-]+@[a-z0-9_-]+(\.[a-z0-9_-]+)*\.[a-z]{2,6}$';
final String phoneReg = r'^(\+?)((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}$';

var maskFormatter = MaskTextInputFormatter(mask: '+## (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});