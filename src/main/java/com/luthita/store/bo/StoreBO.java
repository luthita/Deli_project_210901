package com.luthita.store.bo;

import java.io.IOException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.luthita.common.FileManagerService;
import com.luthita.store.dao.StoreDAO;
import com.luthita.store.model.Store;

@Service
public class StoreBO {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private StoreDAO storeDAO;
	
	@Autowired
	private FileManagerService fileManagerService;
	
	public Store existStoreByAdminId(int adminId) {
		return storeDAO.selectStoreByAdminId(adminId);
	}
	public Store getStore(int id) {
		return storeDAO.selectStoreById(id); 
	}
	
	public int createStore(int adminId, String storeName, String address, String introduce, String phoneNumber, String kinds, MultipartFile logoFile) {
		
		String logoImagePath = null;
		if(logoFile != null) {
			try {
				logoImagePath = fileManagerService.saveFile(adminId, logoFile);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				logger.error("[파일업로드 에러] " + e.getMessage());
			}
		}
		
		return storeDAO.insertStore(adminId, storeName, address, introduce, phoneNumber, kinds, logoImagePath);
	}
	
	public List<Store> getStoreListByKinds(String kinds){
		return storeDAO.selectStoreListByKinds(kinds);
	};
	
}
