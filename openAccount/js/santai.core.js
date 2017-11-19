/*
 * yinml at 20141108
 * 核心js文件，包含倒计时、缓存util、ajax调用、cookie操作、settimeout等
 */

/*
 * 倒计时对象
 * 调用方式：
 * var countdown = new stCountDown(50);
 * countdown = new stCountDown(constantUtil.getCountDownTime());
 * countdown.setShowElement("timer");//设置要显示计数的页面元素id
 * countdown.setTimeOutCallback(function(){});//设置倒计时归零时要执行的js方法
 * countdown.start();//开始倒计时
 * countdown.revert();//倒计时计数还原
 * countdown.stop();//停止倒计时
 */
var stCountDown = function(countDownTime){
    //倒计时长
    var default_time = 60;
    //全局倒计时长
    var time = default_time;
    //用于倒计时的计数
    var _timer = time;    
    if(countDownTime!=null){
        if(/^[1-9]+[0-9]*]*$/.test(countDownTime)){
            time = countDownTime;
            _timer = time;
        }else{
            throw new Error(-1,"指定的倒计时长无效："+countDownTime);
        }
    }
    
    //时间间隔周期
    var delay = 1010;
    //延时句柄
    var cdidl = null;
    //显示倒计时时间的控件
    var timeElement=null;
    //时间倒计时到0的时候，需要触发的方法
    var timeoutCallback=null;
    //倒计时延迟多少秒才开始计时
    var delayBeforeStart=1000;
    var needStop = false;
    var isRunning = false;
    
    var getDelayBeforeStart=function(){
        return delayBeforeStart;
    }
        
    //倒计时处理逻辑，每隔1秒减少时间
    var minus = function (){
        clearTimeout(cdidl);
        _timer--;
        if(_timer==0){
            if (typeof timeoutCallback != 'undefined' && timeoutCallback instanceof Function) { 
                timeoutCallback();
            }
        }
        if(_timer<0){
            this.stop();
            return;
        }
        
        if(needStop == false){
            cdidl=setTimeout(f, delay);
        }else{
            _timer = time;
        }
        showTime();
    }
    this.minusExcuter = minus;
    var me = this;
    var f = function() { me.minusExcuter(); };
    
    //显示倒计时时间
    var showTime = function(){
        $("#"+timeElement).text(_timer);
    }
    //设置倒计时起始秒数参数
    this.setCountDown=function(ct){
        if(/^[1-9]+[0-9]*]*$/.test(ct)){
            time=ct;
        }else{
            time=default_time;
            throw new Error("请指定有效的倒计时长!");
        }
    }
    
    this.getCountDown=function(){
        return time;
    }
    
    //设置显示倒计时间的元素
    this.setShowElement=function(element){
        timeElement=element;
    }
    
    //开始倒计时
    this.start = function(){
        
        //如果当前倒计时已经在运行了，就返回不再重复执行
        if(isRunning != false){
            isRunning = true;
        }
        
        if(isRunning == true){
            return;
        }else{
            //倒计时没有运行，设置标记为
            needStop = false;
        }
        
        //开始倒计时，从头开始
        if(/^[1-9]+[0-9]*]*$/.test(time)){
            _timer = time;
        }else{
            throw new Error("无法识别的倒计时设置！");
        }
        
        
        isRunning = true;
        
        clearTimeout(cdidl);
        showTime();
        cdidl=setTimeout(f, delay+getDelayBeforeStart());
    }
    //停止倒计时
    this.stop = function(){
        needStop = true;
        isRunning = false;
        clearTimeout(cdidl);
    }    
    //还原到倒计时开始时
    this.revert = function(){        
        _timer = time;
        showTime();
    }
    //时间倒计时到0的时候，需要触发的方法
    this.setTimeOutCallback=function(callback){
        timeoutCallback = callback;
    }
}

