<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
	Com_IncludeFile("ckfilter.js|ckeditor.js", "ckeditor/");
</script>
<script>
	var imgValueId;//定义一个全局变量用于上传完图片时动态改变显示url

	/**
	* 上传图片
	*/
	window.uploadImg=function(divId,imgId){
		var button=$(divId), interval;
		var fileType = "all",fileNum = "more"; 
		new AjaxUpload(button,{
			action: '${KMSS_Parameter_ResPath}fckeditor/editor/filemanager/upload/simpleuploader?Type=Image', 
			name: 'NewFile',
			responseType:'json',
			onSubmit : function(file, ext){
				if(ext instanceof Array){
					ext = ext[0];
				}
				 if(!/(gif|jpg|jpeg|png|GIF|JPG|PNG|bmp|BMP)$/.test(ext)){
			     	_dialog.alert('<bean:message bundle="km-pindagate" key="kmPindagateMain.picture.ext" />');
			        return false;
				}
				imgValueId=imgId;
				button.text('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.image.uploading"/>');
				if(fileNum == 'one')
					this.disable();
				interval = window.setInterval(function(){
					var text = button.text();
					if (text.length < 13){
						button.text(text + '.');	
					} else {
						button.text('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.image.uploading"/>');
					}
				}, 200);
			},
			onComplete: function(file, response){
				button.html('&nbsp;<bean:message bundle="km-pindagate" key="kmPindagateQuestion.image.upload.browse"/>&nbsp;');
				window.clearInterval(interval);
				this.enable();
				var imageUrl="${LUI_ContextPath}/resource/fckeditor/editor/filemanager/download?fdId="+response.filekey;
				OnUploadCompleted(response.status,imageUrl,response.filekey,response.errorMessage);
			}
		});
	}
	
	/**
	* 上传图片完毕
	*/
	function OnUploadCompleted(retval,url,newName,err){
		if(retval == 1){
			//更新url和图片显示值
			var oldUrl = $('input[name='+ imgValueId+']').val();
			var newUrl;
			if(oldUrl != ""){
				newUrl = oldUrl+";"+url;
			}else{
				newUrl = url;
			}
			$('input[name='+ imgValueId+']').attr('value',newUrl);	
			var imgArr = newUrl.split(";");
			var imgHtml="";
			for(var i=0; i<imgArr.length; i++){
				if(imgArr[i] != ""){
					imgHtml += '<img src="'+imgArr[i]+'" border="1" onclick="previewTooltip(event, this.src)" width="25px" hight="25px" style="cursor: pointer;"/><img src="${KMSS_Parameter_StylePath}icons/delete.gif" width=16 height=16 onclick="deleteImg(\''+ imgValueId +'\','+i+')" title="'+"<bean:message bundle='km-pindagate' key='kmPindagateQuestion.deletePic'/>"+'" style="cursor:pointer;">&nbsp;';
				} 
			}
			$('input[name='+ imgValueId+']').next().next().html(imgHtml);
		}else if(retval == 202){
			_dialog.alert("<bean:message bundle='km-pindagate' key='kmPindagateQuestion.image.upload.fail.invalidType'/>");
		}else{
			_dialog.alert("<bean:message bundle='km-pindagate' key='kmPindagateQuestion.image.upload.fail.other'/>");
		}
	};
	
	/**
	* 删除图片
	*/
	window.deleteImg=function(id,k){
		var imgValueId = id;
		var imgUrl = $('input[name='+ imgValueId +']').val();
		var imgArr = imgUrl.split(";");
		var imgHtml="";
		var newUrl = "";
		var number = 0;
		for(var i=0; i<imgArr.length; i++){
			if(i!=k){
				if(imgArr[i] != ""){
					imgHtml += '<img src="'+imgArr[i]+'" border="1" onclick="previewTooltip(event, this.src)" width="25px" hight="25px"  style="cursor: pointer;"/><img src="${KMSS_Parameter_StylePath}icons/delete.gif" width=10 height=10 onclick="deleteImg(\''+id+'\','+number+')" title="'+"<bean:message bundle='km-pindagate' key='kmPindagateQuestion.deletePic'/>"+'" >&nbsp;';			
					newUrl +=  (imgArr[i] + ";");
					number++;
				}
			}
		}
		$('input[name='+ imgValueId+']').attr('value',newUrl);
		$('input[name='+ imgValueId+']').next().next().html(imgHtml);
	};
	
	/**
	* 显示图例
	*/
	window.showFigure=function(event,_this,imgint) {
		event = event || window.event;
		 var t1="<table cellspacing='1' cellpadding='10' style='border-color:#066666;background-color:#FFFFFF;font-size:12px;border-style:solid;border-width:thin;text-align:center;'><tr><td><img src='" + _this   + "' ></td></tr></table>";
		 var objA = document.getElementById("showtip");
		 objA.innerHTML = t1;
		 with(objA.style) {
		 	top = document.body.scrollTop + event.clientY + 10 + "px";
		 	if (imgint > 0) {
		 		left = document.body.scrollLeft + event.clientX + 10 + "px";
		 	} else {
		 		left = document.body.scrollLeft + event.clientX - objA.offsetWidth - 10 + "px";
		 	}
		 	display = "block";
		 }
	};
	/**
	* 隐藏图例
	*/
	window.hideFigure=function(_this) {
		document.getElementById("showtip").innerHTML = "";
		document.getElementById("showtip").style.display = "none";
	};
	
	function setImage(field){
		if($(field).val() !=null && $(field).val() != ""){
			$("img",$(field).parent()).attr("src",$(field).val());
			$("img",$(field).parent()).showFigure();
		}
		else{
			$("img",$(field).parent()).hide();
		}
	}
	
	/**
	*改变图片的大小
	*/
	window.resizeToSmail=function(_this){
	  _this.style.width="100px"; 
	  _this.style.height ="100px"; 
	};
	
	window.resizeToLarge=function(_this){
	  _this.style.width="25px"; 
	  _this.style.height ="25px"; 
	};
	
	
	window.hideTooltip=function(){
		var divObj = document.getElementById("dHTMLToolTip");
		divObj.style.visibility="hidden";
		divObj.style.left = 1;
		divObj.style.top = 1;
		return false;
	};
	
	window.showTooltip=function(e, tipContent){
		var divObj = document.getElementById("dHTMLToolTip");
		divObj.style.top=document.body.scrollTop+event.clientY+15
		divObj.innerHTML='<img src="'+tipContent+'">';
		if ((e.x + divObj.clientWidth) > (document.body.clientWidth + document.body.scrollLeft)){
			divObj.style.left = (document.body.clientWidth + document.body.scrollLeft) - divObj.clientWidth-10;
		}else{
			divObj.style.left=document.body.scrollLeft+event.clientX
		}
		divObj.style.visibility="visible";
		return true;	
	};
	
	window.previewTooltip=function(e,tipContent){
		var datas = {
				data : [{value : tipContent}],
				value : tipContent,
				valueType:'url'
		};
		seajs.use([ 'lui/imageP/preview' ],function(preview) {
			preview({
				data : datas
			});
		});
	};

	/**
	*校验是否为空
	*/
	window.validateIsNull=function(val){
		val = val.replace(/(\s*$)/g, "");
		if(val == null || val == "")
			return true;
		else
			return false;
	};
	
	/**
	*校验是否为真整数
	*/
	window.validateIsNumber=function(val){
		var re = /^[1-9]\d*$/;
	    if (!re.test(val))
			return false;
		else
			return true;
	};
	
	/**
	*校验输入的是否为数字
	*/
	window.checkDate=function(obj){	
		var str_tmp;
		var str_val="";
		for (var i=0;i<obj.value.length;i++){
			str_tmp=obj.value.substring(i,i+1);	
		 if ( (str_tmp>="0" && str_tmp<="9") || (str_tmp=="." && str_val.indexOf(".")==-1))
				str_val+=str_tmp;
		}
		if (obj.value!=str_val) obj.value=str_val;
	};

</script>