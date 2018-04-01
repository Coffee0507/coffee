package jp.ssie.syakyou.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import jp.ssie.syakyou.model.User;

@Repository
public interface UserRepository {
	public List<User> findById(String id);

}
