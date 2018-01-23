package main;


import org.springframework.stereotype.Service;

@Service
public class ServiceA implements Inter {

	@Override
	public String getRun() {
		String run = "走る";
		System.out.println(run);
		return run;
	}

	@Override
	public String getWalk() {
		String walk = "歩く";
		System.out.println(walk);
		return walk;
	}

	@Override
	public String getJog() {
		String jog = "ジョギング";
		System.out.println(jog);
		return jog;
	}

}
