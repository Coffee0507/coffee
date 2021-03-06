package sample.project.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import sample.project.entity.UserInfo;

@Repository
public interface UserInfoRepository extends JpaRepository<UserInfo, Integer>{

	@Query(value = "SELECT e.id, e.name, e.password FROM user_info e WHERE e.id = :id and e.password = :password and e.name = :name", nativeQuery=true)
	public List<UserInfo> login(@Param("id")int id, @Param("name")String name, @Param("password")String password);

}
