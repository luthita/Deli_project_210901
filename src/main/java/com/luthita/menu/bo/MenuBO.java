package com.luthita.menu.bo;

import java.io.IOException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.luthita.common.FileManagerService;
import com.luthita.menu.dao.MenuDAO;
import com.luthita.menu.model.Menu;

@Service
public class MenuBO {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private MenuDAO menuDAO;
	
	@Autowired
	private FileManagerService fileManagerService;
	
	public List<Menu> getMenuList(){
		return menuDAO.selectMenuList();
	}
	
	public int createMenu(int storeId, String name, int price, MultipartFile imageFile) {
		String imagePath = null;
		if(imageFile != null) {
			try {
				imagePath = fileManagerService.saveFile(storeId, imageFile);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				logger.error("[파일업로드 에러] " + e.getMessage());
			}
		}
		return menuDAO.insertMenu(storeId, name, price, imagePath);
	}
	
	public Menu getMenu(int id) {
		return menuDAO.selectMenu(id);
	}
	
	public int deleteMenu(int id) {
		
		Menu menu = getMenu(id);
		
		if(menu == null) {
			logger.warn("[delete Menu] 삭제할 메뉴가 존재하지 않습니다.");
			return 0;
		}
		
		if(menu.getImagePath() != null) {
			try {
				fileManagerService.deleteFile(menu.getImagePath());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				logger.error("[파일 삭제중 에러]" + e.getMessage());
			}
		}
		return menuDAO.deleteMenu(id);
	}
}
