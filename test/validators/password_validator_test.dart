import 'package:flutter_test/flutter_test.dart';
import 'package:prescript/validators/password_validator.dart';

void main() {
  late PasswordValidator passwordValidator;

  setUp(() {
    passwordValidator = PasswordValidator();
  });

  group("Validação da Senha", () {
    test("deve retornar uma mensagem de erro caso a senha seja nula", () {
      final result = passwordValidator.validate(null);

      expect(result, "A Senha é obrigatória");
    });

    test("deve retornar uma mensagem de erro caso a senha seja vazia", () {
      final result = passwordValidator.validate('');

      expect(result, "A Senha é obrigatória");
    });

    test(
      "deve retornar uma mensagem de erro caso a senha seja menor que 6 caracteres",
      () {
        final result = passwordValidator.validate('ddddd');

        expect(result, "A Senha deve ter no mínimo 6 caracteres");
      },
    );
  });
}
