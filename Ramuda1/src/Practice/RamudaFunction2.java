package Practice;

import java.util.function.BiFunction;

public class RamudaFunction2 {

	public static void main(String[] args){

		BiFunction<Integer, Integer, Integer> adder = (a, b) -> {
			return a * b;
		};

		int result = adder.apply(1, 3);

		System.out.println(result);
	}

}

//adder.apply 必須