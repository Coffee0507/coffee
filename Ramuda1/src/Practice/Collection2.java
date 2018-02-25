package Practice;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Collection2 {

	public static void main(String[] args) {

		int[] numbers = { -1, 1, 0, -3, 8 };

		List<Integer> numbersList = new ArrayList<>();

		for (int n : numbers) {
			numbersList.add(n);
		}

		Collections.sort(numbersList, (a, b) -> {
			return a*a * b*b;
		});

		System.out.println(numbersList + " ");

		for (Integer n : numbersList) {
			System.out.print(n + " ");
		}
		// -
	}
}