<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="santai" uri="/tags/santai"%>
<%@ taglib prefix="santai_ams" uri="/tags/santai_ams"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>武汉空头支票管理系统——收款行录入</title>
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
		loading.hide();
		outBnkShow();
	});
	
	//打开银行信息窗口
	function outBnkShow(){
		$("input",$("#prcaInDiv #outBnkNum").next("span")).click(function(){
			$("#bnkInfoDiv #bnkName").focus();
			$("#bnkInfoDiv #branchName").empty();
			var ajax = new stAjax("getBranch.action");
			ajax.setSuccessCallback(function(data) {
				if (data.success) {
					var vData = data.data;
					if(vData){
						if(vData.branchName){
							$("#bnkInfoForm #branchName").append(vData.branchName);
							$.parser.parse($("#bnkInfoForm #branchName"));
						}
						if(vData.bnk){
							$("#bnkInfoForm #bnk").val(vData.bnk);
						}
						if(vData.reBnk){
							$("#bnkInfoForm #reBnk").val(vData.reBnk);
						}
					}
					return false;
				}
				alert(data.msg ? data.msg : "操作失败！");
				return false;
			});
			ajax.setErrorCallback(function() {
				loading.hide();
				alert("获取银行信息失败！");
			});
	
			ajax.invoke();
			$("#bnkInfoDiv").window('open');
		})
	}
	
	function bnkInfoQuery(){
		$("#factTable td").parent().remove();
		var dataJson={};
		dataJson["bnkName"]=$("#bnkInfoForm #bnkName").textbox("getValue");
		dataJson["branchName"]=$("#bnkInfoForm #branchName").val();
		dataJson["bnk"]=$("#bnkInfoForm #bnk").val();
		dataJson["reBnk"]=$("#bnkInfoForm #reBnk").val();
		var ajax = new stAjax("queryBnkInfo.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data) {
			if (data.success) {
				var vData = data.data;
				if(vData){
					var html="";
					for(var i=0;i<vData.length;i++){
						var txt="<tr>";
						var outBnkName = vData[i]["outBankName"];
						var outBnkExchangeNum = vData[i]["outBnkExchangeNum"];
						var outBnkNum = vData[i]["outBnkNum"];
						var select="<a href=\"JavaScript:choice('"+outBnkName+"','"+outBnkExchangeNum+"','"+outBnkNum+"')\">选择</a>";
						txt+="<td>"+outBnkName+"</td><td>"+outBnkExchangeNum+"</td><td>"+outBnkNum+"</td><td>"+select+"</td>";
						txt+="</tr>";
						html+=txt;
					}
					$("#factTable").append(html);
				}
				return false;
			}
			alert(data.msg ? data.msg : "操作失败！");
			return false;
		});
		ajax.setErrorCallback(function() {
			loading.hide();
			alert("获取银行信息失败！");
		});
		ajax.invoke(); 
	}
	
	function choice(name,code,exchangeNum){
		$("#prcaInDiv #outBnkNum").textbox("setValue",code);
		$("#bnkInfoDiv").window("close");
	}
	
	function record(){
		var dataJson={};
		$("#prcaInDiv input[id]").each(function(){
			var name = $(this).attr('id');
				var value = $(this).textbox("getValue");
				/* flag = validateForm(name,value);
				if(!flag){
					return false;
				} */
				dataJson[name] = value;
		});
		var ajax = new stAjax("inBnkSubmitEmpty.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data) {
			if (data.success) {
				alert(data.msg);
				return false;
			}
			alert(data.msg ? data.msg : "操作失败！");
			return false;
		});
		ajax.setErrorCallback(function() {
			loading.hide();
			alert("备案失败！");
		});
		ajax.invoke(); 
	}
	
	function bnkInfoDivReset(){
		$("#bnkInfoForm #bnkName").textbox("setValue","");
		$("#bnkInfoForm #branchName").val();
	}
	
	function reset(){
		$("body input[id]").each(function(){
			$(this).textbox("setValue","");
		});
	}
</script>
</head>

