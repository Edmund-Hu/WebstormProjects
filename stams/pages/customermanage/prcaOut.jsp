<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="santai" uri="/tags/santai"%>
<%@ taglib prefix="santai_ams" uri="/tags/santai_ams"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>武汉空头支票管理系统——付款行录入</title>
<link rel="stylesheet" type="text/css" href="js/jquery/jquery-easyui/easyui.css" />
<link rel="stylesheet" type="text/css" href="js/jquery/jquery-easyui/icon.css" />
<link rel="stylesheet" type="text/css" href="css/main.css" />
<script type="text/javascript" src="js/jquery/jquery.js"></script>
<script type="text/javascript" src="js/jquery/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/jquery/jquery-easyui/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/santai.core.js"></script>
<script type="text/javascript" src="js/common/common.js"></script>

<script language="javascript" type="text/javascript">
	$(function() {
		initValue();
		registerNoBlur();
		
		$("#checkInfoDiv #outBankName").textbox("textbox").bind("click", function() {  
           $('#bnkInfoDiv').window('open');
        });
        
        $("input",$("#bnkInfo #inBnkExchangeNum").next("span")).blur(function(){
           bnkInfoQuery();
        });
	})
	
	//页面载入初始化举报信息
	function initValue(){
		var ajax = new stAjax("preOutBnkInput.action");
		ajax.setSuccessCallback(function(data) {
			if (data.success) {
				var vData = data.data;
				if(vData){
					$("#checkInfoDiv #outBankName").textbox("setValue",vData['outBankName']);
					$("#reportDiv .business_ss-dm input[id],#outBnkDiv .business_ss-dm input[id]").each(
						function() {
							var name = $(this).attr('id');
							if (vData[name]!=null) {
								$(this).textbox("setValue",vData[name]);
							}
					});
				}
				return false;
			}
			alert(data.msg ? data.msg : "操作失败！");
			return false;
		});
		ajax.setErrorCallback(function() {
			loading.hide();
			alert("服务器处理出现异常！");
		});
		ajax.invoke();
	}
	
	//注册或登记号触发后自动返显
	function registerNoBlur(){
		$("input",$("#outPersonDiv #orgRegisterNo").next("span")).blur(function(){
			loading.show();
			var dataJson={};
			dataJson["orgRegisterNo"]=$("#outPersonDiv #orgRegisterNo").textbox("getValue");
			var ajax = new stAjax("getChequeholder.action");
			ajax.setData(dataJson);
			ajax.setSuccessCallback(function(data) {
				loading.hide();
				if (data.success) {
					var vData = data.data;
					if(vData){
						$("#outPersonDiv .business_ss-dm input[id]").each(
							function() {
								var name = $(this).attr('id');
								if (vData[name]!=null) {
									if(name=="registerMoney"){
										$(this).textbox("setValue",transMoney((data.data)[name]));
									}else{
										$(this).textbox("setValue",vData[name]);
									}
								}
						});
						$("#outPersonDiv .business_ss-dm select[id]").each(
							function() {
								var name = $(this).attr('id');
								if (vData[name]!=null) {
									$(this).combobox("setValue",vData[name]);
								}
						});
					}
					return false;
				}
				alert(data.msg ? data.msg : "操作失败！");
				return false;
			});
			ajax.setErrorCallback(function() {
				loading.hide();
				alert("服务器处理出现异常！");
			});
			ajax.invoke();
		})
	}
	
	//获取收款行同城结算信息
	function bnkInfoQuery(){
		var dataJson = {};
		dataJson["inBnkExchangeNum"]=$("#bnkInfo #inBnkExchangeNum").textbox('getValue');
		var ajax = new stAjax("bnkInfoQuery.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data) {
			if (data.success) {
				var vData = data.data;
				if(vData){
					$("#bnkInfo .business_ss-dm input[id]").each(
						function() {
							var name = $(this).attr('id');
							if (vData[name]!=null) {
								$(this).textbox("setValue",vData[name]);
							}
					});
				}
				return false;
			}
			alert(data.msg ? data.msg : "操作失败！");
			return false;
		});
		ajax.setErrorCallback(function() {
			loading.hide();
			alert("服务器处理出现异常！");
		});
		ajax.invoke();
	}
	
	function record(){
		var dataJson = {};
		$("body .business_ss-dm input[id]").each(
			function() {
				var name = $(this).attr('id');
				var value = $(this).textbox("getValue");
				/* flag = validateForm(name,value);
				if(!flag){
					return false;
				} */
				dataJson[name] = value;
		});
		$("body .business_ss-dm select[id]").each(
			function() {
				var name = $(this).attr('id');
				var value = $(this).combobox("getValue");
				/* flag = validateForm(name,value);
				if(!flag){
					return false;
				} */
				dataJson[name] = value;
		});
		var ajax = new stAjax("report.action");
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
			alert("服务器处理出现异常！");
		});
		ajax.invoke();
	}
	
	function reset(){
		$("body .business_ss-dm input[id]").each(
			function() {
				$(this).textbox("setValue","");
		});
		$("body .business_ss-dm select[id]").each(
			function() {
				$(this).combobox("setValue","");
		});
	}
	
	function bnkInfoDivReset(){
		$("#bnkInfoForm .business_ss-dm input[id]").each(
			function() {
				$(this).textbox("setValue","");
		});
	}
	
	function queryOutBnk(){
		$("#factTable td").parent().remove();
		
		var dataJson = {};
		$("#bnkInfoDiv .business_ss-dm1 input[id]").each(
			function() {
				var name = $(this).attr('id');
				var value = $(this).textbox("getValue");
				dataJson[name] = value;
		});
		var ajax = new stAjax("queryOutBnk.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data) {
			if (data.success) {
				var vData = data.data;
				if(vData){
					var html="";
					for(var i=0;i<vData.length;i++){
						var txt="<tr>";
						var inBnkName = vData[i]["inBnkName"];
						var inBnkExchangeNum = vData[i]["inBnkExchangeNum"];
						var inBnkNum = vData[i]["inBnkNum"];
						var select="<a href=\"JavaScript:choice('"+inBnkName+"','"+inBnkExchangeNum+"','"+inBnkNum+"')\">选择</a>";
						txt+="<td>"+inBnkName+"</td><td>"+inBnkExchangeNum+"</td><td>"+inBnkNum+"</td><td>"+select+"</td>";
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
			alert("服务器处理出现异常！");
		});
		ajax.invoke();
	}
	
	function choice(name,code,exchangeNum){
		$("#outBankName").textbox("setValue",name);
		$("#bnkInfoDiv").window("close");
	}
</script>

</head>

<body>
	<div class="easyui-panel" title="武汉空头支票管理系统——付款行录入" iconCls="ico_281"
		style="width:100%;" data-options="fit:false">
		<div id="outPersonDiv"
			style="margin:0px;width:49%;height:250px; float:left; border-right:1px solid #ddd; border-bottom:1px solid #ddd;">
			<div class="role_window">
				<div class="role_window_title14">出票人信息</div>
				<div class="business_ss-dm">
					<div class="business_title4">注册或登记号：</div>
					<div class="business_input11">
						<input class="easyui-textbox" id="orgRegisterNo" name="orgRegisterNo" style="width:100%;height:24px" data-options="required:true"/>
					</div>
					<div class="business_title2">出票人名：</div>
					<div class="business_input11">
						<input class="easyui-textbox" id="organName" name="organName" style="width:99%;height:24px" data-options="required:true"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title4">地址：</div>
					<div class="business_input10">
						<input class="easyui-textbox" id="address" name="address" style="width:88%;height:24px" data-options="required:true"/>
					</div>

				</div>
				<div class="business_ss-dm">
					<div class="business_title4">负责人类型：</div>
					<div class="business_input11">
						<select id="principalType" name="principalType" class="easyui-combobox" style="width:100%;" data-options="panelHeight:'auto',editable:false,required:true">
							<option></option>
							<option>投资人</option>
							<option>法定代表人</option>
							<option>负责人</option>
							<option>经营者</option>
							<option>执行合伙人企业事务的合伙人</option>
						</select>
					</div>
					<div class="business_title2">姓名：</div>
					<div class="business_input11">
						<input id="principalName" name="principalName" class="easyui-textbox" style="width:99%;height:24px" data-options="required:true"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title4">注册资本：</div>
					<div class="business_input11">
						<input id="registerMoney" name="registerMoney" class="easyui-textbox" style="width:100%;height:24px" data-options="required:true"/>
					</div>
					<div class="business_title2">公司类型：</div>
					<div class="business_input11">
						<select id="ownerType" name="ownerType" class="easyui-combobox" style="width:100%;" data-options="panelHeight:'auto',editable:false,required:true">
							<option></option>
							<option>企业法人</option>
							<option>军队、武警部队</option>
							<option>社会团体</option>
							<option>民办非企业组织</option>
							<option>异地常设机构</option>
							<option>外国驻华机构</option>
							<option>居委会、村委会等</option>
							<option>独立核算附属机构</option>
							<option>非法人企业</option>
							<option>机关事业单位</option>
							<option>个体工商户</option>
							<option>其他组织</option>
						</select>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title4">经营范围：</div>
					<div class="business_input10">
						<input id="bussContents" name="bussContents" class="easyui-textbox" data-options="multiline:true,required:true" style="width:88%;height:50px" />
					</div>
				</div>
			</div>
		</div>
		<div id="checkInfoDiv" style="margin:0px;width:48%;height:250px; float:left;  border-bottom:1px solid #ddd;">
			<div class="role_window">
				<div class="role_window_title14">支票信息</div>
				<div class="business_ss-dm">
					<div class="business_title4">出票人账号：</div>
					<div class="business_input11">
						<input class="easyui-textbox" id="checkerOwnerAccount" name="checkerOwnerAccount" style="width:100%;height:24px" data-options="required:true"/>
					</div>
					<div class="business_title">支票号码：</div>
					<div class="business_input11">
						<input class="easyui-textbox" id="checkerNum" name="checkerNum" style="width:100%;height:24px" data-options="required:true"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title4">出票日期：</div>
					<div class="business_input11">
						<input class="easyui-datebox" id="chkDate" name="chkDate" style="width:100%;" data-options="required:true"/>
					</div>
					<div class="business_title">付款行名：</div>
					<div class="business_input11">
						<input class="easyui-textbox" id="outBankName" name="outBankName" style="width:100%;height:24px" data-options="required:true"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title4">收款人名称：</div>
					<div class="business_input11">
						<input class="easyui-textbox" id="checkHolderName" name="checkHolderName" style="width:100%;height:24px" data-options="required:true"/>
					</div>
					<div class="business_title">支票金额：</div>
					<div class="business_input11">
						<input class="easyui-textbox" id="chkAmount" name="chkAmount" style="width:100%;height:24px" data-options="required:true"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title4">退票日期：</div>
					<div class="business_input11">
						<input id="chkRtnDate" name="chkRtnDate" class="easyui-datebox" style="width:100%;" data-options="required:true"/>
					</div>
					<div class="business_title">违规类型：</div>
					<div class="business_input11">
						<select id="emptyChkType" class="easyui-combobox" name="emptyChkType" style="width:100%;" data-options="panelHeight:'auto',editable:false,required:true">
							<option></option>
							<option value="102">签发空头支票</option>
							<option value="106">签发与其预留印章不符支票</option>
						</select>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title4">时点余额：</div>
					<div class="business_input11">
						<input id="leftAccount" name="leftAccount" class="easyui-textbox" style="width:100%;height:24px" data-options="prompt:'0.00',required:true"/>
					</div>
				</div>
			</div>
		</div>
		<div id="bnkInfo" style="width:100%; height:100px;">
			<div class="role_window">
				<div class="role_window_title14">持票人开户银行信息</div>
				<div class="business_ss-dm">
					<div class="business_title2">收款行同城清算行号：</div>
					<div class="business_input12">
						<input class="easyui-textbox" id="inBnkExchangeNum" name="inBnkExchangeNum" data-options="required:true"/>
					</div>
					<div class="business_title">收款行代码：</div>
					<div class="business_input12">
						<input class="easyui-textbox" id="inBnkNum" name="inBnkNum" data-options="required:true"/>
					</div>
					<div class="business_title">收款行名称：</div>
					<div class="business_input12">
						<input id="inBnkName" name="inBnkName" class="easyui-textbox" data-options="required:true"/>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="reportDiv" style="width:50%;height:150px; float:left; border-right:1px solid #ddd; border-top:1px solid #ddd;border-bottom:1px solid #ddd;">
		<div class="role_window">
			<div class="role_window_title14">举报行信息</div>
			<div class="business_ss-dm">
				<div class="business_title4">同城清算行号：</div>
				<div class="business_input11">
					<input id="reportBnkExchangeNum" name="reportBnkExchangeNum" class="easyui-textbox" style="width:100%;height:24px" disabled="disabled"/>
				</div>
				<div class="business_title2">举报行代码：</div>
				<div class="business_input11">
					<input id="reportBnkNum" name="reportBnkNum" class="easyui-textbox" style="width:100%;height:24px" disabled="disabled"/>
				</div>
			</div>
			<div class="business_ss-dm">
				<div class="business_title4">联系人：</div>
				<div class="business_input11">
					<input id="reportBnkContactor" name="reportBnkContactor"  class="easyui-textbox" style="width:100%;height:24px" data-options="required:true"/>
				</div>
				<div class="business_title2">联系电话：</div>
				<div class="business_input11">
					<input id="reportBnkContactTel" name="reportBnkContactTel" class="easyui-textbox" style="width:100%;height:24px" data-options="required:true"/>
				</div>
			</div>
		</div>
	</div>
	<div id="outBnkDiv" style="width:48%;height:150px;float:left; border-top:1px solid #ddd;border-bottom:1px solid #ddd;">
		<div class="role_window">
			<div class="role_window_title14">出票人开户银行（付款行）信息</div>
			<div class="business_ss-dm">
				<div class="business_title4">同城清算行号：</div>
				<div class="business_input11">
					<input id="outBnkExchangeNum" name="outBnkExchangeNum" class="easyui-textbox" style="width:100%;height:24px" disabled="disabled"/>
				</div>
				<div class="business_title2">付款行代码：</div>
				<div class="business_input11">
					<input id="outBnkNum" name="outBnkNum" class="easyui-textbox" style="width:100%;height:24px" disabled="disabled"/>
				</div>
			</div>
			<div class="business_ss-dm">
				<div class="business_title4">联系人：</div>
				<div class="business_input11">
					<input id="outBnkContactor" name="outBnkContactor" class="easyui-textbox" style="width:100%;height:24px" data-options="required:true"/>
				</div>
				<div class="business_title2">联系电话：</div>
				<div class="business_input11">
					<input id="outBnkContactTel" name="outBnkContactTel" class="easyui-textbox" style="width:100%;height:24px" data-options="required:true"/>
				</div>
			</div>
		</div>

	</div>
	<div class="role_window_button">
		<blockquote>
			<p>
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'ico_287'" style="padding:5px 0px;width:20%; margin-right:10px;" onclick="record()">
					<span style="font-size:14px;">确定</span> </a>
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'ico_101'" style="padding:5px 0px;width:20%;" onclick="reset()">
					<span style="font-size:14px;">重置</span> </a>
			</p>
		</blockquote>
	</div>

	<div id="bnkInfoDiv" class="easyui-window" title="银行信息查询" data-options="modal:true,closed:true,iconCls:'ico_281'" style="width:500px;height:300px;">
		<form id="bnkInfoForm" method="post" enctype="multipart/form-data">
			<div class="role_window1">
				<div class="business_ss-dm1">
					<div class="business_title4">银行名称：</div>
					<div class="business_input10">
						<input id="inBnkName" name="inBnkName" class="easyui-textbox" style="width:100%;" />
					</div>
				</div>
				<div class="business_ss-dm1">
					<div class="business_title4">同城清算行号：</div>
					<div class="business_input10">
						<input id="inBnkExchangeNum" name="inBnkExchangeNum" class="easyui-textbox" style="width:100%;" />
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
			</div>
			<div class="role_window_button1">
				<a href="javascript:void(0)"  class="easyui-linkbutton" data-options="iconCls:'ico_197'"
					style="padding:3px 0px;width:20%; margin-right:10px;"
					onClick="queryOutBnk()"> <span style="font-size:14px;">查询</span>
				</a> <a href="javascript:void(0)"  class="easyui-linkbutton" data-options="iconCls:'ico_101'"
					style="padding:3px 0px;width:20%; margin-right:10px;"
					onClick="bnkInfoDivReset()"> <span style="font-size:14px;">重置</span>
				</a>
			</div>
		</form>
	</div>
</body>
</html>
