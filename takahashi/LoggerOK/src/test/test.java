package test;

import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.logging.StreamHandler;

public class test {

	static final Logger logger = Logger.getLogger(test.class.getName());

	public static void main(String[] args) {

		//		標準出力について
		System.out.println("ここから");

		Logger logger = Logger.getLogger(Logger.GLOBAL_LOGGER_NAME);
		logger.addHandler(new StreamHandler(){
			{
				setOutputStream(System.out);
				setLevel(Level.ALL);
			}
		});

		//		true→ログ出力のみ(赤文字無し)　false→ログ出力と標準出力
		logger.setUseParentHandlers(true);
		logger.info("Loggerテスト レベルInfo");
		logger.severe("Loggerテスト レベルsevere");

		System.out.println("ここまで");



		System.out.println("--------------------------------------------------------------------");


		//		エラーログの吐き方について
		System.out.println("ここから");
		String a = "a";
		try {
			Class.forName(a);
		} catch (ClassNotFoundException e) {
			logger.info("クラスファイルの発見ができなかった");
			System.out.println("--------------------------------------------------------------------");
		}


		System.out.println("ここまで");


		System.out.println("--------------------------------------------------------------------");


		//		ログレベルの変更について
		System.out.println("ここから");
		//		logger.addHandler(new StreamHandler() {
		//			{
		//				setOutputStream(System.out);
		//				setLevel(Level.ALL);
		//			}
		//		});		上記で記載しているのでここでは必要なし
		logger.setLevel(Level.ALL);

		logger.finest("Loggerテストだよ。→finest");
		logger.finer("Loggerテストだよ。→finer");
		logger.fine("Loggerテストだよ。→fine");
		logger.config("Loggerテストだよ。→config");
		logger.info("Loggerテストだよ。→info");
		logger.warning("Loggerテストだよ。→warning");
		logger.severe("Loggerテストだよ。→severe");
		//		Handlerとloggerの両表にLevel.Allを設定したときのみ全出力可能。
		//		そうしない場合、config以下は出力されない

		System.out.println("ここまで");
		System.out.println("--------------------------------------------------------------------");

		System.out.println("ここから");

	}



}