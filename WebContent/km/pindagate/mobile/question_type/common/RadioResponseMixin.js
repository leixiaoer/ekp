define(["dojo/_base/declare","mui/form/RadioGroup","./ImgResponseMixin","./RelationResponseMixin","dojo/dom-construct","dojo/topic","mui/i18n/i18n!km-pindagate:mobile"],
		function(declare,RadioGroup,ImgResponseMixin,RelationResponseMixin,domConstruct,topic,msg){
	
	return declare("km.pindagate.common.RadioResponseMixin",[ImgResponseMixin,RelationResponseMixin],{
		
		renderRadioGroup:function(options){
			var name = options.name,
				value = options.value,
				items = options.items,
				showStatus=options.showStatus,
				srcNodeRef = options.srcNodeRef;
			
			var valueList = [];
			if(value){
				valueList = value.split(';');
			}
			
			var store=[],imgs=[],self=this;
			for(var index=0;index<items.length;index++){
				var item = items[index];
				var mark = item.mark;
				var content;
				if (mark) {
					content = item.text+" ("+item.mark+msg['mobile.score']+")";
				}else{
					content =item.text;
				}
				//item
				var _item={ 
					text:content, 
					value:item.value , 
					checked: this.contains(valueList,item.value) 
				};
				store.push(_item);
				//img
				var _img=[];
				if(item.img != null && item.img != ""){
					var imgArr = item.img.split(";");
					for(var x=0; x<imgArr.length; x++){
						if(imgArr[x]!=0){
							var imgNode=domConstruct.create('img',{src:imgArr[x],className:'muiPindagateImg' });
							_img.push(imgNode);
						}
					}
				}
				imgs.push(_img);
			}
			
			var radioGroup=new RadioGroup({
				id:'id_'+name,//防止冲突
				name:name,
				mul:'false',
				showStatus:showStatus,
				store:store,
				className:'newMui muiFormEleWrap muiFormGroup muiFormStatusEdit'
			},srcNodeRef);
			topic.subscribe('/mui/form/valueChanged',function(widget,args){
				if(widget == radioGroup){
					var data=widget.store.data,
						value=widget.value,
						text="";
					for(var i=0;i<data.length;i++){
						if(data[i].value==value){
							text=data[i].text;
							break;
						}
					}
					topic.publish('/km/pindagate/valueChanged',self,{
						name:name,
						value:value,
						text:text
					});
					//题目关联
					topic.publish('km/pindagate/relation',self,{
						name:name,
						value:value,
						text:text,
						type:""
					});
				}
			});
			self.showTopic();
			radioGroup.startup();
			//call from ImgResponseMixin
			this.addImg(imgs,srcNodeRef);
			
			return radioGroup;
			
		}
		
	});
	
});