/* 封装的ajax对象，采用异步、POST方式向服务器发送数据。
 * 
 * 调用方式：
 * 1、最简单方式，即只需要向服务器发送请求，页面不需要后续处理；
 * var ajax = new stAjax('test.action');
 * ajax.invoke();
 * 
 * 2、需要向服务器发送带数据的请求，需要注意数据格式为json
 * var ajax = new stAjax('test.action');
 * ajax.setData({'p1':1,'p2':'test'});
 * ajax.invoke();
 * 
 * 3、需要向服务器发送带数据的请求，并要根据服务器处理结果进行后续处理
 * var ajax = new stAjax('test.action');
 * ajax.setData({'p1':1,'p2':'test'});
 * ajax.setSuccessCallback(succ_func);
 * ajax.setErrorCallback(error_func);
 * ajax.invoke();
 * 
 * 备注：
 * 1、stAjax对象发起ajax请求时，默认传输方式为POST
 * 2、如果需要使用同步方式的ajax，请设置stAjax对象的async属性，
 *   设置方式为：ajax.setAsync(false);   
 */
var stAjax = function(url_p, method_p, logoutUrl_p){
    var numtest = /^[0-9]*[1-9][0-9]*$/;
    var logoutUrl = "logout.action";
    
    //超时时间设置
    var _timeout = 120*1000;//2分钟
    var timeout = _timeout;
        
    //要调用的服务器地址
    var url = '';    
    if(url_p != null && url_p != undefined){
        var _url = url_p.replace(/(^\s*)|(\s*$)/g, "");
        if(_url.length<1){
            throw(new Error(-1, "必须设置url值！"))
        }
        url = _url;
    }
    
    //session超时要调用的服务器地址
    if(logoutUrl_p != null && logoutUrl_p != undefined){
        var _url = logoutUrl_p.replace(/(^\s*)|(\s*$)/g, "");
        if(_url.length>0){
            logoutUrl = logoutUrl_p;
        }
    }
    
    //调用方式：GET 或者 POST
    var method='POST';
    if(method_p != null && method_p != undefined){
        var _method = method_p.toLowerCase();
        if("get" == _method || "post" == _method){
            method = _method;
        }
    }
    
    //返回数据的格式，默认为JSON
    var dataType = 'JSON';
    
    //发送到服务器的数据
    var data = null;
        
    //使用同步还是异步方式
    var async = true;
    
    //调用成功后进行的callback方法
    var success_callback=null;
    
    //调用失败后进行的callback方法
    var error_callback=null;
    
    this.getTimeout=function(){        
        if(numtest.test(timeout)){
            if(timeout<0){
                return 0;
            }
            return timeout;
        }else{
            _timeout;
        } 
    }
    
    var getUrl = function(){
        return url;
    }
    
    var getMethod = function(){
        return method;
    }
    
    var getDataType = function(){
        return dataType;
    }
    
    var getData = function(){
        if(data == null){
            return {};
        }
        return data;
    }
    
    var getAsync = function(){
        
        if(typeof(async_param) == "boolean"){
            return async;
        }else{
            return true;
        }
    }
    
    this.setTimeout = function(timeout_param){
        if(numtest.test(timeout_param)){
            if(timeout_param<0){
                timeout=0;
                return;
            }
            timeout = timeout_param;
        }else{
            throw(new Error(-1, "设置的timeout值无效：["+tm+"]！"))
        } 
    }
    
    this.setUrl = function(url_param){
        if(url_param != null && url_param != undefined){
            var _url = url_param.replace(/(^\s*)|(\s*$)/g, "");
            if(_url.length<1){
                throw(new Error(-1, "必须设置url值！"))
            }
            url = _url;
        }else{
            throw(new Error(-1, "必须设置url值！"))
        } 
    }
    
    this.setMethod = function(method_param){
        if(method_param != null && method_param != undefined){
            var _method = method_param.toLowerCase();
            if("get" == _method || "post" == _method){
                method = _method;
            }
        }
    }
    
    this.setDataType = function(dataType_param){
        dataType = dataType_param;
    }
    
    this.setData = function(data_param){
        data = data_param;
    }
    
    this.setAsync = function(async_param){
        if(async_param == true || async_param == false)
            async = async_param;
    }
    
    this.setSuccessCallback = function(callback){
        success_callback = callback;
    }
    
    this.setErrorCallback = function(callback){
        error_callback = callback;
    }
        
    this.invoke=function(){
        if(getUrl() == null || getUrl() == undefined || getUrl().length<1){
            throw(new Error(-1, "尚未指定url值！"))
            return;
        }
        $.ajax( {
            type:getMethod(),
            ifModified:true,
            async:async,
            //contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
            beforeSend: function(xhr) {
		        xhr.setRequestHeader("x-st-ajax-header", "santai-core-ajax");
		    },
            timeout:this.getTimeout(),
            url:(getUrl().indexOf("?")>0)?(getUrl() + "&dytime="+(new Date()).getTime()):(getUrl() + "?dytime="+(new Date()).getTime()),
            dataType:getDataType(),
            data:getData(),
            success : function(resp, textStatus, jqXHR) {
                
                if(getDataType().toUpperCase() == "JSON"){
                    var str = JSON.stringify(resp); //系列化对象
	                var cloneData = JSON.parse(str);
	                if(checkSession(cloneData)){
	                    if (typeof success_callback != 'undefined' && success_callback instanceof Function) {
	                        success_callback(cloneData, textStatus, jqXHR);
	                    }
	                }
                    
	                str = null;
	                cloneData = null;
                }else{
                    if (typeof success_callback != 'undefined' && success_callback instanceof Function) {
                        success_callback(resp, textStatus, jqXHR);
                    }
                }
            },
            error : function(resp, errinfo, e) {
                if(getDataType().toUpperCase() == "JSON"){
	                var str = JSON.stringify(resp); //系列化对象
	                var cloneData = JSON.parse(str);
	                if(checkSession(cloneData)){
	                    if (typeof error_callback != 'undefined' && error_callback instanceof Function) { 
	                        error_callback(cloneData, errinfo, e);
	                    }
	                }
	                str = null;
	                cloneData = null;
                }else{
                    if (typeof error_callback != 'undefined' && error_callback instanceof Function) { 
                        error_callback(resp, errinfo, e);
                    }
                }
            },
            complete:function(resp, status){
                resp = null;
            }
        });
    }
    
    var checkSession = function(resp) {
        try {
            if (resp.invalidSession) {
                loginagain(resp);
                return false;
            }
            return true;
        } catch (e) {
            if (window["console"]){
		        console.log(e.message);
		    }
            return false;
        }
    }
    
    var loginagain = function (data) {
        var devLogoutUrl = logoutUrl;
        try {
            if (data.msg != null && data.msg != undefined && data.msg.length>0) {
	            if (window["console"]){
	                console.log(data.msg);
	            }
            }
            
            var obj = window.dialogArguments;
            if (obj == null || obj == undefined) {
                // 说明是第一层页面，因为已经弹出相关提示信息了，所以不需要迁移到超时退出提示的页面
                top.location.href = devLogoutUrl;
            } else {
                // 存放弹出窗口的对象，最上面的一个页面放在最前面
                var objs = new Array();
                obj = getframeobj(obj, objs);
                objs.push(window);
                // 说明是弹出页面
                // 依次关闭弹出页面
                for (var i = 0; i < objs.length; i++) {
                    var currObj = objs[i];
                    currObj.returnValue = "autoclose";
                    currObj.close();
                }
                if (obj != null && obj != undefined) {
                    obj.top.location.href = devLogoutUrl;
                } else {
                    top.location.href = devLogoutUrl;
                }
            }
            return true;
        } catch (e) {
            if (window["console"]){
                console.log(e.message);
            }
            return false;
        }
    }
}

