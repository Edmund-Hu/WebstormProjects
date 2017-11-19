<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="santai" uri="/tags/santai"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>账管系统产品开办</title>
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
<script type="text/javascript" src="js/common/validate.js"></script>
<script type="text/javascript">
	//上一步、下一步
	var curr=1;
	function nextStep(){
  		if(curr!=null){
  			
  			if(!$('#divstep'+curr.toString()).form('validate')){
  				return;
  			};
       		$('#divstep'+curr.toString()).hide();
         	curr=Number(curr)+1;
        	$('#divstep'+curr.toString()).show();
        	if(curr==8){
        		$("#nextStep").hide();
        	}
        	$("#preStep").show();
   		}else{
          	$('#divstep1').show();
         	curr=1;
   		}
	}
	function preStep(){
  		if(curr!=null){
  			if(!$('#divstep'+curr.toString()).form('validate')){
  				return;
  			};
       		$('#divstep'+curr.toString()).hide();
         	curr=Number(curr)-1;
        	$('#divstep'+curr.toString()).show();
        	if(curr==1){
        		$("#preStep").hide();
        	}
        	$("#nextStep").show();
   		}else{
          	$('#divstep1').show();
         	curr=1;
   		}
	}
	$(function(){
		
		//加入repeated类属性     将所有设置相同的repeatedName属性的esayui输入框同步
		$("input",$(".repeated").next("span")).blur(function(){
			var repeatedName = $(this).parent().prev("input").attr("repeatedName");
			var value = $(this).val();
			$(".repeated").each(function(){
				if(repeatedName==$(this).attr("repeatedName")){
					$(this).textbox("setValue",value);
				}
			});
		})
		
		$("div[id='divstep1']").show();
	});
	
	function getProductPage(){
		$("openAccInfo").window('close');
	}
		
