class Member {
  // 불변객체로 만들기 위해서 final을 사용
  // 멤버변수
  final int? mno;
  final String userid;
  final String password;
  final String email;
  final String name;
  final String? regdate;

  // 생성자로 객체 생성시 필수 항목 : 아이디/비밀번호/이메일/이름
  Member({this.mno, required this.userid,
    required this.password, required this.email,
    required this.name, this.regdate});

  @override
  String toString() {
    return 'Member{mno: $mno, userid: $userid, '
        'password: $password, email: $email, '
        'name: $name, regdate: $regdate}';
  }

  // Member객체를 Map으로 변환하는 메서드 (DB저장용)
  Map<String, dynamic> toMap() {

    return {
      'userid': userid,
      'password': password,
      'email': email,
      'name': name,
    };
  }

  // Map을 Member 객체로 변환 (DB 조회용)
  factory Member.fromMap(Map<String, dynamic> Map) {
    return Member(
      mno: Map['mno'],
      userid: Map['userid'],
      password: Map['password'],
      email: Map['email'],
      name: Map['name'],
      regdate: Map['regdate']
    );
  }
}
