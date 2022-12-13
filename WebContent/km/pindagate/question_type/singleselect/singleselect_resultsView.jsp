<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript">
function function_${JsParam.index}(){
	var index = "${JsParam.index}";
	var divId = "${JsParam.divId}";
	fdQuestionDef[index] = eval("("+($('#fdQuestionDef'+index).val())+")");
	fdStatistic[index] = eval("("+($('#fdStatistic'+index).val())+")");
	$('#'+divId).prepend(singleSelect_getTableHTML(index));
	//画“参与”、“跳过”进度条
	var totalNum = 10;
	if($('#fdParticipantNum').val() != null && $('#fdParticipantNum').val() != "")
		totalNum = parseInt($('#fdParticipantNum').val());
	var participateNumber = fdStatistic[index].participateNumber;
	var notInvolvedNumber = fdStatistic[index].notInvolvedNumber;
	var participate = {to: participateNumber*100/totalNum};
	var pantNum = $("#fdParticipantNum").val();
	if(participateNumber ==0 && notInvolvedNumber == 0){
		notInvolvedNumber = pantNum;
	}
	var o1 = new html5jp.progress("participate"+index, participate,"green");
	o1.draw();
	var notInvolved = {to: notInvolvedNumber*100/totalNum};
	var o2 = new html5jp.progress("notInvolved"+index, notInvolved,"#BBB");
	o2.draw();
	
	$('#participateTxt'+index).html("（"+participateNumber+" / "+pantNum+"）");
	$('#notInvolvedTxt'+index).html("（"+notInvolvedNumber+" / "+pantNum+"）");
	//统计结果图
	if(fdQuestionDef[index].statisticPic == "pie")
		singleSelect_graphPie(index);//饼图
	else 
		singleSelect_graphHistogram(index);//柱状图
	if(fdQuestionDef[index].autoAddOther){
		var otherDiv = '<div style="text-align: left;"><a href="#" onclick="singleSelect_viewOtherAnswer('+index+');" style="cursor: pointer;"><bean:message bundle="km-pindagate" key="kmPindagateResponse.view"/>“';
		otherDiv += fdQuestionDef[index].otherText;
		otherDiv += '”</a></div>';
		$('#'+divId).append(otherDiv);
	}
	if(fdQuestionDef[index].autoAddSelectReason){
		var selectReasonDiv = '<div style="text-align: left;"><a href="#" onclick="singleSelect_viewSelectReasonAnswer('+index+');" style="cursor: pointer;"><bean:message bundle="km-pindagate" key="kmPindagateResponse.view"/>“';
		selectReasonDiv += fdQuestionDef[index].selectReasonText;
		selectReasonDiv += '”</a></div>';
		$('#'+divId).append(selectReasonDiv);
	}
	
}

/**
 * 根据题目序号返回一个单选题表单
 */
