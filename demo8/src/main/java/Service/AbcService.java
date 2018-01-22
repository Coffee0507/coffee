package Service;

import org.springframework.stereotype.Service;

import Interface.AbcInterface;

@Service
public class AbcService implements AbcInterface{

	@Override
	public void getRun() {
		String msg = "走る";
		System.out.println(msg);

	}

	@Override
	public void getJog() {
		String msg = "ジョギング";
		System.out.println(msg);
	}

	@Override
	public void getWalk() {
		String msg = "歩く";
		System.out.println(msg);
	}

}
