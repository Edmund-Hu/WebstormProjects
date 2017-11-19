/*
 * 编写 & 整理 by yinml at 20140929
 */

//屏蔽F5、F11、F12等按键
function shieldKeyboard(){
    //屏蔽F1
    window.onhelp = function(){return false;}
    
    //屏蔽鼠标右键
    document.oncontextmenu = function(){event.returnValue=false;}
    //屏蔽选择
    document.onselectstart = function(){
    	var tagName = document.activeElement.tagName;
        tagName = tagName + "";
        tagName = tagName.toUpperCase();
        if(tagName == "INPUT"){
            var type = document.activeElement.getAttribute("type") || document.activeElement.type;
            type = type + "";
            type = type.toLowerCase();
            if(type == "textarea" || type == "text"){
                //如果在文本框中，则允许退格删除
                return;
            }
        }
    	event.returnValue=false;
    }
    document.ondragstart = function(){
    	event.returnValue=false;
    }
    document.onbeforecopy = function(){
    	event.returnValue=false;
    }
    document.oncopy = function(){
    	if(document.selection){
    		document.selection.empty();
    	}
    }
    document.onselect = function(){
    	if(document.selection){
    		document.selection.empty();
    	}
    }
        
    document.onkeydown = function(event){
        
        var e = window.event || event;
        
        if ((e.altKey)&&
            ((e.keyCode==37)||   // 屏蔽 Alt+ 方向键 ←
            (e.keyCode==39)))   // 屏蔽 Alt+ 方向键 →
        {
            e.keyCode=0;
            //alert("不准你使用ALT+方向键前进或后退网页！");
            e.returnValue=false;
            return false;
        }
        
        if (((e.altKey) && (e.keyCode==8)) || (e.keyCode==8)){
            // 屏蔽退格删除键
            if(document.activeElement){
                
                var specAttr = document.activeElement.getAttribute("allowBackSpace");
                specAttr = specAttr + "";
                specAttr = specAttr.toLowerCase();
                if(specAttr == "true"){
                    //如果当前焦点所在元素有指定属性，且值为true，则允许退格删除
                    return false;
                }
                
                var tagName = document.activeElement.tagName;
                tagName = tagName + "";
                tagName = tagName.toUpperCase();
                if(tagName == "INPUT" || tagName == "TEXTAREA" || tagName == "PASSWORD"){
                	return;
                }
                
                var type = document.activeElement.getAttribute("type") || document.activeElement.type;
                type = type + "";
                type = type.toLowerCase();
                if(type == "textarea" || type == "text" || type == "password"){
                    //如果在文本框中，则允许退格删除
                    return;
                }
            }
            
            e.keyCode=0;
            e.returnValue=false;
            return false;
            
        }
        
        //  注：这还不是真正地屏蔽 Alt+ 方向键， 因为 Alt+ 方向键弹出警告框时，按住 Alt 键不放，
        //  用鼠标点掉警告框，这种屏蔽方法就失效了。以后若 有哪位高手有真正屏蔽 Alt 键的方法，请告知。
         
        if ((e.keyCode==116)||                 // 屏蔽 F5 刷新键
            (e.keyCode==112)||                 // 屏蔽 F1 刷新键
            (e.keyCode==113)||                 // 屏蔽 F2 刷新键
            (e.keyCode==114)||                 // 屏蔽 F3 刷新键
            (e.keyCode==115)||                 // 屏蔽 F4 刷新键
            (e.ctrlKey && e.keyCode==82)) // Ctrl + R
        {
            e.keyCode=0;
            e.returnValue=false;
            return false;
        }
        
        if ((e.altKey) && (
            (e.keyCode==116)||                 // 屏蔽 F5 刷新键
            (e.keyCode==112)||                 // 屏蔽 F1 
            (e.keyCode==113)||                 // 屏蔽 F2 
            (e.keyCode==114)||                 // 屏蔽 F3 
            (e.keyCode==115)))                 // 屏蔽 F4 刷新键
        {
            e.keyCode=0;
            e.returnValue=false;
            return false;
        }
        
        // 屏蔽F11
        if (e.keyCode==122){
            e.keyCode=0;
            e.returnValue=false;
            return false;
        }

        // 屏蔽 Ctrl+n
        if (e.ctrlKey && e.keyCode==78){
            e.returnValue=false;
            return false;
        }

        if (e.shiftKey && e.keyCode==121){
            e.returnValue=false;
            return false;
        }

        // 屏蔽 shift+F10
        if (e.srcElement.tagName == "A" && e.shiftKey){
            e.returnValue = false;// 屏蔽 按住shift后点击A标签
            return false;
        }
        
        //鼠标左键新开一网页
        if ((e.altKey)&&(e.keyCode==115)){
            //屏蔽Alt+F4
            window.showModelessDialog("about:blank","","dialogWidth:1px;dialogheight:1px");
            return false;
        }
    }
}
shieldKeyboard();

