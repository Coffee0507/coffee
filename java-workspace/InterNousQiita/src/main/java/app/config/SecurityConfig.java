//package app.config;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
//import org.springframework.security.config.annotation.authentication.configuration.GlobalAuthenticationConfigurerAdapter;
//import org.springframework.security.config.annotation.web.builders.HttpSecurity;
//import org.springframework.security.config.annotation.web.builders.WebSecurity;
//import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
//import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
//import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
//
//@Configuration
//@EnableWebSecurity  //spring securityが提供しているコンフィギュレーションクラスがインポートされ、spring securityを利用するために必要なコンポーネントのBean定義が自動で行われる
//public class SecurityConfig extends WebSecurityConfigurerAdapter{
//
//	@Override
//	public void  configure(WebSecurity web) throws Exception{
//
//		//静的リソースに対するセキュリティ。今は未設定。
//		web.ignoring()
//			.antMatchers(
////				"/images/**",
////				"/css/**",
////				"/javascript/**",
////				"/webjar/**"
//				);
//
//	}
//
//	@Override
//	protected void configure(HttpSecurity http)throws Exception{
//
//		//認可設定  アプリケーションが提供するリソースや処理に対するアクセスを制御する機能を提供する
//		http.authorizeRequests()
//		.antMatchers("/", "/index", "/developmentDiary/**").permitAll() //index(初期画面)は全ユーザーアクセス許可
//		.anyRequest().authenticated();         //それ以外は全て認証無しの場合アクセス不可
//
//		//ログイン設定
//		http.formLogin()
//			.loginProcessingUrl("login")                                //認証処理のパス
////			.loginPage("/index")                                        //ログインフォームのパス
//			.failureHandler(new SampleAuthenticationFailureHandler())  //認証失敗時に呼ばれるハンドリング
////			.defaultSuccessUrl("/menu")                                 //認証成功時の遷移先
//			.usernameParameter("login_id")                              //ユーザーId
//			.passwordParameter("login_password")                        //パスワードのパラメータ名
//			.and();
//
//		//ログアウト設定
//		http.logout()
//			.logoutRequestMatcher(new AntPathRequestMatcher("/logout/**")) //ログアウト処理のパス
//			.logoutSuccessUrl("/index");                                   //ログアウト完了時のパス
//
//
//	}
//
//	@Configuration
//	protected static class AuthenticationConfiguration extends GlobalAuthenticationConfigurerAdapter{
//
//		@Autowired
//		UserDetailsServiceImpl userDetailService;
//
//		@Override
//		public void init(AuthenticationManagerBuilder auth) throws Exception{
//			auth.userDetailsService(userDetailsService)
//
//			.passwordEbcoder(new BCryptPasswordEncoder());
//		}
//	}
//
//}
