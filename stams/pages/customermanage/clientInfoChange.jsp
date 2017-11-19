<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="santai" uri="/tags/santai"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>变更对公客户信息申请</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="js/jquery/jquery-easyui/easyui.css" />
<link rel="stylesheet" type="text/css" href="js/jquery/jquery-easyui/icon.css" />
<link rel="stylesheet" type="text/css" href="css/main.css" />
<script type="text/javascript" src="js/jquery/jquery.js"></script>
<script type="text/javascript" src="js/jquery/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/jquery/jquery-easyui/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="js/santai.core.js"></script>
<script type="text/javascript" src="js/common/common.js"></script>
<script type="text/javascript" src="js/common/LodopFuncs.js"></script>
<script type="text/javascript">

	$(function(){
		init();
		controlPrint();
	})
	
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
	
	function controlPrint(){
		var vActiveId = $("#activeId").textbox("getValue");
		if(vActiveId==""||vActiveId==null){
			$("#printBtn").hide();
		}else{
			$("#printBtn").show();
		}
	}
	
	function init(){
		var vRegistAddress = $("#openBookDiv #registAddress").textbox("getValue").split(',');
		$("#registAddressG").textbox("setValue",vRegistAddress[0]);
		$("#registAddressS").textbox("setValue",vRegistAddress[1]);
		$("#registAddressQ").textbox("setValue",vRegistAddress[2]);
		$("#registAddressD").textbox("setValue",vRegistAddress[3]);
		var vOfficeAddress = $("#openBookDiv #officeAddress").textbox("getValue").split(',');
		$("#officeAddressG").textbox("setValue",vOfficeAddress[0]);
		$("#officeAddressS").textbox("setValue",vOfficeAddress[1]);
		$("#officeAddressQ").textbox("setValue",vOfficeAddress[2]);
		$("#officeAddressD").textbox("setValue",vOfficeAddress[3]);
		
		//对公客户信息 股东
		var vClientPartner = $("#openBookDiv #partner").textbox("getValue").split('||');
		for(var i = 0; i<vClientPartner.length; i++){
			var partner = vClientPartner[i].split(',');
			if(partner.length>1){
				$("#guquan_tb").append("<tr id=" + i + " align='center' >" +
				"<td><input class='easyui-textbox' style='width:100%;height:24px' value='"+partner[0]+"' /></td>" +
				'<td><select class="easyui-combobox" style="width:100%;" data-options="editable:false">'+
					'<option value=""></option>'+
					'<option value="居民身份证" >居民身份证</option>'+
					'<option value="临时身份证" >临时身份证</option>'+
					'<option value="护照" >护照</option>'+
					'<option value="户口簿" >户口簿</option>'+
					'<option value="军人身份证件" >军人身份证件</option>'+
					'<option value="武装警察身份证件" >武装警察身份证件</option>'+
					'<option value="港澳居民往来内地通行证" >港澳居民往来内地通行证</option>'+
					'<option value="外交人员身份证" >外交人员身份证</option>'+
					'<option value="外国人居留许可证" >外国人居留许可证</option>'+
					'<option value="边民出入境通行证" >边民出入境通行证</option>'+
					'<option value="其他" >其他</option>'+
				'</select></td>'+
				"<td><input class='easyui-textbox' style='width:100%;height:24px'  value='"+partner[2]+"'/></td>" +
				"<td><input class='easyui-datebox' style='width:100%;height:24px' value='"+partner[3]+"' data-options='editable:false' /></td>" +
				"<td><input class='easyui-textbox' style='width:100%;height:24px' value='"+partner[4]+"' /></td>" +
				"<td><a href=\'#\' onclick=\"deltr(\'guquan_tb\'," + i + ")\">删除</a></td>" +
				"</tr>");
				
				/* $("#guquan_tb tr[id='"+ i +"']").children().eq(1).children().combobox("select",partner[1]); */
				$("#guquan_tb tr[id='"+ i +"']").children().eq(1).children().find("option[value='"+partner[1]+"']").attr("selected",true);
			 	//$.parser.parse();
				$.parser.parse("#guquan_tb");
			}
		}
		
		//对公客户信息受益权人
		var vBeneficiary = $("#openBookDiv #beneficiary").textbox("getValue").split('||');
		for(var i = 0; i<vBeneficiary.length; i++){
			var beneficiary = vBeneficiary[i].split(',');
			if(beneficiary.length>1){
				$("#quanyi_tb").append("<tr id=" + i + " align='center' >" +
				"<td><input class='easyui-textbox' style='width:100%;height:24px' value='"+beneficiary[0]+"' /></td>" +
				'<td><select class="easyui-combobox" style="width:100%;" data-options="editable:false">'+
					'<option value=""></option>'+
					'<option value="居民身份证" >居民身份证</option>'+
					'<option value="临时身份证" >临时身份证</option>'+
					'<option value="护照" >护照</option>'+
					'<option value="户口簿" >户口簿</option>'+
					'<option value="军人身份证件" >军人身份证件</option>'+
					'<option value="武装警察身份证件" >武装警察身份证件</option>'+
					'<option value="港澳居民往来内地通行证" >港澳居民往来内地通行证</option>'+
					'<option value="外交人员身份证" >外交人员身份证</option>'+
					'<option value="外国人居留许可证" >外国人居留许可证</option>'+
					'<option value="边民出入境通行证" >边民出入境通行证</option>'+
					'<option value="其他" >其他</option>'+
				'</select></td>'+
				"<td><input class='easyui-textbox' style='width:100%;height:24px' value='"+beneficiary[2]+"'/></td>" +
				"<td><input class='easyui-datebox' style='width:100%;height:24px' value='"+beneficiary[3]+"' data-options='editable:false' /></td>" +
				"<td><input class='easyui-textbox' style='width:100%;height:24px' value='"+beneficiary[4]+"' /></td>" +
				"<td><a href=\'#\' onclick=\"deltr(\'quanyi_tb\'," + i + ")\">删除</a></td>" +
				"</tr>");
			 	//$.parser.parse();
			 	$("#quanyi_tb tr[id='"+ i +"']").children().eq(1).children().find("option[value='"+beneficiary[1]+"']").attr("selected",true);
				$.parser.parse("#quanyi_tb");
			}
		}
		
		//商业活动旺季
		var vHighSeasons = $("#openBookDiv #highSeasons").textbox("getValue");
		if(vHighSeasons!=""&&vHighSeasons!=null){
			var highSeasons = $("#openBookDiv #highSeasons").textbox("getValue").split(",");
			for(var i=0; i<highSeasons.length; i++){
				$("#sywj #"+highSeasons[i]).attr("checked", true);
			}
		}
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
		$.parser.parse("#"+table);
	}
	function addClintTbtr(table){
		var _len = $("#"+table+" tr").length;
		$("#"+table).append("<tr id=" + _len + " align='center' >" +
			"<td><input class='easyui-textbox' style='width:100%;height:24px' /></td>" +
			'<td><select class="easyui-combobox" name="idType" style="width:100%;" data-options="editable:false">'+
				'<option value=""></option>'+
				'<option value="居民身份证" >居民身份证</option>'+
				'<option value="临时身份证" >临时身份证</option>'+
				'<option value="护照" >护照</option>'+
				'<option value="户口簿" >户口簿</option>'+
				'<option value="军人身份证件" >军人身份证件</option>'+
				'<option value="武装警察身份证件" >武装警察身份证件</option>'+
				'<option value="港澳居民往来内地通行证" >港澳居民往来内地通行证</option>'+
				'<option value="外交人员身份证" >外交人员身份证</option>'+
				'<option value="外国人居留许可证" >外国人居留许可证</option>'+
				'<option value="边民出入境通行证" >边民出入境通行证</option>'+
				'<option value="其他" >其他</option>'+
			'</select></td>'+
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
		    	var vtd = tdArr.eq(i).children().textbox("getValue").trim().replace(",","，");
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
	
	function getClientChange(){
		var dataJson = {};
		var accountCode = $("#changeBasicAcc #accountCode").val();
		if(accountCode==""){
			alert("账号不能为空。");
			return;
		}
		dataJson["accountCode"]=accountCode;
		loading.show();
		var ajax = new stAjax("getClientChange.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data){
			loading.hide();
			if (data.success){
				$("#openBookDiv .role_window input[id],#clientChangeDiv .role_window input[id]").each(
				function() {
					var name = $(this).attr('id');
					if((data.data)[name]!=null){
						$(this).textbox('setValue',(data.data)[name]);
					}
				});
				$("#openBookDiv .role_window select[id],#clientChangeDiv .role_window select[id]").each(function() {
					var name = $(this).attr('id');
					if ((data.data)[name] == null) {
						var val = $(this).combobox("getData");
						for ( var item in val[0]) {
							if (item == "ID") {
								$(this).combobox("select",val[0][item]);
							}
						}
					}else{
						$(this).combobox('select',(data.data)[name]);
					}
				});
				init();
				controlPrint();
				$('#changeBasicAcc').window('close');
				return false;
			}
			alert(data.msg ? data.msg : "操作失败！");
			return false;
		});
		ajax.setErrorCallback(function() {
			loading.hide();
			alert("获取账户信息失败！");
		});
		ajax.invoke();
	}
	
	function saveChangeBook(status){
		var dataJson = {};
		dataJson["isPrint"] = status;
		var bookId = $("#bookId").textbox("getValue").trim();
		if(bookId==""){
			alert("请查询出需要变更的账户。");
			return;
		}
		if(!$("#clientChangeForm").form('validate')){
			return;
		};
		//地址
		/* var vRegistAddress = $("#registAddressG").val().trim()+","+$("#registAddressS").val().trim()+","+$("#registAddressQ").val().trim()+","+$("#registAddressD").val().trim();
		$("#registAddress").textbox("setValue",vRegistAddress);
		var vOfficeAddress = $("#officeAddressG").val().trim()+","+$("#officeAddressS").val().trim()+","+$("#officeAddressQ").val().trim()+","+$("#officeAddressD").val().trim();
		$("#officeAddress").textbox("setValue",vOfficeAddress); */
		var vRegistAddress = $("#registAddressG").val().trim().replace(",","，")+","+$("#registAddressS").val().trim().replace(",","，")+","
			+$("#registAddressQ").val().trim().replace(",","，")+","+$("#registAddressD").val().trim().replace(",","，");
		$("#openBookDiv #registAddress").textbox("setValue",vRegistAddress);
		var vOfficeAddress = $("#officeAddressG").val().trim().replace(",","，")+","+$("#officeAddressS").val().trim().replace(",","，")+","
			+$("#officeAddressQ").val().trim().replace(",","，")+","+$("#officeAddressD").val().trim().replace(",","，");
		$("#officeAddress").textbox("setValue",vOfficeAddress);
		
		$("#openBookDiv .role_window input[id],#clientChangeDiv .role_window input[id]")
			.each(function() {
			var name = $(this).attr('id');
			if(name=="W1"||name=="W2"||name=="W3"||name=="W4"){
				//商业旺季   复选框
			}else{
				var value = $(this).textbox("getValue").trim();
				dataJson[name] = value;
			}
		});  
		$("#openBookDiv .role_window select[id],#clientChangeDiv .role_window select[id]")
			.each(function() {
			var name = $(this).attr('id');
			var value = $(this).combobox("getValue").trim();
			dataJson[name] = value;
		}); 
		
		var highSeasons = "";
		//商业活动旺季
		$('#sywj input:checkbox:checked').each(function(){
			highSeasons += ($(this).val()+",");
		});
		highSeasons=highSeasons.substring(0,highSeasons.length-1);
		dataJson["highSeasons"]=highSeasons;
		//对公客户信息 股东 权益人信息
		var vClientPartner =  gettrVal('guquan_tb',5);
		if(vClientPartner.length>600){
			alert("股权及受益权人信息中主要股东填写过多。");
			return;
		}
		dataJson["partner"] = vClientPartner;

		var vBeneficiary =  gettrVal('quanyi_tb',5);
		if(vBeneficiary.length>600){
			alert("股权及受益权人信息受权益人填写过多。");
			return;
		}
		dataJson["beneficiary"] = vBeneficiary;
		loading.show();
		var ajax = new stAjax("saveClientChange.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data){
			loading.hide();
			if (data.success){
				$("#openBookDiv #activeId").textbox('setValue', data.data.activeId);
				controlPrint();
				alert(data.msg ? data.msg : "操作成功！");
				return false;
			}
			alert(data.msg ? data.msg : "操作失败！");
			return false;
		});
		ajax.setErrorCallback(function() {
			loading.hide();
			alert("保存变更信息失败！");
		});
		ajax.invoke();
	}
	//客户端打印
	function printToBook(activeId){
		$.messager.confirm('提示:', '如果打印前做过修改请先保存，否则修改将不起效果，你确认要打印吗?', function(event) {
		if (event) {
			var dataJson = {};
			if(activeId == null || activeId == "" || activeId == undefined){
				activeId = $("#activeId").textbox("getValue");
			}else{
				activeId = activeId.substring(6);
			}
			if(activeId == null || activeId == "" || activeId == undefined){
				alert("id为空，数据错误！！！");
				return;
			}else{
				dataJson["activeId"]=activeId;
			}
			
			var ajax = new stAjax("printClientChange.action");
			ajax.setData(dataJson);
			ajax.setSuccessCallback(function(data) {
				if(data.success){			
					$('#printDiv>div').each(function(){
						var name=$(this).attr('id');
						if(name=="printChargeDiv"){
							$('#printChargeDiv div').each(function(){
								var name=$(this).attr('id');
								$(this).text("");//清空数据
								if(data.data.bookCharge!=null){
									$(this).append((data.data.bookCharge)[name]);
								}
							});
						}else{
							$(this).text("");//清空数据
							$(this).append((data.data)[name]);//赋值
						}
					});
					alert("打印成功");
					return;
				}else{
					alert(data.msg ? data.msg : "查询数据失败！");
					return false;
				}
			});
			ajax.setErrorCallback(function() {
				loading.hide();
				alert("服务器处理出现异常，打印失败！");
			});
	
			ajax.invoke();
		 }
		});
	}