var loading = function(){
	
	var st_loading = new stLoading();
	st_loading.create();
	
	this.show = function(msg){
		
		//loading图案要一直处于屏幕正中间，当有滚动条时，相对屏幕正中间
		//x值应该是scrollLeft+可视区域宽度/2
		//y值应该是scrollTop+可视区域高度/2
		
		var x = $(window).width()/2+$(window).scrollLeft();
		if(window.top){
			x = $(window.top.window).width()/2+$("#maindiv", $(top.document)).scrollLeft();
		}
		
		var y = $(window).height()/2+$(window).scrollTop();
		if(window.top){
			y = $("#maindiv", $(top.document)).height()/2+$("#maindiv", $(top.document)).scrollTop();
		}
		
		st_loading.show(msg, x, y);
	}
	
	this.hide = function(){
		st_loading.hide();
	}
}

//创建loading效果
var loading = new loading();

/*
 * 缓存用的util
 */
var cacheUtil = {
    //根据key获取缓存值
    getCache : function(key){
        if(key == null || key == undefined){
            return null;
        }
        if(top && top.head_frame && top.head_frame.cache){
            return top.head_frame.cache.get(key);
        }
    },
    //按照key，存入缓存值
    setCache:function(key, value){
        if(key == null || key == undefined){
            return;
        }
        if(top && top.head_frame && top.head_frame.cache){
            top.head_frame.cache.put(key, value);
        }
    },
    //根据key，删除缓存值
    deleteCache:function(key){
        if(key == null || key == undefined){
            return;
        }
        if(top && top.head_frame && top.head_frame.cache){
            top.head_frame.cache.remove(key);
        }
    },
    //以传入参数作为key的前缀，删除匹配的缓存值
    deleteByPre:function(pre){
        if(pre == null || pre == undefined){
            return;
        }
        if(typeof(pre) != 'string'){
            throw new Error(-1, "传入参数必须是string类型！");
            return;
        }
        if(top && top.head_frame && top.head_frame.cache){
        
            var len = top.head_frame.cache.size();
            for (var i = 0; i < len; i++) {
                var k = top.head_frame.cache.keys[i];
                if(k){
                    if(k.indexOf(pre) == 0){
                        top.head_frame.cache.remove(k);
                        len = top.head_frame.cache.size();
                        i--;
                    }
                }
            }
        }
    },
    //删除非以传入参数作为key的前缀匹配的缓存值
    deleteWithoutPre:function(pre){
        if(pre == null || pre == undefined){
            return;
        }
        if(typeof(pre) != 'string'){
            throw new Error(-1, "传入参数必须是string类型！");
            return;
        }
        if(top && top.head_frame && top.head_frame.cache){
        
            var len = top.head_frame.cache.size();
            for (var i = 0; i < len; i++) {
                var k = top.head_frame.cache.keys[i];
                if(k){
                    if(k.indexOf(pre) == 0){
                        continue;   
                    }
                    top.head_frame.cache.remove(k);
                    len = top.head_frame.cache.size();
                    i--;
                }
            }
        }
    },
    //删除所有缓存
    deleteAll:function(delAllMark){
        if(top && top.head_frame && top.head_frame.cache){
            if("true" == delAllMark){
                top.head_frame.cache.clear();
            }else{
                this.deleteWithoutPre("GLOBAL_");
            }
        }
    }
}

/**
 * 金额格式化
 * @param s要格式化的数值
 * @param n保留的小数位数，自动四舍五入
 * @returns String
 */
function moneyFormat(s,n){
    var n = n > 0 && n <= 20 ? n : 2; 
    if(s == null || s == undefined || s=="") {
        var str = "";
        for(var i=0;i<n;i++) {
            str+="0";
        }
        return "0."+str;
    }
    var a ="";
    if(s<0){s=s*(-1); a= "-";}
    var s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + ""; 
    var l = s.split(".")[0].split("").reverse(), r = s.split(".")[1]; 
    var t = ""; 
    for (i = 0; i < l.length; i++) { 
    t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : ""); 
    } 
    return a+t.split("").reverse().join("") + "." + r; 
}

/*
 * window延迟加载函数
 */
function delaysetload() {
	var oldonload = window.onload; // 注意：oldonload不能重名，否则会出现 to much recursion
									// 的异常；
	window.onload = function() {
		load_init(); // 页面加载完成时调用的函数
		if (oldonload != null && oldonload != undefined && isNaN(oldonload)) {
			oldonload();
		}
	}
}

/*
 * 窗口延时resize
 */
