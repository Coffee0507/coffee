package beansample;

/**
 * ID処理クラス.
 */
public class IdProcessing {

	/**
	 * 指定されたIDに紐づくユーザ情報を返却します.
	 * @param id ID
	 * @return ユーザ情報
	 */
	public UserBean getUserData(String id) {
		UserBean user = null;

		// 引数のIDを判定
		if("web01".equals(id)) {
			// IDがweb01の場合
			// Beanに名前を設定
			String name = "Cartman Taro";
			// Beanに年齢を設定
			int age = 17;
			// 管理者権限を設定
			int auth = 1;

            user = new UserBean(id, name, age, auth);
		} else if ("web02".equals(id)) {
			// IDがweb02の場合
			// Beanに名前を設定
			String name = "Cartman Jiro";
			// Beanに年齢を設定
			int age = 10;
			// 一般権限を設定
			int auth = 0;

			user = new UserBean(id, name, age, auth);
		}
		return user;
	}
}