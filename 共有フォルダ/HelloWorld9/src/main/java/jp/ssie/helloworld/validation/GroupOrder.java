package jp.ssie.helloworld.validation;

import javax.validation.GroupSequence;

@GroupSequence({GroupOrder1.class, GroupOrder2.class,GroupOrder3.class})
public interface GroupOrder {

}