</script>
</head>
<body>
	<div class="easyui-panel" title="变更对公客户信息" iconCls="ico_281" style="width:100%;" data-options="fit:true">
		<div id="changeBasicAcc" class="easyui-window" title="变更对公信息账户" data-options="minimizable: false,closable:false,modal:true,iconCls:'ico_171'"
			style="width:500px;height:200px;padding:10px;">
			<div class="business_ss-dm">
				<div class="business_title" style="width:35%">账号：</div>
				<div class="business_input2">
					<input id="accountCode" class="easyui-textbox" style="width:100%;height:24px" />
				</div>
			</div>
			<div class="role_window_button">
				<!-- <div><label style="font-size: 14px;font-weight: bold;">两者录入一项即可</label></div> -->
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'ico_090'"
					style="padding:5px 0px;width:20%; margin-right:10px;" onclick="getClientChange()">
					<span style="font-size:14px;">下一步</span>
				</a>
			</div>
		</div>
		<div id="openBookDiv" style="width:90%;">
			<div class="role_window">
				<div class="business_ss-dm">
					<div class="business_input8" style="display:none">
						<input id="activeId" class="easyui-textbox" value='<s:property value="activeId"/>' />
						<input id="bookId" class="easyui-textbox" value='<s:property value="bookId"/>' />
						<input id="registAddress" class="easyui-textbox" value='<s:property value="registAddress"/>' />
						<input id="officeAddress" class="easyui-textbox" value='<s:property value="officeAddress"/>'/>
						<input id="partner" class="easyui-textbox" value='<s:property value="partner"/>' />
						<input id="beneficiary" class="easyui-textbox" value='<s:property value="beneficiary"/>'/>
						<input id="highSeasons" class="easyui-textbox" value='<s:property value="highSeasons"/>'/>
					</div>
					<div class="business_title2">账号：</div>
					<div class="business_input8">
						<input id="accountCode" value='<s:property value="accountCode"/>' class="easyui-textbox" style="width: 100%; height: 24px" data-options="editable:false" />
					</div>
					<div class="business_title2">账户名称：</div>
					<div class="business_input8">
						<input id="accountName" value='<s:property value="accountName"/>' class="easyui-textbox" style="width: 100%; height: 24px" data-options="editable:false" />
					</div>
					
				</div>
			</div>
		</div>
		<form id="clientChangeForm">
		<div id="clientChangeDiv" style="width:90%;">
			<div class="role_window">
				<div class="role_window_title14">变更事项及变更后内容如下</div>
				<div class="business_ss-dm">
					<div class="business_title2">客户名称：</div>
					<div class="business_input9">
						<input id="name" value='<s:property value="name"/>' class="easyui-textbox"data-options="validType:'maxLength[60]'" style="width: 100%; height: 24px" />
					</div>
				</div>
				<div class="business_title2">注册地址：</div>
				<div class="business_ss-dm">
					<div class="business_title2">国家：</div>
					<div class="business_input8">
						<input id="registAddressG" class="easyui-textbox"  style="width:100%;height:24px" data-options="validType:'maxLength[15]'"/>
					</div>
					<div class="business_title2">省/自治区/直辖市：</div>
					<div class="business_input8">
						<input id="registAddressS" class="easyui-textbox"  style="width:100%;height:24px" data-options="validType:'maxLength[15]'"/>
					</div>
					<div class="business_title2">市/区：</div>
					<div class="business_input8">
						<input id="registAddressQ" class="easyui-textbox"  style="width:100%;height:24px" data-options="validType:'maxLength[15]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">地址：</div>
					<div class="business_input9">
						<input id="registAddressD" class="easyui-textbox"  style="width:100%;height:24px" data-options="validType:'maxLength[50]'"/>
					</div>
					<div class="business_title2">邮编：</div>
					<div class="business_input12">
						<input id="postCodeRegist" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="postCode"/>' data-options="validType:['number','maxLength[20]']"/>
					</div>
				</div>
				<div class="business_title2">通讯地址：</div>
				<div class="business_ss-dm">
					<div class="business_title2">国家：</div>
					<div class="business_input8">
						<input id="officeAddressG" class="easyui-textbox"  style="width:100%;height:24px" data-options="validType:'maxLength[15]'"/>
					</div>
					<div class="business_title2">省/自治区/直辖市：</div>
					<div class="business_input8">
						<input id="officeAddressS" class="easyui-textbox"  style="width:100%;height:24px" data-options="validType:'maxLength[15]'"/>
					</div>
					<div class="business_title2">市/区：</div>
					<div class="business_input8">
						<input id="officeAddressQ" class="easyui-textbox"  style="width:100%;height:24px" data-options="validType:'maxLength[15]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">地址：</div>
					<div class="business_input9">
						<input id="officeAddressD" class="easyui-textbox"  style="width:100%;height:24px" data-options="validType:'maxLength[50]'"/>
					</div>
					<div class="business_title2">邮编：</div>
					<div class="business_input12">
						<input id="postCodeOffice" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="postCodeNews"/>' data-options="validType:['number','maxLength[20]']"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">电话：</div>
					<div class="business_input8">
						<input id="officeTel" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="mobileCode"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">注册资金：</div>
					<div class="business_input8">
						<input id="registMoney" class="easyui-textbox" value='<s:property value="registMoney"/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm" style="height: 60px;">
					<div class="business_title2">经营范围：</div>
					<div class="business_input10">
						<input id="busiScope" class="easyui-textbox" value='<s:property value="busiScope"/>' data-options="multiline:true" style="width:100%;height:50px" />
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">组织机构代码证件号码：</div>
					<div class="business_input8">
						<input id="idNoOrg" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="idNoOrg"/>' data-options="validType:['englishCheckSub','maxLength[30]']"/>
					</div>
					<div class="business_title2">组织机构代码证件到期日：</div>
					<div class="business_input8">
						<input id="endDateOrg" class="easyui-datebox" value='<s:property value="endDateOrg"/>' style="width:100%;" data-options="validType:'maxLength[60]',editable:false"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">营业执照证件号码：</div>
					<div class="business_input8">
						<input id="idNoLicense" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="idNoLicense"/>' data-options="validType:['englishCheckSub','maxLength[30]']"/>
					</div>
					<div class="business_title2">营业执照证件到期日：</div>
					<div class="business_input8">
						<input id="endDateLicense" class="easyui-datebox" value='<s:property value="endDateLicense"/>' style="width:100%;" data-options="validType:'maxLength[60]',editable:false"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">税务登记证（国）证件号码：</div>
					<div class="business_input8">
						<input id="idNoCountry" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="idNoCountry"/>' data-options="validType:['englishCheckSub','maxLength[30]']"/>
					</div>
					<div class="business_title2">税务登记证（国）证件到期日：</div>
					<div class="business_input8">
						<input id=endDateCountry class="easyui-datebox" value='<s:property value="endDateCountry"/>' style="width:100%;" data-options="validType:'maxLength[60]',editable:false"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">税务登记证（地）证件号码：</div>
					<div class="business_input8">
						<input id="idNoTax" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="areaTax"/>' data-options="validType:['englishCheckSub','maxLength[30]']"/>
					</div>
					<div class="business_title2">税务登记证（地）证件到期日：</div>
					<div class="business_input8">
						<input id="endDateTax" class="easyui-datebox" value='<s:property value="endDateTax"/>' style="width:100%;" data-options="validType:'maxLength[60]',editable:false"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">统一社会信用代码证件号码：</div>
					<div class="business_input8">
						<input id="idNoCredit" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="idNoCredit"/>' data-options="validType:['englishCheckSub','maxLength[30]']"/>
					</div>
					<div class="business_title2">统一社会信用代码证件到期日：</div>
					<div class="business_input8">
						<input id="endDateCredit" class="easyui-datebox" value='<s:property value="endDateCredit"/>' style="width:100%;" data-options="validType:'maxLength[60]',editable:false"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">其他证明文件：</div>
					<div class="business_input8">
						<input id="otherIdName" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="otherIdName"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">证件号码：</div>
					<div class="business_input8">
						<input id="idNoOther" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="idNoOther"/>' data-options="validType:['englishCheckSub','maxLength[30]']"/>
					</div>
					<div class="business_title2">证件到期日：</div>
					<div class="business_input8">
						<input id="endDateOther" class="easyui-datebox" value='<s:property value="endDateOther"/>' style="width:100%;" data-options="validType:'maxLength[60]',editable:false"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">法定代表人  姓：</div>
					<div class="business_input8">
						<input id="legalRepresentSurname" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="legalRepresentSurname"/>' data-options="validType:'maxLength[25]'"/>
					</div>
					<div class="business_title2">法定代表人  名：</div>
					<div class="business_input8">
						<input id="legalRepresentName" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="legalRepresentName"/>' data-options="validType:'maxLength[25]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">证件名称：</div>
					<div class="business_input8">
						<input id="idTypeLegal" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="idTypeLegal"/>' data-options="validType:'maxLength[25]'"/>
					</div>
					<div class="business_title2">证件号码：</div>
					<div class="business_input8">
						<input id="idNoLegal" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="idNoLegal"/>' data-options="validType:['englishCheckSub','maxLength[30]']"/>
					</div>
					<div class="business_title2">证件到期日：</div>
					<div class="business_input8">
						<input id="endDateLegal" class="easyui-datebox"  style="width:100%;height:24px" value='<s:property value="endDateLegal"/>' data-options="validType:'maxLength[60]',editable:false"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">法定代表人国籍：</div>
					<div class="business_input8">
						<input id="nationalLegal" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="nationalLegal"/>' data-options="validType:'maxLength[25]'"/>
					</div>
					<div class="business_title2">法定代表人出生日期：</div>
					<div class="business_input8">
						<input id="birthDateLegal" class="easyui-datebox" style="width:100%;height:24px" value='<s:property value="birthDateLegal"/>' data-options="validType:'maxLength[25]',editable:false"/>
					</div>
					<div class="business_title2">主要营业国家或地区：</div>
					<div class="business_input8">
						<input id="busiCountry" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="busiCountry"/>' data-options="validType:'maxLength[25]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">是否上市公司：</div>
					<div class="business_input8">
						<select id="publicCompany" class="easyui-combobox" style="width:100%;" data-options="validType:'maxLength[60]',editable:false">
							<option value=""></option>
							<option value="0" <s:if test='publicCompany=="0"'>selected='selected'</s:if>>是上市公司</option>
							<option value="1" <s:if test='publicCompany=="1"'>selected='selected'</s:if>>不是上市公司</option>
						</select>
					</div>
					<div class="business_title2">从业人数：</div>
					<div class="business_input8">
						<input id="numEmp" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="numEmp"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">创建日期：</div>
					<div class="business_input8">
						<input id="createDate" class="easyui-datebox" style="width:100%;height:24px" value='<s:property value="createDate"/>' data-options="validType:'maxLength[60]',editable:false"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">年销售币种及销售额：</div>
					<div class="business_input8">
						<input id="salesVolume" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="salesVolume"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">主要海外分支机构所在国家或地区：</div>
					<div class="business_input8">
						<input id="overseasAffiliate" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="overseasAffiliate"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">主要海外客户所在地：</div>
					<div class="business_input8">
						<input id="overseasCust" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="overseasCust"/>' data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div id="sywj" class="business_ss-dm">
					<div class="business_title2">商业活动旺季（可多选）：</div>
					<div class="business_input8">
						<%-- <input id="highSeasons" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="highSeasons"/>'/> --%>
						<label><input id="W1" name="W" type="checkbox" value="W1" />1-3月</label> 
						<label><input id="W2" name="W" type="checkbox" value="W2" />4-6月 </label> 
						<label><input id="W3" name="W" type="checkbox" value="W3" />7-9月 </label>
						<label><input id="W4" name="W" type="checkbox" value="W4" />10-12月 </label>  
					</div>
					<div class="business_title2">其他业务：</div>
					<div class="business_input8">
						<input id="otherBusi" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="otherBusi"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">其他联系方式（移动电话/电子邮件/传真等）：</div>
					<div class="business_input8">
						<input id="otherContact" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="otherContact"/>' data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
			</div>
			<div class="role_window">
				<br /><div class="business_title2">以下为财务负责人信息：</div><br />
				<div class="business_ss-dm">
					<div class="business_title2">姓：</div>
					<div class="business_input19">
						<input id="moneyManSurname" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="moneyManSurname"/>' data-options="validType:'maxLength[25]'"/>
					</div>
					<div class="business_title6">名：</div>
					<div class="business_input19">
						<input id="moneyManName" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="moneyManName"/>' data-options="validType:'maxLength[25]'"/>
					</div>
					<div class="business_title6">国籍：</div>
					<div class="business_input19">
						<input id="nationalMoney" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="nationalMoney"/>' data-options="validType:'maxLength[25]'"/>
					</div>
					<div class="business_title6">出生日期：</div>
					<div class="business_input12">
						<input id="birthDateMoney" class="easyui-datebox" style="width:100%;height:24px" value='<s:property value="birthDateMoney"/>' data-options="validType:'maxLength[60]',editable:false"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">证件名称：</div>
					<div class="business_input8">
						<input id="idNameMoney" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="idNameMoney"/>' data-options="validType:'maxLength[25]'"/>
					</div>
					<div class="business_title6">证件号码：</div>
					<div class="business_input12">
						<input id="idNoMoney" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="idNoMoney"/>' data-options="validType:['englishCheckSub','maxLength[30]']"/>
					</div>
					<div class="business_title6">证件到期日：</div>
					<div class="business_input12">
						<input id="endDateMoney" class="easyui-datebox"  style="width:100%;height:24px" value='<s:property value="endDateMoney"/>' data-options="validType:'maxLength[60]',editable:false"/>
					</div>
				</div>
				
				<br /><div class="business_title2">以下为联系人信息：</div><br />
				<div class="business_ss-dm">
					<div class="business_title2">姓：</div>
					<div class="business_input19">
						<input id="contactManSurname" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="contactManSurname"/>' data-options="validType:'maxLength[25]'"/>
					</div>
					<div class="business_title6">名：</div>
					<div class="business_input19">
						<input id="contactManName" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="contactManName"/>' data-options="validType:'maxLength[25]'"/>
					</div>
					<div class="business_title6">国籍：</div>
					<div class="business_input19">
						<input id="nationalContact" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="nationalContact"/>' data-options="validType:'maxLength[25]'"/>
					</div>
					<div class="business_title6">出生日期：</div>
					<div class="business_input12">
						<input id="birthDateContact" class="easyui-datebox" style="width:100%;height:24px" value='<s:property value="birthDateContact"/>' data-options="validType:'maxLength[60]',editable:false"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">联系电话：</div>
					<div class="business_input8">
						<input id="telContact" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="telContact"/>' data-options="validType:['englishCheckSub','maxLength[30]']"/>
					</div>
					<div class="business_title6">电子邮件：</div>
					<div class="business_input12">
						<input id="emailContact" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="emailContact"/>' data-options="validType:'email'"/>
					</div>
				</div>
				<br />
				<div class="business_title2">以下为代办人信息：</div>
				<br />
				<div class="business_ss-dm">
					<div class="business_title2">姓：</div>
					<div class="business_input19">
						<input id="agentManSurname" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="agentManSurname"/>' data-options="validType:'maxLength[25]'"/>
					</div>
					<div class="business_title6">名：</div>
					<div class="business_input19">
						<input id="agentManName" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="agentManName"/>' data-options="validType:'maxLength[25]'"/>
					</div>
					<div class="business_title6">国籍：</div>
					<div class="business_input19">
						<input id="nationalAgent" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="nationalAgent"/>' data-options="validType:'maxLength[25]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">证件名称：</div>
					<div class="business_input8">
						<input id="idNameAgent" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="idNameAgent"/>' data-options="validType:'maxLength[25]'"/>
					</div>
					<div class="business_title6">证件号码：</div>
					<div class="business_input12">
						<input id="idNoAgent" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="idNoAgent"/>' data-options="validType:['englishCheckSub','maxLength[30]']"/>
					</div>
					<div class="business_title6">证件到期日：</div>
					<div class="business_input12">
						<input id="endDateAgent" class="easyui-datebox"  style="width:100%;height:24px" value='<s:property value="endDateAgent"/>' data-options="validType:'maxLength[60]',editable:false"/>
					</div>
				</div>
			</div>
		</div>
		<div id="relationDiv" style="width:90%;">
			<div class="role_window">
				<div class="role_window_title14" style="float: left;">以下为股权及受益权人信息</div>
				<div class="business_ss-dm1">
					<div class="business_title2">主要股东：</div>
					<div >
						<table id="guquan_tb">
							<tr>
								<td>姓名/名称</td>
								<td>证件种类</td>
								<td>证件号码</td>
								<td>证件到期日</td>
								<td>控股比例(%)</td>
								<!-- <td>操作</td> -->
							</tr>
						</table>
						<div style="border:2px; border-color:#00CC00;  margin-left:20%;margin-top:20px">
							<input type="button" value="增加" onclick="addClintTbtr('guquan_tb')" />
							<!-- <input type="button" id="getGQData_btn" value="获取表格数据" onclick="gettrVal('guquan_tb',5)" /> -->
						</div>
					</div>
					<div class="business_title2">收益权人：</div>
					<div >
						<table id="quanyi_tb">
							<tr>
								<td>姓名/名称</td>
								<td>证件种类</td>
								<td>证件号码</td>
								<td>证件到期日</td>
								<td>控股比例</td>
								<!-- <td>操作</td> -->
							</tr>
						</table>
						<div style="border:2px; border-color:#00CC00;  margin-left:20%;margin-top:20px">
							<input type="button"  value="增加" onclick="addClintTbtr('quanyi_tb')"/>
							<!-- <input type="button" id="getGQData_btn" value="获取表格数据" onclick="gettrVal('guquan_tb',5)" /> -->
						</div>
					</div>
				</div>
			</div>
		</div>
		</form>
		<div style="width:90%;">
			<div class="role_window">
				<div class="role_window_button" style="margin-top:30px; padding: 10px auto;">
					<a href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="saveChangeBook(0)">
						<span style="font-size:14px;">保存</span>
					</a>
					<a id="printBtn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-print'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="printToBook()">
						<span style="font-size:14px;">打印</span>
					</a>
					<%-- <a href="javascript:void(0)" name="uploadBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="uploadWindow()">
						<span style="font-size:14px;">上传附件</span>
					</a>
					<a href="javascript:void(0)" name="recordBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="record(5)">
						<span style="font-size:14px;">备案</span>
					</a> --%>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>
