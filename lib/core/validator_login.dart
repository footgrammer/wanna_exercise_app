// 로그인 시 유효성 검사
// 입력란 비어 있는지만 확인

class ValidatorLogin {
  String? validatorId(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return "아이디를 입력해 주세요";
    }
    return null;
  }

  String? validatorPw(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return "비밀번호를 입력해 주세요";
    }
    return null;
  }
}
