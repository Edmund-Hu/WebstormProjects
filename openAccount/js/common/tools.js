
/*
 * 获取字符串的字节长度
 */
function getLength(value) {
    var cArr = value.match(/[^\x00-\xff]/ig);
    return value.length + (cArr == null ? 0 : cArr.length);
}

//将字符串格式的xml内容转化为xml对象
var loadXML = function(xmldata){
    var xmlDoc = null;
    //判断浏览器的类型
    //支持IE浏览器
    if(!window.DOMParser && window.ActiveXObject){
        var xmlDomVersions = ['MSXML.2.DOMDocument.6.0','MSXML.2.DOMDocument.3.0','Microsoft.XMLDOM'];
        for(var i=0;i<xmlDomVersions.length;i++){
            try{
                xmlDoc = new ActiveXObject(xmlDomVersions[i]);
                break;
            }catch(e){
            }
        }
    }
    //支持Mozilla浏览器
    else if(document.implementation && document.implementation.createDocument){
        try{
            /* document.implementation.createDocument('','',null); 方法的三个参数说明
             * 第一个参数是包含文档所使用的命名空间URI的字符串； 
             * 第二个参数是包含文档根元素名称的字符串； 
             * 第三个参数是要创建的文档类型（也称为doctype）
             */
            xmlDoc = document.implementation.createDocument('','',null);
        }catch(e){
        }
    }
    else{
        return null;
    }

    if(xmlDoc!=null){
        xmlDoc.async = false;
        xmlDoc.load(xmldata);
    }
    return xmlDoc;
}

//解析url地址，拆分其中的参数和值
function GetPageUrlParameter(key) {
    var rs = new RegExp("(^|)" + key + "=([^&]*)(&|$)", "gi").exec(String(window.document.location.href)), tmp; 
    if (tmp = rs) { 
       return tmp[2]; 
    } 
    // parameter cannot be found 
    return ""; 
}

/*
 * 校验用的util
 */
