<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="santai" uri="/tags/santai"%>
<%@ taglib prefix="santai_ams" uri="/tags/santai_ams"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>基本存款账户——撤销银行结算账户</title>
	<link rel="stylesheet" type="text/css" href="js/jquery/jquery-easyui/easyui.css" />
	<link rel="stylesheet" type="text/css" href="js/jquery/jquery-easyui/icon.css" />
	<link rel="stylesheet" type="text/css" href="css/main.css" />
	<style type="text/css">
		.lin_system {
			width: 50%;
		}
		
		.lin_system_main {
			padding-left:12%;
		}
	</style>
	<script type="text/javascript" src="js/jquery/jquery.js"></script>
	<script type="text/javascript" src="js/jquery/jquery-easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/jquery/jquery-easyui/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="js/jquery/jquery.form.js"></script>
	<script type="text/javascript" src="js/santai.core.js"></script>
	<script type="text/javascript" src="js/common/common.js"></script>
   	
	<script language="javascript" type="text/javascript">
	loading.show();//显示loading动画

	$(document).ready(function() {
		loading.hide();//页面加载完成，关闭loading
		btnControl($("#closeWin a[name='destroy']"),'close');
	});
	
	function closeAccount(){
		
		if(!$("#closeWin").form('validate')){
			return false;
		}
		var accountCode = $("#accountCode").textbox("getValue");
		var branchCode = $("#branchCode").textbox("getValue");
		var openBankName = $("#openBankName").textbox("getValue");
		var destReason = $("#destReason").combobox("getValue");
		var account_type_ = $("#account_type_").combobox("getValue");
		var lic_mode_ = $("#lic_mode_").combobox("getValue");
		var operator_code_ = $("#operator_code_").textbox("getValue");
		var memo_ = $("#memo_").textbox("getValue");
		if(!/^[0-9]+$/.test(accountCode)){
			alert("账号只能包括数字。");
			return false;
		}
		if(""==trim(destReason)){
			alert("销户原因不能为空");
			return false;
		}
		var dataJson = {};
		dataJson["accountCode"] = accountCode;
		dataJson["branchCode"] = branchCode;
		dataJson["openBankName"] = openBankName;
		dataJson["destReason"] = destReason;
		dataJson["account_type_"] = account_type_;
		dataJson["lic_mode_"] = lic_mode_;
		dataJson["operator_code_"] = operator_code_;
		dataJson["memo_"] = memo_;
		
		var ajax = new stAjax("accountBasicClose.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data) {
			if(data.success){
				alert(data.msg);
				btnControl($("#closeWin a[name='destroy']"),'close');
				return false;
			}
			alert(data.msg ? data.msg : "操作失败！");
			return false;
		});
		ajax.setErrorCallback(function() {
			loading.hide();
			alert("服务器处理出现异常，销户失败！");
		});

		ajax.invoke();
	};
	
	$.extend($.fn.validatebox.defaults.rules,
		{    //验证字母和数字
			englishCheckSub:{
			validator:function(value){
			return /^[a-zA-Z0-9]+$/.test(value);
			},
			message:"只能包括英文字母、数字."
			}
		}
	)
	
	function uploadWindow(){
		//先清空原来的控件
	  	$("#uploadForm .role_window div").remove();
	
	  	var bizCode = "9099";
	  	var ajax = new stAjax("preDestroy.action");
		ajax.setData({"biz_code":bizCode,"accountCode":$("#accountCode").textbox("getValue")});
		ajax.setSuccessCallback(function(data) {
			if(data.success){
				var dataV=data.data;
				$("#operator_code_").textbox("setValue",dataV.idNumber);
				//遍历list
				var list = dataV.other;
				var divText="";
				for ( var i = 0; i < list.length; i++) {
					var m=list[i];
					var tmp1="BIZ_FILE_ID_='"+m.biz_FILE_ID_+"' ";
					var tmp2="data-options=\"prompt:'"+m.biz_FILE_NAME+"'";
					if(m.must_==1){
						tmp2+=",required:'true'";
					}
					tmp2+="\" ";
					txt="<div class='business_ss-dm' style='width:80%;padding-left:5%'><div class='business_title1'>"+m.biz_FILE_NAME+"</div><input name='file' class='easyui-filebox' "+tmp1+tmp2+" style='width:300px' buttonText='选择文件'/></div>";
					divText+=txt;
				}
				$("#uploadDiv .role_window").append(divText);
				$.parser.parse($("#uploadDiv .role_window"));
	  			$("#uploadDiv").window('open');
				return false;
			}else{
				alert(data.msg ? data.msg : "操作失败！");
				return false;
			}
		});
		ajax.setErrorCallback(function() {
			loading.hide();
			alert("服务器处理出现异常！");
		});

		ajax.invoke();
	  }
	  
	  function upload(){
	 	var accountCode = $("#closeWin #accountCode").textbox("getValue");
	  	if(trim(accountCode)==""){
	  		alert("上传文件前请先录入账号");
	  	}
	  	$("#uploadForm input[name='licNo']").val(accountCode);
	  	
	  	var tmp="";
	  	$("#uploadForm .business_ss-dm input").each(function(){
	  		var v=$(this).attr("BIZ_FILE_ID_");
	  		if (v){
	  			//same as "营业执照.jpg":"6b2a1a43-d824-473f-a4a5-63edd4d7aee1";
	  			var p = $(this).textbox("getValue");//由于可能没有textbox属性，取值会报错
	  			if(p){
			  		tmp+=(v+"*");
	  			}
	  		}
	  	});
	  	$("#uploadForm input[name='tempArr']").val(tmp);
	  	
		$("#uploadForm").ajaxSubmit({
	         url:"uploadImg.action",  
	         type:"post",  
	         enctype:"multipart/form-data",  
	         contentType: "application/x-www-form-urlencoded; charset=utf-8",  
	         dataType:"json",
	         beforeSend:function(){
	         	loading.show();
	         },
	         success: function(data){
	         	if(data.success){
	         		fileUpload();
	         	}else{
			 alert("上传失败！"+data.msg);
	         	}
	         },  
	         error: function() {  
	         	loading.hide();
			    alert("服务器处理出现异常！");
	         }  
	     });
	  }
	  
	  function fileUpload(){
	 	var ajax = new stAjax("clientUpload.action");
		ajax.setData({"licNo":$("#accountCode").textbox("getValue")});
		ajax.setSuccessCallback(function(data) {
            loading.hide();
			if(data.success){
				alert(data.msg);
			  	$("#uploadDiv").window('close');
			  	btnControl($("#closeWin a[name='destroy']"),'show');
				return false;
			}else{
				alert(data.msg ? data.msg : "操作失败！");
				return false;
			}
		});
		ajax.setErrorCallback(function() {
			loading.hide();
			alert("服务器处理出现异常！");
		});

		ajax.invoke();
	  }
	  
	  function btnControl(obj,sts){
		if('close'==sts){
			obj.hide();
		}else{
			obj.show();
		}
	  }
