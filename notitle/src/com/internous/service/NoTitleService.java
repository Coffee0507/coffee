package com.internous.service;

import com.internous.interfice.NoTitleInterfice;

public class NoTitleService implements NoTitleInterfice{


	@Override
	public void getInfo(String name1, String name2, int number1, int number2) {
		System.out.println(name1+name2+"さん"+number1+number2);
	}

	@Override
	public void getInfo2(String name1, String name2, int number3, int number4) {
		System.out.println(name1+""+name2+"さん"+(number3-number4));
	}
}
