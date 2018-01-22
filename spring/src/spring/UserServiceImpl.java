package spring;

public class UserServiceImpl implements UserService {
	private final UserRepository userRepository;
	private final PasswordEncoder passwordEncoder;

	public UserServiceImpl(javax.sql.DataSource dataSource){
//		データベース上のユーザー情報を操作する実装クラス
		this.userRepository = new JdbcUserRepository(dataSource);
//		BCryptアルゴリズムでハッシュ化する実装クラス
		this.passwordEncoder = new BCryptPasswordEncoder;
	}

	public void register(User user, String rawPassword) {
		if (this.userRepository.countByUsername(user.getUsername()) > 0) {
//		ユーザー名がすでに使用されていたら例外をスローする
			throw new UserAlreadyRegisteredException();
		}
//		生パスワードをハッシュ化して設定
		user.setPassword(this.passwordEncoder.encode(rawPassword));
		this.userRepository.save(user);
	}

}
