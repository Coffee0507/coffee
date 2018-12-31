//package app.config;
//
//import java.io.IOException;
//
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import org.springframework.security.authentication.BadCredentialsException;
//import org.springframework.security.core.AuthenticationException;
//import org.springframework.security.web.authentication.AuthenticationFailureHandler;
//
////spring security の認証失敗時に呼ばれるハンドラクラス
//public class SampleAuthenticationFailureHandler implements AuthenticationFailureHandler{
//
//
//	@Override
//	public void onAuthenticationFailure(HttpServletRequest req, HttpServletResponse res, AuthenticationException exce
//			) throws IOException, ServletException{
//		String errorId = "";
//
//		if(exce instanceof BadCredentialsException) {
//			errorId = "ログイン認証の失敗: SampleAuthenticationFailurehandlerクラス";
//		}
//
//		res.sendRedirect(req.getContextPath() + "/" + req.getParameter("identifier") + "/index?error=" + errorId);
//	}
//
//
//
//}
