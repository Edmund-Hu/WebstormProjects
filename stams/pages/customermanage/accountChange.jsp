<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="santai" uri="/tags/santai"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>变更单位银行结算账户申请书</title>
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
		
		var vCompany = $("#openBookDiv #relationCompany").textbox("getValue").split('||');
		for(var i = 0; i<vCompany.length; i++){
			var company = vCompany[i].split(',');
			if(company.length>1){
				$("#glqiye_tb").append("<tr id=" + i + " align='center' >" +
				"<td><input class='easyui-textbox' style='width:100%;height:24px' value='"+company[0]+"' /></td>" +
				"<td><input class='easyui-textbox' style='width:100%;height:24px' value='"+company[1]+"' /></td>" +
				"<td><input class='easyui-textbox' style='width:100%;height:24px' value='"+company[2]+"' /></td>" +
				"<td><input class='easyui-textbox' style='width:100%;height:24px' value='"+company[3]+"' /></td>" +
				"<td><a href=\'#\' onclick=\"deltr(\'glqiye_tb\'," + i + ")\">删除</a></td>" +
				"</tr>");
			 	//$.parser.parse();
				$.parser.parse("#glqiye_tb");
			}
		}
		
		//股东
		var vRelationPartner = $("#openBookDiv #relationPartner").textbox("getValue").split('||');
		for(var i = 0; i<vRelationPartner.length; i++){
			var partner = vRelationPartner[i].split(',');
			if(partner.length>1){
				$("#glgudong_tb").append("<tr id=" + i + " align='center' >" +
				"<td><input class='easyui-textbox' style='width:100%;height:24px' value='"+partner[0]+"' /></td>" +
				/* '<td><select class="easyui-combobox" style="width:100%;" data-options="editable:false">'+
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
				'</select></td>'+ */
				'<td>'+
				"<input class='easyui-combobox' style='width:100%;height:24px' url='getTypeEnum.action?typeCode=ID_TYPE'"+ 
				"data-options="+'"'+"valueField:'typeValue', textField:'typeName',editable:false"+'" '+"value='"+partner[1]+"' >"+
				'</td>'+
				"<td><input class='easyui-textbox' style='width:100%;height:24px' value='"+partner[2]+"'/></td>" +
				"<td><input class='easyui-datebox' style='width:100%;height:24px' value='"+partner[3]+"' data-options='editable:false' /></td>" +
				"<td><input class='easyui-textbox' style='width:100%;height:24px' value='"+partner[4]+"' /></td>" +
				"<td><a href=\'#\' onclick=\"deltr(\'glgudong_tb\'," + i + ")\">删除</a></td>" +
				"</tr>");
			 	//$.parser.parse();
			 	$("#glgudong_tb tr[id='"+ i +"']").children().eq(1).children().find("option[value='"+partner[1]+"']").attr("selected",true);
				$.parser.parse("#glgudong_tb");
			}
		}
		//被授权办理业务人
		var vPeople = $("#authorizePeople").textbox("getValue").split('||');
		var dataStr = "data:[{a:'A',b:'A'},{a:'B',b:'B'},{a:'C',b:'C'},{a:'D',b:'D'},{a:'E',b:'E'},{a:'F',b:'F'},"+
  	    "{a:'G',b:'G'},{a:'H',b:'H'},{a:'I',b:'I'}]";
		for(var i = 0; i<vPeople.length; i++){
			var people = vPeople[i].split(',');
			if(people.length>1){
				$("#shouquan_tb").append("<tr id=" + i + " align='center' >" +
				"<td><input class='easyui-textbox' style='width:100%;height:24px' value='"+people[0]+"' /></td>" +
				'<td>'+
				"<input class='easyui-combobox' style='width:100%;height:24px' url='getTypeEnum.action?typeCode=ID_TYPE'"+ 
				"data-options="+'"'+"valueField:'typeValue', textField:'typeName',editable:false"+'" '+"value='"+people[1]+"' >"+
				'</td>'+
				"<td><input class='easyui-textbox' style='width:100%;height:24px' value='"+people[2]+"' /></td>" +
				"<td><input class='easyui-datebox' style='width:100%;height:24px' value='"+people[3]+"' data-options='editable:false'/></td>" +
				"<td><input class='easyui-textbox' style='width:100%;height:24px' value='"+people[4]+"' /></td>" +
				"<td>"+
				"<input class='easyui-combobox' data-options="+'"'+"separator:'.',multiple:'true',editable:false,valueField:'a',textField:'b',"+dataStr+'"'+" value='"+people[5]+"' style='width:100%;height:24px' >"+
				"</td>" +
				"<td><a href=\'#\' onclick=\"deltr(\'shouquan_tb\'," + i + ")\">删除</a></td>" +
				"</tr>");
			 	//$.parser.parse();
				$.parser.parse("#shouquan_tb");
			}
		}
		
		//被授权的内容
		var vContent = $("#authorizeContent").textbox("getValue").split(",");
		$("#I").textbox("setValue",vContent[0]);//其他
		
		if(vContent.length>1){
			for(var i=1; i<vContent.length; i++){
				$("#"+vContent[i]).attr("checked", true);
			}
		}
	}		
	
	function getAccountChange(){
		var dataJson = {};
		var accountCode = $("#changeBasicAcc #accountCode").val();
		var checkNumber = $("#changeBasicAcc #checkNumber").val();
		if(accountCode==""&&checkNumber==""){
			alert("账号和开户许可证核准号不能都为空。");
			return;
		}
		dataJson["accountCode"]=accountCode;
		dataJson["checkNumber"]=checkNumber;
		loading.show();
		var ajax = new stAjax("getAccountChange.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data){
			loading.hide();
			if (data.success){
				$("#openBookDiv .role_window input[id],#accChangeDiv .role_window input[id],#clientChangeDiv .role_window input[id]").each(
				function() {
					var name = $(this).attr('id');
					if((data.data)[name]!=null){
						$(this).textbox('setValue',(data.data)[name]);
					}
				});
				$("#openBookDiv .role_window select[id],#accChangeDiv .role_window select[id],#clientChangeDiv .role_window select[id]").each(function() {
					var name = $(this).attr('id');
					if((data.data)[name]!=null){
						$(this).combobox('setValue',(data.data)[name]);
					}
				});
				init();
				controlPrint();
				$('#changeBasicAcc').window('close');
				return false;
			}
			alert(data.msg ? data.msg : "操作失败！");//alert("未查询到当前账户，可关闭查询窗口手动填写。");
			return false;
		});
		ajax.setErrorCallback(function() {
			loading.hide();
			alert("获取账户信息失败！");
		});
		ajax.invoke();
	}
	
	function saveChangeBook(status,tohome){
		var dataJson = {};
		dataJson["isPrint"] = status;
		/* var bookId = $("#bookId").textbox("getValue").trim();//可能存在系统不存在的 存量客户
		if(bookId==""){
			alert("请查询出需要变更的账户。");
			return;
		} */
		if(!$("#accChangeForm").form('validate')){
			return;
		};
		//地址
		var vRegistAddress = $("#registAddressG").val().trim().replace(",","，")+","+$("#registAddressS").val().trim().replace(",","，")+","
			+$("#registAddressQ").val().trim().replace(",","，")+","+$("#registAddressD").val().trim().replace(",","，");
		$("#openBookDiv #registAddress").textbox("setValue",vRegistAddress);
		var vOfficeAddress = $("#officeAddressG").val().trim().replace(",","，")+","+$("#officeAddressS").val().trim().replace(",","，")+","
			+$("#officeAddressQ").val().trim().replace(",","，")+","+$("#officeAddressD").val().trim().replace(",","，");
		$("#officeAddress").textbox("setValue",vOfficeAddress);
		
		//关联企业 股东
		var vCompany =  gettrVal('glqiye_tb',4);
		if(vCompany.length>600){
			alert("关联企业信息填写过多。");
			return;
		}
		$("#relationCompany").textbox("setValue",vCompany);

		var vPartner =  gettrVal('glgudong_tb',5);
		if(vPartner.length>600){
			alert("关联股东信息填写过多。");
			return;
		}
		$("#relationPartner").textbox("setValue",vPartner);
		
		$("#openBookDiv .business_ss-dm input[id],#accChangeDiv .business_ss-dm input[id],#clientChangeDiv .business_ss-dm input[id]")
			.each(function() {
			var name = $(this).attr('id');
			var value = $(this).textbox("getValue").trim();
			dataJson[name] = value;
		});  
		$("#openBookDiv .business_ss-dm select[id],#accChangeDiv .business_ss-dm select[id],#clientChangeDiv .business_ss-dm select[id]")
			.each(function() {
			var name = $(this).attr('id');
			var value = $(this).combobox("getValue").trim();
			dataJson[name] = value;
		}); 
		
		//结算账户授权
		//被授权人信息
		var vsq =  gettrVal('shouquan_tb',6);
		if(vsq.length>600){
			alert("结算账户相关业务授权中被授权人信息填写过多。");
			return;
		}
		dataJson["authorizePeople"] = vsq;
		
		//办理业务
		var other = $("#I").val().trim().replace(",","，");//其他
		var content = other;
		$('#authorizeDiv input:checkbox:checked').each(function(){
			content += (","+$(this).val());
		});
        dataJson["authorizeContent"] = content;
		
		loading.show();
		var ajax = new stAjax("saveAccountChange.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data){
			loading.hide();
			if (data.success){
				$("#openBookDiv #activeId").textbox('setValue', data.data.activeId);
				controlPrint();
				alert(data.msg ? data.msg : "操作成功！");
				if(tohome){
					redirectUrl("blankmain.action", top.mainframe.document);
				}
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
	function printToBook(activeId,pageNum){
		$.messager.confirm('提示:', '如果打印前做过修改请先保存，否则修改将不起效果，你确认要打印吗?', function(event) {
		if (event) {
			var dataJson = {};
			if(activeId == null || activeId == "" || activeId == undefined){
				activeId = $("#activeId").textbox("getValue");
			}else{
				activeId = activeId.substring(6);
			}
			if(activeId == null || activeId == "" || activeId == undefined){
				alert("请先保存后，在打印。");
				return;
			}else{
				dataJson["activeId"]=activeId;
			}
			
			var ajax = new stAjax("printAccountChange.action");
			ajax.setData(dataJson);
			ajax.setSuccessCallback(function(data) {
				if(data.success){			
					accChangeData = data.data;
					prn_print(pageNum);
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
	<div class="easyui-panel" title="变更单位银行结算账户申请书" iconCls="ico_281" style="width:100%;" data-options="fit:true">
		<div id="changeBasicAcc" class="easyui-window" title="变更单位银行结算账户" data-options="minimizable: false,modal:true,iconCls:'ico_171'"
			style="width:500px;height:200px;padding:10px;">
			<div class="business_ss-dm">
				<div class="business_title" style="width:35%">账号：</div>
				<div class="business_input2">
					<input id="accountCode" class="easyui-textbox" style="width:100%;height:24px" />
				</div>
			</div>
			<div class="business_ss-dm">
				<div class="business_ss-dm">
					<div class="business_title" style="width:35%">开户许可证核准号：</div>
					<div class="business_input2">
						<input id="checkNumber" class="easyui-textbox" style="width:100%;height:24px" />
					</div>
				</div>
			</div>
			<div class="role_window_button">
				<!-- <div><label style="font-size: 14px;font-weight: bold;">两者录入一项即可</label></div> -->
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'ico_090'"
					style="padding:5px 0px;width:20%; margin-right:10px;" onclick="getAccountChange()">
					<span style="font-size:14px;">下一步</span>
				</a>
			</div>
		</div>
		<div id="openBookDiv" style="width:100%;">
			<div id="authorizeDiv" style="width:100%">
			<div class="role_window">
				<div class="business_ss-dm">
					<div style="display:none">
						<input id="authorizePeople" class="easyui-textbox" value='<s:property value="authorizePeople"/>'/>
						<input id="authorizeContent" class="easyui-textbox" value='<s:property value="authorizeContent"/>'/>
					</div>
					<div class="business_title2">单位全称：</div>
					<div class="business_input8">
						<input id="companyName" class="easyui-textbox" style="width:100%;height:24px" data-options="required:true,validType:'maxLength[60]'" value='<s:property value="companyName"/>'/>
					</div>
					<div class="business_title2">法定代表人(负责人)：</div>
					<div class="business_input8">
						<input id="newLinkMan" class="easyui-textbox" value='<s:property value="newLinkMan"/>'  style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm1">
					<div class="business_title2">被授权人信息：</div>
					<div>
						<table id="shouquan_tb">
							<tr>
								<td>姓名</td>
								<td>证件类型</td>
								<td>证件号码</td>
								<td>证件到期日</td>
								<td>联系电话</td>
								<td>授权办理业务种类</td>
							</tr>
						</table>
						<div style="border:2px; border-color:#00CC00;  margin-left:20%;margin-top:20px">
							<input type="button"  value="增加" onclick="addAuthorize('shouquan_tb')"/>
						</div>
					</div>
				</div>
				<div class="business_ss-dm1" style="margin-top: 40px;">
					<div class="business_title2">办理业务种类：</div>
					<div >
						<table>
							<tr>
								<td>
									A、办理单位银行结算账户变更
								</td>
							</tr>
							<tr>
								<td>
									B、办理企业网上银行相关业务:领取网上银行客户认证工具(“动态l1令牌E-Token”/ “数字证书令牌” “USBkey”及相应密码信封)
								</td>
							</tr>
							<tr>
								<td>
									C、签署综合服务协议
								</td>
							</tr>
							<tr>
								<td>
									D、预留签章式样：将其个人签章及
									<label><input id="D1" name="D" type="checkbox" value="D1" />本单位公章</label> 
									<label><input id="D2" name="D" type="checkbox" value="D2" />财务专用章作为预留银行印鉴 </label> 
								</td>
							</tr>
							<tr>
								<td>
									E、变更预留签章式样：变更
									<label><input id="E1" name="E" type="checkbox" value="E1" />个人签章及</label> 
									<label><input id="E2" name="E" type="checkbox" value="E2" />本单位公章 </label> 
									<label><input id="E3" name="E" type="checkbox" value="E3" />财务专用章 </label> 
								</td>
							</tr>
							<tr>
								<td>
									F、作为结算证主卡指定持卡人
								</td>
							</tr>
							<tr>
								<td>
									G、作为结算证副卡指定持卡人
								</td>
							</tr>
							<tr>
								<td>
									H、作为我单位大额交易有权确认人员(原则上应为两人)
								</td>
							</tr>
							<tr>
								<td>
									I、其他：
									<input id="I" style="width:40%;" class="easyui-textbox"  data-options="validType:'maxLength[120]'"/>
								</td>
							</tr>
						</table>
					</div>
				</div>
				</div>
			</div>
			
			<div class="role_window">
				<div class="business_ss-dm">
					<div class="business_input8" style="display:none">
						<input id="activeId" class="easyui-textbox" value='<s:property value="activeId"/>' />
						<input id="bookId" class="easyui-textbox" value='<s:property value="bookId"/>' />
						<input id="registAddress" class="easyui-textbox" value='<s:property value="registAddress"/>' />
						<input id="officeAddress" class="easyui-textbox" value='<s:property value="officeAddress"/>'/>
						<input id="relationCompany" class="easyui-textbox" value='<s:property value="relationCompany"/>' />
						<input id="relationPartner" class="easyui-textbox" value='<s:property value="relationPartner"/>'/>
					</div>
					<div class="business_title2">账户名称：</div>
					<div class="business_input8">
						<input id="oldAccountName" value='<s:property value="oldAccountName"/>' class="easyui-textbox" style="width: 100%; height: 24px" data-options="validType:'maxLength[60]'" />
					</div>
					<div class="business_title4">开户银行代码：</div>
					<div class="business_input8">
						<input id="openBankCode" value='<s:property value="openBankCode"/>' class="easyui-textbox" style="width: 100%; height: 24px" data-options="validType:'maxLength[60]'" />
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">账号：</div>
					<div class="business_input8">
						<input id="accountCode" value='<s:property value="accountCode"/>' class="easyui-textbox" style="width: 100%; height: 24px" data-options="validType:'maxLength[60]'" />
					</div>
					<div class="business_title4">账户性质：</div>
					<div class="business_input8">
						<select id="accountType" class="easyui-combobox" name="accountType" style="width:100%;" data-options="panelHeight:'auto',editable:false">
							<option value="0" selected='selected'>基本账户</option>
							<option value="1" <s:if test="accountType==1">selected='selected'</s:if>>一般账户</option>
							<option value="2" <s:if test="accountType==2">selected='selected'</s:if>>预算单位专用存款账户</option>
							<option value="3" <s:if test="accountType==3">selected='selected'</s:if>>特殊单位专用存款账户</option>
							<option value="4" <s:if test="accountType==4">selected='selected'</s:if>>非预算单位专用存款账户</option>
							<option value="5" <s:if test="accountType==5">selected='selected'</s:if>>临时机构临时存款账户</option>
							<option value="6" <s:if test="accountType==6">selected='selected'</s:if>>非临时机构临时存款账户</option>
						</select> 
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">开户许可证核准号：</div>
					<div class="business_input9">
						<input id="checkNumber" value='<s:property value="checkNumber"/>' class="easyui-textbox" value="" data-options="width:400,validType:'maxLength[60]'" style="height: 24px" />
					</div>
				</div> 
			</div>
		</div>
		<form id="accChangeForm">
		<div id="accChangeDiv" style="width:100%">
			<div class="role_window">
				<div class="role_window_title14">变更事项及变更后内容如下</div>
				<div class="business_ss-dm">
					<div class="business_title2">账户名称：</div>
					<div class="business_input9">
						<input id="accountName" value='<s:property value="accountName"/>' class="easyui-textbox"data-options="validType:'maxLength[60]'" style="width: 100%; height: 24px" />
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
						<input id="postCode" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="postCode"/>' data-options="validType:['number','maxLength[20]']"/>
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
						<input id="postCodeNews" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="postCodeNews"/>' data-options="validType:['number','maxLength[20]']"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">电话：</div>
					<div class="business_input8">
						<input id="mobileCode" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="mobileCode"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">注册资金：</div>
					<div class="business_input8">
						<input id="registMoney" class="easyui-textbox" value='<s:property value="registMoney"/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">注册货币：</div>
					<div class="business_input8">
						<%-- <select id="registMoneyType" class="easyui-combobox" name="registMoneyType" style="width:100%;" data-options="panelHeight:'auto',editable:false">
								<option value="1" <s:if test="registMoneyType==1">selected='selected'</s:if>>人民币</option>
								<option value="2" <s:if test="registMoneyType==2">selected='selected'</s:if>>美元</option>
								<option value="3" <s:if test="registMoneyType==3">selected='selected'</s:if>>港元</option>
								<option value="4" <s:if test="registMoneyType==4">selected='selected'</s:if>>日元</option>
								<option value="5" <s:if test="registMoneyType==5">selected='selected'</s:if>>欧元</option>
								<option value="A" <s:if test='registMoneyType=="A"'>selected='selected'</s:if>>英镑</option>
								<option value="B" <s:if test='registMoneyType=="B"'>selected='selected'</s:if>>加拿大元</option>
								<option value="C" <s:if test='registMoneyType=="C"'>selected='selected'</s:if>>澳大利亚元</option>
								<option value="D" <s:if test='registMoneyType=="D"'>selected='selected'</s:if>>韩元</option>
								<option value="E" <s:if test='registMoneyType=="E"'>selected='selected'</s:if>>新加坡元</option>
								<option value="F" <s:if test='registMoneyType=="F"'>selected='selected'</s:if>>其它货币折美元</option>
						</select> --%>
						<select class="easyui-combobox" id="registMoneyType" name="registMoneyType" style="width:100%;height:24px" url='getTypeEnum.action?typeCode=REGIST_MONEY_TYPE' 
							data-options="editable:false,valueField:'typeValue', textField:'typeName'" value='<s:property value="registMoneyType"/>' ></select>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">证明文件种类：</div>
					<div class="business_input8">
						<%-- <input id="fileType" class="easyui-textbox" value='<s:property value="fileType"/>'  style="width:100%;height:24px"  data-options="validType:'maxLength[60]'"/> --%>
						<select class="easyui-combobox" id="fileType" name="fileType" style="width:100%;height:24px" url='getTypeEnum.action?typeCode=FILE_TYPE' 
							data-options="editable:false,valueField:'typeValue', textField:'typeName'" value='<s:property value="fileType"/>' ></select>
					</div>
					<div class="business_title2">证明文件编号：</div>
					<div class="business_input8">
						<input id="fileNumber" class="easyui-textbox" style="width:100%;height:24px"  value='<s:property value="fileNumber"/>' data-options="validType:['englishCheckSub','maxLength[60]']"/>
					</div>
					<div class="business_title2">证明文件到期日：</div>
					<div class="business_input12">
						<input id="fileEndDate" class="easyui-datebox" value='<s:property value="fileEndDate"/>' style="width:100%;" data-options="editable:false"/>
					</div>
				</div>
				<%-- <div class="business_ss-dm">
					<div class="business_title2">证明文件种类2：</div>
					<div class="business_input8">
						<input id="fileTypeSecond" class="easyui-textbox" value='<s:property value="fileTypeSecond"/>'  style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">证明文件编号2：</div>
					<div class="business_input8">
						<input id="fileNumberSecond" class="easyui-textbox" value='<s:property value="fileNumberSecond"/>' style="width:100%;height:24px" data-options="validType:['englishCheckSub','maxLength[60]']"/>
					</div>
					<div class="business_title2">证明文件到期日2：</div>
					<div class="business_input12">
						<input id="fileEndDateSecond" class="easyui-datebox" value='<s:property value="fileEndDateSecond"/>' style="width:100%;" data-options="editable:false"/>
					</div>
				</div> --%>
				<div class="business_ss-dm" style="height: 60px;">
					<div class="business_title2">经营范围：</div>
					<div class="business_input10">
						<input id="busiScope" class="easyui-textbox" value='<s:property value="busiScope"/>' data-options="multiline:true" style="width:100%;height:50px" />
					</div>
				</div>
				<div class="business_title2">法定代表人或单位负责人</div>
				<div class="business_ss-dm">
					<div class="business_title2">姓名：</div>
					<div class="business_input19">
						<input id="linkMan" class="easyui-textbox" value='<s:property value="linkMan"/>'  style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title6">证件到期日：</div>
					<div class="business_input12">
						<input id="linkIdEndDate" class="easyui-datebox" value='<s:property value="linkIdEndDate"/>' style="width:100%;" data-options="editable:false" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title6">证件种类：</div>
					<div class="business_input12">
						<%-- <select id="idType" class="easyui-combobox" name="idType" style="width:100%;" data-options="panelHeight:'auto',editable:false">
							<option value=""></option>
							<option value="1" <s:if test="idType==1">selected='selected'</s:if>>居民身份证</option>
							<option value="2" <s:if test="idType==2">selected='selected'</s:if>>临时身份证</option>
							<option value="3" <s:if test="idType==3">selected='selected'</s:if>>文护照</option>
							<option value="4" <s:if test="idType==4">selected='selected'</s:if>>户口簿</option>
							<option value="5" <s:if test="idType==5">selected='selected'</s:if>>军人身份证件</option>
							<option value="6" <s:if test="idType==6">selected='selected'</s:if>>武装警察身份证件</option>
							<option value="7" <s:if test="idType==7">selected='selected'</s:if>>港澳居民往来内地通行证</option>
							<option value="8" <s:if test="idType==8">selected='selected'</s:if>>外交人员身份证</option>
							<option value="9" <s:if test="idType==9">selected='selected'</s:if>>外国人居留许可证</option>
							<option value="10" <s:if test="idType==10">selected='selected'</s:if>>边民出入境通行证</option>
							<option value="11" <s:if test="idType==11">selected='selected'</s:if>>其他</option>
						</select> --%>
						<select class="easyui-combobox" id="idType" name="idType"  value='<s:property value="idType"/>' style="width:100%;height:24px" url='getTypeEnum.action?typeCode=ID_TYPE' 
							data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  ></select>
						<%-- <input id="idType" class="easyui-textbox" value='<s:property value="idType"/>'  style="width:100%;height:24px" /> --%>
					</div>
					<div class="business_title6">证件号码：</div>
					<div class="business_input12">
						<input id="idNumber" class="easyui-textbox" value='<s:property value="idNumber"/>'  style="width:100%;height:24px"  data-options="validType:['englishCheckSub','maxLength[60]']"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title4">上级法人或主管单位的基本存款账户核准号：</div>
					<div class="business_input9">
						<input id="chargeCheckNumber" style="width:100%;" class="easyui-textbox" value='<s:property value="chargeCheckNumber"/>' data-options="validType:['englishCheckSub','maxLength[20]']"/>
					</div>
				</div>
				<div class="business_title4">上级法人或主管单位法定代表人或单位负责人</div>
				<div class="business_ss-dm">
					<div class="business_title2">姓名：</div>
					<div class="business_input19">
						<input id="chargeLinkMan" class="easyui-textbox" value='<s:property value="chargeLinkMan"/>'  style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title6">证件到期日：</div>
					<div class="business_input12">
						<input id="chargeLicenseEndDate" class="easyui-datebox" value='<s:property value="chargeLicenseEndDate"/>' style="width:100%;" data-options="editable:false"/>
					</div>
					<div class="business_title6">证件种类：</div>
					<div class="business_input12">
						<%-- <select id="chargeIdType" class="easyui-combobox" name="chargeIdType" style="width:100%;" data-options="panelHeight:'auto',editable:false">
							<option value=""></option>
							<option value="1" <s:if test="chargeIdType==1">selected='selected'</s:if>>居民身份证</option>
							<option value="2" <s:if test="chargeIdType==2">selected='selected'</s:if>>临时身份证</option>
							<option value="3" <s:if test="chargeIdType==3">selected='selected'</s:if>>文护照</option>
							<option value="4" <s:if test="chargeIdType==4">selected='selected'</s:if>>户口簿</option>
							<option value="5" <s:if test="chargeIdType==5">selected='selected'</s:if>>军人身份证件</option>
							<option value="6" <s:if test="chargeIdType==6">selected='selected'</s:if>>武装警察身份证件</option>
							<option value="7" <s:if test="chargeIdType==7">selected='selected'</s:if>>港澳居民往来内地通行证</option>
							<option value="8" <s:if test="chargeIdType==8">selected='selected'</s:if>>外交人员身份证</option>
							<option value="9" <s:if test="chargeIdType==9">selected='selected'</s:if>>外国人居留许可证</option>
							<option value="10" <s:if test="chargeIdType==10">selected='selected'</s:if>>边民出入境通行证</option>
							<option value="11" <s:if test="chargeIdType==11">selected='selected'</s:if>>其他</option>
						</select> --%>
						<select class="easyui-combobox" id="chargeIdType" name="chargeIdType"  value='<s:property value="chargeIdType"/>'style="width:100%;height:24px" url='getTypeEnum.action?typeCode=ID_TYPE' 
							data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  ></select>
						<%-- <input id="chargeIdType" class="easyui-textbox" value='<s:property value="chargeIdType"/>'  style="width:100%;height:24px" /> --%>
					</div>
					<div class="business_title6">证件号码：</div>
					<div class="business_input12">
						<input id="chargeIdNumber" class="easyui-textbox" value='<s:property value="chargeIdNumber"/>'  style="width:100%;height:24px"  data-options="validType:['englishCheckSub','maxLength[60]']"/>
					</div>
				</div>
			</div>
		</div>
		<div id="clientChangeDiv" style="width:90%;">
			<div class="role_window">
				<div class="role_window_title14">客户附加信息变更内容</div>
				<div class="business_ss-dm">
					<div class="business_title2">存款人英文名称：</div>
					<div class="business_input8">
						<input id="accountEnName" class="easyui-textbox" style="width:100%;height:24px"  value='<s:property value="accountEnName"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">传真号码：</div>
					<div class="business_input8">
						<input id="faxCode" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="faxCode"/>' data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">企业类型：</div>
					<div class="business_input8">
						<%-- <select id="companyType" class="easyui-combobox" style="width:100%;" data-options="editable:false">
							<option value=""></option>
							<option value="A" <s:if test='companyType=="A"'>selected='selected'</s:if>>A:内资—国有企业</option>
							<option value="B" <s:if test='companyType=="B"'>selected='selected'</s:if>>B:内资—集体企业</option>
							<option value="C" <s:if test='companyType=="C"'>selected='selected'</s:if>>C:内资—股份合作企业</option>
							<option value="D" <s:if test='companyType=="D"'>selected='selected'</s:if>>D:内资—联营企业</option>
							<option value="E" <s:if test='companyType=="E"'>selected='selected'</s:if>>E:内资—国有独资有限责任公司</option>
							<option value="F" <s:if test='companyType=="F"'>selected='selected'</s:if>>F:内资—其他有限责任公司</option>
							<option value="G" <s:if test='companyType=="G"'>selected='selected'</s:if>>G:内资—股份有限公司</option>
							<option value="H" <s:if test='companyType=="H"'>selected='selected'</s:if>>H:内资—私营企业</option>
							<option value="I" <s:if test='companyType=="I"'>selected='selected'</s:if>>I:内资—其他企业</option>
							<option value="J" <s:if test='companyType=="J"'>selected='selected'</s:if>>J:港、澳、台商投资—合资经营企业</option>
							<option value="K" <s:if test='companyType=="K"'>selected='selected'</s:if>>K:港、澳、台商投资—合作经营企业</option>
							<option value="L" <s:if test='companyType=="L"'>selected='selected'</s:if>>L:港、澳、台商投资—独资经营企业 </option>
							<option value="M" <s:if test='companyType=="M"'>selected='selected'</s:if>>M:港、澳、台商投资—股份有限公司</option>
							<option value="N" <s:if test='companyType=="N"'>selected='selected'</s:if>>N:外商投资—中外合资经营企业</option>
							<option value="O" <s:if test='companyType=="O"'>selected='selected'</s:if>>O:外商投资—中外合作经营企业</option>
							<option value="P" <s:if test='companyType=="P"'>selected='selected'</s:if>>P:外商投资—外商独资企业</option>
							<option value="Q" <s:if test='companyType=="Q"'>selected='selected'</s:if>>Q:外商投资—股份有限公司</option>
							<option value="R" <s:if test='companyType=="R"'>selected='selected'</s:if>>R:其他类型客户</option>
						</select> --%>
						<select class="easyui-combobox" id="companyType" name="companyType"  value='<s:property value="companyType"/>' style="width:100%;height:24px" url='getTypeEnum.action?typeCode=COMPANY_TYPE' 
							data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  ></select>
					</div>
					<div class="business_title2">客户子类型：</div>
					<div class="business_input8">
						<%-- <select id="peopleSonType" class="easyui-combobox" name="peopleType" style="width:100%;" data-options="panelHeight:'auto',editable:false">
							<option value=""></option>
							<option value="201" <s:if test='peopleSonType=="201"'>selected='selected'</s:if>>企业法人</option>
							<option value="202" <s:if test='peopleSonType=="202"'>selected='selected'</s:if>>非法人企业</option>
							<option value="203" <s:if test='peopleSonType=="203"'>selected='selected'</s:if>>国家机关</option>
							<option value="204" <s:if test='peopleSonType=="204"'>selected='selected'</s:if>>实行预算管理的事业单位</option>
							<option value="205" <s:if test='peopleSonType=="205"'>selected='selected'</s:if>>非预算管理的事业单位</option>
							<option value="206" <s:if test='peopleSonType=="206"'>selected='selected'</s:if>>团级（含）以上军队、武警部队及分散执勤的支（分）队</option>
							<option value="207" <s:if test='peopleSonType=="207"'>selected='selected'</s:if>>社会团体</option>
							<option value="208" <s:if test='peopleSonType=="208"'>selected='selected'</s:if>>具有社会团体法人资格的工会组织</option>
							<option value="209" <s:if test='peopleSonType=="209"'>selected='selected'</s:if>>民办非企业组织</option>
							<option value="210" <s:if test='peopleSonType=="210"'>selected='selected'</s:if>>外地常设机构</option>
							<option value="211" <s:if test='peopleSonType=="211"'>selected='selected'</s:if>>外国驻华机构</option>
							<option value="212" <s:if test='peopleSonType=="212"'>selected='selected'</s:if>>有字号的个体工商户</option>
							<option value="213" <s:if test='peopleSonType=="213"'>selected='selected'</s:if>>无字号的个体工商户</option>
							<option value="214" <s:if test='peopleSonType=="214"'>selected='selected'</s:if>>居民委员会、村民委员会、社区委员会</option>
							<option value="215" <s:if test='peopleSonType=="215"'>selected='selected'</s:if>>单位设立的独立核算的附属机构</option>
							<option value="216" <s:if test='peopleSonType=="216"'>selected='selected'</s:if>>其他组织</option>
							<option value="217" <s:if test='peopleSonType=="217"'>selected='selected'</s:if>>使、领馆</option>
							<option value="218" <s:if test='peopleSonType=="218"'>selected='selected'</s:if>>宗教组织</option>
							<option value="219" <s:if test='peopleSonType=="219"'>selected='selected'</s:if>>国外企业</option>
							<option value="220" <s:if test='peopleSonType=="220"'>selected='selected'</s:if>>外国政府机构</option>
						</select> --%>
						<select class="easyui-combobox" id="peopleSonType" name="peopleSonType" style="width:100%;height:24px" url='getTypeEnum.action?typeCode=PROPOSER_TYPE' 
							data-options="editable:false,valueField:'typeValue', textField:'typeName'" value='<s:property value="peopleSonType"/>' ></select>
					</div>
					<div class="business_title2">行业代码：</div>
					<div class="business_input8">
						<input id="busiType" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="busiType"/>' data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">注册日期：</div>
					<div class="business_input8">
						<input id="registDate" class="easyui-datebox" style="width:100%;height:24px" value='<s:property value="registDate"/>' data-options="editable:false"/>
					</div>
					<div class="business_title2">电子邮件地址：</div>
					<div class="business_input8">
						<input id="email" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="email"/>' data-options="validType:'email'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<%-- <div class="business_title2">姓：</div>
					<div class="business_input19">
						<input id="clientMoneyManSurname" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="clientMoneyManSurname"/>' data-options="validType:'maxLength[25]'"/>
					</div> --%>
					<div class="business_title2">财务负责人姓名：</div>
					<div class="business_input19">
						<input id="clientMoneyManName" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="clientMoneyManName"/>' data-options="validType:'maxLength[25]'"/>
					</div>
					<div class="business_title6">证件名称：</div>
					<div class="business_input12">
						<%-- <input id="clientIdNameMoney" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="clientIdNameMoney"/>' data-options="validType:'maxLength[25]'"/> --%>
						<select class="easyui-combobox" id="clientIdNameMoney" name="clientIdNameMoney"  value='<s:property value="clientIdNameMoney"/>'style="width:100%;height:24px" url='getTypeEnum.action?typeCode=ID_TYPE' 
							data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  ></select>
					</div>
					<div class="business_title6">证件到期日：</div>
					<div class="business_input12">
						<input id="clientEndDateMoney" class="easyui-datebox"  style="width:100%;height:24px" value='<s:property value="clientEndDateMoney"/>' data-options="editable:false"/>
					</div>
					<div class="business_title6">证件号码：</div>
					<div class="business_input12">
						<input id="clientIdNoMoney" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="clientIdNoMoney"/>' data-options="validType:'maxLength[25]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">控股股东姓名：</div>
					<div class="business_input19">
						<input id="partnerPeople" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="partnerPeople"/>' data-options="validType:'maxLength[25]'"/>
					</div>
					<div class="business_title6">证件种类：</div>
					<div class="business_input12">
						<%-- <input id="idTypePartner" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="idTypePartner"/>' data-options="validType:'maxLength[25]'"/> --%>
						<select class="easyui-combobox" id="idTypePartner" name="idTypePartner"  value='<s:property value="idTypePartner"/>'style="width:100%;height:24px" url='getTypeEnum.action?typeCode=ID_TYPE' 
							data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  ></select>
					</div>
					<div class="business_title6">证件到期日：</div>
					<div class="business_input12">
						<input id="endDatePartner" class="easyui-datebox"  style="width:100%;height:24px" value='<s:property value="endDatePartner"/>' data-options="validType:'maxLength[60]',editable:false"/>
					</div>
					<div class="business_title6">证件号码：</div>
					<div class="business_input12">
						<input id="idNoPartner" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="idNoPartner"/>' data-options="validType:['englishCheckSub','maxLength[30]']"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">实际控制人姓名：</div>
					<div class="business_input19">
						<input id="controlPeople" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="controlPeople"/>' data-options="validType:'maxLength[25]'"/>
					</div>
					<div class="business_title6">证件种类：</div>
					<div class="business_input12">
						<%-- <input id="idTypeControl" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="idTypeControl"/>' data-options="validType:'maxLength[60]'"/> --%>
						<select class="easyui-combobox" id="idTypeControl" name="idTypeControl"  value='<s:property value="idTypeControl"/>'style="width:100%;height:24px" url='getTypeEnum.action?typeCode=ID_TYPE' 
							data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  ></select>
					</div>
					<div class="business_title6">证件到期日：</div>
					<div class="business_input12">
						<input id="endDateControl" class="easyui-datebox"  style="width:100%;height:24px" value='<s:property value="endDateControl"/>' data-options="editable:false"/>
					</div>
					<div class="business_title6">证件号码：</div>
					<div class="business_input12">
						<input id="idNoControl" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="idNoControl"/>' data-options="validType:['englishCheckSub','maxLength[60]']"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<%-- <div class="business_title2">姓：</div>
					<div class="business_input19">
						<input id="clientContactManSurname" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="clientContactManSurname"/>' data-options="validType:'maxLength[25]'"/>
					</div> --%>
					<div class="business_title2">联系人姓名：</div>
					<div class="business_input19">
						<input id="clientContactManName" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="clientContactManName"/>' data-options="validType:'maxLength[25]'"/>
					</div>
					<div class="business_title6">联系电话：</div>
					<div class="business_input8">
						<input id="clientTelContact" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="clientTelContact"/>' data-options="validType:'maxLength[25]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2" style="width:30%;">单位申请现金库存限额（3-4天零星备用金）：</div>
					<div class="business_input8">
						<input id="applyMoney" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="applyMoney"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					
					<div class="business_title2" style="width:20%;">银行批准库存限额（银行填写）：</div>
					<div class="business_input8">
						<input id="passMoney" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="passMoney"/>' data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
			</div>
		</div>
		<div id="relationDiv" style="width:100%;">
			<div class="role_window">
				<div class="role_window_title14">以下为关联企业、股东登记信息</div>
				<div class="business_title2">关联企业：</div>
				<div>
					<table id="glqiye_tb">
						<tr>
							<td>关联企业名称</td>
							<td>法定代表人</td>
							<td>组织机构代码</td>
							<td>是否为控股股东</td>
						</tr>
					</table>
					<div style="border:2px; border-color:#00CC00;  margin-left:20%;margin-top:20px">
						<input type="button"  value="增加" onclick="addtr('glqiye_tb',4)"/>
					</div>
				</div>
				<div class="business_title2">股东/出资人为自然人时：</div>
				<div>
					<table id="glgudong_tb">
						<tr>
							<td>股东姓名</td>
							<td>证件种类</td>
							<td>证件号码</td>
							<td>证件到期日</td>
							<td>是否为控股股东</td>
						</tr>
					</table>
					<div style="border:2px; border-color:#00CC00;  margin-left:20%;margin-top:20px">
						<input type="button"  value="增加" onclick="addClintTbtr('glgudong_tb')"/>
					</div>
				</div>
			</div>
		</div>
		</form>
		<div style="width:90%;height:100px;">
			<div class="role_window">
				<div class="role_window_button" style="margin-top:30px; padding: 10px auto;">
					<a href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
						style="padding:3px 0px;width:10%; margin-right:10px;" onclick="saveChangeBook(0)">
						<span style="font-size:14px;">保存</span>
					</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-print'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="printToBook('',0)">
						<span style="font-size:14px;">打印(业务授权书)</span>
					</a>
					<a id="printBtn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-print'"
						style="padding:3px 0px;width:18%; margin-right:10px;" onclick="printToBook('',1)">
						<span style="font-size:14px;">打印(无附加客户信息)</span>
					</a>
					<a id="printBtn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-print'"
						style="padding:3px 0px;width:18%; margin-right:10px;" onclick="printToBook('',2)">
						<span style="font-size:14px;">打印(含附加客户信息)</span>
					</a>
					<a id="printBtn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-print'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="printToBook('',3)">
						<span style="font-size:14px;">打印(关联企业、股东信息)</span>
					</a>
					<a id="printBtn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-print'"
						style="padding:3px 0px;width:16%; margin-right:10px;" onclick="printToBook('',8)">
						<span style="font-size:14px;">打印(外汇账户)</span>
					</a>
					<s:if test='#request.hstatus != "1"'>
					<a id="checkPassBtn" href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
						style="padding:3px 0px;width:10%; margin-right:10px;" onclick="saveChangeBook(1)">
						<span style="font-size:14px;">核对通过</span>
					</a>
					</s:if>
					<s:else>
					<a id="checkPassBtn" href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="saveChangeBook(0,1)">
						<span style="font-size:14px;">提交核对</span>
					</a>
					</s:else>
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
	<!-- 打印界面 -->
	<jsp:include page="printAccChange.jsp" />
</body>
</html>
