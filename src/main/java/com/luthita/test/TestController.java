package com.luthita.test;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.luthita.test.bo.TestBO;
import com.luthita.test.model.Like;

@Controller
public class TestController {
	@Autowired
	private TestBO testBO;
	
  @ResponseBody
    @RequestMapping("/test1")
    public String helloWorld() {
        return "Hello world!";
    }
  
  @ResponseBody
  @RequestMapping("/test2")
  public List<Like> dbTest(){
	  
	  List<Like> likeList = testBO.getLikeList();
	  return likeList;
  }

  @RequestMapping("/test3")
  public String jspTest() {
	  return "test/test";
  }
}
