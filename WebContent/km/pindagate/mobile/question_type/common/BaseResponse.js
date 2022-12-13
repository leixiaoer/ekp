define(["dojo/_base/declare","dijit/_WidgetBase",'./ValidationResponseMixin',"mui/rtf/_ImageResizeMixin","./LinkResponseMixin",
        "dojo/dom-construct","dojo/dom-style","dojo/html","dojo/query","dojo/topic","dojo/request",
        "mui/util",'dojo/ready',"dojo/on","dojo/dom",
        "mui/i18n/i18n!km-pindagate:mobile",
        "dojo/dom-class",
        "dojo/dom-attr"],
		function(declare,WidgetBase,ValidationResponseMixin,_ImageResizeMixin,LinkResponseMixin,domConstruct,domStyle,html,query,topic,request,util,ready,on,dom,msg,domClass,domAttr){
	
	return declare("km.pindagate.base.BaseResponse",[WidgetBase,ValidationResponseMixin,_ImageResizeMixin,LinkResponseMixin],{
		
		lazy:true,//是否延迟渲染
		
		hasRender:false,//组件是否已渲染
		
		rscriptType : /^$|\/(?:java|ecma)script/i,
		
		context:null,
		
		value:null,
		valueTxt:null,
		
		showStatus:"edit",
		
		buildRendering:function(){
			this.subscribe('km/pindagate/paging','handlePaging');
			this.subscribe('/km/pindagate/valueChanged','handleValueChange');
			
			this.inherited(arguments);
			this.initProperties();//属性
			this.initValueFeild();//值
			if(!this.lazy){
				this.render();//渲染
			}
		},
		
		//属性初始化
		initProperties:function(){
			var self = this;
			this.inherited(arguments);
			if(this.context){
				this.index=this.context.index;
				this.type=this.context.type;//问题类型
				this.typeName=this.context.typeName;//问题类型名字
				this.questionDef=this.context.questionDef;//问题信息
				this.relationDef=this.context.relationDef;//题目关联
				this.serialNum=this.context.serialNum;//问题序号
				this.title=this.context.title;//问题名字
				this.pageno=this.context.pageno;//所在页
				this.initValueFromDraft();
			}
		},
		
		initValueFromDraft : function(){
			var fdDraftAnswer = query('[name="fdItems[' + this.index + '].fdDraftAnswer"]'),
				fdDraftAnswerTxt = query('[name="fdItems[' + this.index + '].fdDraftAnswerTxt"]'),
				fdDraftRelHide = query('[name="fdItems[' + this.index + '].fdDraftRelHide"]'),
				fdDraftOther  = query('[name="fdItems[' + this.index + '].fdDraftOther"]'),
				fdDraftSelectReason = query('[name="fdItems[' + this.index + '].fdDraftSelectReason"]');
			this.draftValue =  fdDraftAnswer.length > 0 ? fdDraftAnswer[0].value : null; 
			this.draftValueTxt =  fdDraftAnswerTxt.length > 0 ? fdDraftAnswerTxt[0].value : null; 
			this.draftRelHide =  fdDraftRelHide.length > 0 ? fdDraftRelHide[0].value : null; 
			this.draftOther = fdDraftOther.length > 0 ? fdDraftOther[0].value : null;
			this.draftSelectReason = fdDraftSelectReason.length > 0 ? fdDraftSelectReason[0].value : null;
		},
		
		//值域初始化
		initValueFeild:function(){
			this.valueDom=domConstruct.create('input',{type:'hidden',name:'fdItems['+this.index+'].fdAnswer'},this.context.renderNode);
			this.valueTxtDom=domConstruct.create('input',{type:'hidden',name:'fdItems['+this.index+'].fdAnswerTxt'},this.context.renderNode);
			this.relHideDom=domConstruct.create('input',{type:'hidden',name:'fdItems['+this.index+'].fdRelationHide'},this.context.renderNode);
			query('[name="fdItems['+this.index+'].fdAnswer"]').val(this.draftValue);
			query('[name="fdItems['+this.index+'].fdAnswerTxt"]').val(this.draftValueTxt);
			query('[name="fdItems['+this.index+'].fdRelationHide"]').val(this.draftRelHide);
		},
		
		render:function(){
			var self = this;
			if(!this.hasRender){
				this.renderTitle();	//题头
				this.renderTip();//摘要、说明
				this.renderBody();//内容
				this.renderAtt();//附件
				ready(function(){
					//处理rtf中的链接(不跳转，而是在view中打开)
					self.formatLink(self.subjectNode);
					self.formatLink(self.tipNode);
					//处理rtf中的图片(支持图片预览)
					self.formatContent(self.context.renderNode);
				})
			}
			this.hasRender=true;
		},
		
		renderTitle:function(){
			var renderNode=this.context.renderNode,
				subject=this.formatStr(this.questionDef.subject),
				willAnswer=this.questionDef.willAnswer;
			var fdnum=this.context.serialNum;
			if (fdnum<10) {
				fdnum="0"+fdnum
			}
			
			//单选还是多选
			this.titileFlag=domConstruct.create('div',{className:'pindagate_body_tit_flag' },renderNode);
			
			domConstruct.create('span',{innerHTML:this.typeName},this.titileFlag);
			
			//标题
			this.subjectNode=domConstruct.create('div',{className:'pindagate_body_tit' },renderNode);
			var subjectNum = domConstruct.create('span',{innerHTML:fdnum,className:'pindagate_body_tit_num' },this.subjectNode);
			//是否必答
			if(willAnswer){
				domConstruct.create('span',{innerHTML:'*',className:'muiRequire' },this.subjectNode);
			}
			this.subjectDesc=domConstruct.create('span',{className:'pindagate_body_tit_desc' },this.subjectNode);
			domConstruct.create('span',{innerHTML:subject },this.subjectDesc);
			//this.formatContent(this.subjectNode);
		},
		
		renderTip:function(){
			var	renderNode=this.context.renderNode, 
				tip=this.formatStr(this.questionDef.tip);
			if(tip){
				this.tipNode=domConstruct.create('div',{innerHTML:tip,className:'pindagate_body_subTit' },renderNode);
			}
			//this.formatContent(this.tipNode);
		},
		
		renderBody:function(){
			//for override
		},
		
		renderAtt:function() {
			var self = this;
			topic.subscribe('km/pindagate/paging',function(data) {
				var totalPage = data.totalPage,
					currentPage = data.currentPage;
				var isShowNext = false;
				// 从当前题目开始循环，找到能显示的下一题
				for(; currentPage<allTopics.length; currentPage++) {
					var topics = allTopics[currentPage];
					if(topics && topics.isShow) {
						// 找到可显示的下一题，循环结束
						isShowNext = true;
						break;
					}
				}
				// 根据是否显示下一题来控制“下一页”按钮的显示和隐藏
				if(isShowNext) {
					domStyle.set(self.attNext, "display", "block");
				} else {
					domStyle.set(self.attNext, "display", "none");
				}
			});
			renderNode=this.context.renderNode;
			var num=this.context.serialNum;
			attNode=domConstruct.create('div',{className:'muiAtt' },renderNode);
			self.attNext=domConstruct.create('div',{innerHTML:msg['mobile.kmPindagateMain.page.next'],className:'pindagate_nav_next','id':"endNext"+num},renderNode);
			on(dom.byId("endNext"+num), "touchstart", function(e){
				e.preventDefault();
				topic.publish('km/pindagate/mveventend',num);
		     },500);
			var dhs = new html._ContentSetter({
				parseContent : true,
				onEnd : function() {
					var scripts = query('script', this.node);
					scripts.forEach(function(node, index) {
						//只处理javascript
						if (self.rscriptType.test(node.type || "")) {
							if (node.src) {
								//src方式引入的暂时没解决方案
							} else {
								window["eval"].call(window,
										(node.text || node.textContent
												|| node.innerHTML || ""));
							}
						}
					});
					this.inherited("onEnd", arguments);
				}
			},500);
			dhs.node = attNode;
			this._getText(function(text) {
				dhs.set(text);
			});
			dhs.tearDown();
		},
		
		_getText:function(callBack){
			var self = this,
				attUrl='/km/pindagate/km_pindagate_question/kmPindagateQuestion.do?method=viewAtt&attachmentIds='+this.questionDef.attachmentIds;
			var promise = request.post(util.formatUrl(attUrl), {
				sync : true
			}).response.then(function(data) {
				if (data.status == 200) {
					var text = data.data;
					callBack.call(self, text);
				}
			});
		},
		
		handlePaging:function(args){
			var currentPage=args.currentPage,
				pageType=args.pageType || 'one',//分页类型,one:一道题一页(适合移动端)、many:多道题一页(适合PC端)
				myPage=this.pageno;
			if(pageType=='one'){
				myPage=this.serialNum;
			}
			if(pageType=='one' || pageType == 'many'){
				if(myPage == currentPage){
					this.show();
				}else{
					this.hide();
				}
			}
/*			topic.publish("/mui/list/toTop", null ,{y: 0 });*/
		},
		
		
		handleValueChange:function(widget,args){
			if(widget == this){
				this.value=this.value || {};
				this.valueTxt=this.valueTxt || {};
				this.value[args.name]=args.value;
				this.valueTxt[args.name]=args.text;
				var _domValue='',
					_txtDomValue='';
				for(var key in this.value){
					_domValue+=this.value[key];	
					_domValue+=';';
				}
				for(key in this.valueTxt){
					_txtDomValue += this.valueTxt[key];	
					_txtDomValue += "\r\n";
				}
				if(_domValue.length>0){
					_domValue=_domValue.substring(0,_domValue.length-1);
				}
				if(_txtDomValue.length>0){
					_txtDomValue=_txtDomValue.substring(0,_txtDomValue.length-2);
				}
				this.valueDom.value=_domValue;
				this.valueTxtDom.value=_txtDomValue;
				//校验
				if(this.validate){
					this.validate(this.value);
				}
			}
		},
		
		//显示本题
		show:function(){
			this.render();
			domStyle.set(this.context.renderNode,'display','block');
		},
		
		//隐藏本题
		hide:function(){
			domStyle.set(this.context.renderNode,'display','none');
		},
		
		//格式化字符串
		formatStr:function(str){
			return str.replace(/<p>/g,"").replace(/<\/p>/g,"<br>").replace(/\n/g,"").replace(/(<br>)+$/g,"");;
		},
		
		//格式化选项数据
		formatData:function(datas){
			var result=[];
			for(var index=0;index<datas.length;index++){
				var data = datas[index],
					tmp={};
				tmp.value=index;
				tmp.text=data[0];
				tmp.img=data[1];
				result.push(tmp);
			}
			return result;
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