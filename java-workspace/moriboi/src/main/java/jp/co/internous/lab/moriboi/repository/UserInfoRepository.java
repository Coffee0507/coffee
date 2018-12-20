package jp.co.internous.lab.moriboi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import jp.co.internous.lab.moriboi.entity.UserInfoEntity;

@Repository
public interface UserInfoRepository extends JpaRepository<UserInfoEntity, Integer> {
	
	public List<UserInfoEntity> findByLoginIdAndLoginPassword(String loginId, String loginPassword);

}
