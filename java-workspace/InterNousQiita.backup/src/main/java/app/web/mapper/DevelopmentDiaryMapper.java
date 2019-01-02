package app.web.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import app.web.developmentDiary.DevelopmentDiaryModel;

@Mapper
public interface DevelopmentDiaryMapper {


	public List<DevelopmentDiaryModel> login(@Param("id") int id, @Param("pass") String pass);

}