var checkUtil={
    //校验指定内容是否为手机号码格式
    checkTelNo : function(telNo, showmsg_ele_id){
        if(!(/^1[3|5|4|7|8][0-9]\d{8}$/.test(telNo))){
            var msgEle = document.getElementById(showmsg_ele_id);
            if (msgEle){ 
                msgEle.innerText = "手机号码不正确！"; 
            }
        //    if (typeof callback != 'undefined' && callback instanceof Function) { 
          //      callback();
        //    }
            return false; 
        }else{            
            var msgEle = document.getElementById(showmsg_ele_id);
            if (msgEle){ 
                msgEle.innerText = ""; 
            }
            return true;
        }
    },
    
    // 验证银行账号19个数字
    checkBankNo : function(BankNo) {
    	if (BankNo.value == "")
			return;
		var account = new String(BankNo.value);
		account = account.substring(0, 23); /*帐号的总数, 包括空格在内 */
		if (account.match(".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{3}") == null) {
			/* 对照格式 */
			if (account.match(".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{3}|"
							+ ".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{3}|"
							+ ".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{3}|"
							+ ".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{3}") == null) {
				var accountNumeric = accountChar = "", i;
				var b = /^[0-9a-zA-Z]*$/g;
				for (i = 0; i < account.length; i++) {
					accountChar = account.substr(i, 1);
					if (!b.test(accountChar) && (accountChar != " "))
						accountNumeric = accountNumeric + accountChar;
				}
				account = "";
				for (i = 0; i < accountNumeric.length; i++) { /* 可将以下空格改为-,效果也不错 */
					if (i == 4)
						account = account + "-"; /* 帐号第四位数后加空格 */
					if (i == 8)
						account = account + "-"; /* 帐号第八位数后加空格 */
					if (i == 12)
						account = account + "-";/* 帐号第十二位后数后加空格 */
					if (i == 16)
						account = account + "-";/* 帐号第十二位后数后加空格 */
					account = account + accountNumeric.substr(i, 1)
				}
			}
		} else {
			account = " " + account.substring(1, 5) + " "
					+ account.substring(6, 10) + " "
					+ account.substring(14, 18) + " "
					+ account.substring(18, 22) + " "
					+ account.substring(22, 25);
		}
		if (account != BankNo.value)
			BankNo.value = account;
    },
    
    //校验指定内容是否为邮编格式
    checkPostCode : function(postCode, showmsg_ele_id){
        if(!(/^[0-9]\d{5}(?!\d)$/.test(postCode))){ 
            var msgEle = document.getElementById(showmsg_ele_id);
            if (msgEle){ 
                msgEle.innerText = "邮政编码不正确！"; 
            }
            return false; 
        } else {            
            var msgEle = document.getElementById(showmsg_ele_id);
            if (msgEle){ 
                msgEle.innerText = ""; 
            }
            return true;
        }
    },
    
    //校验指定内容是否为身份证号码格式
    checkIDCard:function(idCard, showmsg_ele_id){
        if(idCard == null || idCard == undefined || typeof(idCard)!="string"){ 
            var msgEle = document.getElementById(showmsg_ele_id);
            if (msgEle){ 
                msgEle.innerText = "身份证号["+idCard+"]不正确！"; 
            }
            return false; 
        }
        var rtnObj = function(){
            var code = 0;
            var msg = "";
            
            this.setCode = function(_code){
                code = _code;
            }
            this.getCode = function(){
                return code;
            }
            this.setMsg = function(_msg){
                msg = _msg;
            }
            this.getMsg = function(){
                return msg;
            }
        }

        var idCardNo = function(value) {
            //验证身份证号方法 
            var testIdCardNo = function (idcard) {
                var Errors = new Array("验证通过!", "身份证号码位数不对!", "身份证号码出生日期超出范围或含有非法字符!", "身份证号码校验错误!", "身份证地区非法!");
                var area = { 11: "北京", 12: "天津", 13: "河北", 14: "山西", 15: "内蒙古", 21: "辽宁", 22: "吉林", 23: "黑龙江", 31: "上海", 32: "江苏", 
                            33: "浙江", 34: "安徽", 35: "福建", 36: "江西", 37: "山东", 41: "河南", 42: "湖北", 43: "湖南", 44: "广东", 45: "广西", 
                            46: "海南", 50: "重庆", 51: "四川", 52: "贵州", 53: "云南", 54: "西藏", 61: "陕西", 62: "甘肃", 63: "青海", 64: "宁夏", 
                            65: "xinjiang", 71: "台湾", 81: "香港", 82: "澳门", 91: "国外" }
                var idcard, Y, JYM;
                var S, M;
                var idcard_array = new Array();
                idcard_array = idcard.split("");
                if (area[parseInt(idcard.substr(0, 2))] == null){
                    var rtn = new rtnObj();
                    rtn.setCode(-1);
                    rtn.setMsg(Errors[4]);
                    return rtn;
                }
                switch (idcard.length) {
                    case 15:
                        if ((parseInt(idcard.substr(6, 2)) + 1900) % 4 == 0 || ((parseInt(idcard.substr(6, 2)) + 1900) % 100 == 0 && (parseInt(idcard.substr(6, 2)) + 1900) % 4 == 0)) {
                            ereg = /^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$/; //测试出生日期的合法性 
                        } else {
                            ereg = /^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$/; //测试出生日期的合法性 
                        }
                        if (ereg.test(idcard)){
                            var rtn = new rtnObj();
                            rtn.setCode(0);
                            rtn.setMsg(Errors[0]);
                            return rtn;
                        }else{
                            var rtn = new rtnObj();
                            rtn.setCode(-1);
                            rtn.setMsg(Errors[2]);
                            return rtn;
                        }
                        break;
                    case 18:
                        if (parseInt(idcard.substr(6, 4)) % 4 == 0 || (parseInt(idcard.substr(6, 4)) % 100 == 0 && parseInt(idcard.substr(6, 4)) % 4 == 0)) {
                            ereg = /^[1-9][0-9]{5}(19|20)[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$/; //闰年出生日期的合法性正则表达式 
                        } else {
                            ereg = /^[1-9][0-9]{5}(19|20)[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$/; //平年出生日期的合法性正则表达式 
                        }
                        if (ereg.test(idcard)) {
                            S = (parseInt(idcard_array[0]) + parseInt(idcard_array[10])) * 7 + (parseInt(idcard_array[1]) + parseInt(idcard_array[11])) * 9 + (parseInt(idcard_array[2]) + parseInt(idcard_array[12])) * 10 + (parseInt(idcard_array[3]) + parseInt(idcard_array[13])) * 5 + (parseInt(idcard_array[4]) + parseInt(idcard_array[14])) * 8 + (parseInt(idcard_array[5]) + parseInt(idcard_array[15])) * 4 + (parseInt(idcard_array[6]) + parseInt(idcard_array[16])) * 2 + parseInt(idcard_array[7]) * 1 + parseInt(idcard_array[8]) * 6 + parseInt(idcard_array[9]) * 3;
                            Y = S % 11;
                            M = "F";
                            JYM = "10X98765432";
                            M = JYM.substr(Y, 1);
                            if (M == idcard_array[17]){
                                var rtn = new rtnObj();
                                rtn.setCode(0);
                                rtn.setMsg(Errors[0]);
                                return rtn;
                            }else{
                                var rtn = new rtnObj();
                                rtn.setCode(-1);
                                rtn.setMsg(Errors[3]);
                                return rtn;
                            }
                        }else{
                            var rtn = new rtnObj();
                            rtn.setCode(-1);
                            rtn.setMsg(Errors[2]);
                            return rtn;
                        }
                        break;
                    default:
                        var rtn = new rtnObj();
                        rtn.setCode(-1);
                        rtn.setMsg(Errors[1]);
                        return rtn;
                        break;
                }
            };
            return testIdCardNo(value);
        };
        
        var rtn = idCardNo(idCard);
        if(rtn.getCode() && rtn.getCode() != 0){ 
            var msgEle = document.getElementById(showmsg_ele_id);
            if (msgEle){ 
                msgEle.innerText = "身份证号["+idCard+"]不正确！"; 
            }
            return false; 
        } else {
            var msgEle = document.getElementById(showmsg_ele_id);
            if (msgEle){ 
                msgEle.innerText = ""; 
            }
            return true;
        }
    },
    
    //判断是否为整数
    isInteger:function(param){
        if(param == null || param == undefined || param.length<1){
            return false;
        }
        return /^\d+$/.test(param);
    },
    //判断是否是数字或英文或英数混合
    isNumOrEnglish:function(param){
        if(param == null || param == undefined || param.length<1){
            return false;
        }
        return /^[A-Za-z0-9]+$/.test(param);
    },
    //判断卡号格式:字母、数字、短横线
    checkCardCode : function(cardCode, showmsg_ele_id){
        if(!(/^[A-Za-z0-9-]+$/.test(cardCode))){
            return false; 
        }else{            
            return true;
        }
    },
    //判断账号格式:字母、数字、短横线
    checkAccountCode : function(accountCode, showmsg_ele_id){
        if(!(/^[A-Za-z0-9-]+$/.test(accountCode))){
            return false; 
        }else{            
            return true;
        }
    },
    //检查是否是英文、数字、中文
    checkEnglishOrChinese : function(content, showmsg_ele_id){
        if(!(/^[A-Za-z0-9\u4e00-\u9fa5]+$/.test(content))){
            return false; 
        }else{            
            return true;
        }
    },
	    /**
	 * 校验字符串是否为浮点型 返回值： 如果为空，定义校验不通过， 返回true 如果字串为浮点型，校验通过， 返回true 如果校验不通过， 返回false
	 * 参考提示信息：输入域不是合法的浮点数！
	 */
	checkIsDouble : function(str) {
		// 如果为空，则通过校验
		if (str == "")
			return false;
		// 如果是整数，则校验整数的有效性
		if (str.indexOf(".") == -1) {
			if (checkIsInteger(str) == true)
				return true;
			else
				return false;
		} else {
			var reg = /^-?\d+(\.\d*)?$/;
			if (reg.test(str)) {
				return true;
			}
			return false;
		}
	},
	/**
	 * 校验整型是否为非负数 str：要校验的串。
	 * 
	 * 返回值： 如果为空，定义校验不通过，返回false 如果非负数， 返回true 如果是负数， 返回false 参考提示信息：输入值不能是负数！
	 */
	isNotNegativeInteger : function(str) {
		// 如果为空，则通过校验
		if (str == "")
			return false;
		if (checkIsInteger(str) == true) {
			if (parseInt(str, 10) < 0)
				return false;
			else
				return true;
		} else
			return false;
	},
	/* 校验浮点型是否为非负数 str：要校验的串。
	 * 
	 * 返回值： 如果为空，定义校验不通过，返回false; 如果非负数， 返回true 如果是负数， 返回false 参考提示信息：输入值不能是负数！
	 */
	isNotNegativeDouble : function(str) {
		// 如果为空，则通过校验
		if (str == "")
			return false;
		if (checkIsDouble(str) == true) {
			if (parseFloat(str) < 0)
				return false;
			else
				return true;
		} else
			return false;
	},
	//是否是正整数
	isPlusInteger : function (str) {// 如果为空，则通过校验
		if (str == "")
			return false;
	
		var patrn = /^(0|[1-9]\d*)$/;
		return patrn.test(str);
	}
}