function singleSelect_getTableHTML(index){
	var tableHTML = '<table class="options_tb" width=90% id="singleSelect_TB'+index+'">';
	tableHTML += singleSelect_getTitleHTML(index);
	tableHTML += singleSelect_getProgressHTML(index);
	tableHTML += '</table>';
	return tableHTML;
}
function singleSelect_getTitleHTML(index){
	var serialNum = $('#serialNum'+index).val();
	var titleHTML = '<tr><td>';
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_no">'+serialNum+'、</div>';
	if(fdQuestionDef[index].willAnswer)
		titleHTML += '<span class="pi_txtStrong">*</span>';
	
	titleHTML += '<span class="pi_txtStrong"> ['+$('#quesTypeName'+index).val()+']</span>';
	var title = fdQuestionDef[index].subject;
	title = title.replace("<div>", "");
	title = title.replace("</div>", "");
	title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_content">'+title+'</div>';
	//titleHTML += '<span class="pi_txtTitle">'+$('#fdTitle'+index).val()+'</span>';
	titleHTML += '</td></tr>';
	if(fdQuestionDef[index].tip != ''){
		titleHTML += '<tr><td><div class="pi_subjectExplain">';
		titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.titleDescription"/>'+$("<div class='pi_subjectExplain_content'></div>").append(fdQuestionDef[index].tip).text();
		titleHTML += '</div></td></tr>';
	}
	return titleHTML;
}
function singleSelect_getProgressHTML(index){
	var progressHTML = '<tr><td>';
	progressHTML += '<table><tr><td><bean:message bundle="km-pindagate" key="kmPindagateQuestionRes.involved"/></td><td><div id="participate'+index+'"></div></td><td><div id="participateTxt'+index+'"></td></tr></div>';
	progressHTML += '<table><tr><td><bean:message bundle="km-pindagate" key="kmPindagateQuestionRes.notInvolved"/></td><td><div id="notInvolved'+index+'"></div></td><td><div id="notInvolvedTxt'+index+'"></td></tr></div>';
	progressHTML += '</td></tr>';
	return progressHTML;
}
//饼图
function singleSelect_graphPie(index){
	var t = new html5jp.graph.circle("vbar" + index);
	function test(){
		this.draw = function(items, inparams){
			if( ! this.ctx ) {return;}
			/* パラメータの初期化 */
			var params = {
				backgroundColor: null,
				shadow: true,
				border: false,
				caption: false,
				captionNum: true,
				captionRate: true,
				fontSize: "12px",
				fontFamily: "Arial,sans-serif",
				textShadow: true,
				captionColor: "#ffffff",
				startAngle: -90,
				legend: true,
				legendFontSize: "12px",
				legendFontFamily: "Arial,sans-serif",
				legendColor: "#000000",
				otherCaption: "other"
			};
			if( inparams && typeof(inparams) == 'object' ) {
				for( var key in inparams ) {
					params[key] = inparams[key];
				}
			}
			this.params = params;
			/* CANVASの背景を塗る */
			if( params.backgroundColor ) {
				this.ctx.beginPath();
				this.ctx.fillStyle = params.backgroundColor;
				this.ctx.fillRect(0, 0, this.canvas.width, this.canvas.height);
			}
			/* CANVAS要素の横幅が縦幅の1.5倍未満、または縦幅が200未満であれば凡例は強制的に非表示 */
			if(this.canvas.width / this.canvas.height < 1.5 || this.canvas.height < 200) {
				params.legend == false;
			}
			/* CANVAS要素の座標 */
			var canvas_pos = this._getElementAbsPos(this.canvas);
			/* 円グラフの中心座標と半径 */
			var cpos = {
				x: this.canvas.width / 2,
				y: this.canvas.height / 2,
				r: Math.min(this.canvas.width, this.canvas.height) * 0.8 / 2
			};
			/* 10項目を超えていれば、10項目目以降を"その他"に統合 */
			items = this._fold_items(items);
			var item_num = items.length;
			/* 凡例表示の場合の円グラフ中心x座標と、凡例の各種座標を算出 */
			if(params.legend == true) {
				/* 円グラフ中心x座標 */
				cpos.x = this.canvas.height * 0.1 + cpos.r;
				/* DIV要素を仮に挿入してみて高さを調べる(1行分の高さ) */
				var tmpdiv = document.createElement('DIV');
				tmpdiv.appendChild( document.createTextNode('あTEST') );
				tmpdiv.style.fontSize = params.legendFontSize;
				tmpdiv.style.fontFamily = params.legendFontFamily;
				tmpdiv.style.color = params.legendColor;
				tmpdiv.style.margin = "0";
				tmpdiv.style.padding = "0";
				tmpdiv.style.visible = "hidden";
				tmpdiv.style.position = "absolute";
				tmpdiv.style.left = canvas_pos.x.toString() + "px";
				tmpdiv.style.top = canvas_pos.y.toString() + "px";
				this.canvas.parentNode.appendChild(tmpdiv);
				/* 凡例の各種座標を算出 */
				var lpos = {
					x: this.canvas.height * 0.2 + cpos.r * 2,
					y: ( this.canvas.height - ( tmpdiv.offsetHeight * item_num + tmpdiv.offsetHeight * 0.2 * (item_num - 1) ) ) / 2,
					h: tmpdiv.offsetHeight
				};
				lpos.cx = lpos.x + lpos.h * 1.4; // 文字表示開始位置(x座標)
				lpos.cw = this.canvas.width - lpos.cx;       // 文字表示幅
				/* 仮に挿入したDIV要素を削除 */
				tmpdiv.parentNode.removeChild(tmpdiv);
			}
			/* 外円の影 */
			if( params.shadow == true ) {
				this._make_shadow(cpos);
			}
			/* 外円を黒で塗りつぶす */
			this.ctx.beginPath();
			this.ctx.arc(cpos.x, cpos.y, cpos.r, 0, Math.PI*2, false)
			this.ctx.closePath();
			this.ctx.fillStyle = "#0B7ACF";
			this.ctx.fill();
			/* 全項目の値の合計を算出 */
			var sum = 0;
			for(var i=0; i<item_num; i++) {
				var n = items[i][1];
				if( isNaN(n) || n <=0 ) {
					throw new Error('invalid graph item data.' + n);
				}
				sum += n;
			}
			if(sum <= 0) {
				throw new Error('invalid graph item data.');
			}
			/* 各項目のデフォルト色を定義 */
			var colors = ["11,122,207", "214,44,0", "248,154,5", "87,203,46", "33,156,0", "33,41,107", "115,0,90", "132,0,0", "165,99,0", "24,123,0"];
			/* 円グラフを描写 */
			var rates = new Array();
			var startAngle = this._degree2radian(params.startAngle);
			for(var i=0; i<item_num; i++) {
				/* 項目の名前 */
				var cap = items[i][0];
				/* 項目の値 */
				var n = items[i][1];
				/* 比率 */
				var r = n / sum;
				/* パーセント */
				if(r < 0.0001){
					r = 0.0001;
				}
				if(r >= 0.9999){
					r = 0.9999;
				}
				var p = Math.round(r * 1000) / 10;
				/* 描写角度（ラジアン） */
				var rad = this._degree2radian(360*r);
				/* 円弧終点角度 */
				endAngle = startAngle + rad;
				/* 円弧を描画 */
				this.ctx.beginPath();
				this.ctx.moveTo(cpos.x,cpos.y);
				this.ctx.lineTo(
					cpos.x + cpos.r * Math.cos(startAngle),
					cpos.y + cpos.r * Math.sin(startAngle)
				);
				this.ctx.arc(cpos.x, cpos.y, cpos.r, startAngle, endAngle, false);
				this.ctx.closePath();
				/* 円グラフの色を特定 */
				var rgb = colors[i];
				var rgbo = this._csscolor2rgb(items[i][2]);
				if(rgbo) {
					rgb = rgbo.r + "," + rgbo.g + "," + rgbo.b;
				}
				/* 円グラフのグラデーションをセット */
				var radgrad = this.ctx.createRadialGradient(cpos.x,cpos.y,0,cpos.x,cpos.y,cpos.r);
				radgrad.addColorStop(0, "rgba(" + rgb + ",1)");
				radgrad.addColorStop(0.7, "rgba(" + rgb + ",0.85)");
				radgrad.addColorStop(1, "rgba(" + rgb + ",0.75)");
				this.ctx.fillStyle = radgrad;
				this.ctx.fill();
				/* 円弧の枠線 */
				if(params.border == true) {
					this.ctx.stroke();
				}
				/* キャプション */
				var drate;
				var fontSize;
				if(r <= 0.03) {
					drate = 1.1;
				} else if(r <= 0.05) {
					drate = 0.9;
				} else if(r <= 0.1) {
					drate = 0.8;
				} else if(r <= 0.15) {
					drate = 0.7;
				} else {
					drate = 0.6;
				}
				var cp = {
					x: cpos.x + (cpos.r * drate) * Math.cos( (startAngle + endAngle) / 2 ),
					y: cpos.y + (cpos.r * drate) * Math.sin( (startAngle + endAngle) / 2 )
				};
				var div = document.createElement('DIV');
				if(r <= 0.05) {
					if(params.captionRate == true) {
						div.appendChild( document.createTextNode( p + "%") );
					}
				} else {
					if(params.caption == true) {
						div.appendChild( document.createTextNode(cap) );
						if(params.captionNum == true || params.captionRate == true) {
							div.appendChild( document.createElement('BR') );
						}
					}
					if(params.captionRate == true) {
						div.appendChild( document.createTextNode( p + "%" ) );
					}
					if(params.captionNum == true) {
						var numCap = n;
						if(params.caption == true || params.captionRate == true) {
							numCap = "(" + numCap + ")";
						}
						div.appendChild( document.createTextNode( numCap ) );
					}
				}
				div.style.position = 'absolute';
				div.style.textAlign = 'center';
				div.style.color = params.captionColor;
				div.style.fontSize = params.fontSize;
				div.style.fontFamily = params.fontFamily;
				div.style.margin = "0";
				div.style.padding = "0";
				div.style.visible = "hidden";
				if( params.textShadow == true ) {
					var dif = [ [ 0,  1], [ 0, -1], [ 1,  0], [ 1,  1], [ 1, -1], [-1,  0], [-1,  1], [-1, -1] ];
					for(var j=0; j<8; j++) {
						var s = div.cloneNode(true);
						this.canvas.parentNode.appendChild(s);
						s.style.color = "black";
						s.style.left = (parseFloat(cp.x - s.offsetWidth / 2 + dif[j][0])).toString() + "px";
						s.style.top = (cp.y - s.offsetHeight / 2 + dif[j][1]).toString() + "px";
					}
				}
				this.canvas.parentNode.appendChild(div);
				div.style.left = (cp.x - div.offsetWidth / 2).toString() + "px";
				div.style.top = (cp.y - div.offsetHeight / 2).toString() + "px";
				/* 凡例 */
				if(params.legend == true) {
					/* 文字 */
					var ltxt = document.createElement('DIV');
					var txtless = cap;
					if(txtless.length > 8)
						txtless = txtless.substring(0,8)+"..";
					ltxt.appendChild( document.createTextNode(txtless) );
					ltxt.title = cap;
					ltxt.style.position = "absolute";
					ltxt.style.fontSize = params.legendFontSize;
					ltxt.style.fontFamily = params.legendFontFamily;
					ltxt.style.color = params.legendColor;
					ltxt.style.margin = "0";
					ltxt.style.padding = "0";
					ltxt.style.left = lpos.cx.toString() + "px";
					ltxt.style.top = lpos.y.toString() + "px";
					ltxt.style.width = (lpos.cw).toString() + "px";
					ltxt.style.whiteSpace = "nowrap";
					ltxt.style.overflow = "hidden";
					this.canvas.parentNode.appendChild(ltxt);
					/* 記号の影 */
					if( params.shadow == true ) {
						this.ctx.beginPath();
						this.ctx.rect(lpos.x+1, lpos.y+1, lpos.h, lpos.h);
						this.ctx.fillStyle = "#222222";
						this.ctx.fill();
					}
					/* 記号 */
					this.ctx.beginPath();
					this.ctx.rect(lpos.x, lpos.y, lpos.h, lpos.h);
					this.ctx.fillStyle = "black";
					this.ctx.fill();
					this.ctx.beginPath();
					this.ctx.rect(lpos.x, lpos.y, lpos.h, lpos.h);
					var symbolr = {
						x: lpos.x + lpos.h / 2,
						y: lpos.y + lpos.h / 2,
						r: Math.sqrt(lpos.h * lpos.h * 2) / 2
					};
					var legend_radgrad = this.ctx.createRadialGradient(symbolr.x,symbolr.y,0,symbolr.x,symbolr.y,symbolr.r);
					legend_radgrad.addColorStop(0, "rgba(" + rgb + ",1)");
					legend_radgrad.addColorStop(0.7, "rgba(" + rgb + ",0.85)");
					legend_radgrad.addColorStop(1, "rgba(" + rgb + ",0.75)");
					this.ctx.fillStyle = legend_radgrad;
					this.ctx.fill();
					/* */
					lpos.y = lpos.y + lpos.h * 1.2;
				}
				/* */
				startAngle = endAngle;
			}
		};
	}
	test.prototype = t;
	var cg = new test("vbar"+index);
	if( ! cg ) { return; }
	var items = [];
	var id = 0;
	for(var key in fdStatistic[index].options){
		if(key != 0){
			var item = [];
			item[0] = fdStatistic[index].options[key];
			item[1] = (fdStatistic[index].items[key] == "0") ? 0.0000001 : parseInt(fdStatistic[index].items[key]);
			items[id] = item;
			id++;
		}
	}
	var params = {
		backgroundColor: "#fff",
		shadow: true,
		captionNum: true,
		startAngle: -90
	};
	try{
	cg.draw(items, params);
	}catch(e){}
}
//柱状图
function singleSelect_graphHistogram(index){
	var t = new html5jp.graph.vbar("vbar" + index);
	function test(){
		this._draw_x_scale_label = function(pos){
			var p = this.params;
			if( p.x.length > 0 ) {
				/* 标题文字x轴 */
				var text = p.x[0].toString();
				if(text != "") {
					/* 计算文字标题区的x轴的大小 */
					var s = this._getTextBoxSize(text, p.xCaptionFontSize, p.xCaptionFontFamily);
					/* 计算文字标题区的x轴左上角的坐标 */
					var x = Math.round( p.cpos.x0 + p.cpos.w/2 - s.w/2 );
					/* 绘制x轴的标题文字 */
					this._drawText(x, p.cpos.y_caption_y, text, p.xCaptionFontSize, p.xCaptionFontFamily, p.xCaptionColor);
				}
			}
			if( p.xScale == true && p.x.length > 1 ) {
				var width = p.cpos.w / pos.length;
				for(var i=0; i<pos.length; i++) {
					if(i + 1 > p.x.length - 1) { break; }
					/* 文本x轴的刻度 */
					var text = p.x[i+1].toString();
					if(text == "") { continue; }
					/* 计算文本区域的x轴的大小规模 */
					var s = this._getTextBoxSize(text, p.xScaleFontSize, p.xScaleFontFamily);
					/* 计算的左上角的坐标，以绘制文本x轴规模 */
					var x = Math.round( pos[i] - width / 2 );
					/* 画一个文本x轴的刻度 */
					this._drawText1(x, p.cpos.x_scale_y, text, p.xScaleFontSize, p.xScaleFontFamily, p.xScaleColor,width);
				}
			}
		};

		
		this._drawText1 = function(x, y, text, font_size, font_family, color,width){
			var span = document.createElement('SPAN');
			var textless = text;
			if(text.length > 8)
				textless = text.substring(0,8)+"..";  
			span.appendChild( document.createTextNode(textless) );
			span.title = text;
			span.style.cssText = "word-break: break-all";
			span.style.fontSize = font_size;
			span.style.fontFamily = font_family;
			span.style.color = color;
			span.style.margin = "0";
			span.style.padding = "0";
			span.style.position = "absolute";
			span.style.display = 'block';
			span.style.float = 'left';
			span.style.left = x.toString() + "px";
			if(!y)
				y = 0;
			span.style.top = y.toString() + "px";
			if(width)
				span.style.width = width+"px";
			span.style.textAlign="center";
			this.canvas.parentNode.appendChild(span);
		};
	}
	test.prototype = t;
	var g = new test("vbar"+index);
	if(!g) { return; }
	var items = [fdStatistic[index].items];
	for(var key in items[0]){
		if(key > 0){
			items[0][key] = parseInt(items[0][key]);
		}
	}
	var xx = [];
	var optionTxt = "";
	for(var key in fdStatistic[index].options){
		if(key == 0)
			optionTxt = "";//$('<div></div>').append(fdStatistic[index].options[key]).text();
		else 
			optionTxt = fdStatistic[index].options[key];
		xx[key] = optionTxt;
	}
   	var options = {
   		x: xx,
		y: [""]
   	};
	g.draw(items, options);
}
/**
* 查看其他答案
*/
function singleSelect_viewOtherAnswer(index)
{
	var questionId = $('#questionId'+index).val();
	Com_OpenWindow('<c:url value="/km/pindagate/km_pindagate_question_res/kmPindagateQuestionRes.do?method=list&questionId='+questionId+'&otherText=other&type=other" />');
}

/**
* 查看选择原因答案
*/
function singleSelect_viewSelectReasonAnswer(index)
{
	var questionId = $('#questionId'+index).val();
	Com_OpenWindow('<c:url value="/km/pindagate/km_pindagate_question_res/kmPindagateQuestionRes.do?method=list&questionId='+questionId+'&type=selectReason" />');
}
</script>
<div id="${HtmlParam.divId}" class="pi_question" style="margin-top: -15px;">
<div style="text-align: left"><canvas width="500" height="300" id="vbar${HtmlParam.index}"></canvas></div>
</div>