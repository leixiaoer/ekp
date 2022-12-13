

define(function(require, exports, module) {
	var $ = require('lui/jquery');
	var str = require('lui/util/str');
	
	var ResourceLoadMixin = {
		
		_parseFormScript: function(cfg) {
			if (cfg.src || !cfg.element) {
				return;
			}
			var elem = $(cfg.element).children("script[type='text/code']");
			if (elem.length < 1) {
				return;
			}
			if (elem.attr('xsrc') != null) {
				cfg.src = elem.attr('xsrc');
			} else {
				cfg.code = str.decodeHTML(elem.html());
			}
		},
		
		_initResource: function(cfg,xobj) {
			if(this._loaded)
				return;
//			this._loaded = false;
			this._try_times = 1;
			this._parseFormScript(cfg); 
			if(xobj != null && cfg.src != null)
				cfg.reqUrl = xobj.getEnv().fn.formatUrl(cfg.src);
			this.code = cfg.code;
			this.dataType = cfg.dataType;
			
			if (cfg.code) {
				this._onLoad(cfg.code);
				this._loaded = true;
			} else if(cfg.reqUrl) {
				this.loadResource(cfg.reqUrl);
			} else {
				this._byDefault();
				this._loaded = true;
			}
		},
		
		loadResource: function(url) {
			if(url.indexOf('s_cache=')<0){
				if(url.indexOf("?")>=0){
					url = url + "&s_cache=" + seajs.data.env.cache;
				}else{
					url = url + "?s_cache=" + seajs.data.env.cache;
				}
			}
			
			// 增加多语言切换参数，防止国际化因为缓存导致无效
			if (url.indexOf('s_locale=') < 0){
				if(seajs.data.env.locale)
					url += '&s_locale=' + seajs.data.env.locale;
			}
				
			var self = this;
			this._loaded = false;
			
			$.ajax({
            	url: url,
            	dataType: this.dataType || 'text',
            	jsonp : "jsonpcallback",
            	success: function(txt){
            		if('jsonp' == self.dataType)
            			txt = txt.text;
            		self._loaded = true;
            		self._onLoad(txt);
            	},
                error: function() {
                	self._loaded = true;
                	self._byDefault();
                }
            });
		},
		
		_onLoad: function(txt) {
			
		},
		
		_byDefault: function() {
			
		},
		
		_resReady: function(draw, data, callback) {
			if (this._loaded) {
				draw(data, callback);
				return;
			}
			this._try_times ++;
    		if (this._try_times > 5000) {
    			return;
    		};
	    	var self = this;
	    	setTimeout(function() {
	    		self._resReady(draw, data, callback);
	    	}, 20);
		}
	};
	
	
	exports.ResourceLoadMixin = ResourceLoadMixin;
});