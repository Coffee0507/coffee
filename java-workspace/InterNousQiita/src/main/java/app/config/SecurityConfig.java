//package app.config;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.http.HttpMethod;
//import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
//import org.springframework.security.config.annotation.web.builders.HttpSecurity;
//import org.springframework.security.config.annotation.web.builders.WebSecurity;
//import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
//import org.springframework.security.core.userdetails.UserDetailsService;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
//import org.springframework.security.web.authentication.logout.HttpStatusReturningLogoutSuccessHandler;
//import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
//
//@Configuration
//public class SecurityConfig extends WebSecurityConfigurerAdapter{
//
//	@Autowired
//	UserDetailsService userDetailService;
//
//	@Autowired
//	BCryptPasswordEncoder passwordEncoder;
//
//	private static final String REMEMBER_ME_KEY = "sampleRememberMeKey";
//
//	@Override
//	public void configure(WebSecurity web)throws Exception {
//		web.ignoring()                                     //無視する
//			.antMatchers("/css/**", "/img/**", "/js/**");  //静的コンテンツのアクセスは認証をかけないように設定する
//	}
//
//	@Override
//	protected void configure(AuthenticationManagerBuilder auth)throws Exception{
//		auth.userDetailsService(userDetailService)                     //UserDetailServiceインターフェースを実装した独自の認証レルムを使うようにする
//		.passwordEncoder(passwordEncoder);
//	}
//
//	@Override
//	protected void configure(HttpSecurity http)throws Exception{
//
////		省略？
//
//		String permittedUrls = null;
////			{
////				LOGIN_TIMEOUT_URL,
////				FORBIDDEN_URL,
////				ERROR_URL,
////				NOT_FOUND_URL,
////				RESET_PASSWORD_URL,
////				CHANGE_PASSWORD_URL
////		};
//
//		http.authorizeRequests()
//			.antMatchers(HttpMethod.POST).permitAll()                     //認証をかけないエンドポイントを明確に指定し、
//			.antMatchers("/developmentDiary/**").hasRole("ADMIN")          //
//			.anyRequest().authenticated()                                  //それ以外は認証がかかるようにする
//			.and()
//			.exceptionHandling()
//			.authenticationEntryPoint(null /** authenticationEntryPoint() */ )       //セッションタイムアウトした際にメッセージを表示する
//			.accessDeniedHandler(null /** accessDeniedhandler() */ );                //AuthenticationEntryPointを独自に実装して、それを使うように設定する
//
//		http.formLogin()                                                //WEBフォーム認証のパラメータ名や遷移先URLを設定する
//		//ログイン画面のURL
//		.loginPage("/developmentDiary/login")
//		//ログインIDのパラメータ名
//		.usernameParameter("id")
//		//ログインパスワードのパラメータ名
//		.passwordParameter("password")
//		//認可を処理するURL
//		.loginProcessingUrl("http://localhost:4200/developmentDiary")
//		//ログイン成功時の遷移先 フロントがangularなので不要
////		.successForwardUrl(null /** LOGIN_SUCCESS_URL */ )
//		//ログイン失敗時の遷移先 フロントがangularなので不要
////		.failureUrl(null /** LOGIN_FAILURE_URL */ )
//		.permitAll();
//
//		http.logout()                                                   //ログアウトしたときに、Cookieを削除するように設定する
//			.logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
//			//Cookieを破棄
//			.deleteCookies("SESSION", "JSESSIONID", null /** remenberMeCookieName */ )
//			//ログアウト画面のURL フロントがangularなので不要
////			.logoutUrl(null /** LOGOUT_URL */ )
//			//ログアウト後の遷移先 フロントがangularなので不要
////			.logoutSuccessUrl(null /** LOGOUT_SUCCESS_URL */ )
//			//ajaxの場合はHTTPステータスを返す
//			.defaultLogoutSuccessHandlerFor(new HttpStatusReturningLogoutSuccessHandler() , request -> "XMLHttpRequest".equals(request.getHeader("X-Requested-With")))
//			//セッションを破棄する
//			.invalidateHttpSession(true).permitAll();
//
//		http.rememberMe().key(REMEMBER_ME_KEY	)							//自動ログインの為に、RememberMeの設定をする
//																			//固定値なら何でも良い(デフォルトだと自動生成の為起動するたびに変更されるので指定する必要がある)
//			.rememberMeServices(null /** multiDeviceRememberMeServices() */ );
//	}
//
////	@Bean
////	public AccessDeniedHandler accessDeniedHandler() {
////		return new DefaultAccessDeniedHandler();
////	}
////
////	@Bean
////	public AuthenticationEntryPoint authenticationEntryPoint() {
////		return new DefaultAuthenticationEntryPoint(LOGIN_URL, LOGIN_TIMEOUT_URL);
////	}
//}
