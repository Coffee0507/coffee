package jp.ssie.helloworld.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import jp.ssie.helloworld.model.User;

@Repository
public interface UserRepository extends JpaRepository<User, String> {
	public List<User> findById(int id);
}
