define(["dojo/_base/declare","mui/form/CheckBoxGroup","./RelationResponseMixin","./ImgResponseMixin","dojo/dom-construct","dojo/topic"],
		function(declare,CheckBoxGroup,RelationResponseMixin,ImgResponseMixin,domConstruct,topic){
	
	return declare("km.pindagate.common.CheckBoxResponseMixin",[RelationResponseMixin,ImgResponseMixin],{
		
		renderCheckBoxGroup:function(options){
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
				//item
				var _item={ 
					text:item.text, 
					value:item.value , 
					checked:this.contains(valueList,item.value)  
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
			
			var checkboxGroup=new CheckBoxGroup({
				id:'id_'+name,//防止冲突
				name:name,
				mul:'false',
				showStatus:showStatus,
				store:store,
				className:'newMui muiFormEleWrap muiFormGroup muiFormStatusEdit'
			},srcNodeRef);
			topic.subscribe('/mui/form/valueChanged',function(widget,args){
				if(widget == checkboxGroup){
					var data=widget.store.data,
						value=widget.value,
						valueArray=value.split(';');
						text="";
					for(var i=0;i<data.length;i++){
						if( self.contains(valueArray,data[i].value) ){
							text += data[i].text+';';
						}
					}
					if(text){
						text=text.substring(0,text.length-1);
					}
					topic.publish('/km/pindagate/valueChanged',self,{
						name:name,
						value:value,
						text:text
					});
				}
			});
			self.showTopic();
			checkboxGroup.startup();
			
			//在组件渲染到dom节点后再把图片添加上去 fix wangjf  call from ImgResponseMixin
			this.addImg(imgs,srcNodeRef);
			
			return checkboxGroup;
			
		},
		
		contains:function(array,item){
			for(i=0;i<array.length;i++){
				if(array[i]==item){
					return true;
				}
			}
			return false;
		}
		
	});
	
});