package com.internousdev.Action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.internousdev.Interface.AbcInterface;

@RestController
public class AbcAction {

	@Autowired
	AbcInterface abc;

	@RequestMapping("/yyy")
	public void AbcAction() {
		abc.getJog();
	}

}