function delaysetresize() {
	var oldonresize = window.onresize; // 注意：oldonresize不能重名，否则会出现 to much
										// recursion 的异常；
	window.onresize = function() {
		load_init(); // 页面缩放完成时调用的函数
		if (oldonresize != null && oldonresize != undefined
				&& isNaN(oldonresize)) {
			oldonresize();
		}
	}
}



//----------------------------日期 start-----------------------------
/*
 * 将字符串形式的日期数据格式化
 */
function strDateTime(str) {
	var r = str.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/);
	if (r == null)
		return false;
	var d = new Date(r[1], r[3] - 1, r[4]);
	return (d.getFullYear() == r[1] && (d.getMonth() + 1) == r[3] && d
			.getDate() == r[4]);
}

/* 
 * 两个日期相差的天数 
 */
function DateDiff(sDate1, sDate2) {
	var aDate, oDate1, oDate2, iDays
	aDate = sDate1.split("-")
	oDate1 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0])
	aDate = sDate2.split("-")
	oDate2 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0])
	iDays = parseInt(Math.abs(oDate1 - oDate2) / 1000 / 60 / 60 / 24)
	return iDays
}

/*
 * 日期比较，传入日期格式需要为yyyy-mm-dd
 */
function compareDate(startDate, endDate) {

	var startArr = startDate.split("-");
	var endArr = endDate.split("-");
	var start = new Date();
	var end = new Date();

	var starty = parseInt(startArr[0], 10);
	var endy = parseInt(endArr[0], 10);

	var startm = parseInt(startArr[1], 10) - 1;
	var endm = parseInt(endArr[1], 10) - 1;

	var startd = parseInt(startArr[2], 10);
	var endd = parseInt(endArr[2], 10);
	if (starty > endy) {
		return true;
	} else if (startm > endm && starty == endy) {
		return true;
	} else if (starty == endy && startm == endm && startd > endd) {
		return true;
	} else {
		return false;
	}
}

/*
 * 在指定的日期基础上增加
 * dtDate:日期
 * NumDay:数量
 * strInterval：s-秒/n-分/h-小时/d-天/w-星期/m-月/y-年
 */
function DateAdd(dtDate, NumDay, strInterval) {
	var dtTmp = new Date(dtDate);
	if (isNaN(dtTmp)) {
		dtTmp = new Date();
	}
	switch (strInterval) {
		case "s" :
			dtTmp = new Date(Date.parse(dtTmp) + (1000 * parseInt(NumDay)));
			break;
		case "n" :
			dtTmp = new Date(Date.parse(dtTmp) + (60000 * parseInt(NumDay)));
			break;
		case "h" :
			dtTmp = new Date(Date.parse(dtTmp) + (3600000 * parseInt(NumDay)));
			break;
		case "d" :
			dtTmp = new Date(Date.parse(dtTmp) + (86400000 * parseInt(NumDay)));
			break;
		case "w" :
			dtTmp = new Date(Date.parse(dtTmp)
					+ ((86400000 * 7) * parseInt(NumDay)));
			break;
		case "m" :
			dtTmp = new Date(dtTmp.getFullYear(), (dtTmp.getMonth())
							+ parseInt(NumDay), dtTmp.getDate(), dtTmp
							.getHours(), dtTmp.getMinutes(), dtTmp.getSeconds());
			break;
		case "y" :
			dtTmp = new Date(dtTmp.getFullYear() + parseInt(NumDay), dtTmp
							.getMonth(), dtTmp.getDate(), dtTmp.getHours(),
					dtTmp.getMinutes(), dtTmp.getSeconds());
			break;
	}
	var mStr = new String(dtTmp.getMonth() + 1);
	var dStr = new String(dtTmp.getDate());
	if (mStr.length == 1) {
		mStr = "0" + mStr;
	}
	if (dStr.length == 1) {
		dStr = "0" + dStr;
	}
	try {
		return new Date((dtTmp.getFullYear() + "-" + mStr + "-" + dStr)
				.replace(/-/g, "/"));
	} catch (e) {
		return null;
	}
}

//----------------------------日期 end-----------------------------


//----------------------------select控件的控制 start-----------------------------

