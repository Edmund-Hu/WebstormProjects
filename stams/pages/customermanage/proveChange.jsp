<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="santai" uri="/tags/santai"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>预留印鉴变更申请</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="js/jquery/jquery-easyui/easyui.css" />
<link rel="stylesheet" type="text/css" href="js/jquery/jquery-easyui/icon.css" />
<link rel="stylesheet" type="text/css" href="css/main.css" />
<object  id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0> 
       <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
</object>
<script type="text/javascript" src="js/jquery/jquery.js"></script>
<script type="text/javascript" src="js/jquery/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/jquery/jquery-easyui/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/santai.core.js"></script>
<script type="text/javascript" src="js/common/common.js"></script>
<script type="text/javascript" src="js/common/LodopFuncs.js"></script>
<script type="text/javascript">

	$(function(){
		
	})
	
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
		
		//变更事项
		var vChoses = $("#changeTypes").textbox("getValue");
		if(vChoses!=""&&vChoses!=null){
			var choses = vChoses.split(",");
			for(var i=0; i<choses.length; i++){
				$("#choseDiv input:checkbox[value='"+choses[i]+"']").attr("checked", true);
			};
		}
	}
	
	function getAccInfo(){
		var dataJson = {};
		var accountCode = $("#accInfo #accountCode").val();
		//var checkNumber = $("#accInfo #checkNumber").val();
		if(accountCode==""){
			alert("账号不能为空。");
			return;
		}
		dataJson["accountCode"]=accountCode;
		//dataJson["checkNumber"]=checkNumber;
		loading.show();
		var ajax = new stAjax("getProveChange.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data){
			loading.hide();
			if (data.success){
				$("#proveChangeDiv .role_window input[id]").each(function() {
					var name = $(this).attr('id');
					if((data.data)[name]!=null){
						$(this).textbox('setValue',(data.data)[name]);
					}
				});
				$("#proveChangeDiv .role_window select[id]").each(function() {
					var name = $(this).attr('id');
					if((data.data)[name]!=null){
						$(this).combobox('setValue',(data.data)[name]);
					}
				});
				init();
				$('#accInfo').window('close');
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
	
	function saveProveChange(status,tohome){
		
		if(!$("#proveChangeDiv").form('validate')){
			return;
		};
		var dataJson = {};
		dataJson["isPrint"] = status;
		$("#proveChangeDiv .business_ss-dm input[id]")
			.each(function(){
			var name = $(this).attr('id');
			var value = $(this).textbox("getValue").trim();
			dataJson[name] = value;
		});
		$("#proveChangeDiv .business_ss-dm select[id]")
			.each(function() {
			var name = $(this).attr('id');
			var value = $(this).combo("getValue").trim();
			dataJson[name] = value; 
		});
		
		//变更内容选择
		var chose = "";
		$('#choseDiv input:checkbox:checked').each(function(){
			chose += ($(this).val()+",");
		});
		var changeTypes = chose.substring(0,chose.length-1);
		dataJson["changeTypes"] = changeTypes;
		
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
		var ajax = new stAjax("saveProveChange.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data) {
			loading.hide();
			if (data.success) {
				$("#activeId").textbox('setValue', data.data.activeId);
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
			alert("保存账户预留印鉴变更申请失败！");
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
				alert("打印前请先保存");
				return;
			}else{
				dataJson["activeId"]=activeId;
			}
			var ajax = new stAjax("printProveChange.action");
			ajax.setData(dataJson);
			ajax.setSuccessCallback(function(data) {
				if(data.success){
					accChangeData = data.data;
					prn_print(pageNum);
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
	<div class="easyui-panel" title="预留印鉴变更申请书" iconCls="ico_281" style="width:100%;" data-options="fit:true">
		<div id="accInfo" class="easyui-window" title="变更单位银行结算账户" data-options="minimizable: false,modal:true,iconCls:'ico_171'"
			style="width:500px;padding:10px;">
			<div class="business_ss-dm">
				<div class="business_title" style="width:35%">账号：</div>
				<div class="business_input2">
					<input id="accountCode" class="easyui-textbox" style="width:100%;height:24px" />
				</div>
			</div>
			<!-- <div class="business_ss-dm">
				<div class="business_ss-dm">
					<div class="business_title" style="width:35%">开户许可证核准号：</div>
					<div class="business_input2">
						<input id="checkNumber" class="easyui-textbox" style="width:100%;height:24px" />
					</div>
				</div>
			</div> -->
			<div class="role_window_button">
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'ico_090'"
					style="padding:5px 0px;width:20%; margin-right:10px;" onclick="getAccInfo()">
					<span style="font-size:14px;">下一步</span>
				</a>
			</div>
		</div>
		<div id="proveChangeDiv" style="width:100%;">
			<div id="authorizeDiv" style="width:100%">
			<div class="role_window">
				<div class="business_ss-dm">
					<div style="display:none">
						<input id="activeId" class="easyui-textbox" value='<s:property value="activeId"/>' />
						<input id="bookId" class="easyui-textbox" value='<s:property value="bookId"/>' />
						<input id="authorizePeople" class="easyui-textbox" value='<s:property value="authorizePeople"/>'/>
						<input id="authorizeContent" class="easyui-textbox" value='<s:property value="authorizeContent"/>'/>
						<input id="changeTypes" class="easyui-textbox" value='<s:property value="changeTypes"/>'/>
					</div>
					<div class="business_title2">单位全称：</div>
					<div class="business_input8">
						<input id="companyName" class="easyui-textbox" style="width:100%;height:24px" data-options="required:true,validType:'maxLength[60]'" value='<s:property value="companyName"/>'/>
					</div>
					<div class="business_title2">账号：</div>
					<div class="business_input8">
						<input id="accountCode" class="easyui-textbox" value='<s:property value="accountCode"/>' style="width:100%;height:24px" data-options="validType:['number','maxLength[17]']"/>
					</div>
					<div class="business_title2">法定代表人(负责人)：</div>
					<div class="business_input8">
						<input id="linkMan" class="easyui-textbox" value='<s:property value="linkMan"/>'  style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
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
				<div id="choseDiv" style="height: 150px;">
					<div class="business_title2">现因变更：</div><br />
					<label style="float: left;width: 100%;padding-left: 10%;padding-top: 10px;"><input  type="checkbox" value="1" />单位公章/财务专用章</label><br />
					<label style="float: left;width: 100%;padding-left: 10%;padding-top: 10px;"><input  type="checkbox" value="2" />法定代表人或单位负责人</label>
					<div class="business_ss-dm">
						<div class="business_title6">取消：</div>
						<div class="business_input12">
							<input id="beforeManName" class="easyui-textbox" style="width:100%;height:24px" data-options="validType:'maxLength[60]'" value='<s:property value="beforeManName"/>'/>
						</div>
						<div class="business_title6">变更为：</div>
						<div class="business_input12">
							<input id="afterManName" class="easyui-textbox" style="width:100%;height:24px" data-options="validType:'maxLength[60]'" value='<s:property value="afterManName"/>'/>
						</div>
						<div class="business_title6">身份证件号码：</div>
						<div class="business_input12">
							<input id="afterManId" class="easyui-textbox" name="doManIdNo" value='<s:property value="afterManId"/>'  style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
						</div>
						<div class="business_title6">身份证件到期日:</div>
						<div class="business_input12">
							<input id="afterManDate" class="easyui-datebox" style="width:100%;height:24px" data-options="editable:false,validType:'maxLength[60]'" value='<s:property value="afterManDate"/>'/>
						</div>
					</div> 
					<br />
					<div style="float: left;width: 100%;padding-left: 10%;"><input type="checkbox" value="3" />被授权的签字人 </div><br />
					<div style="float: left;width: 12%;padding-left: 10%;padding-top: 6px;"><input type="checkbox" value="4" />其他（请注明）：
					</div>
					<div class="business_ss-dm" style="width: 78%;">
						<div class="business_input8">
							<input id="other" class="easyui-textbox" style="width:100%;height:24px" data-options="validType:'maxLength[60]'" value='<s:property value="other"/>'/>
						</div>
					</div>
				</div>
				<div class="business_title2" style="width: 30%;" >向贵行申请变更该账户预留印鉴，兹授权：</div><br />
				<div class="business_title2" style="width: 40%;" >下列人员将其个人签章及本单位公章/财务专用章作为预留银行印鉴：</div>
				<div class="business_ss-dm" style="height:  auto;">
				<table style="margin-left:12%;margin-top: 10px;margin-bottom: 10px;">
					<tbody>
						<tr>
							<td>姓名</td>
							<td>证件类型</td>
							<td>证件号码</td>
							<td>证件到期日</td>
							<td>联系电话</td>
						</tr>
						<tr align="center">
							<td><input id="name1" class='easyui-textbox' style='width:100%;height:24px' value='<s:property value="name1"/>' /></td>
							<td>
								<select class="easyui-combobox" id="idType1" name="idType1"  value='<s:property value="idType1"/>'style="width:100%;height:24px" url='getTypeEnum.action?typeCode=ID_TYPE' 
								data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  ></select>
							</td>
							<td><input id="idNo1" class='easyui-textbox' style='width:100%;height:24px' value='<s:property value="idNo1"/>' /></td>
							<td><input id="idEndDate1" class='easyui-datebox' style='width:100%;height:24px' value='<s:property value="idEndDate1"/>' data-options='editable:false'/></td>
							<td><input id="tel1" class='easyui-textbox' style='width:100%;height:24px' value='<s:property value="tel1"/>' /></td>
						</tr>
						<tr align="center">
							<td><input id="name2" class='easyui-textbox' style='width:100%;height:24px' value='<s:property value="name2"/>' /></td>
							<td>
								<select class="easyui-combobox" id="idType2" name="idType2"  value='<s:property value="idType2"/>'style="width:100%;height:24px" url='getTypeEnum.action?typeCode=ID_TYPE' 
								data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  ></select>
							</td>
							<td><input id="idNo2" class='easyui-textbox' style='width:100%;height:24px' value='<s:property value="idNo2"/>' /></td>
							<td><input id="idEndDate2" class='easyui-datebox' style='width:100%;height:24px' value='<s:property value="idEndDate2"/>' data-options='editable:false'/></td>
							<td><input id="tel2" class='easyui-textbox' style='width:100%;height:24px' value='<s:property value="tel2"/>' /></td>
						</tr>
						<tr align="center">
							<td><input id="name3" class='easyui-textbox' style='width:100%;height:24px' value='<s:property value="name3"/>' /></td>
							<td>
								<select class="easyui-combobox" id="idType3" name="idType3"  value='<s:property value="idType3"/>'style="width:100%;height:24px" url='getTypeEnum.action?typeCode=ID_TYPE' 
								data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  ></select>
							</td>
							<td><input id="idNo3" class='easyui-textbox' style='width:100%;height:24px' value='<s:property value="idNo3"/>' /></td>
							<td><input id="idEndDate3" class='easyui-datebox' style='width:100%;height:24px' value='<s:property value="idEndDate3"/>' data-options='editable:false'/></td>
							<td><input id="tel3" class='easyui-textbox' style='width:100%;height:24px' value='<s:property value="tel3"/>' /></td>
						</tr>
					</tbody>
				</table>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">办理人姓名：</div>
					<div class="business_input8">
						<input id="doManName" class="easyui-textbox" style="width:100%;height:24px" data-options="required:true,validType:'maxLength[60]'" value='<s:property value="doManName"/>'/>
					</div>
					<div class="business_title2">身份证件种类：</div>
					<div class="business_input8">
						<select class="easyui-combobox" id="doManIdType" name="doManIdType"  value='<s:property value="doManIdType"/>'style="width:100%;height:24px" url='getTypeEnum.action?typeCode=ID_TYPE' 
								data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  ></select>
					</div>
					<div class="business_title2">证件号码：</div>
					<div class="business_input8">
						<input id="doManIdNo" class="easyui-textbox" name="doManIdNo" value='<s:property value="doManIdNo"/>'  style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">证件到期日：</div>
					<div class="business_input8">
						<input id="doManEndDate" class="easyui-datebox" style="width:100%;height:24px" data-options="editable:false,required:true,validType:'maxLength[60]'" value='<s:property value="doManEndDate"/>'/>
					</div>
					<div class="business_title2">联系电话：</div>
					<div class="business_input8">
						<input id="doManTel" class="easyui-textbox" name="doManTel" value='<s:property value="doManTel"/>'  style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">新预留印鉴启用日：</div>
					<div class="business_input8">
						<input id="useDate" class="easyui-datebox" style="width:100%;height:24px" data-options="editable:false,required:true,validType:'maxLength[60]'" value='<s:property value="useDate"/>'/>
					</div>
					<div class="business_title2">原预留印鉴编号：</div>
					<div class="business_input8">
						<input id="oldProveNo" class="easyui-textbox" name="oldProveNo" value='<s:property value="oldProveNo"/>'  style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
			</div>
			<div class="role_window_button" style="margin-top:30px;">
				<a href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
					style="padding:3px 0px;width:20%; margin-right:10px;" onclick="saveProveChange(0)">
					<span style="font-size:14px;">保存</span>
				</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-print'"
					style="padding:3px 0px;width:20%; margin-right:10px;" onclick="printToBook('',0)">
					<span style="font-size:14px;">打印(业务授权书)</span>
				</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-print'"
					style="padding:3px 0px;width:20%; margin-right:10px;" onclick="printToBook('',5)">
					<span style="font-size:14px;">打印(预留印鉴变更)</span>
				</a>
				<s:if test='#request.hstatus != "1"'>
				<a id="checkPassBtn" href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
					style="padding:3px 0px;width:20%; margin-right:10px;" onclick="saveProveChange(1)">
					<span style="font-size:14px;">核对通过</span>
				</a>
				</s:if>
				<s:else>
					<a id="checkPassBtn" href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="saveProveChange(0,1)">
						<span style="font-size:14px;">提交核对</span>
					</a>
				</s:else>
			</div>
		</div>
	</div>
	<!-- 打印界面 -->
	<jsp:include page="printAccChange.jsp" />
	<input id="bankName" type="hidden" value='<s:property value="bankName"/>'/>
</body>
</html>