/*
 * javascript实现的Map();
 */
function Map(){
    this.keys = new Array();
    this.data = new Object();
    var toString = Object.prototype.toString;
    /**
     * 当前Map当前长度
     */
    this.size = function(){
        return this.keys.length;
    }
     
    /**
     * 添加值
     * @param {Object} key
     * @param {Object} value
     */
    this.put = function(key, value){
        if(!this.containsKey(key)){
            this.keys.push(key);
        }
        this.data[key] = value;
    }

    /**
     * 根据当前key获取value
     * @param {Object} key
     */
    this.get = function(key){
        return this.data[key];
    }

    /**
     * 根据当前key移除Map对应值
     * @param {Object} key
     */
    this.remove = function(key){
        var index = this.indexOf(key);
        if(index != -1){
            this.keys.splice(index, 1);
        }
        this.data[key] = null;
        return delete this.data[key];
    }

    /**
     * 清空Map
     */
    this.clear = function(){
        for(var i=0, len = this.size(); i < len; i++){
            var key = this.keys[i];
            this.data[key] = null;
        }
        this.keys.length = 0;
    }

    /**
     * 当前key是否存在
     * @param {Object} key
     */
    this.containsKey = function(key){
        return this.data[key] != null;
    }

    /**
     * 是否为空
     */
    this.isEmpty = function(){
        return this.keys.length === 0;
    }

    /**
     * 类型Java中Map.entrySet
     */
    this.entrySet = function(){
        var size = this.size();
        var datas = new Array(size);
        for (var i = 0, len = size; i < len; i++) {
            var key = this.keys[i];
            var value = this.data[key];
            datas[i] = {
                'key' : key,
                'value':value
            }
        }
        return datas;
    }

    /**
     * 遍历当前Map
     * var map = new Map();
     * map.put('key', 'value');
     * map.each(function(index, key, value){
     *      console.log("index:" + index + "--key:" + key + "--value:" + value)
     * })
     * @param {Object} fn
     */
    this.each = function(fn){
        if(toString.call(fn) === '[object Function]'){
            for (var i = 0, len = this.size(); i < len; i++) {
                var key = this.keys[i];
                fn(i, key, this.data[key]);
            }
        }
        return null;
    }

    /**
     * 获取Map中 当前key 索引值
     * @param {Object} key
     */
    this.indexOf = function(key){
        var size = this.size();
        if(size > 0){
            for(var i=0, len=size; i < len; i++){
                if(this.keys[i] == key)
                return i;
            }
        }
        return -1;
    }

    /**
     * Override toString
     */
    this.toString = function(){
        var str = "{";
        for (var i = 0, len = this.size(); i < len; i++, str+=",") {
            var key = this.keys[i];
            var value = this.data[key];
            str += key + "=" + value;
        }
        str = str.substring(0, str.length-1);
        str += "}";
        return str;
    }

    /**
     * 获取Map中的所有value值(Array)
     */
    this.values = function(){
        var size = this.size();
        var values = new Array();
        for(var i = 0; i < size; i++){
            var key = this.keys[i];
            values.push(this.data[key]);
        }
        return values;
    }
}

