<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="santai" uri="/tags/santai"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>专用、临时存款账户变更申请书</title>
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
		controlPrint();
		$("#dedicatedDiv").hide();
		$("#shortDiv").hide();
		$("#accountType").combobox({
			onChange:function(){
				showDiv();
			}
		})
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
	
	function showDiv(){
		var vAccountType = $("#openBookDiv #accountType").combobox("getValue");
		if(vAccountType==2||vAccountType==3||vAccountType==4){
			$("#dedicatedDiv").show();
			$("#shortDiv").hide();
		}
		if(vAccountType==5||vAccountType==6){
			$("#dedicatedDiv").hide();
			$("#shortDiv").show();
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
		var ajax = new stAjax("getDedicatedShortChange.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data){
			loading.hide();
			if (data.success){
				var divName = "";
				if (data.data.accountType == "2"||data.data.accountType == "3"||data.data.accountType == "4") {
					divName = "dedicatedDiv";
				} 
				if (data.data.accountType == "5"||data.data.accountType == "6") {
					divName = "shortDiv";
				}
				$("#openBookDiv .role_window input[id],#" + divName + " .role_window input[id]").each(
				function() {
					var name = $(this).attr('id');
					if((data.data)[name]!=null){
						$(this).textbox('setValue',(data.data)[name]);
					}
				});
				$("#openBookDiv .role_window select[id],#" + divName + " .role_window select[id]").each(function() {
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
				showDiv();
				controlPrint();
				$('#changeBasicAcc').window('close');
				return false;
			}
			alert(data.msg ? data.msg : "操作失败！");
			//alert("未查询到当前账户，可关闭查询窗口手动填写。");
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
		
		if(!$("#dedicatedForm").form('validate')){
			return;
		};
		
		//地址
		var vAccountType = $("#openBookDiv #accountType").combobox("getValue");
		var divName = "";
		if (vAccountType == "2"||vAccountType == "3"||vAccountType == "4") {
			divName = "dedicatedDiv";
		} 
		if (vAccountType == "5"||vAccountType == "6") {
			divName = "shortDiv";
		}
		/* if(vAccountType==""){
			alert("请查询出需要变更的账户。");
			return;
		} */
		var flag= true;
		$("#" + divName + " .role_window input[id],#openBookDiv .role_window input[id]").each(function() {
			var name = $(this).attr('id');
			var value = $(this).textbox("getValue").trim();
			/* flag = validateForm(name, value); */
			if (!flag) {
				return false;
			}
			dataJson[name] = value;
		});
		$("#" + divName + " .role_window select[id],#openBookDiv .role_window select[id]").each(function() {
			var name = $(this).attr('id');
			var value = $(this).combobox("getValue").trim();
			/* flag = validateForm(name, value); */
			if (!flag) {
				return false;
			}
			dataJson[name] = value;
		});
		loading.show();
		var ajax = new stAjax("saveDedicatedShortChange.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data) {
			loading.hide();
			if (data.success) {
				$("#openBookDiv #activeId").textbox('setValue',data.data.activeId);
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
				alert("id为空，数据错误！！！");
				return;
			}else{
				dataJson["activeId"]=activeId;
			}
			var ajax = new stAjax("printDedicatedShortChange.action");
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
	<div class="easyui-panel" title="专用、临时存款账户变更账户" iconCls="ico_281" style="width:100%;" data-options="fit:true">
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
		<div id="openBookDiv" style="width:90%;height:150px;">
			<div class="role_window">
				<div class="business_ss-dm">
					<div class="business_input8" style="display:none">
						<input id="activeId" class="easyui-textbox" value='<s:property value="activeId"/>' />
						<input id="bookId" class="easyui-textbox" value='<s:property value="bookId"/>' />
						<input id="type" class="easyui-textbox" value='<s:property value="type"/>' />
					</div>
					<div class="business_title2">存款人名称：</div>
					<div class="business_input8">
						<input id="depositorName" value='<s:property value="depositorName"/>' class="easyui-textbox" style="width: 100%; height: 24px" data-options="validType:'maxLength[60]'" />
					</div>
					<div class="business_title2">账户名称：</div>
					<div class="business_input8">
						<input id="oldAccountName" value='<s:property value="oldAccountName"/>' class="easyui-textbox" style="width: 100%; height: 24px" data-options="validType:'maxLength[60]'" />
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">开户银行代码：</div>
					<div class="business_input8">
						<input id="openBankCode" value='<s:property value="openBankCode"/>' class="easyui-textbox" style="width: 100%; height: 24px" data-options="validType:'maxLength[60]'" />
					</div>
					<div class="business_title2">账号：</div>
					<div class="business_input8">
						<input id="accountCode" value='<s:property value="accountCode"/>' class="easyui-textbox" style="width: 100%; height: 24px" data-options="validType:'maxLength[60]'" />
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">账户性质：</div>
					<div class="business_input8">
						<select id="accountType" class="easyui-combobox" name="accountType" style="width:100%;" data-options="panelHeight:'auto',<%-- readonly:true, --%>editable:false">
							<option value=""></option>
							<option value="2" <s:if test="accountType==2">selected='selected'</s:if>>预算单位专用存款账户</option>
							<option value="3" <s:if test="accountType==3">selected='selected'</s:if>>特殊单位专用存款账户</option>
							<option value="4" <s:if test="accountType==4">selected='selected'</s:if>>非预算单位专用存款账户</option>
							<option value="5" <s:if test="accountType==5">selected='selected'</s:if>>临时机构临时存款账户</option>
							<option value="6" <s:if test="accountType==6">selected='selected'</s:if>>非临时机构临时存款账户</option>
						</select> 
					</div>
					<div class="business_title2">开户许可证核准号：</div>
					<div class="business_input8">
						<input id="checkNumber" value='<s:property value="checkNumber"/>' class="easyui-textbox" value="" data-options="validType:'maxLength[60]'" style="width:100%;height:24px" />
					</div>
				</div> 
			</div>
		</div>
		<form id='dedicatedForm'>
		<div id="dedicatedDiv" style="width:90%;height:230px;">
			<div class="role_window">
				<div class="role_window_title14">变更事项及变更后内容如下</div>
				<div class="business_ss-dm">
					<div class="business_title">内设机构（部门）名称：</div>
					<div class="business_input8">
						<input id="departName" style="width:100%;" class="easyui-textbox" value='<s:property value="departName"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">内设机构（部门）电话：</div>
					<div class="business_input8">
						<input id="departTel" style="width:100%;" class="easyui-textbox" value='<s:property value="departTel"/>' data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">内设机构（部门）地址：</div>
					<div class="business_input8">
						<input id="departAddress" style="width:100%;" class="easyui-textbox" value='<s:property value="departAddress"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">内设机构（部门）邮编：</div>
					<div class="business_input8">
						<input id="departPostCode" style="width:100%;" class="easyui-textbox" value='<s:property value="departPostCode"/>' data-options="validType:['number','maxLength[60]']"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">内设机构（部门）负责人姓名：</div>
					<div class="business_input8">
						<input id="principleName" style="width:100%;" class="easyui-textbox" value='<s:property value="principleName"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">证件到期日：</div>
					<div class="business_input8">
						<input id="idEndDate" style="width:100%;" class="easyui-datebox" value='<s:property value="idEndDate"/>' data-options="editable:false" />
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">证件种类：</div>
					<div class="business_input8">
						<%-- <input id="idType" style="width:100%;" class="easyui-textbox" value='<s:property value="idType"/>' /> --%>
						<%-- <select id="idType" class="easyui-combobox" name="idType" style="width:100%;" data-options="panelHeight:'auto',editable:false">
							<option value=""></option>
							<option value="居民身份证" <s:if test="idType=='居民身份证'">selected='selected'</s:if>>居民身份证</option>
							<option value="临时身份证" <s:if test="idType=='临时身份证'">selected='selected'</s:if>>临时身份证</option>
							<option value="护照" <s:if test="idType=='护照'">selected='selected'</s:if>>护照</option>
							<option value="户口簿" <s:if test="idType=='户口簿'">selected='selected'</s:if>>户口簿</option>
							<option value="军人身份证件" <s:if test="idType=='军人身份证件'">selected='selected'</s:if>>军人身份证件</option>
							<option value="武装警察身份证件" <s:if test="idType=='武装警察身份证件'">selected='selected'</s:if>>武装警察身份证件</option>
							<option value="港澳居民往来内地通行证" <s:if test="idType=='港澳居民往来内地通行证'">selected='selected'</s:if>>港澳居民往来内地通行证</option>
							<option value="外交人员身份证" <s:if test="idType=='外交人员身份证'">selected='selected'</s:if>>外交人员身份证</option>
							<option value="外国人居留许可证" <s:if test="idType=='外国人居留许可证'">selected='selected'</s:if>>外国人居留许可证</option>
							<option value="边民出入境通行证" <s:if test="idType=='边民出入境通行证'">selected='selected'</s:if>>边民出入境通行证</option>
							<option value="其他" <s:if test="idType=='其他'">selected='selected'</s:if>>其他</option>
						</select> --%>
						<select class="easyui-combobox"  id="idType" name="accountCategory"  value='<s:property value="idType"/>'style="width:100%;height:24px" url='getTypeEnum.action?typeCode=ID_TYPE' 
							data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  ></select>
					</div>
					<div class="business_title2">证件号码：</div>
					<div class="business_input8">
						<input id="idNo" style="width:100%;" class="easyui-textbox" value='<s:property value="idNo"/>' data-options="validType:['englishCheckSub','maxLength[60]']"/>
					</div>
				</div>
			</div>
		</div>
		<div id="shortDiv" style="width:90%;height:230px;">
			<div class="role_window">
				<div class="role_window_title14">变更事项及变更后内容如下</div>
				<div class="business_ss-dm">
					<div class="business_title">项目部名称：</div>
					<div class="business_input8">
						<input id="departName" style="width:100%;" class="easyui-textbox" value='<s:property value="departName"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">项目部电话：</div>
					<div class="business_input8">
						<input id="departTel" style="width:100%;" class="easyui-textbox" value='<s:property value="departTel"/>' data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">项目部地址：</div>
					<div class="business_input8">
						<input id="departAddress" style="width:100%;" class="easyui-textbox" value='<s:property value="departAddress"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">项目部邮编：</div>
					<div class="business_input8">
						<input id="departPostCode" style="width:100%;" class="easyui-textbox" value='<s:property value="departPostCode"/>' data-options="validType:['number','maxLength[60]']"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">项目部负责人姓名：</div>
					<div class="business_input8">
						<input id="principleName" style="width:100%;" class="easyui-textbox" value='<s:property value="principleName"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">证件到期日：</div>
					<div class="business_input8">
						<input id="idEndDate" style="width:100%;" class="easyui-datebox" value='<s:property value="idEndDate"/>' data-options="editable:false" />
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">证件种类：</div>
					<div class="business_input8">
						<%-- <select id="idType" class="easyui-combobox" name="idType" style="width:100%;" data-options="panelHeight:'auto',editable:false">
							<option value=""></option>
							<option value="居民身份证" <s:if test="idType=='居民身份证'">selected='selected'</s:if>>居民身份证</option>
							<option value="临时身份证" <s:if test="idType=='临时身份证'">selected='selected'</s:if>>临时身份证</option>
							<option value="护照" <s:if test="idType=='护照'">selected='selected'</s:if>>护照</option>
							<option value="户口簿" <s:if test="idType=='户口簿'">selected='selected'</s:if>>户口簿</option>
							<option value="军人身份证件" <s:if test="idType=='军人身份证件'">selected='selected'</s:if>>军人身份证件</option>
							<option value="武装警察身份证件" <s:if test="idType=='武装警察身份证件'">selected='selected'</s:if>>武装警察身份证件</option>
							<option value="港澳居民往来内地通行证" <s:if test="idType=='港澳居民往来内地通行证'">selected='selected'</s:if>>港澳居民往来内地通行证</option>
							<option value="外交人员身份证" <s:if test="idType=='外交人员身份证'">selected='selected'</s:if>>外交人员身份证</option>
							<option value="外国人居留许可证" <s:if test="idType=='外国人居留许可证'">selected='selected'</s:if>>外国人居留许可证</option>
							<option value="边民出入境通行证" <s:if test="idType=='边民出入境通行证'">selected='selected'</s:if>>边民出入境通行证</option>
							<option value="其他" <s:if test="idType=='其他'">selected='selected'</s:if>>其他</option>
						</select> --%>
						<select class="easyui-combobox"  id="idType" name="accountCategory"  value='<s:property value="idType"/>'style="width:100%;height:24px" url='getTypeEnum.action?typeCode=ID_TYPE' 
							data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  ></select>
					</div>
					<div class="business_title2">证件号码：</div>
					<div class="business_input8">
						<input id="idNo" style="width:100%;" class="easyui-textbox" value='<s:property value="idNo"/>' data-options="validType:['englishCheckSub','maxLength[60]']"/>
					</div>
				</div>
			</div>
		</div>
		</form>
		<div style="width:90%;height:100px;">
			<div class="role_window">
				<div class="role_window_button" style="margin-top:30px; padding: 10px auto;">
					<a href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="saveChangeBook(0)">
						<span style="font-size:14px;">保存</span>
					</a>
					<a id="printBtn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-print'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="printToBook('',4)">
						<span style="font-size:14px;">打印</span>
					</a>
					<s:if test='#request.hstatus != "1"'>
					<a id="checkPassBtn" href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="saveChangeBook(1)">
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
