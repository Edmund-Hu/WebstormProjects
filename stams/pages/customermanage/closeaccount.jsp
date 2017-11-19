<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="santai" uri="/tags/santai"%>
<%@ taglib prefix="santai_ams" uri="/tags/santai_ams"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>一般存款账户——撤销银行结算账户</title>
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
		<script type="text/javascript" src="js/santai.core.js"></script>
		<script type="text/javascript" src="js/common/common.js"></script>
    	
		<script language="javascript" type="text/javascript">
	loading.show();//显示loading动画

	$(document).ready(function() {
		loading.hide();//页面加载完成，关闭loading
	});
	
	function closeAccount(){
		var dateArr=["openDate","handlePeopleTime","handlePbcTime"];
		if(!$("#closeWin").form('validate')){
			return false;
		}
		var accountCode = $("#accountCode").textbox("getValue");
		var branchCode = $("#branchCode").textbox("getValue");
		var openBankName = $("#openBankName").textbox("getValue");
		var destReason = $("#destReason").combobox("getValue");
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
		
		var ajax = new stAjax("accountClose.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data) {
			if(data.success){
				$("#accMsgDiv .business_ss-dm input[id]").each(
						function() {
							var name = $(this).attr('id');
							if ((data.data)[name]!=null) {
								if($.inArray(name, dateArr)>=0){
									$(this).datebox('setValue',(data.data)[name]);
								}else{
									$(this).textbox('setValue',(data.data)[name]);
								}
							}
							$(this).textbox('readonly',true);
					});
					$("#accMsgDiv .business_ss-dm select[id]").each(
						function() {
							var name = $(this).attr('id');
							if ((data.data)[name] == null) {
								var val = $(this).combobox("getData");
									for ( var item in val[0]) {
										if (item == "ID") {
											$(this).combobox("select",val[0][item]);
										}
									}
							} else {
								$(this).combobox('setValue',(data.data)[name]);
							}
							$(this).combobox('readonly',true);
						});
			
			
				$("#accMsgDiv").window('open');
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
	
	function accountConfirm(){
		var destReason = $("#destReason").combobox("getValue");
		var accountCode = $("#accountCode").textbox("getValue");
		var ajax = new stAjax("accountCloseConfirm.action");
		ajax.setData({"destReason":destReason,"accountCode":accountCode});
		ajax.setSuccessCallback(function(data) {
			if(data.success){
				$('#accMsgDiv').window('close');
				alert("销户成功");
				$(".lin_system_button a[name='recordBtn']").hide();
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
	}
	
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
</script>
</head>

<body>
<form name="closeWin" id="closeWin" action="">
	<div class="easyui-panel" title="一般存款账户——撤销银行结算账户" iconCls="ico_280"
		style="width: 100%;">
		<div class="lin_system">
			<div class="lin_system_main">
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
					<div class="lin_system_left">销户原因：</div>
					<div class="role_window_input">
						<select id="destReason" class="easyui-combobox" name="destReason" style="width: 100%;height: 32px" data-options="required:true,panelHeight:'auto',editable:false">
							<option value=""></option>
							<option value="2">撤并</option>
							<option value="3">解散</option>
							<option value="4">宣告破产</option>
							<option value="5">关闭</option>
							<option value="6">被吊销营业执照或执业许可证</option>
							<option value="7">其它</option>
						</select>
					</div>
				</div>
				<div class="lin_system_button">
					<a href="#" class="easyui-linkbutton" name="recordBtn"
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
<div id="accMsgDiv"  class="easyui-window" title="撤销银行结算账户－>信息核对" data-options="modal:true,closed:true,iconCls:'ico_281'" style="width:80%;height:95%;">
	<div class="role_window">
				<div class="role_window_border">
					<div class="business_ss-dm">
						<div class="business_title2">存款人名称：</div>
						<div class="business_input9">
							<input id="accountName" class="easyui-textbox" style="width:100%;height:24px" />
						</div>
						<div class="business_title2">电话：</div>
						<div class="business_input12">
							<input id="mobileCode" class="easyui-textbox" style="width:100%;height:24px" />
						</div>
						<div class="business_title2">邮编：</div>
						<div class="business_input12">
							<input id="postCode" class="easyui-textbox" style="width:100%;height:24px" />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title">营业执照注册地址：</div>
						<div class="business_input9">
							<input id="registAddress" class="easyui-textbox"  style="width:100%;height:24px" />
						</div>
						<div class="business_title2">组织机构代码：</div>
						<div class="business_input12">
							<input id="orgInstitCd" class="easyui-textbox" style="width:100%;height:24px" />
						</div>
						<div class="business_title2">地区代码：</div>
						<div class="business_input12">
							<input id="areaCode" class="easyui-textbox" style="width:100%;height:24px" />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">存款人类别：</div>
						<div class="business_input8">
							<select id="peopleType" class="easyui-combobox" name="linkManType" style="width:100%;" data-options="panelHeight:'auto',editable:false">
								<option value="01">企业法人</option>
								<option value="02">非法人企业</option>
								<option value="03">机关</option>
								<option value="04">实行预算管理的事业单位</option>
								<option value="05">非预算管理的事业单位</option>
								<option value="06">团级（含）以上军队及分散执勤的支（分）队</option>
								<option value="07">团级（含）以上武警部队及分散执勤的支（分）队</option>
								<option value="08">社会团体</option>
								<option value="09">宗教组织</option>
								<option value="10">民办非企业组织</option>
								<option value="11">外地常设机构</option>
								<option value="12">外国驻华机构</option>
								<option value="13">有字号的个体工商户</option>
								<option value="14">无字号的个体工商户</option>
								<option value="15">居民委员会、村民委员会、社区委员会</option>
								<option value="16">单位设立的独立核算的附属机构</option>
								<option value="17">其他组织</option>
							</select>
						</div>
						<div class="business_title2">人员类别：</div>
						<div class="business_input8">
							<select id="linkManType" class="easyui-combobox" style="width:100%;" data-options="panelHeight:'auto',editable:false">
								<option value="1">法定代表人</option>
								<option value="2">单位负责人</option>
							</select>
						</div>
						<div class="business_title2">姓名：</div>
						<div class="business_input8">
							<input id="linkMan" class="easyui-textbox" style="width:100%;height:24px" />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">证件种类：</div>
						<div class="business_input8">
							<select id="idType" class="easyui-combobox" name="idType" style="width:100%;" data-options="panelHeight:'auto',editable:false">
								<option value="1">身份证</option>
								<option value="2">军官证</option>
								<option value="3">文职干部证</option>
								<option value="4">警官证</option>
								<option value="5">士兵证</option>
								<option value="6">护照</option>
								<option value="7">港、澳、台居民通行证</option>
								<option value="8">户口簿</option>
								<option value="9">其它合法身份证件</option>
							</select>
						</div>
						<div class="business_title2">证件号码：</div>
						<div class="business_input8">
							<input id="idNumber" class="easyui-textbox" style="width:100%;height:24px" />
						</div>
						<div class="business_title2">行业分类：</div>
						<div class="business_input8">
							<select id="accountCategory" class="easyui-combobox" style="width:100%;" data-options="required:true,editable:false">
								<option value="A" chanye="0">A:农、林、牧、渔业</option>
								<option value="B" chanye="1">B:采掘业</option>
								<option value="C" chanye="1">C:制造业</option>
								<option value="D" chanye="1">D:电力、燃气及水的生产和供应业</option>
								<option value="E" chanye="1">E:建筑业</option>
								<option value="F" chanye="2">F:交通运输、仓储和邮政业</option>
								<option value="G" chanye="2">G:信息传输、计算机服务和软件业</option>
								<option value="H" chanye="2">H:批发和零售业</option>
								<option value="I" chanye="2">I:住宿和餐饮业</option>
								<option value="J" chanye="2">J:金融业</option>
								<option value="K" chanye="2">K:房地产业</option>
								<option value="L" chanye="2">L:租赁和商务服务业</option>
								<option value="M" chanye="2">M:科学研究、技术服务业和地质勘察业</option>
								<option value="N" chanye="2">N:水利、环境和公共设施管理业</option>
								<option value="O" chanye="2">O:居民服务和其他服务业</option>
								<option value="P" chanye="2">P:教育</option>
								<option value="Q" chanye="2">Q:卫生、社会保障和社会福利业</option>
								<option value="R" chanye="2">R:文化、体育和娱乐业</option>
								<option value="S" chanye="2">S:公共管理和社会组织</option>
								<option value="T" chanye="2">T:国际组织</option>
							</select>
						</div>
					</div>
					<div class="business_ss-dm">
					<div class="business_title2">资金币种：</div>
						<div class="business_input8">
							<select id="registMoneyType" class="easyui-combobox" name="registMoneyType" style="width:100%;" data-options="panelHeight:'auto',editable:false">
								<option value="1">人民币</option>
								<option value="2">美元</option>
								<option value="3">港元</option>
								<option value="4">日元</option>
								<option value="5">欧元</option>
								<option value="A">英镑</option>
								<option value="B">加拿大元</option>
								<option value="C">澳大利亚元</option>
								<option value="D">韩元</option>
								<option value="E">新加坡元</option>
								<option value="F">其它货币折美元</option>
							</select>
						</div>
						<div class="business_title2">注册资金：</div>
						<div class="business_input8">
							<input id="registMoney" class="easyui-textbox" style="width:100%;height:24px" />
						</div>
						<div class="business_title2">未标明注册资金：</div>
						<div class="business_input8">
							<select id="nofundflag" class="easyui-combobox" style="width:100%;" data-options="panelHeight:'auto',editable:false">
								<option value="true">标明</option>
								<option value="false">未标明</option>
							</select>
						</div>
					</div>
					<div class="business_ss-dm" style="height: 60px;">
						<div class="business_title2">经营范围：</div>
						<div class="business_input10">
							<input id="busiScope" class="easyui-textbox" data-options="multiline:true" style="width:100%;height:50px" />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title">国税登记证号：</div>
						<div class="business_input9">
							<input id="countryTax" class="easyui-textbox" style="width:100%;height:24px" />
						</div>
						<div class="business_title">地税登记证号：</div>
						<div class="business_input9">
							<input id="areaTax" class="easyui-textbox" style="width:100%;height:24px" />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">证明文件类型：</div>
						<div class="business_input8">
							<select id="fileType" class="easyui-combobox" name="state" style="width:100%;" data-options="panelHeight:'auto',editable:false">
								<option value="01">营业执照</option>
								<option value="02">批文</option>
								<option value="03">登记证书</option>
								<option value="04">开户证明</option>
							</select>
						</div>
						<div class="business_title">证明文件编号：</div>
						<div class="business_input8">
							<input id="fileNumber" class="easyui-textbox" style="width:100%;height:24px" />
						</div>
						<div class="business_title2">有效期至：</div>
						<div class="business_input8">
							<input id="licenseEndDate" class="easyui-datebox" style="width:100%;" />
						</div>
					</div>
				</div>
				<div class="role_window_button">
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'ico_091'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="$('#accMsgDiv').window('close')">
						<span style="font-size:14px;">返回</span>
					</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'ico_090'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="accountConfirm()">
						<span style="font-size:14px;">确定</span>
					</a>
				</div>
			</div>
</div>
</body>
</html>