</script>
</head>
<body>
	<div class="easyui-panel" title="人行账管系统——产品开办/撤销" iconCls="ico_281" style="width:100%;" data-options="fit:true">
		<div id="openProduct" style="width:100%">
			<div class="role_window" style="height: 600px;">
				<div class="role_window_title14">国内结算产品开办申请表</div>
				<div class="business_ss-dm">
					<div class="business_title2">单位名称：</div>
					<div class="business_input8">
						<input id="depositorName" class="easyui-textbox repeated" repeatedName="depositorName" style="width:100%;height:24px" data-options="required:true,validType:'maxLength[60]'" value='<s:property value="depositorName"/>'/>
					</div>
					<!-- <div class="business_title2">账号：</div> 
					<div class="business_input8">
						<input id="accountCode" class="easyui-textbox" data-options="required:'true',validType:['number','maxLength[17]']" 
							style="width:100%;height:24px" />
					</div> -->
					<div class="business_title2">开户银行名称：</div>
					<div class="business_input8">
						<input id="openBankName" class="easyui-textbox" value='<s:property value="openBankCode"/>'
						data-options="required:'true'" style="width:100%;height:24px"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">证件类别：</div>
					<div class="business_input8">
						<select id="fileType" class="easyui-combobox" name="fileType" style="width:100%;" data-options="editable:false,validType:'maxLength[60]'">
							<option value="身份证" <s:if test="=='身份证'">selected='selected'</s:if>>身份证</option>
							<option value="军官证" <s:if test="=='军官证'">selected='selected'</s:if>>军官证</option>
							<option value="其他" <s:if test="=='其他'">selected='selected'</s:if>>其他</option>
						</select>
					</div>
					<div class="business_title2">证件号码：</div>
					<div class="business_input8">
						<input id="fileNumber" class="easyui-textbox" data-options="required:'true',validType:['englishCheckSub','maxLength[60]']" style="width:100%;height:24px" />
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">法定代表人：</div>
					<div class="business_input8">
						<input id="linkMan" class="easyui-textbox repeated" repeatedName="linkMan" value='<s:property value="linkMan"/>'  style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">联系人姓名：</div>
					<div class="business_input8">
						<input id="clientInfo.contactManSurname" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="clientInfo.contactManSurname"/><s:property value="clientInfo.contactManName"/>' data-options="required:true,validType:'maxLength[25]'"/>
					</div>
					<div class="business_title2">联系电话：</div>
					<div class="business_input8">
						<input id="clientInfo.telContact" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="clientInfo.telContact"/>' data-options="required:true,validType:['englishCheckSub','maxLength[30]']"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">地址：</div>
					<div class="business_input9">
						<input id="registAddress"  class="easyui-textbox" style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					拟开办产品名称：
					<label><input id="PD1" name="PD" type="checkbox" value="PD1" />中银单位结算卡</label> 
					<label><input id="PD2" name="PD" type="checkbox" value="PD2" />对公短信通 </label> 
					<label><input id="PD3" name="PD" type="checkbox" value="PD3" />单位客户回单自助打印盖章</label> 
					<label><input id="PD4" name="PD" type="checkbox" value="PD4" />电子回单箱 </label> 
				</div>
				<div class="role_window_title14" style="float: left;">对公短信通产品开办须知</div>
				<div class="business_ss-dm">
					<div class="business_title2">收费账户户名：</div>
					<div class="business_input12">
						<input id="" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="postCodeNews"/>' data-options="validType:['maxLength[20]']"/>
					</div>
				</div>
				<div class="role_window_title14" style="float: left;">对公短信通客户信息表(一个人300)</div>
				<div class="business_ss-dm">
					<div class="business_title2">姓名：</div>
					<div class="business_input8">
						<input id="" class="easyui-textbox" value='<s:property value=""/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">手机号码：</div>
					<div class="business_input8">
						<input id="" class="easyui-textbox" value='<s:property value=""/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">证件类型：</div>
					<div class="business_input8">
						<select id="" class="easyui-combobox" name="" style="width:100%;" data-options="panelHeight:'auto',editable:false,validType:'maxLength[60]'">
							<option value="身份证" <s:if test="=='身份证'">selected='selected'</s:if>>身份证</option>
							<option value="军官证" <s:if test="=='军官证'">selected='selected'</s:if>>军官证</option>
							<option value="其他" <s:if test="=='其他'">selected='selected'</s:if>>其他</option>
						</select>
					</div>
					<div class="business_title2">证件号码：</div>
					<div class="business_input8">
						<input id="" class="easyui-textbox" value='<s:property value=""/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="role_window_title14" style="float: left;">青岛市分行自助卡申请/变更表</div>
				<div class="business_ss-dm">
					<div class="business_title2">申请人(公司名称)：</div>
					<div class="business_input8">
						<input id="" class="easyui-textbox" value='<s:property value=""/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">主卡管理人姓名：</div>
					<div class="business_input8">
						<input id="" class="easyui-textbox" value='<s:property value=""/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">联系电话(手机)：</div>
					<div class="business_input8">
						<input id="" class="easyui-textbox" value='<s:property value=""/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="role_window_title14" style="float: left;">中银单位结算卡开办/变更申请表</div>
				<div class="business_ss-dm">
					<%-- <div class="business_title2">单位账号：</div>
					<div class="business_input8">
						<input id="" class="easyui-textbox" value='<s:property value=""/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div> --%>
					<div class="business_title2">单位名称：</div>
					<div class="business_input8">
						<input id="" class="easyui-textbox" value='<s:property value=""/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">主卡持卡人姓名：</div>
					<div class="business_input8">
						<input id="" class="easyui-textbox" value='<s:property value=""/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">证件类型：</div>
					<div class="business_input8">
						<input id="" class="easyui-textbox" value='<s:property value=""/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">证件号码：</div>
					<div class="business_input8">
						<input id="" class="easyui-textbox" value='<s:property value=""/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">手机号码：</div>
					<div class="business_input8">
						<input id="" class="easyui-textbox" value='<s:property value=""/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">子卡1持卡人姓名：</div>
					<div class="business_input8">
						<input id="" class="easyui-textbox" value='<s:property value=""/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">证件类型：</div>
					<div class="business_input8">
						<input id="" class="easyui-textbox" value='<s:property value=""/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">证件号码：</div>
					<div class="business_input8">
						<input id="" class="easyui-textbox" value='<s:property value=""/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">手机号码：</div>
					<div class="business_input8">
						<input id="" class="easyui-textbox" value='<s:property value=""/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">子卡2持卡人姓名：</div>
					<div class="business_input8">
						<input id="" class="easyui-textbox" value='<s:property value=""/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">证件类型：</div>
					<div class="business_input8">
						<input id="" class="easyui-textbox" value='<s:property value=""/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">证件号码：</div>
					<div class="business_input8">
						<input id="" class="easyui-textbox" value='<s:property value=""/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">手机号码：</div>
					<div class="business_input8">
						<input id="" class="easyui-textbox" value='<s:property value=""/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
			</div>
		<div style="width:100%;height:250px;">
			<div class="role_window">
				<div class="role_window_button" style="margin-top:30px;">
					<a id="toCheckBtn" href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
						style="padding:3px 0px;width:20%; margin-right:10px;display:none;" onclick="saveBook(1,1)">
						<span style="font-size:14px;">保存</span>
					</a>
					<a id="printBtn" href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-print'"
						style="padding:3px 0px;width:20%; margin-right:10px;display:none;" onclick="printToBook()">
						<span style="font-size:14px;">打印</span>
					</a>
				</div>
			</div>
		</div>
		</div>
	</div>
	<!-- 打印界面 -->
	<jsp:include page="printDetail.jsp" />
	<input id="vOpenBankCode" type="hidden" value='<s:property value="openBankCode"/>'/>
	<input id="vOpenBankName" type="hidden" value='<s:property value="openBankName"/>'/>
	<input id="vCurr" type="hidden" value="<s:date name="openDate" format="yyyy-MM-dd"/>"/>
	<input id="vOrgCode" type="hidden" value="<s:property value="orgCode" />" />
</body>
</html>
