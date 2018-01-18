package com.internous.service;

import com.internous.Interface.TotalPriceInterface;

public class TotalPriceService implements TotalPriceInterface {

	@Override
	public void getAddition(int numberA,int numberB) {
		int total = numberA + numberB;
		System.out.println(total);
	}

	@Override
	public void getSubtraction(int numberA,int numberB) {
		int total = numberA - numberB;
		System.out.println(total);

	}

	@Override
	public void getMultiplication(int numberA,int numberB) {
		int total = numberA * numberB;
		System.out.println(total);

	}

	@Override
	public void getDivision(int numberA,int numberB) {
		int total = numberA / numberB;
		System.out.println(total);

	}

	@Override
	public void getRemainder(int numberA,int numberB) {
		int total = numberA % numberB;
		System.out.println(total);

	}

}
