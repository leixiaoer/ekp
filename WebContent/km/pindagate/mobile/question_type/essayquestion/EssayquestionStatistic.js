define(["dojo/_base/declare","../common/BaseStatistic","./_CollpaseListItemMixin","dojo/dom-construct","dojo/request","mui/util","dojo/topic"],
		function(declare,BaseStatistic,_CollpaseListItemMixin,domConstruct,request,util,topic){
	
	return declare("km.pindagate.essayquestion.EssayquestionStatistic",[BaseStatistic,_CollpaseListItemMixin],{

		url:'/km/pindagate/km_pindagate_question_res/kmPindagateQuestionRes.do?method=list',
		
		renderBody:function(){
			this.url = util.setUrlParameter(this.url,'questionId',this.data.questionId);
			this.url = util.formatUrl(this.url);
			this.doLoad(this);
			this.subscribe('/km/pindagate/essayquestion/toggle','doLoad');
		},
		
		doLoad:function(widget){
			if(this == widget){
				var self = this;
				this.pageno = this.pageno || 1;
				this.url = util.setUrlParameter(this.url,'pageno',this.pageno);
				var _promise = request.post(this.url,{handleAs : 'json'});
				_promise.then(function(items){
					self.generateItems(items);
					topic.publish('/km/pindagate/essayquestion/loaded',self,items);
				});
			}
		},
		
		generateItems:function(items){
			this.formatItems(items);
			for(var i = 0 ;i < this.listDatas.length;i++){
				var data = this.listDatas[i];
				if(data.fdAnswer){
					var essayItem =domConstruct.create('div',{className:'essayItem'},this.renderNode);
					domConstruct.create("img", { className: "essayItemHeader",src:util.formatUrl(data.header)}, essayItem);//头像
					domConstruct.create("h4", { innerHTML:data.fdName}, essayItem);//名字
					var date=domConstruct.create("p", { className:"essayDate mui mui-time"}, essayItem);
					domConstruct.create("span", { innerHTML:data.fdCreateTime }, date);//日期
					//内容
					var Econtent=domConstruct.create("div",{className:"content"},essayItem),
						answer = data.fdAnswer.replace(/\r\n/g,'<br>').replace(/\n/g,'<br>').replace(/ /g,'&nbsp;').replace(/#039;/g,"'").replace(/&amp;/g,'')
								 .replace(/#034;/g,'"').replace(/&/g,'"').replace(/amp;#034;/g,'');
					domConstruct.create("p",{innerHTML:answer},Econtent);
				}
			}
		},
		
		formatItems:function(items){
			this._loadOver = false;
			var page = {};
			if (items) {
				if (items['datas']){//分页数据
					this.listDatas = this.formatItemDatas(items['datas']);
					page = items['page'];
					if (page) {
						this.pageno = parseInt(page.currentPage, 10) + 1;
						this.rowsize = parseInt(page.pageSize, 10);
						this.totalSize = parseInt(page.totalSize, 10);
						if(parseInt(page.totalSize || 0, 10) <= (this.pageno-1) * this.rowsize) {
							this._loadOver = true;
						}
					}
				}else{//直接数据,不分页
					this.listDatas = items;
					this.totalSize = items.length;
					this.pageno = 1;
					this._loadOver = true;
				}
			}
		},
		
		formatItemDatas : function(datas) {
			var dataed = [];
			for (var i = 0; i < datas.length; i++) {
				var datasi = datas[i];
				dataed[i] = {};
				for (var j = 0; j < datasi.length; j++) {
					dataed[i][datasi[j].col] = datasi[j].value;
				}
			}
			return dataed;
		},
		
	});
	
});