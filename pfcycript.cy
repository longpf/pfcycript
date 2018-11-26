
(function(exports){



	var invalidParamStr = 'Invalid parameter';
	var missingParamStr = 'Missing parameter';

	// hook touchesBegan:withEvent: 方便快捷找到对应view
	@import com.saurik.substrate.MS 
	var oldm_touchbegin = function(){};
	exports.touchobj = 0;
	MS.hookMessage(UIResponder,
		@selector(touchesBegan:withEvent:),
		function(touches,event) {
			exports.touchobj=this;
			// // 添加一个带颜色的view 便于观察
			// var aview = [new UIView init];
			// [aview setFrame: [this bounds]];
		 //    [aview setBackgroundColor:[UIColor redColor]];
		 //    [aview setAlpha:0.5];
			// [aview performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
			// [this addSubview:aview];
			oldm_touchbegin->call(this,touches,event);
		},oldm_touchbegin);


	




	PFTopVC = function(){
		return _PFTopVC(UIApp.keyWindow.rootViewController);
	};


	var _PFTopVC = function(vc){
		if (vc.presentedViewController) {
        	return _PFTopVC(vc.presentedViewController);
	    }else if ([vc isKindOfClass:[UITabBarController class]]) {
	        return _PFTopVC(vc.selectedViewController);
	    } else if ([vc isKindOfClass:[UINavigationController class]]) {
	        return _PFTopVC(vc.visibleViewController);
	    } else {
	    	var count = vc.childViewControllers.count;
    		for (var i = count - 1; i >= 0; i--) {
    			var childVc = vc.childViewControllers[i];
    			if (childVc && childVc.view.window) {
    				vc = _PFTopVC(childVc);
    				break;
    			}
    		}
	        return vc;
    	}
	}

})(exports);