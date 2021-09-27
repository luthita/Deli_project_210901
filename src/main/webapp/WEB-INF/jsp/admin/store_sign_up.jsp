<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사장님 광장 회원가입</title>
<!-- bootstrap CDN link -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

  <%-- AJAX를 사용하려면 더 많은 함수가 있는 js를 포함해야 한다. --%>
  <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
  <!-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script> -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="/static/css/style.css" type="text/css">
</head>
</head>
<body class="bgGray d-flex justify-content-center align-items-center">
	<div>
		<form id="storeSignUpForm" method="post">
		<h1 class="textO2 fontJua display-3 my-4">사장님 광장</h1>
		<div class="mb-3">
			<strong>가게 이름</strong><br>
			<input type="text" class="form-control" name="storeName" id="storeName" placeholder="가게 이름을 기입해주세요">
		</div>
		<div class="mb-3">
			<strong>가게 주소</strong><br>
			<input type="text" class="form-control" name="address" id="address" placeholder="가게 주소를 기입해주세요">
		</div>
		<div class="mb-3">
			<strong>가게 번호</strong><br>
			<input type="text" class="form-control" name="phoneNumber" id="phoneNumber" placeholder="'-'까지 입력해주세요">
		</div>
		<div class="mb-3">
			<strong>카테고리</strong><br>
			<select name="kinds" id="kinds" class="form-control">
				<option>카테고리</option>
				<option value="korean">분식</option>
				<option value="chickenpizza">치킨/피자</option>
				<option value="chinese">중식</option>
				<option value="japanese">일식/돈가츠</option>
				<option value="nightfood">야식</option>
				<option value="dessert">디저트</option>
			</select>
		</div>
		<div class="mb-3">
			<strong>가게 소개</strong><br>
			<textarea class="form-control" name="introduce" id="introduce" rows="5"></textarea>
		</div>
		
		<div class="mb-3">
			<strong>가게 로고</strong><br>
			<div class="filebox preview-image">
				<input class="upload-name" value="파일선택" disabled="disabled">
				<label for="input-file">업로드</label>
				<input type="file" id="input-file" accept=".gif, .jpg, .png, .jpeg" class="upload-hidden">
			</div>
		</div>
		<div>
			<button type="submit" id="signUpBtn" class="btn bgO2 w-100 mb-3 mr-3 text-white">회원가입</button>
		</div>
		</form>
	</div>
</body>
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
    
    $('#storeSignUpForm').submit(function(e){
    	e.preventDefault();
    	
    	// validation
		let storeName = $('#storeName').val().trim();
		if(storeName == ''){
			alert('가게 이름을 입력하세요');
			return;
		}
		
		let address = $('#address').val().trim();
		if(address == ''){
			alert('가게주소를 입력하세요');
			return;
		}
		
		let phoneNumber = $('#phoneNumber').val().trim();
		if(phoneNumber == ''){
			alert('가게번호를 입력하세요');
			return;
		}
		
		let kinds = $('#kinds').val();
		if(kinds == '카테고리'){
			alert('카테고리를 입력하세요');
			return;
		}
		
		let introduce = $('#introduce').val();
		
		var formData = new FormData();
		formData.append("file", fileTarget[0].files[0]);
		formData.append("storeName", storeName);
		formData.append("address", address);
		formData.append("phoneNumber", phoneNumber);
		formData.append("kinds",kinds);
		formData.append("introduce", introduce);
		
		$.ajax({
			type: 'POST',
			url: '/admin/store_sign_up',
			data: formData,
			enctype: 'multipart/form-data',
			processData: false,
			contentType: false,
			success: function(data){
				if(data.result == 'success'){
					alert("가게 등록이 되셨습니다.");
					location.href="/admin/sign_out";
					alert("다시 로그인해주십시오")
				}else{
					alert("fail");
				}
			},error: function(jqXHR, textStatus, errorThrown) {
				var errorMsg = jqXHR.responseJSON.status;
				alert(errorMsg + ":" + textStatus);
			}
		});
    });
});
</script>
</html>