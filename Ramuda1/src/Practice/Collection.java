package Practice;

import java.util.ArrayList;
import java.util.Collections;

public class Collection {

	public static void main(String[] args) {

		int[] n = {2,5,6,9,14};

		ArrayList<Integer> N = new ArrayList<>();

		for(int n2 : n){
			N.add(n2);
		}

		Collections.sort(N,(a,b) ->{
			return a+b;
		});

for(Integer N2 : N){
	System.out.println(N2+" ");
}








//		String[] str = {"2","a","13","4b"};
//
//		ArrayList<String> str2 = new ArrayList<>();
//
//		for(String s : str){
//			str2.add(s);
//		}
//
//		str2.sort(Comparator.naturalOrder());
//
//		System.out.println(str2);
//
//		str2.sort(Comparator.reverseOrder());
//
//		System.out.print(str2);
//
//
//		int[] i = {9,15,8,2};
//
//		ArrayList<Integer> i2 = new ArrayList<>();
//
//		for(int i3 : i){
//			i2.add(i3);
//		}
//
//		i2.sort(Comparator.naturalOrder());
//		System.out.println(i2);
//
//		i2.sort(Comparator.reverseOrder());
//		System.out.print(i2);
//

	}

}