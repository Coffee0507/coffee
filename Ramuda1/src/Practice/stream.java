package Practice;

import java.util.ArrayList;
import java.util.List;

public class stream {

	public static void main(String[] args) {
		int[] numbers = { -1, 2, 0, 12, 17, 15, -3, 8 };

		List<Integer> numbersList = new ArrayList<Integer>();

		for (int n : numbers) {
			numbersList.add(n);
		}
		//
		// numbersList.stream().forEach((i) -> {
		// System.out.println(i + " ");
		// });
		//
		// numbersList.stream().filter((i) -> {
		// return i % 7 != 0;
		// }).forEach((i) -> {
		// System.out.println(i + " ");
		// });

		numbersList.stream().filter((i) -> {
			return i > 0;
		}).map((i) -> {
			return "*" + i + "*";
		}).forEach((s) -> {
			System.out.println(s + " ");
		});

		numbersList.stream().filter((i) -> {
			return i > 2;
		}).sorted((i1, i2) -> {
			return i1 - i2;
		}).map((i) -> {
			return "#" + i + "#";
		}).forEach((s) ->{
			System.out.println(s + ".");
		});

	}

}