<body>
<form name="closeWin" id="closeWin" action="">
	<div id="prcaInDiv" class="easyui-panel" title="武汉空头支票管理系统——收款行录入" iconCls="ico_280"
		style="width: 100%;">
		<div class="lin_system2" style="margin-top: 15px;">
			<div class="lin_system_main3">
            <div class="role_window" style="width:100%;border-right:1px solid #ddd;border-bottom:1px solid #ddd;" >
				<div class="role_window_title14" style="font-weight:bold">支票信息</div>
                <div class="role_window" style="width:50%; float:left;" >
				<div class="lin_system_details">
					<div class="lin_system_left">支票号码：</div>
					<div class="role_window_input">
						<input class="easyui-textbox" id="checkerNum" name="checkerNum"
							data-options="required:true" style="width: 100%; height: 32px">
					</div>
				</div>
				<div class="lin_system_details">
					<div class="lin_system_left">出票金额：</div>
					<div class="role_window_input">
						<input class="easyui-textbox" id="chkAmount" name="chkAmount"
							data-options="required:true" style="width: 100%; height: 32px">
					</div>
				</div>
				<div class="lin_system_details">
					<div class="lin_system_left">出票日期：</div>
					<div class="role_window_input">
						<input id="chkDate" class="easyui-datebox" style="width:100%;height: 32px" data-options="required:true"/>
					</div>
				</div>
				<div class="lin_system_details">
					<div class="lin_system_left">退票日期：</div>
					<div class="role_window_input">
						<input id="chkRtnDate" class="easyui-datebox" style="width:100%;height: 32px" data-options="required:true"/>
					</div>
				</div>
                </div>
                <div class="role_window" style="width:50%; float:left;" >
				<div class="lin_system_details">
					<div class="lin_system_left">付款行行号：</div>
					<div class="role_window_input">
						<input class="easyui-textbox" id="outBnkNum" name="outBnkNum" data-options="required:true" style="width: 100%; height: 32px">
					</div>
				</div>
				<div class="lin_system_details">
					<div class="lin_system_left">出票人账号：</div>
					<div class="role_window_input">
						<input class="easyui-textbox" id="checkerOwnerAccount" name="checkerOwnerAccount" data-options="required:true" style="width: 100%; height: 32px">
					</div>
				</div>
				<div class="lin_system_details"">
					<div class="lin_system_left">出票人名称：</div>
						<div class="role_window_input">
							<input class="easyui-textbox" id="organName" name="organName" data-options="required:true" style="width: 100%; height: 32px">
					</div>
				</div>
				<div class="lin_system_details">
					<div class="lin_system_left">收款人名称：</div>
						<div class="role_window_input">
							<input class="easyui-textbox" id="checkHolderName" name="checkHolderName" data-options="required:true" style="width: 100%; height: 32px">
					</div>
				</div>
                </div>
                </div>
                <div class="role_window"  style=" width:100%; border-bottom:1px solid #ddd;" >
				<div class="role_window_title14" style="font-weight:bold">举报行信息</div>
				<div class="lin_system_details">
					<div class="lin_system_left" style="width:12%" >举报行代码：</div>
						<div class="role_window_input" style="width:83%">
							<input class="easyui-textbox" id="reportBnkNum" name="reportBnkNum" value='<s:property value="reportBnkNum"/>'" data-options="required:true" style="width: 100%; height: 32px">
					</div>
				</div>
				<div class="lin_system_details">
					<div class="lin_system_left" style="width:12%">联系人：</div>
						<div class="role_window_input" style="width:83%">
							<input class="easyui-textbox" id="reportBnkContactor" name="reportBnkContactor" value='<s:property value="reportBnkContactor"/>'" data-options="required:true" style="width: 100%; height: 32px">
					</div>
				</div>
				<div class="lin_system_details">
					<div class="lin_system_left" style="width:12%">联系电话：</div>
						<div class="role_window_input" style="width:83%">
							<input class="easyui-textbox" id="reportBnkContactTel" name="reportBnkContactTel" value='<s:property value="reportBnkContactTel"/>'"  data-options="required:true" style="width: 100%; height: 32px">
					</div>
				</div>
                </div>
				<div class="lin_system_button">
					<a href="#" class="easyui-linkbutton" name="upload"
						data-options="iconCls:'ico_287'"
						style="padding: 3px 0px; width: 30%;"
						onclick="record()"> 
						<span style="font-size: 14px;">确定</span>
					</a>
					<a href="#" class="easyui-linkbutton" name="destroy"
						data-options="iconCls:'ico_101'"
						style="padding: 3px 0px; width: 30%;"
						onclick="reset()"> 
						<span style="font-size: 14px;">重置</span>
					</a>
				</div>
			</div>
		</div>
	</div>
</form>
<div id="bnkInfoDiv" class="easyui-window" title="银行信息查询" data-options="modal:true,closed:true,iconCls:'ico_281'"
			style="width:500px;height:300px;">
	<form id="bnkInfoForm" method="post" enctype="multipart/form-data">
		<div class="role_window1">
			<div class="business_ss-dm1">
				<div class="business_title4">银行名称：</div>
				<div class="business_input10">
					<input id="bnkName" class="easyui-textbox" style="width:100%;" />
				</div>
			</div>
			<div class="business_ss-dm1">
				<div class="business_title4">所属银行：</div>
				<div class="business_input10">
					<select id="branchName" name="branchName" style="width:100%;">
						
					</select>
				</div>
			</div>
			<div class="role_list" style="width:100%;">
				<table cellpadding="1" cellspacing="1" id='factTable' border="1">
					<tr>
						<th width="30%">银行名称</th>
						<th width="25%">同城清算号</th>
						<th width="25%">银行机构代码</th>
						<th width="20%">选择</th>
					</tr>
				</table>
			</div>
			<input type="hidden" id="bnk" name="bnk" value="">
			<input type="hidden" id="reBnk" name="reBnk" value="">
		</div>
		<div class="role_window_button">
			<a href="javascript:void(0)" name="uploadBtn" class="easyui-linkbutton" data-options="iconCls:'ico_197'"
				style="padding:3px 0px;width:20%; margin-right:10px;" onclick="bnkInfoQuery()">
				<span style="font-size:14px;">查询</span>
			</a>
			<a href="javascript:void(0)" name="uploadBtn" class="easyui-linkbutton" data-options="iconCls:'ico_101'"
				style="padding:3px 0px;width:20%; margin-right:10px;" onclick="bnkInfoDivReset()">
				<span style="font-size:14px;">重置</span>
			</a>
		</div>
	</form>
</div>
</body>
</html>
