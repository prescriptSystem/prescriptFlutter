class PasswordValidator {
  String? validate(String? senha) {
    if (senha == null || senha.isEmpty) {
      return "A Senha é obrigatória";
    } else if (senha.length < 6) {
      return "A Senha deve ter no mínimo 6 caracteres";
    }
  }
}
