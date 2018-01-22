package spring;

public interface PasswordEncoder {
//	パスワードをハッシュ化する処理
	String encode(String rawPassword);

}
