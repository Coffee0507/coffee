package object;

// interfaceを実装
public class Human implements HumanInterface {

	private String run;
	private String eat;
	private String sleep;

	@Override
	public void getRun() {
		 run = "走る";
		System.out.println(run);
		;
	}

	@Override
	public void getEat() {
		 eat = "食べる";
		System.out.println(eat);
	}

	@Override
	public void getSleep() {
		sleep = "寝る";
		System.out.println(sleep);
	}

}