/*
 * cookie用的util
 */
var cookieUtil = {
    //存入cookie，option为限制cookie的参数对象
    setCookie : function(name, value, option) {
        // 用于存储赋值给document.cookie的cookie格式字符串
        var str = name + "=" + escape(value);
        if (option) {
            // 如果设置了过期时间
            if (option.expireSeconds && /^\d*$/.test(option.expireSeconds)) {
                var ms = option.expireSeconds;
                var date = new Date();
                date.setTime(date.getTime() + ms);
                str += "; expires=" + date.toGMTString();
            }
            if (option.path){
                str += "; path=" + path;// 设置访问路径
            }
            if (option.domain){
                str += "; domain=" + domain;// 设置访问主机
            }
            if (option.secure){
                str += "; true";// 设置安全性
            }
        }
        document.cookie = str;
    },
    //获取指定的cookie内容
    getCookie : function(name) {
        var cookieArray = document.cookie.split("; ");// 得到分割的cookie名值对
        var cookie = new Object();
        for (var i = 0; i < cookieArray.length; i++) {
            var arr = cookieArray[i].split("=");// 将名和值分开
            if (arr[0] == name){
                if(arr[1] == undefined){
                    return "";
                }
                return unescape(arr[1]);// 如果是指定的cookie，则返回它的值
            }
        }
        return "";
    },
    //删除指定的cookie
    deleteCookie : function(name) {
        this.setCookie(name, "", {
            expireSeconds : -1
        });//将过期时间设置为过去来删除一个cookie
    },
    //以传入值为名称前缀，删除匹配的cookie
    deleteByPre:function(pre_name){
        var cookieArray = document.cookie.split("; ");// 得到分割的cookie名值对
        var cookie = new Object();
        for (var i = 0; i < cookieArray.length; i++) {
            var arr = cookieArray[i].split("=");// 将名和值分开
            if(arr[0].indexOf(pre_name)>-1){
                this.setCookie(arr[0], "", {
                        expireSeconds : -1
                });//将过期时间设置为过去来删除一个cookie
            }
        }
    },
    //删除所有cookie
    deleteAll:function(){
        var cookieArray = document.cookie.split("; ");// 得到分割的cookie名值对
        var cookie = new Object();
        for (var i = 0; i < cookieArray.length; i++) {
            var arr = cookieArray[i].split("=");// 将名和值分开            
            this.setCookie(arr[0], "", {
                    expireSeconds : -1
            });//将过期时间设置为过去来删除一个cookie
        }
    }
}

