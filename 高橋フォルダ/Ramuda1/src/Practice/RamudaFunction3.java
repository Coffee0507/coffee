package Practice;

import java.util.function.Consumer;

public class RamudaFunction3 {

	public static void main(String[] args){

		Consumer<String> buyer = (goods)->{
			System.out.println(goods + "を購入しました");
		};
		buyer.accept("a");
	}
}
