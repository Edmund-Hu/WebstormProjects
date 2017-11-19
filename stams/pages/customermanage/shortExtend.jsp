<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="santai" uri="/tags/santai"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>临时存款账户展期申请</title>
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
	
	function getShortExtend(){
		var dataJson = {};
		var accountCode = $("#shortExtendAcc #accountCode").val();
		var checkNumber = $("#shortExtendAcc #checkNumber").val();
		if(accountCode==""&&checkNumber==""){
			alert("账号和开户许可证核准号不能都为空。");
			return;
		}
		dataJson["accountCode"]=accountCode;
		dataJson["checkNumber"]=checkNumber;
		loading.show();
		var ajax = new stAjax("getShortExtend.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data){
			loading.hide();
			if (data.success){
				$("#openBookDiv .role_window input[id],#extendDiv .role_window input[id]").each(
				function(){
					var name = $(this).attr('id');
					if((data.data)[name]!=null){
						$(this).textbox('setValue',(data.data)[name]);
					}
				});
				$("#openBookDiv .role_window select[id],#extendDiv .role_window select[id]").each(function() {
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
				controlPrint();
				$('#shortExtendAcc').window('close');
				return false;
			}
			alert(data.msg ? data.msg : "操作失败！");
			//alert("未查询到当前账户，可关闭查询窗口手动填写。");
			return false;
		});
		ajax.setErrorCallback(function() {
			loading.hide();
			alert("获取展期账户信息失败！");
		});
		ajax.invoke();
	}
	
	function saveShortExtend(status,tohome){
		if(!$("#extendForm").form('validate')){
			return;
		};
		
		var dataJson = {};
		dataJson["isPrint"] = status;
		var bookId = $("#bookId").textbox("getValue").trim();
		/* if(bookId==""){
			alert("请查询出需要展期的账户。");
		} */
		var flag= true;
		$("#openBookDiv .role_window input[id],#extendDiv .role_window input[id]").each(function() {
			var name = $(this).attr('id');
			var value = $(this).textbox("getValue").trim();
			/* flag = validateForm(name, value); */
			if (!flag) {
				return false;
			}
			dataJson[name] = value;
		});
		$("#openBookDiv .role_window select[id],#extendDiv .role_window select[id]").each(function() {
			var name = $(this).attr('id');
			var value = $(this).combobox("getValue").trim();
			/* flag = validateForm(name, value); */
			if (!flag) {
				return false;
			}
			dataJson[name] = value;
		});
		
		if(dataJson["fileTypeExtend"].length>60){
			alert("展期证明文件种类输入不能超过60个字符.");
			return;
		}
		loading.show();
		var ajax = new stAjax("saveShortExtend.action");
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
			alert("保存展期信息失败！");
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
			
			var ajax = new stAjax("printShortExtend.action");
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
	<div class="easyui-panel" title="临时存款账户-展期账户" iconCls="ico_281" style="width:100%;" data-options="fit:true">
		<div id="shortExtendAcc" class="easyui-window" title="变更单位银行结算账户" data-options="minimizable: false,modal:true,iconCls:'ico_171'"
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
					style="padding:5px 0px;width:20%; margin-right:10px;" onclick="getShortExtend()">
					<span style="font-size:14px;">下一步</span>
				</a>
			</div>
		</div>
		<form id="extendForm">
		<div id="openBookDiv" style="width:100%;">
			<div class="role_window">
				<div class="business_ss-dm">
					<div class="business_input8" style="display:none">
						<input id="activeId" class="easyui-textbox" value='<s:property value="activeId"/>' />
						<input id="bookId" class="easyui-textbox" value='<s:property value="bookId"/>' />
					</div>
					<div class="business_title2">存款人名称：</div>
					<div class="business_input8">
						<input id="depositorName" value='<s:property value="depositorName"/>' class="easyui-textbox" style="width: 100%; height: 24px" data-options="validType:'maxLength[60]'" />
					</div>
					<div class="business_title2">地址：</div>
					<div class="business_input9">
						<input id="registAddress" class="easyui-textbox"  style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">邮编：</div>
					<div class="business_input8">
						<input id="postCode" class="easyui-textbox" style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">电话：</div>
					<div class="business_input8">
						<input id="mobileCode" class="easyui-textbox" style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">账号：</div>
					<div class="business_input8">
						<input id="accountCode" class="easyui-textbox" style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">开户核准号：</div>
					<div class="business_input8">
						<input id="checkNumber" class="easyui-textbox" data-options="validType:'maxLength[60]'" style="width:100%;height:24px" />
					</div>
				</div> 
				<div class="business_ss-dm">
					<div class="business_title2">开户日期：</div>
					<div class="business_input8">
						<input id="openDate" class="easyui-datebox" value="<s:date name="openDate" format="yyyy-MM-dd"/>" style="width:100%;height:24px" data-options="validType:'maxLength[60]',editable:false" />
					</div>
					<div class="business_title2">账户有效期至：</div>
					<div class="business_input8">
						<input id="accountEndDate" class="easyui-datebox" value="<s:date name="accountEndDate" format="yyyy-MM-dd"/>" style="width:100%;height:24px" data-options="validType:'maxLength[60]',editable:false" />
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">开户证明文件种类：</div>
					<div class="business_input8">
						<%-- <input id="fileType" class="easyui-textbox" value='<s:property value="fileType"/>'  style="width:100%;height:24px" data-options="editable:false" /> --%>
						<select class="easyui-combobox" id="fileType" name="fileType" style="width:100%;height:24px" url='getTypeEnum.action?typeCode=FILE_TYPE' 
							data-options="editable:false,valueField:'typeValue', textField:'typeName'" value='<s:property value="fileType"/>' ></select>
					</div>
					<div class="business_title2">开户证明文件有效期至：</div>
					<div class="business_input8">
						<input id="fileEndDate" class="easyui-datebox" value='<s:property value="fileEndDate"/>' style="width:100%;" data-options="editable:false"/>
					</div>
				</div>
			</div>
		</div>
		<div id="extendDiv" style="width:100%;height:230px;">
			<div class="role_window">
				<div class="role_window_title14">以下为展期内容：</div>
				<div class="business_ss-dm" style="height: 60px;">
					<div class="business_ss-dm">
						<div class="business_title2">展期原因：</div>
						<div class="business_input10">
							<input id="extendReason" class="easyui-textbox" data-options="multiline:true,validType:'maxLength[300]',required:true" style="width:100%;height:50px" />
						</div>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">申请展期有效期至：</div>
					<div class="business_input8">
						<input id="extendEndDate" class="easyui-datebox" style="width:100%;height:24px" data-options="editable:false" />
					</div>
					<div class="business_title2">批准展期有效期至：</div>
					<div class="business_input8">
						<input id="passExtendEndDate" class="easyui-datebox" style="width:100%;" data-options="editable:false"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">展期证明文件种类：</div>
					<div class="business_input8">
						<!-- <input id="fileTypeExtend" class="easyui-textbox" style="width:100%;height:24px" data-options="validType:'maxLength[60]'" /> -->
						<select class="easyui-combobox" id="fileTypeExtend" name="fileTypeExtend" style="width:100%;height:24px" url='getTypeEnum.action?typeCode=FILE_TYPE' 
							data-options="editable:false,valueField:'typeValue', textField:'typeName'" value='<s:property value="fileTypeExtend"/>' ></select>
					</div>
					<div class="business_title2">展期证明文件有效期至：</div>
					<div class="business_input8">
						<input id="fileEndDateExtend" class="easyui-datebox" style="width:100%;" data-options="editable:false"/>
					</div>
				</div>
			</div>
		</div>
		</form>
		<div style="width:90%;height:100px;">
			<div class="role_window">
				<div class="role_window_button" style="margin-top:30px; padding: 10px auto;">
					<a href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="saveShortExtend(0)">
						<span style="font-size:14px;">保存</span>
					</a>
					<a id="printBtn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-print'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="printToBook('',6)">
						<span style="font-size:14px;">打印</span>
					</a>
					<s:if test='#request.hstatus != "1"'>
					<a id="checkPassBtn" href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="saveShortExtend(1)">
						<span style="font-size:14px;">核对通过</span>
					</a>
					</s:if>
					<s:else>
					<a id="checkPassBtn" href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="saveShortExtend(0,1)">
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
