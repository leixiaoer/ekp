!function(e,t){"object"==typeof exports&&"undefined"!=typeof module?t(exports):"function"==typeof define&&define.amd?define(["exports"],t):t((e=e||self).WPS={})}(this,function(e){"use strict";var t,n,o=function(){return(o=Object.assign||function(e){for(var t,n=1,o=arguments.length;n<o;n++)for(var r in t=arguments[n])Object.prototype.hasOwnProperty.call(t,r)&&(e[r]=t[r]);return e}).apply(this,arguments)},r=function(){function e(){}return e.add=function(t){e._handleList.push(t),window.addEventListener("message",t,!1)},e.remove=function(t){var n=e._handleList.indexOf(t);n>=0&&e._handleList.splice(n,1),window.removeEventListener("message",t,!1)},e.empty=function(){for(;e._handleList.length;)window.removeEventListener("message",e._handleList.shift(),!1)},e.parse=function(e){return"object"==typeof e?e:JSON.parse(e)},e._handleList=[],e}();!function(e){e.unknown="unknown",e.spreadsheet="s",e.writer="w",e.presentation="p",e.pdf="f"}(t||(t={})),function(e){e.wps="w",e.et="s",e.presentation="p",e.pdf="f"}(n||(n={}));var i,a,p,s,c,u,d,f=(i=0,function(){return++i}),l=(a=null,function(e,t){if(!a){a=document.createElement("iframe");var n={id:"wps-iframe",src:e,scrolling:"no",frameborder:"0",allowfullscreen:"allowfullscreen",webkitallowfullscreen:"true",mozallowfullscreen:"true"};for(var o in n)a.setAttribute(o,n[o]);t?t.appendChild(a):document.body.appendChild(a),a.destroy=function(){a.parentNode.removeChild(a),a=null}}return a}),m=function(e){l().contentWindow.postMessage(JSON.stringify(e),"*")},v=function(e){return new Promise(function(t){var n=f();e.type=w();var o=function(e){var i=r.parse(e.data);"wps.api.reply"===i.eventName&&i.msgId===n&&(t(i.data),r.remove(o))};r.add(o),m({eventName:"wps.jssdk.api",data:e,msgId:n})})},y=function(e){var t=o({},e),n=t.headers,r=void 0===n?{}:n,i=t.subscriptions,a=void 0===i?{}:i,p=(t.wpsUrl,r.backBtn),s=void 0===p?{}:p,c=r.shareBtn,u=void 0===c?{}:c,d=r.otherMenuBtn,f=void 0===d?{}:d,l=function(e,t){e.subscribe&&"function"==typeof e.subscribe&&(e.callback=t,a[t]=e.subscribe,delete e.subscribe)};if(l(s,"wpsconfig_back_btn"),l(u,"wpsconfig_share_btn"),l(f,"wpsconfig_other_menu_btn"),f.items&&Array.isArray(f.items)){var m=[];f.items.forEach(function(e,t){switch(void 0===e&&(e={}),e.type){case"export_img":e.type=1,e.callback="export_img";break;case"export_pdf":e.type=1,e.callback="export_pdf";break;case"save_version":e.type=1,e.callback="save_version";break;case"about_wps":e.type=1,e.callback="about_wps";break;case"split_line":e.type=2;break;case"custom":e.type=3,l(e,"wpsconfig_other_menu_btn_"+t),m.push(e)}}),m.length&&(b||F)&&(f.items=m)}if("object"==typeof a.print){var v="wpsconfig_print";"function"==typeof a.print.subscribe&&(a[v]=a.print.subscribe,t.print={callback:v},void 0!==a.print.custom&&(t.print.custom=a.print.custom)),delete a.print}"function"==typeof a.exportPdf&&(a[v="wpsconfig_export_pdf"]=a.exportPdf,t.exportPdf={callback:v},delete a.exportPdf);return o({},t,{subscriptions:a})},w=(p="",function(e){if(void 0===e&&(e=""),!p&&e){var o=e.toLowerCase();-1!==o.indexOf("/office/s/")&&(p=t.spreadsheet),-1!==o.indexOf("/office/w/")&&(p=t.writer),-1!==o.indexOf("/office/p/")&&(p=t.presentation),-1!==o.indexOf("/office/f/")&&(p=t.pdf)}if(!p){var r=e.match(/[\?&]type=([a-z]+)/)||[];p=n[r[1]]||""}return p}),x=window.navigator.userAgent.toLowerCase(),b=/Android|webOS|iPhone|iPod|BlackBerry|iPad/i.test(x),F=function(){try{return-1!==window._parent.location.search.indexOf("from=wxminiprogram")}catch(e){return!1}}();!function(e){e[e.wdExportFormatPDF=17]="wdExportFormatPDF",e[e.wdExportFormatXPS=18]="wdExportFormatXPS"}(s||(s={})),function(e){e[e.wdExportAllDocument=0]="wdExportAllDocument",e[e.wdExportSelection=1]="wdExportSelection",e[e.wdExportCurrentPage=2]="wdExportCurrentPage",e[e.wdExportFromTo=3]="wdExportFromTo"}(c||(c={})),function(e){e[e.wdExportDocumentContent=0]="wdExportDocumentContent",e[e.wdExportDocumentWithMarkup=7]="wdExportDocumentWithMarkup"}(u||(u={})),function(e){e[e.title=1]="title",e[e.tag=2]="tag"}(d||(d={}));var A;!function(e){e[e.xlTypePDF=0]="xlTypePDF",e[e.xlTypeXPS=1]="xlTypeXPS"}(A||(A={}));var P,E,h;!function(e){e[e.ppFixedFormatTypePDF=2]="ppFixedFormatTypePDF",e[e.ppFixedFormatTypeXPS=1]="ppFixedFormatTypeXPS"}(P||(P={})),function(e){e[e.ppPrintAll=1]="ppPrintAll",e[e.ppPrintCurrent=3]="ppPrintCurrent"}(E||(E={})),function(e){e[e.msoFalse=0]="msoFalse",e[e.msoTrue=-1]="msoTrue"}(h||(h={}));var g,k,D=function(){return new Promise(function(e){return k=e})},_=function(e){return"wps.advanced.api.ready"===e||"web_loaded"===e},T=function(e,t){void 0===e&&(e={});r.add(function(n){var o=r.parse(n.data),i=o.eventName,a=void 0===i?"":i,p=o.data,s=void 0===p?null:p,c=o.url,u=void 0===c?null:c;-1===["wps.jssdk.api"].indexOf(a)&&("ready"===a&&(m({eventName:"setConfig",data:e}),g.tokenData&&m({eventName:"setToken",data:g.tokenData}),k(),g.iframeReady=!0),_(a)&&S(),"function"==typeof t[a]&&t[a](g,u||s))})},S=function(){var e=w(g.url);e===t.writer&&function(e){e.WpsApplication=function(){return{ActiveDocument:{ExportAsFixedFormatAsync:function(e){var t={api:"WpsApplication().ActiveDocument.ExportAsFixedFormatAsync",args:o({ExportFormat:s.wdExportFormatPDF,Range:c.wdExportAllDocument,From:1,To:1,Item:u.wdExportDocumentWithMarkup,IncludeDocProps:!0},"object"==typeof e?e:{})};return v(t)},ImportDataIntoFieldsAsync:function(e){var t={api:"WpsApplication().ActiveDocument.ImportDataIntoFieldsAsync",args:{Data:e.Data,Options:e.Options}};return v(t)}},Enum:o({},s,c,u)}}}(g),e===t.spreadsheet&&function(e){e.EtApplication=function(){return{ActiveWorkbook:{ExportAsFixedFormatAsync:function(e){var t={api:"EtApplication().ActiveWorkbook.ExportAsFixedFormatAsync",args:o({Type:A.xlTypePDF,IncludeDocProps:!0},"object"==typeof e?e:{})};return v(t)},ActiveSheet:{ExportAsFixedFormatAsync:function(e){var t={api:"EtApplication().ActiveWorkbook.ActiveSheet.ExportAsFixedFormatAsync",args:o({Type:A.xlTypePDF,IncludeDocProps:!0},"object"==typeof e?e:{})};return v(t)}}},Enum:o({},A)}}}(g),e===t.presentation&&function(e){e.WppApplication=function(){return{ActivePresentation:{ExportAsFixedFormatAsync:function(e){var t={api:"WppApplication().ActivePresentation.ExportAsFixedFormatAsync",args:o({FixedFormatType:P.ppFixedFormatTypePDF,RangeType:E.ppPrintAll,FrameSlides:h.msoTrue},"object"==typeof e?e:{})};return v(t)}},Enum:o({},P,E)}}}(g)};console.log("WPS WebOffice JS-SDK V1.0.9"),e.config=function(e){void 0===e&&(e={}),g&&g.destroy();try{var t,n=y(e),i=n.wpsUrl,a=n.subscriptions,p=void 0===a?{}:a,s=n.mount,c=l(i,void 0===s?null:s);return delete n.mount,delete n.wpsUrl,delete n.subscriptions,D(),g={url:i,version:"1.0.9",iframe:c,Enum:o({},h),iframeReady:!1,tokenData:null,setToken:function(e){g.tokenData=e,g.iframeReady&&m({eventName:"setToken",data:e})},ready:function(){return t||(t=new Promise(function(e){var t=function(n){var o=r.parse(n.data).eventName;_(o)&&(e(),r.remove(t))};r.add(t)}))},destroy:function(){c.destroy(),r.empty(),g=null},save:function(){return v({api:"save"})}},T(n,p),g.ready(),g}catch(e){console.error(e)}},Object.defineProperty(e,"__esModule",{value:!0})});
