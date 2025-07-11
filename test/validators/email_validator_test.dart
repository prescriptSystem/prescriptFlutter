import 'package:flutter_test/flutter_test.dart';
import 'package:prescript/validators/email_validator.dart';

void main() {
  late EmailValidator emailValidator;

  setUp(() {
    emailValidator = EmailValidator();
  });

  group("Validação do E-mail", () {
    test("deve retornar uma mensagem de erro caso o e-mail seja nulo", () {
      final result = emailValidator.validate(null);
      expect(result, equals('O E-mail é obrigatório'));
    });

    test("deve retornar uma mensagem de erro caso o e-mail seja vazio", () {
      final result = emailValidator.validate('');
      expect(result, equals('O E-mail é obrigatório'));
    });

    test("deve retornar uma mensagem de erro caso o e-mail seja inválido", () {
      final result = emailValidator.validate('victor');
      expect(result, equals('O E-mail é inválido'));
    });

    test("deve retornar nulo caso o e-mail seja válido", () {
      final result = emailValidator.validate('victor@gmail.com');
      expect(result, isNull);
    });
  });
}
