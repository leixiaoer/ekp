/*
 * 插件修改过
 */
(function($) {
	$.fn.tipsy = function(options) {

		options = $.extend({}, $.fn.tipsy.defaults, options);

		return this.each(function() {
			var opts = $.fn.tipsy.elementOptions(this, options);
			var classPrefix = opts.className || "defaults";
			// alert(classPrefix);
			$(this).mouseover(function() {
				$.fn.tipsy.defaults.global_flag = true;
				$.data(this, 'cancel.tipsy', true);
				var tip = $.data(this, 'active.tipsy');
				if (!tip) {
					tip = $('<div  class="' + classPrefix
							+ 'tipsy"><div class="' + classPrefix
							+ 'tipsy-inner"/></div>');
					tip.css({
								position : 'absolute',
								zIndex : 100000
							});
					$.data(this, 'active.tipsy', tip);
				}

				if ($(this).attr('title')
						|| typeof($(this).attr('original-title')) != 'string') {
					$(this).attr('original-title', $(this).attr('title') || '')
							.removeAttr('title');
				}
				var title;
				// 修正特殊调用
				// if (typeof opts.title == 'string') {
				// title = $(this).attr(opts.title == 'title' ? 'original-title'
				// : opts.title);
				// } else if (typeof opts.title == 'function') {
				// title = opts.title.call(this);
				// }
				if (typeof opts.title == 'string') {
					title = opts.title;
				} else if ($(this).attr('title')) {
					title = $(this).attr('title');
				} else {
					title = "title";
				}
				tip.find('.' + classPrefix + 'tipsy-inner')[opts.html
						? 'html'
						: 'text'](title || opts.fallback);

				var pos = $.extend({}, $(this).offset(), {
							width : this.offsetWidth,
							height : this.offsetHeight
						});
				tip.get(0).className = '' + classPrefix + 'tipsy'; // reset
																	// classname
																	// in case
																	// of
																	// dynamic
																	// gravity
				tip.remove().css({
							top : 0,
							left : 0,
							visibility : 'hidden',
							display : 'block'
						}).appendTo(document.body);
				var actualWidth = tip[0].offsetWidth, actualHeight = tip[0].offsetHeight;
				var gravity = (typeof opts.gravity == 'function')
						? opts.gravity.call(this)
						: opts.gravity;

				switch (gravity.charAt(0)) {
					case 'n' :
						tip.css({
									top : pos.top + pos.height,
									left : pos.left + pos.width / 2
											- actualWidth / 2
								}).addClass('' + classPrefix + 'tipsy-north');
						break;
					case 's' :
						tip.css({
									top : pos.top - actualHeight,
									left : pos.left + pos.width / 2
											- actualWidth / 2
								}).addClass('' + classPrefix + 'tipsy-south');
						break;
					case 'e' :
						tip.css({
									top : pos.top + pos.height / 2
											- actualHeight / 2,
									left : pos.left - actualWidth
								}).addClass('' + classPrefix + 'tipsy-east');
						break;
					case 'w' :
						tip.css({
									top : pos.top + pos.height / 2
											- actualHeight / 2,
									left : pos.left + pos.width
								}).addClass('' + classPrefix + 'tipsy-west');
						break;
				}

				if (opts.fade) {
					tip.css({
								opacity : 0,
								display : 'block',
								visibility : 'visible'
							}).animate({
								opacity : 0.8
							});
				} else {
					tip.css({
								visibility : 'visible'
							});
				}
				var parent = $(this);

				$(tip).hover(function() {
							$(this).data("flag", true);
						}, function() {
							opts.check = false;
							setTimeout(function() {
									$(tip).stop().fadeOut(100, function() {
										$(tip).remove();
									});
//								}
							}, 200);
						})

			});

			$(this).mouseout(function() {
						$.data(this, 'cancel.tipsy', false);
//						$.fn.tipsy.defaults.global_flag = false;
						var self = this;
						setTimeout(function() {
									if ($(self).attr("cancel.tipsy"))
										return;
									var tip = $.data(self, 'active.tipsy');
									var flag = $(tip).data("flag");
									if (typeof(flag) == 'undefined' || !flag) {
										tip.stop().fadeOut(200, function() {
													$(this).remove();
												});
									} else {
										// tip.remove();
									}
								}, 100);

					});

		});

	};

	// Overwrite this method to provide options on a per-element basis.
	// For example, you could store the gravity in a 'tipsy-gravity' attribute:
	// return $.extend({}, options, {gravity: $(ele).attr('tipsy-gravity') ||
	// 'n' });
	// (remember - do not modify 'options' in place!)
	$.fn.tipsy.elementOptions = function(ele, options) {
		return $.metadata ? $.extend({}, options, $(ele).metadata()) : options;
	};

	$.fn.tipsy.defaults = {
		fade : false,
		fallback : '',
		gravity : 'n',
		html : false,
		title : 'title',
		className : 'defaults',
		global_flag : false,
		global_div:false
	};

	$.fn.tipsy.autoNS = function() {
		return $(this).offset().top > ($(document).scrollTop() + $(window)
				.height()
				/ 2) ? 's' : 'n';
	};

	$.fn.tipsy.autoWE = function() {
		return $(this).offset().left > ($(document).scrollLeft() + $(window)
				.width()
				/ 2) ? 'e' : 'w';
	};
})(jQuery);