/*支持传参的settimeout函数*/
var _sto = setTimeout;    
st_setTimeout = function(callback,timeout,param){    
    var args = Array.prototype.slice.call(arguments,2);    
    var _cb = function(){    
        callback.apply(null,args);    
    }    
    return _sto(_cb,timeout);    
} 

//----------------------------跳转 start-----------------------------
/*
 * 页面迁移方法
 */
function redirectUrl(url, target){
    if(url == null || url == undefined || url.length<1){
        return;
    }
    
    if(url.indexOf("?")>0){
        url = url + "&dytime="+(new Date()).getTime();
    }else{
        url = url + "?dytime="+(new Date()).getTime();
    }
    
    var doc = document;
    if(target){
    	doc = target;
    }
    var rform = doc.createElement("form");
    
    doc.body.appendChild(rform);
    rform.method="post";
    rform.action = url;
    rform.submit();
}

/*
 * a标签跳转
 */
function go_link(url) {
	var link = document.createElement("a");
	link.href = url;
	document.body.appendChild(link);
	link.click();
}

//----------------------------跳转 end-----------------------------

/*
 * 禁止键盘复制粘贴
 */
function estopkeycopyandpaste() {
	if (event.ctrlKey && event.keyCode == 86) {
		event.keyCode = 0;
		return false;
	}
}

/*
 * 禁止鼠标复制粘贴
 */
function estopmscopyandpaste() {
	// 1:左键 2：右键
	var btn = event.button;
	if (btn == 2) {
		document.oncontextmenu = new Function("return false");
		return false;
	}
}

/*
 * 递归获取弹出页面的上级页面
 */
function getframeobj(obj, objs) {
	if (obj == null || obj == undefined) {
		return null;
	}
	var p = obj.window.dialogArguments;
	if (p == null || p == undefined) {
		return obj;
	}

	objs.push(obj.window);
	return getframeobj(p, objs);
}

/*
 * 动态在页面上加载css或js
 */
var dynamicLoading = {
    css: function(path){
        if(!path || path.length === 0){
            throw new Error('argument "path" is required !');
        }
        var head = document.getElementsByTagName('head')[0];
        var link = document.createElement('link');
        link.href = path;
        link.rel = 'stylesheet';
        link.type = 'text/css';
        head.appendChild(link);
    },
    js: function(path){
        if(!path || path.length === 0){
            throw new Error('argument "path" is required !');
        }
        var head = document.getElementsByTagName('head')[0];
        var script = document.createElement('script');
        script.src = path;
        script.type = 'text/javascript';
        head.appendChild(script);
    }
}

