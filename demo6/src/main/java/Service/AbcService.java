package Service;

import InterFace.AbcInterface;

public class AbcService implements AbcInterface{

	@Override
	public String getRun() {
		System.out.println("走る");;
		return null;
	}

	@Override
	public String getJog() {
		System.out.println("ジョギング");;
		return null;
	}

	@Override
	public String getWalk() {
		System.out.println("歩く");;
		return null;
	}


}
