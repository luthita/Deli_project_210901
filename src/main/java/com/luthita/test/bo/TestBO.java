package com.luthita.test.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.luthita.test.dao.TestDAO;
import com.luthita.test.model.Like;

@Service
public class TestBO {
	@Autowired
	private TestDAO testDAO;

	public List<Like> getLikeList(){
		return testDAO.selectLikeList();
	}
}
