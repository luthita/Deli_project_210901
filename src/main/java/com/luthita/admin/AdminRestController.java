package com.luthita.admin;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.luthita.admin.bo.AdminBO;
import com.luthita.admin.model.Admin;
import com.luthita.common.EncryptUtils;
import com.luthita.menu.bo.MenuBO;
import com.luthita.store.bo.StoreBO;
import com.luthita.store.model.Store;

@RequestMapping("/admin")
@RestController
public class AdminRestController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private AdminBO adminBO;
	
	@Autowired
	private StoreBO storeBO;
	
	@Autowired
	private MenuBO menuBO;
	
	@RequestMapping("/is_duplicated_id")
	public Map<String,Boolean> isDuplicated(
			@RequestParam("loginId") String loginId){
		
		Map<String, Boolean> result = new HashMap<>();
		Admin admin = adminBO.getAdminByloginId(loginId);
		
		if(admin == null) {
			result.put("result", false);
		}else {
			result.put("result", true);
		}
		return result;
	}
	
	@PostMapping("/sign_up")
	public Map<String, String> signUp(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			@RequestParam("email") String email){
		
		// 암호화
		String encryptPassword = EncryptUtils.md5(password);
		
		adminBO.addAdmin(loginId, encryptPassword, email);
		
		Map<String, String> result = new HashMap<>();
		result.put("result", "success");
		
		return result;
	}
	
	
	
	@PostMapping("/sign_in")
	public Map<String, String> signIn(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			HttpServletRequest request){
		
		String encryptPassword = EncryptUtils.md5(password);
		
		Admin admin = adminBO.getAdminByloginIdAndPassword(loginId, encryptPassword);
		
		Map<String, String> result = new HashMap<>();
		if(admin != null) {
			HttpSession session = request.getSession();
			session.setAttribute("adminLoginId", admin.getLoginId());
			session.setAttribute("adminId", admin.getId());
			
			// 해당 admin 계정에 가게가 등록이 되어 있다면 세션 existStore 에 true 
			Store existStore = storeBO.existStoreByAdminId(admin.getId());
			if(existStore != null) {
				session.setAttribute("existStore", true);
				session.setAttribute("storeId", existStore.getId());
				session.setAttribute("storeName", existStore.getStoreName());
				session.setAttribute("kinds", existStore.getKinds());
			} else {
				session.setAttribute("existStore", false);
			}
			
			result.put("result", "success");
		} else {
			result.put("result", "fail");
			result.put("message", "존재하지 않는 ID 입니다.");
		}
		return result;
		
	}
	
	@PostMapping("/store_sign_up")
	public Map<String, String> storeSignUp(
			@RequestParam("storeName") String storeName,
			@RequestParam("address") String address,
			@RequestParam("introduce") String introduce,
			@RequestParam("phoneNumber") String phoneNumber,
			@RequestParam("kinds") String kinds,
			@RequestParam(value = "file", required = false) MultipartFile logoFile,
			HttpServletRequest request){
		
		Map<String,String> result = new HashMap<>();
		HttpSession session = request.getSession();
		Integer adminId = (Integer) session.getAttribute("adminId");
		
		
		
		if(adminId == null) {
			result.put("result","error");
			logger.error("[가게등록] 로그인 세션이 없습니다.");
			return result;
		}
		
		int row = storeBO.createStore(adminId, storeName, address, introduce, phoneNumber, kinds, logoFile);
		if(row > 0) {
			result.put("result", "success");
		} else {
			result.put("result", "error");
			logger.error("[가게등록] 가게등록을 완료하지 못했습니다.");
		}
		
		return result;
	}
	
	@PostMapping("/menu_create")
	public Map<String, String> menuCreate(
			@RequestParam("name") String name,
			@RequestParam("price") int price,
			@RequestParam(value = "file", required = false) MultipartFile imageFile,
			HttpServletRequest request){
		
		Map<String,String> result = new HashMap<>();
		HttpSession session = request.getSession();
		
		Integer storeId = (Integer) session.getAttribute("storeId");
		
		if(storeId == null) {
			result.put("result", "error");
			logger.error("[가게등록] 등록된 가게 세션이 없습니다.");
			return result;
		}
		int row = menuBO.createMenu(storeId, name, price, imageFile);
		if(row > 0 ){
			result.put("result", "success");
		} else {
			result.put("result", "error");
			logger.error("[메뉴등록] 메뉴 등록을 완료하지 못했습니다.");
		}
		return result;
	}
	
	@PostMapping("/delete_menu")
	public Map<String, String> deleteMenu(
			@RequestParam("id") int id){
		
		Map<String, String> result = new HashMap<>();
		int row = menuBO.deleteMenu(id);
		if(row > 0 ) {
			result.put("result", "success");
		} else {
			result.put("result", "error");
		}
		
		return result;
		
	}
	@PostMapping("/store_update")
	public Map<String, String> storeUpdate(
			@RequestParam("introduce") String introduce,
			@RequestParam("kinds") String kinds,
			@RequestParam("deliveryfee") int deliveryfee,
			@RequestParam("minimumPrice") int minimumPrice,
			@RequestParam(value = "file", required = false) MultipartFile logoFile,
			HttpServletRequest request){
		
		Map<String,String> result = new HashMap<>();
		HttpSession session = request.getSession();
		Integer adminId = (Integer) session.getAttribute("adminId");
		
		if(adminId == null) {
			result.put("result","error");
			logger.error("[가게등록] 로그인 세션이 없습니다.");
			return result;
		}
		
		int row = storeBO.updateStore(adminId, introduce, kinds,deliveryfee, minimumPrice, logoFile);
		if(row > 0) {
			result.put("result", "success");
		} else {
			result.put("result", "error");
			logger.error("[가게정보변경] 가게정보변경을 완료하지 못했습니다.");
		}
		
		return result;
	}
	
}