if(typeof JSON!=='object'){JSON={}}(function(){'use strict';function f(n){return n<10?'0'+n:n}if(typeof Date.prototype.toJSON!=='function'){Date.prototype.toJSON=function(){return isFinite(this.valueOf())?this.getUTCFullYear()+'-'+f(this.getUTCMonth()+1)+'-'+f(this.getUTCDate())+'T'+f(this.getUTCHours())+':'+f(this.getUTCMinutes())+':'+f(this.getUTCSeconds())+'Z':null};String.prototype.toJSON=Number.prototype.toJSON=Boolean.prototype.toJSON=function(){return this.valueOf()}}var cx,escapable,gap,indent,meta,rep;function quote(string){escapable.lastIndex=0;return escapable.test(string)?'"'+string.replace(escapable,function(a){var c=meta[a];return typeof c==='string'?c:'\\u'+('0000'+a.charCodeAt(0).toString(16)).slice(-4)})+'"':'"'+string+'"'}function str(key,holder){var i,k,v,length,mind=gap,partial,value=holder[key];if(value&&typeof value==='object'&&typeof value.toJSON==='function'){value=value.toJSON(key)}if(typeof rep==='function'){value=rep.call(holder,key,value)}switch(typeof value){case'string':return quote(value);case'number':return isFinite(value)?String(value):'null';case'boolean':case'null':return String(value);case'object':if(!value){return'null'}gap+=indent;partial=[];if(Object.prototype.toString.apply(value)==='[object Array]'){length=value.length;for(i=0;i<length;i+=1){partial[i]=str(i,value)||'null'}v=partial.length===0?'[]':gap?'[\n'+gap+partial.join(',\n'+gap)+'\n'+mind+']':'['+partial.join(',')+']';gap=mind;return v}if(rep&&typeof rep==='object'){length=rep.length;for(i=0;i<length;i+=1){if(typeof rep[i]==='string'){k=rep[i];v=str(k,value);if(v){partial.push(quote(k)+(gap?': ':':')+v)}}}}else{for(k in value){if(Object.prototype.hasOwnProperty.call(value,k)){v=str(k,value);if(v){partial.push(quote(k)+(gap?': ':':')+v)}}}}v=partial.length===0?'{}':gap?'{\n'+gap+partial.join(',\n'+gap)+'\n'+mind+'}':'{'+partial.join(',')+'}';gap=mind;return v}}if(typeof JSON.stringify!=='function'){escapable=/[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g;meta={'\b':'\\b','\t':'\\t','\n':'\\n','\f':'\\f','\r':'\\r','"':'\\"','\\':'\\\\'};JSON.stringify=function(value,replacer,space){var i;gap='';indent='';if(typeof space==='number'){for(i=0;i<space;i+=1){indent+=' '}}else if(typeof space==='string'){indent=space}rep=replacer;if(replacer&&typeof replacer!=='function'&&(typeof replacer!=='object'||typeof replacer.length!=='number')){throw new Error('JSON.stringify');}return str('',{'':value})}}if(typeof JSON.parse!=='function'){cx=/[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g;JSON.parse=function(text,reviver){var j;function walk(holder,key){var k,v,value=holder[key];if(value&&typeof value==='object'){for(k in value){if(Object.prototype.hasOwnProperty.call(value,k)){v=walk(value,k);if(v!==undefined){value[k]=v}else{delete value[k]}}}}return reviver.call(holder,key,value)}text=String(text);cx.lastIndex=0;if(cx.test(text)){text=text.replace(cx,function(a){return'\\u'+('0000'+a.charCodeAt(0).toString(16)).slice(-4)})}if(/^[\],:{}\s]*$/.test(text.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g,'@').replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g,']').replace(/(?:^|:|,)(?:\s*\[)+/g,''))){j=eval('('+text+')');return typeof reviver==='function'?walk({'':j},''):j}throw new SyntaxError('JSON.parse');}}}());


// 对Date的扩展，将 Date 转化为指定格式的String
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，
//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
//例子： 
//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.Format = function(fmt){
    //author: meizz 
    var o = { 
    "M+" : this.getMonth()+1,                 //月份 
    "d+" : this.getDate(),                    //日 
    "h+" : this.getHours(),                   //小时 
    "m+" : this.getMinutes(),                 //分 
    "s+" : this.getSeconds(),                 //秒 
    "q+" : Math.floor((this.getMonth()+3)/3), //季度 
    "S"  : this.getMilliseconds()             //毫秒 
    }; 
    if(/(y+)/.test(fmt)) 
    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
    for(var k in o) 
        if(new RegExp("("+ k +")").test(fmt)) 
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length))); 
    return fmt; 
};

Array.prototype.unique = function() { 
	var i=0,tmp={},that=this.slice(0) 
	this.length=0; 
	for(;i<that.length;i++){ 
		if(!(that[i] in tmp)){ 
			this[this.length]=that[i]; 
			tmp[that[i]]=true; 
		} 
	} 
	return this; 
}; 
Array.prototype.indexOf = function(e){
    for(var i=0,j; j=this[i]; i++){
        if(j==e){return i;}
    }
    return -1;
};
Array.prototype.contains = function (element) { 
	for (var i = 0; i < this.length; i++) { 
		if (this[i] == element) { 
		  return true; 
		} 
	} 
	return false; 
};
Array.prototype.clear=function(){ 
    this.length=0; 
}; 
Array.prototype.insertAt=function(index,obj){ 
    this.splice(index,0,obj); 
};
Array.prototype.removeAt=function(index){ 
    this.splice(index,1); 
};
Array.prototype.remove=function(obj){ 
	var index=this.indexOf(obj); 
	if (index>=0){ 
	   this.removeAt(index); 
	} 
};
String.prototype.trim=function(){
     return this.replace(/(^\s*)|(\s*$)/g, '');
};
String.prototype.endWith = function(s) {
	if (s == null || s == "" || this.length == 0 || s.length > this.length)
		return false;
	if (this.substring(this.length - s.length) == s)
		return true;
	else
		return false;
	return true;
}
String.prototype.startWith = function(s) {
	if (s == null || s == "" || this.length == 0 || s.length > this.length)
		return false;
	if (this.substr(0, s.length) == s)
		return true;
	else
		return false;
	return true;
}

