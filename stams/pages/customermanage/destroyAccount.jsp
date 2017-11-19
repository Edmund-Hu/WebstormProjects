<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="santai" uri="/tags/santai"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>撤销单位银行结算账户申请</title>
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
		var activeId = $("#activeId").textbox("getValue");
		if(activeId!=""){
			$("#closeAcc").window('close');
		}
		controlPrint();
		var isPrint = $("#isPrint").textbox("getValue");
		if(isPrint=="1"){
			$("#saveBtn").hide();
			$("div input").each(
			function(){
				try{
					$(this).textbox('readonly',true);
				}catch(e){
					$(this).attr("disabled",true);
				}
			});
			$("div select").each(
			function(){
				$(this).combobox('readonly',true);
			});
		}
		var blankProof = $("#blankProof").textbox("getValue");
		$("input[type='radio'][value='"+blankProof+"']").attr("checked",true);
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
	
	function init(){
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
				"data-options="+'"'+"valueField:'typeValue', textField:'typeName',editable:false,panelHeight:'auto'"+'" '+"value='"+people[1]+"' >"+
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
	
	function controlPrint(){
		var vActiveId = $("#activeId").textbox("getValue");
		if(vActiveId==""||vActiveId==null){
			$("#printBtn").hide();
		}else{
			$("#printBtn").show();
		}
	}
	
	function getCloseAccount(){
		var dataJson = {};
		var accountCode = $("#closeAcc #accountCode").val();
		var checkNumber = $("#closeAcc #checkNumber").val();
		if(accountCode==""&&checkNumber==""){
			alert("账号和开户许可证核准号不能都为空。");
			return;
		}
		dataJson["accountCode"]=accountCode;
		dataJson["checkNumber"]=checkNumber;
		loading.show();
		var ajax = new stAjax("getCloseAccount.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data){
			loading.hide();
			if (data.success){
				//有（否）未用重要空白凭证单选框
				$("input[type='radio'][value='"+(data.data)["blankProof"]+"']").attr("checked",true);
				
				$("#openBookDiv .role_window input[id],#closeDiv .role_window input[id]").each(
				function(){
					var name = $(this).attr('id');
					if((data.data)[name]!=null){
						$(this).textbox('setValue',(data.data)[name]);
					}
				});
				$("#openBookDiv .role_window select[id],#closeDiv .role_window select[id]").each(function() {
					var name = $(this).attr('id');
					if ((data.data)[name] != null) {
						$(this).combobox('select',(data.data)[name]);
					}
				});
				controlPrint();
				init();
				$('#closeAcc').window('close');
				return false;
			}
			//alert(data.msg ? data.msg : "操作失败！");
			alert("未查询到当前账户，可关闭查询窗口手动填写。");
			return false;
		});
		ajax.setErrorCallback(function() {
			loading.hide();
			alert("获取撤销账户信息失败！");
		});
		ajax.invoke();
	}
	
	function saveCloseAccount(status,tohome){
		if(!$("#openBookDiv").form('validate')){
			return;
		};
		
		var dataJson = {};
		dataJson["isPrint"] = status;
		/*var bookId = $("#bookId").textbox("getValue").trim();
		 if(bookId==""){
			alert("请查询出需要撤销的账户。");
			return;
		} */
		$("#openBookDiv .business_ss-dm input[id],#closeDiv .business_ss-dm input[id]").each(function() {
			var name = $(this).attr('id');
			var value = $(this).textbox("getValue").trim();
			dataJson[name] = value;
		});
		$("#openBookDiv .business_ss-dm select[id],#closeDiv .business_ss-dm select[id]").each(function() {
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
		
		var blankProof = $('input:radio:checked').val();
		dataJson["blankProof"] = blankProof;
		loading.show();
		var ajax = new stAjax("saveCloseAccount.action");
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
			alert("保存撤销信息失败！");
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
				alert("请先保存");
				return;
			}else{
				dataJson["activeId"]=activeId;
			}
			
			var ajax = new stAjax("printCloseAccount.action");
			ajax.setData(dataJson);
			ajax.setSuccessCallback(function(data) {
				if(data.success){			
					closeAccData = data.data;
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
	<div class="easyui-panel" title="撤销单位银行结算账户" iconCls="ico_281" style="width:100%;" data-options="fit:true">
		<div id="closeAcc" class="easyui-window" title="撤销单位银行结算账户-查询" data-options="minimizable: false,modal:true,iconCls:'ico_171'"
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
					style="padding:5px 0px;width:20%; margin-right:10px;" onclick="getCloseAccount()">
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
									A、办理单位银行结算账户撤销
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
			
			<div style="display:none">
				<input id="isPrint" class="easyui-textbox" value='<s:property value="isPrint"/>' />
			</div>
			<div class="role_window">
				<div class="business_ss-dm">
					<div class="business_input8" style="display:none">
						<input id="activeId" class="easyui-textbox" value='<s:property value="activeId"/>' />
						<input id="bookId" class="easyui-textbox" value='<s:property value="bookId"/>' />
						<input id="blankProof" class="easyui-textbox" value='<s:property value="blankProof"/>' />
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
						<input id="accountCode" value='<s:property value="accountCode"/>' class="easyui-textbox" style="width: 100%; height: 24px" data-options="validType:'maxLength[60]'" />
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">账户性质：</div>
					<div class="business_input8">
						<%-- <select id="accountType" class="easyui-combobox" name="accountType" style="width:100%;" data-options="panelHeight:'auto',readonly:true,editable:false">
							<option value=""></option>
							<option value="0" <s:if test="accountType==0">selected='selected'</s:if>>基本账户</option>
							<option value="1" <s:if test="accountType==1">selected='selected'</s:if>>一般账户</option>
							<option value="2" <s:if test="accountType==2">selected='selected'</s:if>>专用账户</option>
							<option value="3" <s:if test="accountType==3">selected='selected'</s:if>>临时账户</option>
						</select>  --%>
						<select id="accountType" class="easyui-combobox" name="accountType" style="width:100%;" data-options="<%-- required:true, --%>panelHeight:'auto',<%-- readonly:true, --%>editable:false,validType:'maxLength[60]'">
							<option value=""></option>
							<option value="0" <s:if test='accountType=="0"'>selected='selected'</s:if>>基本账户</option>
							<option value="1" <s:if test="accountType==1">selected='selected'</s:if>>一般账户</option>
							<option value="2" <s:if test="accountType==2">selected='selected'</s:if>>预算单位专用存款账户</option>
							<option value="3" <s:if test="accountType==3">selected='selected'</s:if>>特殊单位专用存款账户</option>
							<option value="4" <s:if test="accountType==4">selected='selected'</s:if>>非预算单位专用存款账户</option>
							<option value="5" <s:if test="accountType==5">selected='selected'</s:if>>临时机构临时存款账户</option>
							<option value="6" <s:if test="accountType==6">selected='selected'</s:if>>非临时机构临时存款账户</option>
						</select>
					</div>
					<div class="business_title2">开户许可证核准号：</div>
					<div class="business_input8">
						<input id="checkNumber" value='<s:property value="checkNumber"/>' class="easyui-textbox" value="" data-options="validType:'maxLength[60]'" style="width:100%;height: 24px" />
					</div>
				</div> 
		</div>
		<div id="closeDiv" style="width:100%;">
			<div class="role_window">
				<div class="business_ss-dm" style="height: 60px;">
					<div class="business_ss-dm">
						<div class="business_title2">撤销原因：</div>
						<div class="business_input10">
							<input id="closeReason" value='<s:property value="closeReason"/>' class="easyui-textbox" data-options="multiline:true,required:true" style="width:100%;height:50px" />
						</div>
					</div>
				</div>
				<div style="height: 80px;">
					<div class="business_title2">有(否)未用重要空白凭证：</div>
					<div class="business_input10">
						<label><input id="A1" name="blankProof" type="radio" value="1" />无</label> <br />
						<label><input id="A2" name="blankProof" type="radio" value="2" />有，相关凭证号码详见另附清单。</label> <br />
						<label><input id="A3" name="blankProof" type="radio" value="3" />有，相关凭证号码详见另附清单，但凭证实物已遗失（销毁），由此引起的一切经济纠纷及责任由我公司承担。 </label><br />
						<label><input id="A4" name="blankProof" type="radio" value="4" />有，但凭证实物已遗失（销毁），且无法提供相关凭证号码，由此引起的一切经济纠纷及责任由我公司承担。</label>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">账户余额：</div>
					<div class="business_input8">
						<input id="accountBalance" value='<s:property value="accountBalance"/>' class="easyui-textbox" style="width:100%;height:24px" data-options="validType:'maxLength[60]'" />
					</div>
					<div class="business_title2">利息：</div>
					<div class="business_input8">
						<input id="interest" value='<s:property value="interest"/>' class="easyui-textbox" style="width:100%;height:24px" data-options="validType:'maxLength[60]'" />
					</div>
					<div class="business_title2">账已对清，不存在未达账项：</div>
					<div class="business_input8">
						<select id="checked" class="easyui-combobox" name="checked" style="width:100%;" data-options="panelHeight:'auto',editable:false">
							<option value=""></option>
							<option value="1" <s:if test="checked==1">selected='selected'</s:if>>是</option>
							<option value="0" <s:if test="checked==0">selected='selected'</s:if>>否</option>
						</select> 
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">经办人：</div>
					<div class="business_input8">
						<input id="operator" value='<s:property value="operator"/>' class="easyui-textbox" style="width:100%;" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">本息汇入行：</div>
					<div class="business_input8">
						<input id="inputMoney" value='<s:property value="inputMoney"/>' class="easyui-textbox" style="width:100%;" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">汇入账号：</div>
					<div class="business_input8">
						<input id="inputAccount" value='<s:property value="inputAccount"/>' class="easyui-textbox" style="width:100%;" data-options="validType:['englishCheckSub','maxLength[60]']"/>
					</div>
				</div>
				<div class="business_title1">如法定代表人/单位位负流人亲往行行办理销户手续，无需填写以下内容</div><br />
				<div class="business_title2">被授权人信息：</div>
				<div class="business_ss-dm">
					<div class="business_title2">姓名：</div>
					<div class="business_input8">
						<input id="name" value='<s:property value="name"/>' class="easyui-textbox" style="width:100%;" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">证件种类：</div>
					<div class="business_input8">
						<%-- <input id="idType" value='<s:property value="idType"/>' class="easyui-textbox" style="width:100%;" data-options="validType:'maxLength[60]'"/> --%>
						<select class="easyui-combobox"  id="idType" name="idType"  value='<s:property value="idType"/>'style="width:100%;height:24px" url='getTypeEnum.action?typeCode=ID_TYPE' 
							data-options="editable:false,valueField:'typeValue', textField:'typeName',panelHeight:'auto',validType:'maxLength[60]'"  ></select>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">证件号码：</div>
					<div class="business_input8">
						<input id="idNo" value='<s:property value="idNo"/>' class="easyui-textbox" style="width:100%;" data-options="validType:['englishCheckSub','maxLength[60]']"/>
					</div>
					<div class="business_title2">证件到期日：</div>
					<div class="business_input8">
						<input id="idEndDate" value='<s:property value="idEndDate"/>' class="easyui-datebox" style="width:100%;" data-options="editable:false"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">联系电话：</div>
					<div class="business_input8">
						<input id="mobile" value='<s:property value="mobile"/>' class="easyui-textbox" style="width:100%;" data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
			</div>
		</div>
		<div style="width:100%;">
			<div class="role_window">
				<div class="role_window_button" style="margin-top:30px; padding: 10px auto;">
					<a id="saveBtn" href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
						style="padding:3px 0px;width:15%; margin-right:10px;" onclick="saveCloseAccount(0)">
						<span style="font-size:14px;">保存</span>
					</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-print'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="printToBook('',0)">
						<span style="font-size:14px;">打印(业务授权书)</span>
					</a>
					<a id="printBtn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-print'"
						style="padding:3px 0px;width:15%; margin-right:10px;" onclick="printToBook('',1)">
						<span style="font-size:14px;">打印(撤销账户申请)</span>
					</a>
					<a id="printBtn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-print'"
						style="padding:3px 0px;width:15%; margin-right:10px;" onclick="printToBook('',2)">
						<span style="font-size:14px;">打印(外汇账户)</span>
					</a>
					<s:if test='#request.hstatus != "1"'>
					<a id="checkPassBtn" href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
						style="padding:3px 0px;width:15%; margin-right:10px;" onclick="saveCloseAccount(1)">
						<span style="font-size:14px;">核对通过</span>
					</a>
					</s:if>
					<s:else>
					<a id="checkPassBtn" href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
						style="padding:3px 0px;width:15%; margin-right:10px;" onclick="saveCloseAccount(0,1)">
						<span style="font-size:14px;">提交核对</span>
					</a>
					</s:else>
				</div>
			</div>
		</div>
	</div>
	<!-- 打印界面 -->
	<jsp:include page="printCloseAcc.jsp" />
</body>
</html>
