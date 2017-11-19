<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="santai" uri="/tags/santai"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>补（换）发开户许可证申请</title>
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

	
	function getAccount(){
		var dataJson = {};
		var accountCode = $("#patchLicenceAcc #accountCode").val();
		var checkNumber = $("#patchLicenceAcc #checkNumber").val();
		if(accountCode==""&&checkNumber==""){
			alert("账号和开户许可证核准号不能都为空。");
			return;
		}
		dataJson["accountCode"]=accountCode;
		dataJson["checkNumber"]=checkNumber;
		loading.show();
		var ajax = new stAjax("getPatchLicence.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data){
			loading.hide();
			if (data.success){
				$("#applyBookDiv .role_window input[id]").each(
				function(){
					var name = $(this).attr('id');
					if((data.data)[name]!=null){
						$(this).textbox('setValue',(data.data)[name]);
					}
				});
				$("#applyBookDiv .role_window select[id]").each(function() {
					var name = $(this).attr('id');
					if ((data.data)[name] != null) {
						$(this).combobox('select',(data.data)[name]);
					}
				});
				$('#patchLicenceAcc').window('close');
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
	
	function savePatchLicence(status,tohome){
		var dataJson = {};
		dataJson["isPrint"] = status;
		var bookId = $("#applyBookDiv #accountCode").textbox("getValue").trim();
		/* if(bookId==""){
			alert("请查询出需要补（换）发开户许可证的账户。");
		} */
		$("#applyBookDiv .business_ss-dm input[id]")
			.each(function() {
			var name = $(this).attr('id');
			var value = $(this).textbox("getValue").trim();
			dataJson[name] = value;
		});  
		$("#applyBookDiv .business_ss-dm select[id]")
			.each(function() {
			var name = $(this).attr('id');
			var value = $(this).combobox("getValue").trim();
			dataJson[name] = value;
		}); 
		loading.show();
		var ajax = new stAjax("savePatchLicence.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data) {
			loading.hide();
			if (data.success) {
				$("#applyBookDiv #activeId").textbox('setValue',data.data.activeId);
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
			alert("保存申请信息失败！");
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
			var ajax = new stAjax("printPatchLicence.action");
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
	<div class="easyui-panel" title="补（换）发开户许可证账户" iconCls="ico_281" style="width:100%;" data-options="fit:true">
		<div id="patchLicenceAcc" class="easyui-window" title="补（换）发开户许可证账户查询" data-options="minimizable: false,modal:true,iconCls:'ico_171'"
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
					style="padding:5px 0px;width:20%; margin-right:10px;" onclick="getAccount()">
					<span style="font-size:14px;">下一步</span>
				</a>
			</div>
		</div>
		<div id="applyBookDiv" style="width:100%;">
			<div class="role_window">
				<div class="business_ss-dm">
					<div class="business_input8" style="display:none">
						<input id="activeId" class="easyui-textbox" value='<s:property value="activeId"/>' />
						<input id="bookId" class="easyui-textbox" value='<s:property value="bookId"/>' />
					</div>
					<div class="business_title2">账户名称：</div>
					<div class="business_input8">
						<input id="accountName" value='<s:property value="accountName"/>' class="easyui-textbox" style="width: 100%; height: 24px" data-options="validType:'maxLength[60]'" />
					</div>
					<div class="business_title2">开户银行名称：</div>
					<div class="business_input8">
						<input id="openBankName" value='<s:property value="openBankName"/>' class="easyui-textbox" style="width: 100%; height: 24px" data-options="validType:'maxLength[60]'" />
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">开户银行代码：</div>
					<div class="business_input8">
						<input id="openBankCode" value='<s:property value="openBankCode"/>' class="easyui-textbox" style="width: 100%; height: 24px" data-options="validType:'maxLength[60]'" />
					</div>
					<div class="business_title2">账号：</div>
					<div class="business_input8">
						<input id="accountCode" class="easyui-textbox" style="width:100%;height:24px" data-options="validType:'maxLength[20]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">账户性质：</div>
					<div class="business_input8">
						<select id="accountType" class="easyui-combobox" name="accountType" style="width:100%;" data-options="panelHeight:'auto',editable:false">
							<option value="0" <s:if test="accountType==0">selected='selected'</s:if>>基本账户</option>
							<option value="1" <s:if test="accountType==1">selected='selected'</s:if>>一般账户</option>
							<option value="2" <s:if test="accountType==2">selected='selected'</s:if>>预算单位专用存款账户</option>
							<option value="3" <s:if test="accountType==3">selected='selected'</s:if>>特殊单位专用存款账户</option>
							<option value="4" <s:if test="accountType==4">selected='selected'</s:if>>非预算单位专用存款账户</option>
							<option value="5" <s:if test="accountType==5">selected='selected'</s:if>>临时机构临时存款账户</option>
							<option value="6" <s:if test="accountType==6">selected='selected'</s:if>>非临时机构临时存款账户</option>
						</select> 
					</div>
					<div class="business_title2">原开户许可证核准号：</div>
					<div class="business_input8">
						<input id="checkNumber" class="easyui-textbox" value="" data-options="validType:'maxLength[20]'" style="height: 24px" />
					</div>
				</div> 
			</div>
			<div class="role_window">
				<div class="business_ss-dm" style="height: 60px;">
					<div class="business_ss-dm">
						<div class="business_title2">申请补（换）发原因：</div>
						<div class="business_input10">
							<input id="applyReason" class="easyui-textbox" data-options="multiline:true,validType:'maxLength[250]'" style="width:100%;height:50px" />
						</div>
					</div>
				</div>
			</div>
		</div>
		<div style="width:100%;">
			<div class="role_window">
				<div class="role_window_button" style="margin-top:30px; padding: 10px auto;">
					<a href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="savePatchLicence(0)">
						<span style="font-size:14px;">保存</span>
					</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-print'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="printToBook('',7)">
						<span style="font-size:14px;">打印</span>
					</a>
					<s:if test='#request.hstatus != "1"'>
					<a id="checkPassBtn" href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="savePatchLicence(1)">
						<span style="font-size:14px;">核对通过</span>
					</a>
					</s:if>
					<s:else>
					<a id="checkPassBtn" href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="savePatchLicence(0,1)">
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
