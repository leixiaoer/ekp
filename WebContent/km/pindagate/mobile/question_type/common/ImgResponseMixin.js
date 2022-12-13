define(["dojo/_base/declare","mui/rtf/_ImageResizeMixin","dojo/dom-construct","dojo/dom-style","dojo/query","dojo/ready"],
		function(declare,_ImageResizeMixin,domConstruct,domStyle,query,ready){
	
	
	return declare("km.pindagate.common.ImgResponseMixin",[_ImageResizeMixin],{
		
		//TODO 优化
		addImg:function(imgs/* Array */,srcNodeRef){
			var self=this;
			ready(function(){
				var muiFields=query('.muiCheckItem',srcNodeRef).length>0?query('.muiCheckItem',srcNodeRef):query('.muiRadioItem',srcNodeRef);
				if(muiFields.length > 0){
					for(var i=0;i<imgs.length;i++){
						var _img=imgs[i];
						for(var j=0;j<_img.length;j++){
							domConstruct.place(_img[j],muiFields[i],'after');
						}
					}
				}
				//self.formatContent(srcNodeRef);
			});
		},
		
		resizeDom:function(item){
			this.inherited(arguments);
			var styleVar = {
				"height":'8rem',
				"max-width" : '20%',
				"margin-top":'.2rem',
				"margin-right":'2rem',
				"display":'block'
			};
			domStyle.set(item, styleVar);
		}
		
	});
	
});