</script>
</head>

<body>
<form name="closeWin" id="closeWin" action="">
	<div class="easyui-panel" title="基本存款账户——撤销银行结算账户" iconCls="ico_280"
		style="width: 100%;">
		<div class="lin_system">
			<div class="lin_system_main">
				<div class="lin_system_details">
					<div class="lin_system_left">通过账号撤销：</div>
					<div class="role_window_input">
						<select id="account_type_" class="easyui-combobox" name="account_type_" readonly="true" style="width: 100%;height: 32px" data-options="required:true,panelHeight:'auto',editable:false">
							<option value="0">账 号</option>
							<option value="1">开户许可证核准号</option>
						</select>
					</div>
				</div>
				<div class="lin_system_details">
					<div class="lin_system_left">账号：</div>
					<div class="role_window_input">
						<input class="easyui-textbox" id="accountCode" name="accountCode"
							data-options="prompt:'请输入账号',validType:['length[1, 17]'],missingMessage:'账号必须填写',required:true"
							style="width: 100%; height: 32px">
					</div>
				</div>
				<div class="lin_system_details">
					<div class="lin_system_left">银行机构代码：</div>
					<div class="role_window_input">
						<input class="easyui-textbox" id="branchCode" name="branchCode" disabled="disabled" value='<s:property value="other.branchCode"/>'
						style="width: 100%; height: 32px">
					</div>
				</div>
				<div class="lin_system_details">
					<div class="lin_system_left">银行机构名称：</div>
					<div class="role_window_input">
						<input class="easyui-textbox" id="openBankName" name="openBankName" disabled="disabled" value='<s:property value="other.name"/>'
						style="width: 100%; height: 32px">
					</div>
				</div>
				<div class="lin_system_details">
					<div class="lin_system_left">撤销原因：</div>
					<div class="role_window_input">
						<select id="destReason" class="easyui-combobox" name="destReason" style="width: 100%;height: 32px" data-options="required:true,panelHeight:'auto',editable:false">
							<option value="cffb95cd-a990-4149-9ca6-01507932a024">转户</option>
							<option value="7809d2e9-0b8a-4739-af51-91fffa450f77">撤并</option>
							<option value="861c442b-b65e-447a-bead-bedb5dbdf985">解散</option>
							<option value="ac29c20d-8b97-4974-87ef-0bec126510f6">宣告破产</option>
							<option value="0ab82341-1c0a-4484-89e2-e3c3ead5f688">关闭</option>
							<option value="bf17c886-ff37-4cda-8c6d-b735f5e2b69a">被吊销营业执照或执业许可证</option>
							<option value="ea025f9b-1fc6-4b7e-8896-e193493bdbb2">其它</option>
						</select>
					</div>
				</div>
				<div class="lin_system_details">
					<div class="lin_system_left">原开户许可证处理方法：</div>
					<div class="role_window_input">
						<select id="lic_mode_" class="easyui-combobox" name="lic_mode_" style="width: 100%;height: 32px" data-options="required:true,panelHeight:'auto',editable:false">
							<option value="6">收回存款人的许可证</option>
							<option value="11">存款人的许可证已遗失</option>
						</select>
					</div>
				</div>
				<div class="lin_system_details" style="height: 60px;">
					<div class="lin_system_left">备注：</div>
						<div class="role_window_input">
							<input class="easyui-textbox" id="memo_" name="memo_" data-optins="multiline:true" style="width: 100%; height: 50px">
					</div>
				</div>
				<div class="lin_system_button">
					<a href="#" class="easyui-linkbutton" name="upload"
						data-options="iconCls:'ico_207'"
						style="padding: 3px 0px; width: 30%;"
						onclick="uploadWindow()"> 
						<span style="font-size: 14px;">上传</span>
					</a>
					<a href="#" class="easyui-linkbutton" name="destroy"
						data-options="iconCls:'ico_207'"
						style="padding: 3px 0px; width: 30%;"
						onclick="closeAccount()"> 
						<span style="font-size: 14px;">销户备案</span>
					</a>
				</div>
			</div>
		</div>
	</div>
