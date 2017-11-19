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

$.extend($.fn.validatebox.defaults.rules, {    
    maxLength: {    
        validator: function(value, param){  
            return value.length <= param[0];    
        },    
        message: '最多输入{0}位字符.'   
    },
    number: {
		validator: function (value, param) {
			return /^[0-9]+.?[0-9]*$/.test(value);
		},
		message: '请输入数字.'
	},
	englishCheckSub:{
		validator:function(value){
			return /^[a-zA-Z0-9]+$/.test(value);
		},
		message:"只能包括英文字母、数字."
	}
});
