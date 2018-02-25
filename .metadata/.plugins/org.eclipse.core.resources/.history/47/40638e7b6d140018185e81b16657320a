
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Main main = new Main();
		main.solveD();
	}

	private void solveA() {
		Scanner sc = new Scanner(System.in);
		int N = sc.nextInt();
		int A = sc.nextInt();
		int B = sc.nextInt();

		int NA = N * A;

		if (NA > B) {
			System.out.println(B);
		} else {
			System.out.println(NA);
		}
	}

	private void solveB() {
		Scanner sc = new Scanner(System.in);

		String N = sc.nextLine();

		int iN = Integer.parseInt(N);

		String[] str = N.split("");

		int I = 0;
		for (int i = 0; i < str.length; i++) {
			int I2 = Integer.parseInt(str[i]);
			I += I2;
		}
		if (iN % I == 0) {
			System.out.println("Yes");
		} else if (iN % I != 0) {
			System.out.println("No");
		}

	}

	private void solveC() {
		Scanner sc = new Scanner(System.in);
		int N = sc.nextInt();
		int K = sc.nextInt();
		int X = sc.nextInt();
		int Y = sc.nextInt();

		int NX = N * X;
		int NKY = (N - K) * Y;

		if (N <= K) {
			System.out.println(NX);
		} else {
			System.out.println(K * X + (N - K) * Y);
		}
	}

	private void solveD() {
		Scanner sc = new Scanner(System.in);

		String W = sc.nextLine();
		String[] str = W.split("");

		String word = "abcdefghijklmnopqrstuvwxyz";
		String[] w = word.split("");

		int math = 0;

		for (int i = 0; i < w.length; i++) {
			for (int j = 0; j < str.length; j++) {
				if (w[i].equals(str[j])) {
					math++;
				}
			}
			if (math % 2 != 0) {
				break;
			}
		}
		if (math % 2 == 0) {
			System.out.println("Yes");
		}else{
			System.out.println("No");
		}

	}

	private void solveE() {
		Scanner sc = new Scanner(System.in);
		int N = sc.nextInt();
		System.out.println(N);
	}

	private void solveF() {
		Scanner sc = new Scanner(System.in);
		int N = sc.nextInt();
		System.out.println(N);
	}

}