package beansample;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * MVCモデルクラス.
 * C（コントローラ）
 */
@WebServlet("/ControllerServlet")
public class ControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * コンストラクタ.
	 */
	public ControllerServlet() {
		super();
	}

	/**
	 * POSTメソッドでリクエストされた場合の処理.
	 * @param request
	 * @param response
	 * @throws javax.servlet.ServletException
	 * @throws java.io.IOException
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// ID入力画面で入力されたIDを取得
		String id = request.getParameter("id");

		// IDに紐づくユーザ情報をモデルに格納するために指示
		// ID処理クラスをインスタンス化
		IdProcessing ip = new IdProcessing();
		// ID処理クラスにIDを渡してユーザ情報をモデルに格納
		UserBean bean = ip.getUserData(id);

		// ビューに画面を表示させるための準備
		RequestDispatcher rd;



		// モデルの情報を判定
		if (bean != null) {
			// モデルの情報が存在する場合
			// setAttributeメソッドを使ってモデルの情報をセット
			request.setAttribute("user", bean);
			// つぎに表示させる画面（ビュー）を指定
			rd = request.getRequestDispatcher("/beansample/WebContent/userResponse.jsp");
		} else {
			// モデルの情報が存在しない（IDに紐づくユーザ情報がない）場合
			// エラー画面へ
			rd = request.getRequestDispatcher("/beansample/WebContent/userError.jsp");
		}

		// ③-2 つぎの画面を表示
		rd.forward(request, response);
	}
}