// 说明：javascript的加法结果会有误差，在两个浮点数相加的时候会比较明显。这个函数返回较为精确的加法结果。
// 调用：accAdd(arg1,arg2)
// 返回值：arg1加上arg2的精确结果
function accAdd(arg1, arg2) {
	var r1, r2, m;
	try {
		r1 = arg1.toString().split(".")[1].length
	} catch (e) {
		r1 = 0
	}
	try {
		r2 = arg2.toString().split(".")[1].length
	} catch (e) {
		r2 = 0
	}
	m = Math.pow(10, Math.max(r1, r2))
	return (arg1 * m + arg2 * m) / m
}

// 说明：javascript的减法结果会有误差，在两个浮点数相加的时候会比较明显。这个函数返回较为精确的减法结果。
// 调用：accSub(arg1,arg2)
// 返回值：arg1减上arg2的精确结果
function accSub(arg1, arg2) {
	return accAdd(arg1, -arg2);
}

// 说明：javascript的乘法结果会有误差，在两个浮点数相乘的时候会比较明显。这个函数返回较为精确的乘法结果。
// 调用：accMul(arg1,arg2)
// 返回值：arg1乘以arg2的精确结果
function accMul(arg1, arg2) {
	var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
	try {
		m += s1.split(".")[1].length
	} catch (e) {
	}
	try {
		m += s2.split(".")[1].length
	} catch (e) {
	}
	return Number(s1.replace(".", "")) * Number(s2.replace(".", ""))
			/ Math.pow(10, m)
}

// 说明：javascript的除法结果会有误差，在两个浮点数相除的时候会比较明显。这个函数返回较为精确的除法结果。
// 调用：accDiv(arg1,arg2)
// 返回值：arg1除以arg2的精确结果
function accDiv(arg1, arg2) {
	var t1 = 0, t2 = 0, r1, r2;
	try {
		t1 = arg1.toString().split(".")[1].length
	} catch (e) {
	}
	try {
		t2 = arg2.toString().split(".")[1].length
	} catch (e) {
	}
	with (Math) {
		r1 = Number(arg1.toString().replace(".", ""))
		r2 = Number(arg2.toString().replace(".", ""))
		return (r1 / r2) * pow(10, t2 - t1);
	}
}

// 给Number类型增加一个add方法，调用起来更加方便。
Number.prototype.add = function(arg) {
	return accAdd(arg, this);
}
// 给Number类型增加一个sub方法，调用起来更加方便。
Number.prototype.sub = function(arg) {
	return accSub(this, arg);
}
// 给Number类型增加一个mul方法，调用起来更加方便。
Number.prototype.mul = function(arg) {
	return accMul(arg, this);
}
// 给Number类型增加一个div方法，调用起来更加方便。
Number.prototype.div = function(arg) {
	return accDiv(this, arg);
}

/*
 * loading动画
 * create()：创建元素
 * show()：显示动画
 * hide()：关闭动画
 */
