import 'package:form_field_validator/form_field_validator.dart';

class Validators {
  /// Email Validator
  static final email = EmailValidator(errorText: 'Masukkan email yang valid');

  /// Password Validator
  static final password = MultiValidator([
    RequiredValidator(errorText: 'Password harus diisi'),
  ]);

  /// Required Validator with Optional Field Name
  static RequiredValidator requiredWithFieldName(String? fieldName) =>
      RequiredValidator(errorText: '${fieldName ?? 'Field'} is required');

  /// Plain Required Validator
  static final required = RequiredValidator(errorText: 'Field is required');
}