// 1.判断是否存在指定value对应的option
function selectIsExitItem(objSelect, objItemValue) {
	var isExit = false;
	for (var i = 0; i < objSelect.options.length; i++) {
		if (objSelect.options[i].value == objItemValue) {
			isExit = true;
			break;
		}
	}
	return isExit;
}
// 2.向select选项中 加入一个Item
function addItemToSelect(objSelect, objItemText, objItemValue, isFilterExist) {
	// 判断是否存在
	if (isFilterExist && selectIsExitItem(objSelect, objItemValue)) {
		// alert("该Item的Value值已经存在");
	} else {
		var varItem = new Option(objItemText, objItemValue);
		objSelect.options.add(varItem);
		return varItem;
		// alert("成功加入");
	}
}
// 3.从select选项中根据value删除一个Item
function removeItemFromSelect(objSelect, objItemValue) {
	// 判断是否存在
	if (selectIsExitItem(objSelect, objItemValue)) {
		for (var i = 0; i < objSelect.options.length; i++) {
			if (objSelect.options[i].value == objItemValue) {
				objSelect.options.remove(i);
				break;
			}
		}
		// alert("成功删除");
	} else {
		// alert("该select中 不存在该项");
	}
}
// 4.删除select中选中的项
function removeSelectedItemFromSelect(objSelect) {
	var length = objSelect.options.length - 1;
	for (var i = length; i >= 0; i--) {
		if (objSelect[i].selected == true) {
			objSelect.options[i] = null;
		}
	}
}
// 5.修改select选项中 value=objItemValue的text为objItemText
function updateItemToSelect(objSelect, objItemText, objItemValue) {

	for (var i = 0; i < objSelect.options.length; i++) {
		if (objSelect.options[i].value == objItemValue) {
			objSelect.options[i].text = objItemText;
			break;
		}
	}
}
// 6.设置select中text=objItemText的第一个Item为选中
function selectItemByText(objSelect, objItemText) {
	// 判断是否存在
	var isExit = false;
	for (var i = 0; i < objSelect.options.length; i++) {
		if (objSelect.options[i].text == objItemText) {
			objSelect.options[i].selected = true;
			isExit = true;
			break;
		}
	}
}
// 7.设置select中value="paraValue"的第一个Item为选中
function selectItemByValue(objSelect, objItemValue) {
	// 判断是否存在
	var isExit = false;
	for (var i = 0; i < objSelect.options.length; i++) {
		if (objSelect.options[i].value == objItemValue) {
			objSelect.options[i].selected = true;
			isExit = true;
			break;
		}
	}
}
// 8.根据value返回对应的第一个option
function getItemByValueFromSelect(objSelect, objItemValue) {
	for (var i = 0; i < objSelect.options.length; i++) {
		if (objSelect.options[i].value == objItemValue) {
			return objSelect.options[i];
		}
	}
}
//----------------------------select控件的控制 end-----------------------------

function st_addIframe(contentid, eleid, url, flag, param){
	
	var iframe = $("<iframe id=\""+eleid+"\" name=\""+eleid+"\" scrolling=\"no\" frameborder=\"0\" src=\""+url+"\" style=\"overflow:hidden;\"></iframe>");
	if(param){
		if(param.width){
			$(iframe).css("width", param.width);
		}
		if(param.height){
			$(iframe).css("height", param.height);
		}
	}
	$("#"+contentid).append(iframe);
	iframe = null;
	
	iframe = document.getElementById(eleid); 
	
	iframe.onload = iframe.onreadystatechange = function() {
		
		if("uninitialized" == iframe.readyState){
			//还未开始载入
		}
		if("loading" == iframe.readyState){
			//载入中
			iframe.contentWindow.window.document.oncontextmenu=function(e){
				return false;
			}
		}
		if("loaded" == iframe.readyState){
			//载入完成
		}
		if("interactive" == iframe.readyState){
			//已加载，文档与用户可以开始交互 
		}
        if (!iframe.readyState || iframe.readyState == "complete") {
        	
			iframe.contentWindow.window.document.oncontextmenu=function(e){
				return false;
			}
			
			//如果flag值为true，则不进行高宽调整
			if(!flag){
	        	//加载完成
				var scroll_x = false;//是否有横向滚动
				var scroll_y = false;//是否有纵向滚动
	            
				//宽度
				var iframeWidth = 
					Math.min(iframe.contentWindow.window.document.documentElement.scrollWidth
						, iframe.contentWindow.window.document.body.scrollWidth);
				
				if($("#"+contentid).width()>=iframeWidth){
					//iframe的宽度小于容器宽度，将iframe宽度扩大
					iframeWidth = $("#"+contentid).width();
				}else{
					scroll_x = true;//iframe的宽度大于容器宽度，出现横向滚动条
				}
	            //高度
				var iframeHeight = 
					Math.min(iframe.contentWindow.window.document.documentElement.scrollHeight
						, iframe.contentWindow.window.document.body.scrollHeight)+1;
						
				if($("#"+contentid).height()>=iframeHeight){
					//iframe的高度小于容器高度，将iframe高度扩大
					iframeHeight = $("#"+contentid).height();
				}else{
					scroll_y = true;//iframe的高度大于容器高度，出现纵向滚动条
				}
				
	            if($(iframe).parent().length == 1){
	            	//判断iframe父级元素对于overflow的设置；
	            	var parentEle = $(iframe).parent().get(0);
	            	if(parentEle.style.overflow && parentEle.style.overflow == "auto"){
	            		
	            	}
	            	
	            	if(parentEle.style.overflowX && parentEle.style.overflowX == "auto"){
	            		
	            	}
	            	if(parentEle.style.overflowX && parentEle.style.overflowX == "hidden"){
	            		scroll_x = false;
	            	}
	            	
	            	if(parentEle.style.overflowY == "auto"){
	            		
	            	}
	            	if(parentEle.style.overflowY == "hidden"){
	            		scroll_y = false;
	            	}
	            }
	            
	            $(iframe).width(scroll_y?iframeWidth-17:iframeWidth);
	            $(iframe).height(scroll_x?iframeHeight-17:iframeHeight);
        	}
    	}
    };
}