var stLoading = function(){
	
	var hasShow = false;
	var needHide = true;
	var try_num = 0;
	var idl=null;
	var loading_msg = "喝杯茶，等一会儿...";
	var words = [
		/* "且喝一杯茶，且等一会儿"
		,"路途遥远，我正奋马扬鞭"
		,"您别嫌弃我，慢工出细活"
		,"微笑一个，心情快乐"*/
		"正在努力处理中，请稍候..."//领导要求提示语正规、严谨、专业，所以进行修改 at 20151104
	];
	
	this.create = function(){
		if(document.body){
			var loadingbackground = $('<div id="st_loading_div_bkg_id" style="display:none; background-color:#000; position:absolute; top:0px; left:0px;"></div>');
			
			var win_windth = $(window).width()>$(document.body).width()?$(window).width():$(document.body).width();
			var win_height = $(window).height()>$(document.body).height()?$(window).height():$(document.body).height();
			loadingbackground.css("width", win_windth);
			loadingbackground.css("height", win_height);
			loadingbackground.css("z-index", 99999);
			loadingbackground.css("opacity", "0.1");//透明度
			
			var loadingdiv = $('<div id="st_loading_div_id" '
				+'class="query_hint_div" '
				+'style="display:none;border:5px solid #939393;width:270px; height:100px; padding:0 20px; position:absolute; left:50%; margin-left:-140px; top:50%; margin-top:-40px;font-size:15px; color:#333; font-weight:bold; text-align:center; background-color:#f9f9f9;">'
				+'<div><img style="position:relative;top:10px;left:-8px; float:left;" src="images/loading.gif" /></div>'
				+'<div id="st_loading_msg_div_id" style="width:180px;position:relative;top:40%;float:left; font-size:11pt;word-wrap:break-word;word-break:normal;">'+loading_msg+'</div></div>');
			loadingdiv.css("z-index", loadingbackground.css("z-index")+1);//透明度
			
			$(document.body).append(loadingbackground);
			$(document.body).append(loadingdiv);
			
			hasShow = true;
		}else{
			setTimeout(this.create, 100);
		}
	}
	
	this.show = function(msg, x, y){
		function doShow(msg, x, y){
			if(msg != null && msg != undefined && msg.trim().length>0){
				$("div[id='st_loading_msg_div_id']").html(msg);
			}else{
				$("div[id='st_loading_msg_div_id']").html(words[parseInt(Math.random()*(words.length))]);
			}
			
			if(x && y && $.isNumeric(x) && $.isNumeric(y)){
				$("#st_loading_div_id").offset(
					{
						left:(Number(x) - $("#st_loading_div_id").width)/2
					//  , top:(Number(y) - $("#st_loading_div_id").height()*2/3)
					}
				);
			}
			
			$("div[id^='st_loading_div_']").each(function(){
		    	$(this).show();
		    });
		    needHide = true;
		}
		
		function tryShow(msg, x, y){
			if(idl){
				clearTimeout(idl);
				idl = null;
			}
			if(hasShow){
			    doShow(msg, x, y);
			}else{
				if(try_num>10){
					return false;
				}
				try_num++;
				idl = st_setTimeout(function(p){tryShow(p.msg, p.x, p.y);}, 500,{msg:msg, x:x, y:y});
			}
		}
		tryShow(msg, x, y);
	}
	
	this.hide = function(){
		if(idl){
			clearTimeout(idl);
			idl = null;
		}
		
	    $("div[id^='st_loading_div_']").each(function(){
	    	$(this).hide();
	    });
	    needHide = false;
	    try_num=0;
	}
}

function trim(target){
	if(target != null && target != undefined){
		return target.replace(/^\s+|\s+$/g, "");
	}
	
	return "";
}

/*
 * 从服务器获取当前时间
 */
function getServerCurrentTime() {
	// 因程序执行耗费时间,所以时间并不十分准确,误差大约在2000毫秒以下
	var xmlHttp = false;
	// 获取服务器时间
	try {
		xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
	} catch (e) {
		try {
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		} catch (e2) {
			xmlHttp = false;
		}
	}

	if (!xmlHttp && typeof XMLHttpRequest != 'undefined') {
		xmlHttp = new XMLHttpRequest();
	}

	xmlHttp.open("GET", "null.txt", false);
	xmlHttp.setRequestHeader("Range", "bytes=-1");
	xmlHttp.send(null);

	try {
		var offset = Date.parse(xmlHttp.getResponseHeader("Date"));// 获取标头中的时间
		offset -= (new Date()).getTime(); // 获取本地时间与服务器时间的间隔
		var d = new Date(); // 获取当前时间
		d.setTime(d.getTime() + offset); // 通过服务器和本地的时间间隔获取当前服务器时间
		return d;
	} catch (e) {
		return null;
	}
}