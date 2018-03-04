package Practice;

public class Ramuda2 {

	public static void main(String[] args) {
		method(() -> {
			System.out.println("hello");
		});
	}

	public static void method(Runnable r) {
		r.run();
	}
}

//Runnableインターフェースでは引数無し、戻り値無しのラムダ式しか作成できない
//他の形で作成したい場合は、関数型インターフェースというものがあるので、そちらを利用する。
//

