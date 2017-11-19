function valiNull(name,value){
	if(trim(value)==""){
		alert(name+"不能为空!");
		return false;
	}
	return true;
}

function getLength(str){
	var len = str.length;
	var reLen = 0;
	for (var i = 0; i < len; i++){
		if(str.charCodeAt(i) < 27 || str.charCodeAt(i) > 126){// 全角
			reLen += 3;
		}else{
			reLen++;
		}
	}
	return reLen;
  }

function valiOrgInstitCd(value){
	/*if (value.replace(/[^\x00-\xff]/gi, 'xx').length == 10) {
		return true;
	}else{
		alert("组织机构代码格式不正确!");
		return false;
	}*/
}

function valiCheckNumber(value){
	if (!/^J\d{13}$/.test(value)) {
		alert("请录入正确的基本存款账户开户许可证核准号!");
		return false;
	}
	return true;
}

function valiAccountCode(value){
	if(!/^\d{17}$/.test(value.length)){
		alert("账号长度只能为17位");
		return false;
	}
	return true;
}

function valiAccountName(value){
	var len=getLength(value);
	if(len>128){
		alert("存款人名称不得超过128个字符！");
		return false;
	}
	return true;
}

function valiTax(name,value){
	if(!(value.length==15 || value.length==18)){
		alert(name+"的长度只能为15和18");
		return false;
	}
	return true;
}

//是否 null 或者 空
function isEmptyToo(s)
{
   return ((s == null) || (s.length == 0) )
}

//字符是否为0-9
function isDigit (c)
{   
	return ((c >= "0") && (c <= "9"))
}

//是否数字
function isFloat (s)
{
    var i;
    var seenDecimalPoint = false;
    if (isEmptyToo(s))
       if (isFloat.arguments.length == 1) return defaultEmptyOK;
       else return (isFloat.arguments[1] == true);
    if (s == ".") return false;
    for (i = 0; i < s.length; i++)
    {
        // Check that current character is number.
        var c = s.charAt(i);
        if ((c == ".") && !seenDecimalPoint) seenDecimalPoint = true;
        else if (!isDigit(c)) return false;
    }
    return true;
}

//小数（m,n）,忽略小数首尾的0,不允许正负号
function isDecimal(s,m,n){
	if(!isFloat(s)) return false;
	if(String(parseInt(s,10)).length > m) return false;
	var ss = String(parseFloat(s));
	if(ss.indexOf(".")>=0 && ss.substring( ss.indexOf(".") + 1, ss.length).length > n ) return false;
	return true;
}

function isDate(d) {
	var reg = /^(\d{1,4})(-|\/)(\d{2})\2(\d{2})$/;
	var result = d.match(reg);
	if (result == null) { return false };
	var dt = new Date(result[1], result[3] - 1, result[4]);
	if (Number(dt.getFullYear()) != Number(result[1])) { return false; }
	if (Number(dt.getMonth()) + 1 != Number(result[3])) { return false; }
	if (Number(dt.getDate()) != Number(result[4])) { return false; }
	return true;
}

$.extend($.fn.validatebox.defaults.rules, {    
    maxLength: {    
        validator: function(value, param){  
            return value.length <= param[0];    
        },    
        message: '最多输入{0}位字符.'   
    },
    number: {
		validator: function (value, param) {
			return /^[0-9]*$/.test(value);
		},
		message: '请输入数字.'
	},
	englishCheckSub:{
		validator:function(value){
			return /^[a-zA-Z0-9]+$/.test(value);
		},
		message:"只能包括英文字母、数字."
	},
	length: {    
        validator: function(value, param){  
            return value.length == param[0];    
        },    
        message: '应该输入{0}位字符.'   
    },
    money:{
    	validator: function(value, param){  
            return isDecimal(value,param[0],param[1]);   
        },    
        message: '金额整数最多输入{0}位数字,小数最多输入{1}位数字。' 
    },
    date:{
    	validator: function(value, param){  
            return isDate(value);
        },    
        message: '请输入正确的日期格式(yyyy-mm-dd)。' 
    },
    checkNumber:{
    	validator: function(value, param){  
            return /^J\d{13}$/.test(value);
        },    
        message: '请录入正确的基本存款账户开户许可证核准号.' 
    }
});

function hasChoseA(vsq){
	var authorizePeoples = vsq.split("||");
	var countA = 0;
	for(var i = 0 ; i<authorizePeoples.length; i++){
		var peopleInfos = authorizePeoples[i].split(",");
		if(peopleInfos.length<6){
			break;
		}
		if(peopleInfos[5].indexOf("A")>-1){
			countA ++;
		}
	}
	if(countA<1){
		return false;
	}
	return true;
}
