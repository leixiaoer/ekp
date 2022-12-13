<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
	//改变图片的大小
	function resizeToSmail(_this){
	  _this.style.width="300px"; 
	  _this.style.height ="300px"; 
	}
	function resizeToLarge(_this){
	  _this.style.width="14px"; 
	  _this.style.height ="14px"; 
	}
	//点击预览图片
	function previewTooltip(e,tipContent){
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
	}

</script>