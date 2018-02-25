package Practice;

public class Ramuda {


	public static void main(String[] args){

		Runnable runner = () ->{
			System.out.println("helloworld");
		};

		runner.run();
	}
}
//最初の()はrunメソッドの引数を表し、->{}の中身はrunメソッドの実装内容になります。
//runner変数にはRunnableを実装した無名クラスのインスタンスが代入されます。
//つまり、ラムダ式とはインターフェースを実装したインスタンスを生成する式といえる。

//変数の型にインターフェースを指定することでラムダ式を受け取ることができる。