/*
 * 机构树选择窗
 * 使用示例：
 * var orgUI = new OrgUI();
 * orgUI.show(function(p){
 * 		if(p && p.length>0){
 * 			for(var i=0;i<p.length;i++){
 * 				alert(p[i].orgCode+":"+p[i].orgName);
 * 			}
 * 		}
 * 	}, {needCheck:true}, loading);
 * 
 * 方法说明：
 * show：显示机构树
 *      （同一个OrgUI对象的该方法，第一次执行会向后台获取一次机构数据，以供生成机构树，之后再执行就直接显示第一次时获取到的机构数据）
 *      每次调用，均会清除机构树之前的选择/选中状况。 
 *      参数说明：param1：function函数，便于双击树节点或者点击确定后回传选择的机构，该函数第一个参数，为选择的机构数组；
 *              param2：object对象，
 *              		其属性needCheck取值为【true/false】，
 *              			取值为true表示显示的机构树带有勾选框，提供多选功能，此时树节点双击事件无效；
 *              			取值为false时只能单选一个机构，树节点可以单击也可双击；
 *              		其属性x取值为数字，表示其距显示窗口左上角的横向距离；
 *              		其属性y取值为数字，表示其距显示窗口左上角的纵向距离；
 *              param3：loading元素对象，参见santai.core.js中loading对象的使用说明
 *              
 * hide：关闭机构树
 */
