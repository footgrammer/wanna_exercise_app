class ValidatorUtil {
  String? loginValidatorPhone(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return "전화번호를 입력해 주세요";
    }
    if (value!.length < 10 || value.length > 11) {
      return "올바른 전화번호를 입력해 주세요";
    }
    return null;
  }

  String? loginValidatorPw(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return "비밀번호를 입력해 주세요";
    }
    if (value!.length < 6) {
      return "비밀번호는 6자 이상아어야 합니다.";
    }
    return null;
  }

  String? registerValidatorPhone(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return "전화번호를 입력해 주세요.";
    }
    if (value!.length > 11 ||
        value.length < 10 ||
        value[0] != '0' ||
        value[1] != '1') {
      return "올바른 전화번호를 입력해 주세요.";
    }
    return null;
  }

  String? registerValidatorPw(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return "비밀번호를 입력해 주세요.";
    }
    final reg = RegExp(r'(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9]+$');
    if (value!.length < 6 || !reg.hasMatch(value)) {
      return "영문자와 숫자를 포함하여 6자 이상 입력해 주세요.";
    }
    return null;
  }
}
