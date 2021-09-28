package com.luthita.store.bo;

import java.io.IOException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.luthita.common.FileManagerService;
import com.luthita.review.dao.ReviewDAO;
import com.luthita.store.dao.StoreDAO;
import com.luthita.store.model.Store;

@Service
public class StoreBO {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private StoreDAO storeDAO;
	
	@Autowired
	private ReviewDAO reviewDAO;
	
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
	
	public String getStoreNameById(int id) {
		return storeDAO.selectStoreNameById(id);
	}
	public int updateStore(int adminId, String introduce,String kinds,int deliveryFee,int  minimumPrice,MultipartFile logoFile) {
		
		String logoImagePath = null;
		if(logoFile != null) {
			try {
				logoImagePath = fileManagerService.saveFile(adminId, logoFile);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				logger.error("[파일업로드 에러] " + e.getMessage());
			}
		}
		
		return storeDAO.updateStore(adminId, introduce, kinds,deliveryFee, minimumPrice, logoImagePath);
	}
	
	public void updateStorePoint(int storeId) {
		List<Integer> pointList = reviewDAO.getPointListById(storeId);
		int sumPoint = 0;
		for(int reviewPoint : pointList) {
			sumPoint += reviewPoint;
		}
		double avgPoint = sumPoint / (double)pointList.size();
		
		storeDAO.updatePoint(avgPoint, storeId);
	}
	
}
