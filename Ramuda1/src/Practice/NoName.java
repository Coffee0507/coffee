package Practice;

public class NoName {

	public static void main(String[] args) {

		Runnable runner = new Runnable() {
			public void run() {
				System.out.println("Hello world");
			}
		};

		runner.run();
	}
}
// Runnableインターフェースのインスタンスを生成しているように見えるが
// 実際にはRunnableインターフェースを実装した無名クラスのインスタンスを生成している