var OrgUI = function(){
	var canShow = false;//调用show方法时是否可以显示
	var hasTree = false;//是否已经构造树
	
	var clearParam = function(){
		canShow = false;
		hasTree = false;
	}
	
	var create = function(){
		clearParam();
		
		$(document).ready(function(){
			//页面加载完成后，才创建这个窗口
			
			if($('#org_float_div_w').length>0){
				$('#org_float_div_w').empty();
				$('#org_float_div_w').remove();
			}
			
			var orgdiv = $('<div id="org_float_div_w">'
						+'<div style="background:#ffffff;width: 100%;float: left;height: 90%;margin-top: 2px;">'
						+'  <div style="overflow:auto; border:1px solid #000000;"><ul id="org_float_div_tree" class="easyui-tree"></ul></div>'
						+'</div>'
						+'<div style="width: 100%;margin: 10px auto 0px auto;float: left;text-align: center;">'
							+'<a href="#" id="org_float_div_choosebtn" class="easyui-linkbutton"'
							+'   data-options="iconCls:\'icon-ok\'" style="padding: 5px 0px; width: 25%;">'
							+'      <span style="font-size: 14px;">确定</span></a>'
						+'</div>'
					+'</div>');
			$("body").find("div:first").append(orgdiv);
			$('#org_float_div_w').window({
			width:300,
			height:400,
			modal:true,//模态窗
			title:'选择机构',
			closed:true,//默认关闭
			collapsible:false,//缩放
			    minimizable:false,
			    maximizable:false
			});
			
			canShow = true;
		}); 
	}
	create();
	
	this.show = function(callbackFunction, param, loading){
		
		if(!canShow){
			setTimeout(this.show, 500);
			return false;
		}
		
		var left, top = 0;
		
		if(param && param.x && $.isNumeric(param.x)){
			left = param.x;
		}else{
			left = $(document.activeElement).offset().left - $('#org_float_div_w').width()/2;
		}
		
		if(param && param.y && $.isNumeric(param.y)){
			top = param.y;
		}else{
			top = $(document.activeElement).offset().top + $(document.activeElement).height();
		}
		
		if(param && param.reload){
			//需要重新向服务器获取机构数据
			hasTree = false;
		}
		
		$('#org_float_div_w').window({left: left});
		$('#org_float_div_w').window({top: top});
		
		$('#org_float_div_w').window('open');
		
		if(loading){
			//说明存在loading元素，可以将其调用起来
			loading.show();
		}
		
		$("#org_float_div_tree").parent().width($('#org_float_div_w').width()-3);
		$("#org_float_div_tree").parent().height($('#org_float_div_w').height()-40);
		
		if(!hasTree){
			
			//还没有构造树
			var ajax = new stAjax('getSubOrgs.action');
			ajax.setSuccessCallback(function(data){
				
				if(data.msg && data.msg.trim().length>0){
					alert(data.msg);
				}
				
				if(loading){
					//说明存在loading元素，可以将其调用起来
					loading.hide();
				}
				
				if(data.success && data.result){
					
					//获取菜单树，并展开第一层
					$('#org_float_div_tree').tree({
						data: data.result
						,checkbox:param?(param.needCheck?(true):(false)):(false)
						,lines:true
						,formatter:function(node){
							var s = node.text+"["+node.id+"]";
							if (node.children){
								s += ' <span style=\'color:blue\'>(' + node.children.length + ')</span>';
							}
							return s;
						}
						,loadFilter: function(rows){
							return convert(rows);
						}
						,onDblClick : function(node) {
							if(param && param.needCheck){
								return false;
							}
					    	var orgCode = node.id;
							$('#org_float_div_w').window('close');
							
							if (typeof callbackFunction != 'undefined' && callbackFunction instanceof Function) {
								callbackFunction([{orgCode:node.id, orgName:node.text}]);
								return false;
							}
						}
						,onLoadSuccess:function(node, data){
							onTreeLoadSuccess(node, data);
						}
					});
				}
			});
			ajax.setErrorCallback(function(data){			
				alert("服务器处理出现异常！");
				
				if(loading){
					//说明存在loading元素，可以将其调用起来
					loading.hide();
				}
	        });
			ajax.invoke();
		}else{
			//已经构造树
			$('#org_float_div_tree').tree("reload");
			$('#org_float_div_tree').tree({onLoadSuccess : function(node, data){onTreeLoadSuccess(node, data);}});
		}
		
		$("#org_float_div_choosebtn").off("click");
		$("#org_float_div_choosebtn").on("click",function(){
			
			var validNodes = [];
			
			if(param && param.needCheck){
				//允许勾选，则不采纳选中的节点
				var _choosedNodes = $('#org_float_div_tree').tree('getChecked', 'checked');
				for(var i=0;i<_choosedNodes.length;i++){
					validNodes.push({orgCode:_choosedNodes[i].id, orgName:_choosedNodes[i].text});
				}
			}else{
				//不允许勾选，则只需要选中的节点
				var selectedNode = $('#org_float_div_tree').tree("getSelected");
				validNodes.push({orgCode:selectedNode.id, orgName:selectedNode.text});
			}
			
			if(validNodes && validNodes.length>0){
				$('#org_float_div_w').window('close');
				if (typeof callbackFunction != 'undefined' && callbackFunction instanceof Function) {
					callbackFunction(validNodes);
				}
				return false;
			}
			
			alert("尚未选择机构！");
		});
	}
	
	function onTreeLoadSuccess(node, data){
		hasTree = true;
		if(loading){
			//说明存在loading元素，可以将其调用起来
			loading.hide();
		}
	}
	
	this.hide = function(){
		$('#org_float_div_w').window('close');
		clearParam();
	}
	
	function convert(rows){
		function exists(rows, parentCode){
			for(var i=0; i<rows.length; i++){
				if (rows[i].orgCode == parentCode) return true;
			}
			return false;
		}
		
		var nodes = [];
		
		//查找根节点
		for(var i=0; i<rows.length; i++){
			var row = rows[i];
			if (!exists(rows, row.parentCode)){
				var rootNode = {
					id:row.orgCode
					,text:row.name
				};
				
				if(row.isChecked){
					rootNode.checked = true;
				}
				nodes.push(rootNode);
			}
		}
		
		var toDo = [];
		for(var i=0; i<nodes.length; i++){
			toDo.push(nodes[i]);
		}
		
		//遍历根机构，处理其子节点
		while(toDo.length){
			var node = toDo.shift();	// the parent node
			// get the children nodes
			for(var i=0; i<rows.length; i++){
				var row = rows[i];
				if (row.parentCode == node.id){
					var child = {id:row.orgCode, text:row.name};
					if(row.isChecked){
						child.checked = true;
					}
					if (node.children){
						node.children.push(child);
					} else {
						node.children = [child];
					}
					toDo.push(child);
				}
			}
		}
		return nodes;
	}
}



function windowCenter(div){
	var parent = $(top.window.frames['mainframe'].frameElement).parent();
	var _top = parent.scrollTop()+parent.height()/2-$("#"+div).height()/2;
	$("#"+div).window({top: _top}); 
}


