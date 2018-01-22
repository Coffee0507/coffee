package Service;

import InterFace.InterFace;

public class Service implements InterFace{

	@Override
	public void getAction(String name1, String name2) {
		System.out.println(name1+name2);
	}

}