</form>
<div id="uploadDiv" class="easyui-window" title="附件上传" data-options="modal:true,closed:true,iconCls:'ico_281'"
			style="width:600px;height:300px;">
	<form id="uploadForm" method="post" enctype="multipart/form-data">
		<div class="role_window">
			<!-- <div class="business_ss-dm">
				<div class="business_title3"><input class="easyui-filebox" BIZ_FILE_ID_="6b2a1a43-d824-473f-a4a5-63edd4d7aee1" name="file"  style="width:300px" buttonText="选择文件"/></div>
			</div> -->
			<input type="hidden" name="licNo"/>
			<input type="hidden" name="tempArr"/>
		</div>
		<div class="role_window_button">
			<a href="javascript:void(0)" name="uploadBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
				style="padding:3px 0px;width:20%; margin-right:10px;" onclick="upload()">
				<span style="font-size:14px;">上传附件</span>
			</a>
			<a href="javascript:void(0)" name="uploadBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
				style="padding:3px 0px;width:20%; margin-right:10px;" onclick="$('uploadDiv').window('close')">
				<span style="font-size:14px;">取消</span>
			</a>
		</div>
	</form>
</div>
<input type="hidden" id="operator_code_" class="easyui-textbox" name="operator_code_" value="">
</body>
</html>
