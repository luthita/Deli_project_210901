<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="d-flex justify-content-center align-items-center">
	<div class="menuTable">
		<div class="d-flex justify-content-between m-3">
			<h1 class="textO1 font-weight-bold fontJua">${storeName}</h1>
			<button type="button" class="btn btn-success float-right" data-toggle="modal" data-target="#menuModal">메뉴 등록</button>
		</div>
		
		<table class="table text-center">
	        <thead>
	            <tr>
	                <th>메뉴 이미지</th>
	                <th>메뉴</th>
	                <th>가격</th>
	                <th></th>
	                <th></th>
	            </tr>
	        </thead>
	        <tbody>
	        	<c:forEach var="menu" items="${menuList}">
	            <tr>
	            	<c:choose>
		            	<c:when test="${menu.imagePath eq null}">
		            		<td class="align-middle col-3"><img src="/static/images/noImage.png" width="100px" class="imageScale"></td>
		            	</c:when>
		            	<c:otherwise>
		            		<td class="align-middle col-3"><img src="${menu.imagePath }" width="100px" class="imageScale">
		            	</c:otherwise>
		            </c:choose>
	                <td class="align-middle col-3">${menu.name}</td>
	                <td class="align-middle col-3"><fmt:formatNumber value="${menu.price}" pattern="#,###" />원</td>
	                <td class="align-middle col-2">
	                	<button type="button" class="btn btn-secondary soldOutBtn" data-menu-id="${menu.id}.id}">품절</button>
	                </td>
	                <td class="align-middle col-1">
	                	<button type="button" class="btn btn-danger delBtn" data-menu-id="${menu.id}">삭제</button>
	                </td>
	                
	            </tr>
	            </c:forEach>
	        </tbody>
	    </table>
	</div>
</div>

<div class="modal fade" id="menuModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="menuModalLabel">메뉴 등록</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form class="menuForm">
      <div class="modal-body">
         <div class="form-group">
           <label for="name" class="col-form-label">메뉴 이름 :</label>
           <input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력하세요">
         </div>
         <div class="form-group">
           <label for="price" class="col-form-label">가격 :</label>
           <input type="text" class="form-control" id="price" name="price"placeholder="가격을 입력하세요"></input>
         </div>
         <div class="filebox preview-image">
	         	<span>메뉴 이미지 :</span><br>
			<input class="upload-name" name="imagePath"value="파일선택" disabled="disabled">
			<label for="input-file">업로드</label>
			<input type="file" id="input-file" accept=".gif, .jpg, .png, .jpeg" class="upload-hidden">
		  </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn bgGray" data-dismiss="modal">닫기</button>
        <button type="submit" class="btn bgO2 text-white" id="menuSubmit">등록</button>
      </div>
      </form>
    </div>
  </div>
</div>
<script>
$(document).ready(function(){
	
	var fileTarget = $('.filebox .upload-hidden');
    fileTarget.on('change', function(){
        if(window.FileReader){
        	// 파일명 추출
            var filename = $(this)[0].files[0].name;
           
        } 

        else {
            // Old IE 파일명 추출
            var filename = $(this).val().split('/').pop().split('\\').pop();
        };

        $(this).siblings('.upload-name').val(filename);
    });

    //preview image 
    var imgTarget = $('.preview-image .upload-hidden');

    imgTarget.on('change', function(){
        var parent = $(this).parent();
        parent.children('.upload-display').remove();

        if(window.FileReader){
            //image 파일만
            if (!$(this)[0].files[0].type.match(/image\//)) return;
            
            var reader = new FileReader();
            reader.onload = function(e){
                var src = e.target.result;
                parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img src="'+src+'" class="upload-thumb"></div></div>');
            }
            reader.readAsDataURL($(this)[0].files[0]);
        }

        else {
            $(this)[0].select();
            $(this)[0].blur();
            var imgSrc = document.selection.createRange().text;
            parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img class="upload-thumb"></div></div>');

            var img = $(this).siblings('.upload-display').find('img');
            img[0].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")";        
        }
    });
    
    $('.menuForm').submit(function(e){
    	e.preventDefault();
    	
    	let name = $('#name').val().trim();
		if(name == ''){
			alert('메뉴 이름을 입력하세요.');
			return;
		}
		let price = $('#price').val().trim();
		if(price == ''){
			alert('메뉴 가격을 입력하세요.');
			return;
		}
		
		var formData = new FormData();
		formData.append("file", fileTarget[0].files[0]);
		formData.append("name", name);
		formData.append("price", price);
		
		
		$.ajax({
			type: 'POST',
			url: '/admin/menu_create',
			data: formData,
			enctype: 'multipart/form-data',
			processData: false,
			contentType: false,
			success: function(data){
				if(data.result == 'success'){
					alert("메뉴 등록이 되셨습니다.");
					location.href="/admin/menu_view";
				}else{
					alert("fail");
				}
			},error: function(jqXHR, textStatus, errorThrown) {
				var errorMsg = jqXHR.responseJSON.status;
				alert(errorMsg + ":" + textStatus);
			}
		});
    });
    
    $('.delBtn').on('click', function(e){
    	let deleteMenuId = $(this).data('menu-id');
    	
    	$.ajax({
    		type:'post'
    		, url: '/admin/delete_menu'
    		, data: {"id": deleteMenuId}
    		, success: function(data){
    			if(data.result == 'success'){
    				alert("메뉴 삭제되었습니다");
    				location.reload();
    			}
    		}, error: function(e){
    			alert("error" + e.message);
    		}
    	});
    });
});
</script>