//将带有万字的资金进行转换，并去除中文
function transMoney(val){
	var isContain;
	if(val.indexOf("万")>-1){
		isContain=true;
	}
	val=val.replace(/[,]/g,"");//去除,
	val=val.replace(/[\u4E00-\u9FA5]/g,"");//去除中文
	if(isContain){
		val=val*10000;
	}
	return val;
}

//三证合一后的号码，组织机构代码从中截取
function tranOrgInstitCd(val){
	if(val.length==18){
		val=val.substring(8,17);
	}
	return val;
}

/*出生日期从身份证号码中截取*/
function tranBirthCd(val){
	if(val.length==18){
		val=val.substring(6,10)+"-"+val.substring(10,12)+"-"+val.substring(12,14);
	}
	return val;
}

/**
*动态添加表格行
**/
function addtr(table, col){
	var _len = $("#"+table+" tr").length;
	var row = "";
	for(var i=0; i<col ; i++){
		row +="<td><input class='easyui-textbox' style='width:100%;height:24px' /></td>";
	}
	$("#"+table).append("<tr id=" + _len + " align='center' >" +row+
		"<td><a href=\'#\' onclick=\"deltr(\'"+table+"\'," + _len + ")\">删除</a></td>" +
		"</tr>");
	 //$.parser.parse();
	$.parser.parse("#"+table);
}

//增加对公短信通 客户信息
function addNoteInfo(){
	var _len = $("#dgkehu_tb tr").length;
	$("#dgkehu_tb").append("<tr id=" + _len + " align='center' >" +
			"<td><input class='easyui-textbox' style='width:100%;height:24px' /></td>" +
			"<td><input class='easyui-textbox' style='width:100%;height:24px' /></td>" +
			"<td>"+
				"<select class='easyui-combobox' style='width:100%;' data-options='editable:false'>"+
					"<option value='1' >身份证</option>"+
					"<option value='2' >军官证</option>"+
					"<option value='3' >其他</option>"+
				"</select>"+
			"</td>" +
			"<td><input class='easyui-textbox' style='width:100%;height:24px' /></td>" +
			"<td><a href=\'#\' onclick=\"deltr(\'dgkehu_tb\'," + _len + ")\">删除</a></td>" +
			"</tr>");
	 //$.parser.parse();
	$.parser.parse("#dgkehu_tb "+" tr[id='"+ _len +"']");
}

//增加授权人
function addAuthorize(table){
	var dataStr = "data:[{a:'A',b:'A'},{a:'B',b:'B'},{a:'C',b:'C'},{a:'D',b:'D'},{a:'E',b:'E'},{a:'F',b:'F'},"+
	              	    "{a:'G',b:'G'},{a:'H',b:'H'},{a:'I',b:'I'}]"; 
	var _len = $("#"+table+" tr").length;
	$("#"+table).append("<tr id=" + _len + " align='center' >" +
		"<td><input class='easyui-textbox prodata autoin' objtype='1' style='width:100%;height:24px' /></td>" +
		'<td>'+
			"<input class='easyui-combobox prodata' objtype='1' style='width:100%;height:24px' url='getTypeEnum.action?typeCode=ID_TYPE'"+ 
			"data-options="+'"'+"valueField:'typeValue', textField:'typeName',editable:false,panelHeight:'auto'"+'" '+" >"+
		'</td>'+
		"<td><input class='easyui-textbox prodata' objtype='1' style='width:100%;height:24px' /></td>" +
		"<td><input class='easyui-datebox prodata' objtype='1' style='width:100%;height:24px' data-options='editable:false' /></td>" +
		"<td><input class='easyui-textbox prodata' objtype='1' style='width:100%;height:24px' /></td>" +
		"<td>"+
			"<input class='easyui-combobox' data-options="+'"'+"separator:'.',multiple:'true',editable:false,valueField:'a',textField:'b',"+dataStr+'"'+"style='width:100%;height:24px' >"+
		"</td>" +
		"<td><a href=\'#\' onclick=\"deltr(\'"+table+"\'," + _len + ")\">删除</a></td>" +
		"</tr>");
	 //$.parser.parse();
	$.parser.parse("#"+table+" tr[id='"+ _len +"']");
}

//增加对公客户信息 的股东 和受益人tr
function addClintTbtr(table){
	var _len = $("#"+table+" tr").length;
	$("#"+table).append("<tr id=" + _len + " align='center' >" +
		"<td><input class='easyui-textbox' style='width:100%;height:24px' /></td>" +
		'<td>'+
		"<input class='easyui-combobox' style='width:100%;height:24px' url='getTypeEnum.action?typeCode=ID_TYPE'"+ 
		"data-options="+'"'+"valueField:'typeValue', textField:'typeName',editable:false,panelHeight:'auto'"+'" '+" >"+
		'</td>'+
		"<td><input class='easyui-textbox' style='width:100%;height:24px' /></td>" +
		"<td><input class='easyui-datebox' style='width:100%;height:24px' data-options='editable:false' /></td>" +
		"<td><input class='easyui-textbox' style='width:100%;height:24px' /></td>" +
		"<td><a href=\'#\' onclick=\"deltr(\'"+table+"\'," + _len + ")\">删除</a></td>" +
		"</tr>");
	 //$.parser.parse();
	$.parser.parse("#"+table+" tr[id='"+ _len +"']");
}

/**
动态删除行
*/
var deltr = function(table,index) {
	this.$("#"+table+" tr[id='" + index + "']").remove(); //删除当前行
}

function gettrVal(table, col){
	var str="";
	var row = 1;
	$("#"+table).find("tr").each(function(){
		if(row==1){
			row++;
			return;
		}
		if(row>2){
			str+="||";
		}
	    var tdArr = $(this).children();
	    for(var i=0; i< col; i++){
	    	var vtd = "";
	    	if(i==5){//授权人中的多选下拉获取值
	    		vtd = tdArr.eq(i).children().combo("getText").trim().replace(",","，");
	    	}else{
	    		vtd = tdArr.eq(i).children().textbox("getValue").trim().replace(",","，");
	    	}
	    	if(i<col-1){
	    		str += vtd+",";
	    	}else{
	    		str += vtd;
	    	}
	    }
	    row++;
	})
	return str;
}

//由于拼接的  不能关联数据库 
/*人的证件种类*/
function getIdTypeText(idType){
	var bIdTypeText = "";
	if(idType=="01"){
		bIdTypeText ="居民身份证";
	}else if(idType=="02"){
		bIdTypeText ="临时身份证";
	}else if(idType=="03"){
		bIdTypeText ="护照";
	}else if(idType=="04"){
		bIdTypeText ="户口薄";	
	}else if(idType=="05"){
		bIdTypeText ="军人身份证";	
	}else if(idType=="06"){
		bIdTypeText ="武装警察身份证";	
	}else if(idType=="07"){
		bIdTypeText ="港、澳、台居民往来内地通行证";	
	}else if(idType=="08"){
		bIdTypeText ="外交人员身份证";
	}else if(idType=="09"){
		bIdTypeText ="外国人居留许可证";	
	}else if(idType=="10"){
		bIdTypeText ="边民出入境通行证";
	}else if(idType=="11"){
		bIdTypeText ="其他";
	}else if(idType=="20"){
		bIdTypeText ="客户群";	
	}else if(idType=="47"){
		bIdTypeText ="港、澳、台居民往来内地通行证-香港";	
	}else if(idType=="48"){
		bIdTypeText ="港、澳、台居民往来内地通行证-澳门";
	}else if(idType=="49"){
		bIdTypeText ="台湾居民来往大陆通行证";
	}
	return bIdTypeText;
}

function toChineseNum(num){
	var newchar = "";
	num = ""+num;
	if(num==""||num==null||num==undefined){
		return newchar;
	}
	 for (i = num.length - 1; i >= 0; i--) {
         tmpnewchar = "";
         perchar = num.charAt(i);
         switch (perchar) {
             case "0": tmpnewchar = "零" + tmpnewchar; break;
             case "1": tmpnewchar = "壹" + tmpnewchar; break;
             case "2": tmpnewchar = "贰" + tmpnewchar; break;
             case "3": tmpnewchar = "叁" + tmpnewchar; break;
             case "4": tmpnewchar = "肆" + tmpnewchar; break;
             case "5": tmpnewchar = "伍" + tmpnewchar; break;
             case "6": tmpnewchar = "陆" + tmpnewchar; break;
             case "7": tmpnewchar = "柒" + tmpnewchar; break;
             case "8": tmpnewchar = "捌" + tmpnewchar; break;
             case "9": tmpnewchar = "玖" + tmpnewchar; break;
         }
         switch (num.length - i - 1) {
             case 1: if (perchar != 0) tmpnewchar = tmpnewchar + "拾"; break;
             case 2: if (perchar != 0) tmpnewchar = tmpnewchar + "佰"; break;
             case 3: if (perchar != 0) tmpnewchar = tmpnewchar + "仟"; break;
             case 4: tmpnewchar = tmpnewchar + "万"; break;
             case 5: if (perchar != 0) tmpnewchar = tmpnewchar + "拾"; break;
             case 6: if (perchar != 0) tmpnewchar = tmpnewchar + "佰"; break;
             case 7: if (perchar != 0) tmpnewchar = tmpnewchar + "仟"; break;
             case 8: tmpnewchar = tmpnewchar + "亿"; break;
             case 9: tmpnewchar = tmpnewchar + "拾"; break;
         }
         newchar = tmpnewchar + newchar;
     }
	 return newchar;
}
