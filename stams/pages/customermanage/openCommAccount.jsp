<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="santai" uri="/tags/santai"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>账管系统开一般存款账户</title>
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
		//自动填充区域代码
		$("input",$("#openCommAcc #checkNumber").next("span")).blur(function(){
			var vCheck = $(this).val();
			if(vCheck.length==14){
				$("#openCommAcc #areaCode").textbox('setValue',vCheck.substring(1,5)+"00");
			}
		})
		
		$("#openCommAcc #openBankCode").textbox('setValue',$("#vOpenBankCode").val());
		$("#openCommAcc #openBankName").textbox('setValue',$("#vOpenBankName").val());
		$("#openCommAcc #openDate").datebox('setValue',$("#vCurr").val());
		var sts = $("#handleStatus").textbox("getValue");
		if(sts!=""){
			$("#openCommAcc").window('close');
			if(sts==5){
				$("#openCommAcc .business_ss-dm input[id],#openBookDiv .business_ss-dm input[id],#chargeDiv .business_ss-dm input[id]").each(
				function(){
					$(this).textbox('readonly',true);
				});
				$("#openCommAcc .business_ss-dm select[id],#openBookDiv .business_ss-dm select[id],#chargeDiv .business_ss-dm select[id]").each(
				function(){
					$(this).combobox('readonly',true);
				});
				controlBtnShow(sts);
			}
		}
	})
	
	function controlBtnShow(sts){
		if(sts==1 || sts==5){
			saveBtnControl('close');
			recordBtnControl('close');
		}else if(sts>1 && sts<4){
			saveBtnControl('open');
			recordBtnControl('close');
		}else if(sts==4){
			saveBtnControl('close');
			recordBtnControl('open');
		}else{
			saveBtnControl('open');
			recordBtnControl('close');
		}
	}
	
	function recordBtnControl(sts){
		$(".role_window_button a[name='recordBtn']").each(function() {
			if(sts=='close'){
				$(this).hide();
			}else{
				$(this).show();
			}
		});
	}
	
	function saveBtnControl(sts){
		$(".role_window_button a[name='saveBtn']").each(function() {
			if(sts=='close'){
				$(this).hide();
			}else{
				$(this).show();
			}
		});
	}

	function getBasicInfo(){
		loading.show();
		var dateArr=["openDate","handlePeopleTime","handlePbcTime"];
		var dataJson = {};
		var isQualified;
		$("#openCommAcc .business_ss-dm input[id]").each(function(){
			var name = $(this).attr('id');
			var value = $(this).textbox("getValue");
			dataJson[name] = value;
			isQualified=validatePre(name,value);
		});
		$("#openCommAcc .business_ss-dm select[id]").each(function(){
			var name = $(this).attr('id');
			var value = $(this).combobox("getValue");
			dataJson[name] = value;
			isQualified=validatePre(name,value);
		});
		
		if(!isQualified){
			return;
		}

		var ajax = new stAjax("getBasicInfo.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data) {
			loading.hide();
			if(data.success){
				//将获取的数据返显
				if (data.data) {
					$("#openBookDiv .business_ss-dm input[id],#recordDiv .business_ss-dm input[id]").each(
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
					$("#openBookDiv .business_ss-dm select[id],#recordDiv .business_ss-dm select[id]").each(
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
					$("#chargeDiv .business_ss-dm input[id]").each(
						function() {
							var name = $(this).attr('id');
							name=name.split(".")[1];
							if(data.data.bookCharge!=null){
								$(this).textbox('setValue',(data.data.bookCharge)[name]);
							}
							$(this).textbox('readonly',true);
					});
					$("#chargeDiv .business_ss-dm select[id]").each(
						function() {
							var name = $(this).attr('id');
							name=name.split(".")[1];
							if (data.data.bookCharge == null || (data.data.bookCharge)[name] == null) {
								$("#chargeDiv .business_ss-dm select[id]").each(
									function() {
										//默认选中第一行
										var val = $(this).combobox("getData");
										for ( var item in val[0]) {
											if (item == "ID") {
												$(this).combobox("select",val[0][item]);
											}
										}
								});
							} else {
								$(this).combobox('setValue',(data.data.bookCharge)[name]);
							}
							$(this).combobox('readonly',true);
						});
						var dataArr=["licenseEndDate","officeAddress","firstMoneyMan","firstTelCode","firstMobileCode","secondMoneyMan","secondTelCode","secondMobileCode"];
						for(var i=0;i<dataArr.length;i++){
							$("#"+dataArr[i]).textbox('readonly',false);
						}
						$("#openCommAcc").window('close');
				}
				
				loading.hide();
				return false;
			}
			alert(data.msg ? data.msg : "操作失败！");
			return false;
		});
		ajax.setErrorCallback(function() {
			loading.hide();
			alert("获取基本户信息失败！");
		});
		ajax.invoke();
	}
	
	function saveBook(sts) {
		var dataJson = {};
		$("#handleStatus").textbox('setValue', sts);
		var vOrgCode = $("#vOrgCode").val();
		$("#openBookDiv #orgCode").textbox("setValue",vOrgCode);
		
		$("#openBookDiv .business_ss-dm input[id],#recordDiv .role_window input[id],#chargeDiv .role_window input[id]")
			.each(function() {
				var name = $(this).attr('id');
				var value = $(this).textbox("getValue");
				var flag = validateForm(name,value);
				if(!flag){
					return false;
				}
				dataJson[name] = value;
			});
		$("#openCommAcc .business_ss-dm select[id],#openBookDiv .business_ss-dm select[id]")
			.each(function() {
				var name = $(this).attr('id');
				var value = $(this).combobox("getValue");
				var flag = validateForm(name,value);
				if(!flag){
					return false;
				}
				if(name=="peopleType" && value==14){
					$("#accountName").textbox("setValue","个体户"+$("#accountName").textbox("getValue"));
					dataJson['accountName'] = "个体户"+$("#accountName").textbox("getValue");
				}else if(name=="accountCategory"){
					if(trim(value)!=""){
					    var v = value.split("_");
						var v1=v[0];
						var v2=v[1];
						value = "@"+v1+":"+v2;
					}
				}
				dataJson[name] = value;
			});
		
		var ajax = new stAjax("saveCommOpenBook.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data) {
			if (data.success) {
				if(data.data){
					$("#activeId").textbox('setValue', data.data.activeId);
				}
				$("#vSave").val(1);
				alert(data.msg ? data.msg : "操作成功！");
				return false;
			}
			alert(data.msg ? data.msg : "操作失败！");
			return false;
		});
		ajax.setErrorCallback(function() {
			loading.hide();
			alert("保存开户申请书失败！");
		});

		ajax.invoke();
	}
	
	function record(sts){
		var dataJson = {};
		$("#handleStatus").textbox('setValue', sts);
		var vOrgCode = $("#vOrgCode").val();
		$("#openBookDiv #orgCode").textbox("setValue",vOrgCode);
		
		$("#openBookDiv .business_ss-dm input[id],#recordDiv .role_window input[id],#chargeDiv .role_window input[id]")
			.each(function() {
				var name = $(this).attr('id');
				var value = $(this).textbox("getValue");
				var flag = validateForm(name,value);
				if(!flag){
					return false;
				}
				dataJson[name] = value;
			});
		$("#openBookDiv .business_ss-dm select[id],#openCommAcc .business_ss-dm select[id]")
			.each(function() {
				var name = $(this).attr('id');
				var value = $(this).combobox("getValue");
				var flag = validateForm(name,value);
				if(!flag){
					return false;
				}
				if(name=="peopleType" && value==14){
					$("#accountName").textbox("setValue","个体户"+$("#accountName").textbox("getValue"));
					dataJson['accountName'] = "个体户"+$("#accountName").textbox("getValue");
				}else if(name=="accountCategory"){
					if(trim(value)!=""){
					    var v = value.split("_");
						var v1=v[0];
						var v2=v[1];
						value = "@"+v1+":"+v2;
					}
				}
				dataJson[name] = value;
			});
		var ajax = new stAjax("recordCommOpenBook.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data) {
			if (data.success) {
				alert(data.msg ? data.msg : "操作成功！");
				recordBtnControl('close');
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
	
	function validatePre(name,value){
		value = trim(value);
		if(name=="checkNumber"){
			if ("" == value) {
				alert("基本存款账户开户许可证核准号不能为空!");
				return false;
			}
			if (!/^J\d{13}$/.test(value)) {
				alert("请录入正确的基本存款账户开户许可证核准号!");
				return false;
			}
		}else if(name=="accountCode"){
			if(value==""){
				alert("账号不能为空!");
				return false;
			}
			if(!/^\w{1,}$/.test(value)){
				alert("请录入正确的账号!");
				return false;
			}
		}else if(name=="openDate"){
			if(value==""){
				alert("开户行日期不能为空");
				return false;
			}
		}else if(name=="commonFileNumber"){
			var vCommonFileType = $("#commonFileType").combobox("getValue");
			if(vCommonFileType == "06" && value==""){
				alert("当操作员选择“借款合同”时,证明文件编号为必输项,反之可以为空!");
				return false;
			}
		}else{
			return true;
		}
	}
	
	function validateForm(name,value){
		if(name=="bookCharge.orgInstitCd" || name=="orgInstitCd"){
			if (value == null || value == "") {
				return true;
			} else if (value.replace(/[^\x00-\xff]/gi, 'xx').length == 9) {
				return true;
			} else {
				alert("组织机构代码格式不正确!");
				return false;
			}
		}else if(name=="accountName"){
			var len=getLength(value);
			if(len>128){
				alert("存款人名称不得超过128个字符！");
				return false;
			}
		}else if(name=="busiScope"){
			var len=getLength(value);
			if(len>1024){
				alert("经营范围不得超过1024个字符！");
				return false;
			}
		}else if(name=="fileNumber"){
			if(value==null || value==""){
				alert("证明文件编号不能为空");
			}
		}
		return true;
	}
	
	function getLength(str){
		var len = str.length;
		var reLen = 0;
		for (var i = 0; i < len; i++)
		{
			if(str.charCodeAt(i) < 27 || str.charCodeAt(i) > 126)
			{
				// 全角
				reLen += 3;
			}
			else
			{
				reLen++;
			}
		}
		return reLen;
	  }
	  
	  //客户端打印
	function printToBook(activeId){
		var vSave = $("#vSave").val();
		var sts = $("#handleStatus").textbox("getValue");
		if(vSave==0 && sts==""){
			alert("打印前需要先保存");
			return;
		}
		$.messager.confirm('提示:', '你确认要打印吗?', function(event) {
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
			
			var ajax = new stAjax("getBookById.action");
			ajax.setData(dataJson);
			ajax.setSuccessCallback(function(data) {
				if(data.success){			
					$('#printDiv>div').each(function(){
						var name=$(this).attr('id');
						if(name=="printChargeDiv"){
							$('#printChargeDiv div').each(function(){
								var name=$(this).attr('id');
								$(this).text("");//清空数据
								if(data.data.bookCharge!=null){
									$(this).append((data.data.bookCharge)[name]);
								}
							});
						}else{
							$(this).text("");//清空数据
							$(this).append((data.data)[name]);//赋值
						}
					});
					var licenseEndDate = (data.data)["licenseEndDate"];
					if(licenseEndDate != null && licenseEndDate.length > 9){
						var year = licenseEndDate.substring(0,4);
						var month = licenseEndDate.substring(5,7);
						var day = licenseEndDate.substring(8,10);
						$("#printDiv #year").text("");//清空数据
						$("#printDiv #year").append(year);//赋值
						$("#printDiv #month").text("");//清空数据
						$("#printDiv #month").append(month);//赋值
						$("#printDiv #day").text("");//清空数据
						$("#printDiv #day").append(day);//赋值
					}
					prn_print();
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
	<div class="easyui-panel" title="人行账管系统——开一般存款账户" iconCls="ico_281" style="width:100%;" data-options="fit:false">
		<div id="openCommAcc" class="easyui-window" title="一般存款账号" data-options="modal:true,iconCls:'ico_171'"
			style="width:700px;height:450px;padding:10px;">
			<div class="role_window" style="width:75%;padding-left:10%;height:85%">
				<div class="business_ss-dm">
					<div class="business_title">基本存款账户开户许可证核准号：</div>
					<div class="business_input2">
						<input id="checkNumber" class="easyui-textbox" data-options="required:'true'"
							style="width:100%;height:24px" />
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">账号：</div>
					<div class="business_input2">
						<input id="accountCode" class="easyui-textbox" data-options="required:'true'"
							style="width:100%;height:24px" />
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">商业银行机构代码：</div>
					<div class="business_input2">
						<input id="openBankCode" class="easyui-textbox" disabled="disabled" data-options="required:'true'"
							style="width:100%;height:24px"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">商业银行机构名称：</div>
					<div class="business_input2">
						<input id="openBankName" class="easyui-textbox" disabled="disabled"
							style="width:100%;height:24px"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">基本户开户地地区代码：</div>
					<div class="business_input2">
						<input id="areaCode" class="easyui-textbox" data-options="required:'true'" style="width:100%;height:24px" />
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">开户日期：</div>
					<div class="business_input2">
						<input id="openDate" class="easyui-datebox" style="width:100%;height:24px" data-options="required:true"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">证明文件类型：</div>
					<div class="business_input2">
						<select id="commonFileType" class="easyui-combobox" name="commonFileType" style="width:100%"
							data-options="panelHeight:'auto',editable:false">
							<option value="07" <s:if test='commonFileType=="07"'>selected='selected'</s:if>>其他结算需要的证明</option>
							<option value="06" <s:if test='commonFileType=="06"'>selected='selected'</s:if>>借款合同</option>
						</select>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">证明文件编号：</div>
					<div class="business_input2">
						<input id="commonFileNumber" name="commonFileNumber" class="easyui-textbox" data-options="required:'true',missingMessage:'当操作员选择“借款合同”时,证明文件编号为必输项,反之可以为空'"
							style="width:100%;height:24px" />
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">备注：</div>
					<div class="business_input2">
						<input class="easyui-textbox" style="width:100%;height:24px" />
					</div>
				</div>
			</div>
			<div class="role_window_button">
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'ico_090'"
					style="padding:5px 0px;width:20%; margin-right:10px;" onclick="getBasicInfo()">
					<span style="font-size:14px;">下一步</span>
				</a>
			</div>
		</div>
		<div id="openBookDiv" style="width:90%;height:470px;">
			<div class="role_window">
				<div class="business_ss-dm">
						<div class="business_title2">存款人名称：</div>
						<div class="business_input9">
							<input id="accountName" class="easyui-textbox" style="width:100%;height:24px" data-options="required:true" value='<s:property value="accountName"/>'/>
						</div>
						<div class="business_title2">电话：</div>
						<div class="business_input12">
							<input id="mobileCode" value='<s:property value="mobileCode"/>' class="easyui-textbox" style="width:100%;height:24px" />
						</div>
						<div class="business_title2">邮编：</div>
						<div class="business_input12">
							<input id="postCode" value='<s:property value="postCode"/>' class="easyui-textbox" style="width:100%;height:24px" />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title">营业执照注册地址：</div>
						<div class="business_input9">
							<input id="registAddress" value='<s:property value="registAddress"/>' class="easyui-textbox"  style="width:100%;height:24px" />
						</div>
						<div class="business_title">实际办公地址：</div>
						<div class="business_input9">
							<input id="officeAddress" value='<s:property value="officeAddress"/>' class="easyui-textbox"  style="width:100%;height:24px" />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">组织机构代码：</div>
						<div class="business_input8">
							<input id="orgInstitCd" value='<s:property value="orgInstitCd"/>'  class="easyui-textbox" style="width:100%;height:24px" />
						</div>
						<div class="business_title">地区代码：</div>
						<div class="business_input8">
							<input id="areaCode" value='<s:property value="areaCode"/>'  class="easyui-textbox" style="width:100%;height:24px" />
						</div>
						<div class="business_title2">存款人类别：</div>
						<div class="business_input8">
							<select id="peopleType" class="easyui-combobox" name="peopleType" style="width:100%;" data-options="panelHeight:'auto',editable:false,required:true">
								<option value="01" <s:if test='peopleType=="01"'>selected='selected'</s:if>>企业法人</option>
								<option value="02" <s:if test='peopleType=="02"'>selected='selected'</s:if>>非法人企业</option>
								<option value="03" <s:if test='peopleType=="03"'>selected='selected'</s:if>>机关</option>
								<option value="04" <s:if test='peopleType=="04"'>selected='selected'</s:if>>实行预算管理的事业单位</option>
								<option value="05" <s:if test='peopleType=="05"'>selected='selected'</s:if>>非预算管理的事业单位</option>
								<option value="06" <s:if test='peopleType=="06"'>selected='selected'</s:if>>团级（含）以上军队及分散执勤的支（分）队</option>
								<option value="07" <s:if test='peopleType=="07"'>selected='selected'</s:if>>团级（含）以上武警部队及分散执勤的支（分）队</option>
								<option value="08" <s:if test='peopleType=="08"'>selected='selected'</s:if>>社会团体</option>
								<option value="09" <s:if test='peopleType=="09"'>selected='selected'</s:if>>宗教组织</option>
								<option value="10" <s:if test='peopleType=="10"'>selected='selected'</s:if>>民办非企业组织</option>
								<option value="11" <s:if test='peopleType=="11"'>selected='selected'</s:if>>外地常设机构</option>
								<option value="12" <s:if test='peopleType=="12"'>selected='selected'</s:if>>外国驻华机构</option>
								<option value="13" <s:if test='peopleType=="13"'>selected='selected'</s:if>>有字号的个体工商户</option>
								<option value="14" <s:if test='peopleType=="14"'>selected='selected'</s:if>>无字号的个体工商户</option>
								<option value="15" <s:if test='peopleType=="15"'>selected='selected'</s:if>>居民委员会、村民委员会、社区委员会</option>
								<option value="16" <s:if test='peopleType=="16"'>selected='selected'</s:if>>单位设立的独立核算的附属机构</option>
								<option value="17" <s:if test='peopleType=="17"'>selected='selected'</s:if>>其他组织</option>
							</select>
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">人员类别：</div>
						<div class="business_input8">
							<select id="linkManType" class="easyui-combobox" style="width:100%;" data-options="panelHeight:'auto',editable:false,required:true">
								<option value="1" <s:if test="linkManType==1">selected='selected'</s:if>>法定代表人</option>
								<option value="2" <s:if test="linkManType==2">selected='selected'</s:if>>单位负责人</option>
							</select>
						</div>
						<div class="business_title2">姓名：</div>
						<div class="business_input8">
							<input id="linkMan" value='<s:property value="linkMan"/>'  class="easyui-textbox" style="width:100%;height:24px" />
						</div>
						<div class="business_title2">证件种类：</div>
						<div class="business_input8">
							<select id="idType" class="easyui-combobox" name="idType" style="width:100%;" data-options="panelHeight:'auto',editable:false,required:true">
								<option value="1" <s:if test="idType==1">selected='selected'</s:if>>身份证</option>
								<option value="2" <s:if test="idType==2">selected='selected'</s:if>>军官证</option>
								<option value="3" <s:if test="idType==3">selected='selected'</s:if>>文职干部证</option>
								<option value="4" <s:if test="idType==4">selected='selected'</s:if>>警官证</option>
								<option value="5" <s:if test="idType==5">selected='selected'</s:if>>士兵证</option>
								<option value="6" <s:if test="idType==6">selected='selected'</s:if>>护照</option>
								<option value="7" <s:if test="idType==7">selected='selected'</s:if>>港、澳、台居民通行证</option>
								<option value="8" <s:if test="idType==8">selected='selected'</s:if>>户口簿</option>
								<option value="9" <s:if test="idType==9">selected='selected'</s:if>>其它合法身份证件</option>
							</select>
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">证件号码：</div>
						<div class="business_input8">
							<input id="idNumber" value='<s:property value="idNumber"/>' class="easyui-textbox" style="width:100%;height:24px" data-options="required:true"/>
						</div>
						<div class="business_title2">行业分类：</div>
						<div class="business_input9">
							<select id="accountCategory" class="easyui-combobox" style="width:100%;" data-options="editable:false">
								<option value=""></option>
								<option value="A_0" <s:if test='accountCategory=="A"'>selected='selected'</s:if>>A:农、林、牧、渔业</option>
								<option value="B_1" <s:if test='accountCategory=="B"'>selected='selected'</s:if>>B:采掘业</option>
								<option value="C_1" <s:if test='accountCategory=="C"'>selected='selected'</s:if>>C:制造业</option>
								<option value="D_1" <s:if test='accountCategory=="D"'>selected='selected'</s:if>>D:电力、燃气及水的生产和供应业</option>
								<option value="E_1" <s:if test='accountCategory=="E"'>selected='selected'</s:if>>E:建筑业</option>
								<option value="F_2" <s:if test='accountCategory=="F"'>selected='selected'</s:if>>F:交通运输、仓储和邮政业</option>
								<option value="G_2" <s:if test='accountCategory=="G"'>selected='selected'</s:if>>G:信息传输、计算机服务和软件业</option>
								<option value="H_2" <s:if test='accountCategory=="H"'>selected='selected'</s:if>>H:批发和零售业</option>
								<option value="I_2" <s:if test='accountCategory=="I"'>selected='selected'</s:if>>I:住宿和餐饮业</option>
								<option value="J_2" <s:if test='accountCategory=="J"'>selected='selected'</s:if>>J:金融业</option>
								<option value="K_2" <s:if test='accountCategory=="K"'>selected='selected'</s:if>>K:房地产业</option>
								<option value="L_2" <s:if test='accountCategory=="L"'>selected='selected'</s:if>>L:租赁和商务服务业</option>
								<option value="M_2" <s:if test='accountCategory=="M"'>selected='selected'</s:if>>M:科学研究、技术服务业和地质勘察业</option>
								<option value="N_2" <s:if test='accountCategory=="N"'>selected='selected'</s:if>>N:水利、环境和公共设施管理业</option>
								<option value="O_2" <s:if test='accountCategory=="O"'>selected='selected'</s:if>>O:居民服务和其他服务业</option>
								<option value="P_2" <s:if test='accountCategory=="P"'>selected='selected'</s:if>>P:教育</option>
								<option value="Q_2" <s:if test='accountCategory=="Q"'>selected='selected'</s:if>>Q:卫生、社会保障和社会福利业</option>
								<option value="R_2" <s:if test='accountCategory=="R"'>selected='selected'</s:if>>R:文化、体育和娱乐业</option>
								<option value="S_2" <s:if test='accountCategory=="S"'>selected='selected'</s:if>>S:公共管理和社会组织</option>
								<option value="T_2" <s:if test='accountCategory=="T"'>selected='selected'</s:if>>T:国际组织</option>
							</select>
						</div>
					</div>
					<div class="business_ss-dm">
					<div class="business_title2">资金币种：</div>
						<div class="business_input8">
							<select id="registMoneyType" class="easyui-combobox" name="registMoneyType" style="width:100%;" data-options="panelHeight:'auto',editable:false">
								<option value="1" <s:if test="registMoneyType==1">selected='selected'</s:if>>人民币</option>
								<option value="2" <s:if test="registMoneyType==2">selected='selected'</s:if>>美元</option>
								<option value="3" <s:if test="registMoneyType==3">selected='selected'</s:if>>港元</option>
								<option value="4" <s:if test="registMoneyType==4">selected='selected'</s:if>>日元</option>
								<option value="5" <s:if test="registMoneyType==5">selected='selected'</s:if>>欧元</option>
								<option value="A" <s:if test='registMoneyType=="A"'>selected='selected'</s:if>>英镑</option>
								<option value="B" <s:if test='registMoneyType=="B"'>selected='selected'</s:if>>加拿大元</option>
								<option value="C" <s:if test='registMoneyType=="C"'>selected='selected'</s:if>>澳大利亚元</option>
								<option value="D" <s:if test='registMoneyType=="D"'>selected='selected'</s:if>>韩元</option>
								<option value="E" <s:if test='registMoneyType=="E"'>selected='selected'</s:if>>新加坡元</option>
								<option value="F" <s:if test='registMoneyType=="F"'>selected='selected'</s:if>>其它货币折美元</option>
							</select>
						</div>
						<div class="business_title2">注册资金：</div>
						<div class="business_input8">
							<input id="registMoney" value='<s:property value="registMoney"/>' class="easyui-textbox" style="width:100%;height:24px" />
						</div>
						<div class="business_title2">未标明注册资金：</div>
						<div class="business_input6">
							<select id="nofundflag" class="easyui-combobox" style="width:100%;" data-options="panelHeight:'auto',editable:false">
								<option value="false" <s:if test='nofundflag=="false"'>selected='selected'</s:if>>标明</option>
								<option value="true" <s:if test='nofundflag=="true"'>selected='selected'</s:if>>未标明</option>
							</select>
						</div>
					</div>
					<div class="business_ss-dm" style="height: 60px;">
						<div class="business_title2">经营范围：</div>
						<div class="business_input10">
							<input id="busiScope" value='<s:property value="busiScope"/>' class="easyui-textbox" data-options="multiline:true" style="width:100%;height:50px" />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title">国税登记证号：</div>
						<div class="business_input9">
							<input id="countryTax" value='<s:property value="countryTax"/>' class="easyui-textbox" style="width:100%;height:24px" />
						</div>
						<div class="business_title">地税登记证号：</div>
						<div class="business_input9">
							<input id="areaTax" value='<s:property value="areaTax"/>' class="easyui-textbox" style="width:100%;height:24px" />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">证明文件类型：</div>
						<div class="business_input8">
							<select id="fileType" class="easyui-combobox" name="state" style="width:100%;" data-options="panelHeight:'auto',editable:false,required:true">
								<option value="01" <s:if test='fileType=="01"'>selected='selected'</s:if>>营业执照</option>
								<option value="02" <s:if test='fileType=="02"'>selected='selected'</s:if>>批文</option>
								<option value="03" <s:if test='fileType=="03"'>selected='selected'</s:if>>登记证书</option>
								<option value="04" <s:if test='fileType=="04"'>selected='selected'</s:if>>开户证明</option>
							</select>
						</div>
						<div class="business_title">证明文件编号：</div>
						<div class="business_input8">
							<input id="fileNumber" value='<s:property value="fileNumber"/>' class="easyui-textbox" style="width:100%;height:24px" data-options="required:true"/>
						</div>
						<div class="business_title2">有效期至：</div>
						<div class="business_input8">
							<input id="licenseEndDate" value='<s:property value="licenseEndDate"/>' class="easyui-datebox" style="width:100%;"/>
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">财务负责人姓名：</div>
						<div class="business_input8">
							<input id="firstMoneyMan" value='<s:property value="firstMoneyMan"/>' class="easyui-textbox" style="width:100%;height:24px" />
						</div>
						<div class="business_title2">座机：</div>
						<div class="business_input8">
							<input id="firstTelCode"  value='<s:property value="firstTelCode"/>' class="easyui-textbox" style="width:100%;height:24px" />
						</div>
						<div class="business_title2">手机：</div>
						<div class="business_input8">
							<input id="firstMobileCode" value='<s:property value="firstMobileCode"/>' class="easyui-textbox" style="width:100%;height:24px" />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">财务经办人姓名：</div>
						<div class="business_input8">
							<input id="secondMoneyMan" value='<s:property value="secondMoneyMan"/>' class="easyui-textbox" style="width:100%;height:24px" />
						</div>
						<div class="business_title2">座机：</div>
						<div class="business_input8">
							<input id="secondTelCode" value='<s:property value="secondTelCode"/>' class="easyui-textbox" style="width:100%;height:24px" />
						</div>
						<div class="business_title2">手机：</div>
						<div class="business_input8">
							<input id="secondMobileCode" value='<s:property value="secondMobileCode"/>'  class="easyui-textbox" style="width:100%;height:24px" />
						</div>
						<div class="business_input8" style="display:none">
							<input id="orgCode" class="easyui-textbox" value='<s:property value="orgCode"/>'  />
							<input id="handleStatus" class="easyui-textbox" value='<s:property value="handleStatus"/>' />
							<input id="activeId" class="easyui-textbox" value='<s:property value="activeId"/>' />
							<input id="orgId" class="easyui-textbox" value=''  />
							<input id="basic_account_id" class="easyui-textbox" value=''  />
							<input id="accountType" class="easyui-textbox" value="1"/>
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title">股东或实际控股人：</div>
						<div class="business_input10">
							<input id="stockHolder" value='<s:property value="stockHolder"/>'  class="easyui-textbox" style="width:100%;height:24px" />
						</div>
					</div>
			</div>
		</div>
		<div id="chargeDiv" style="width:65%;height:230px;">
			<div class="role_window">
				<div class="role_window_title14">以下为存款人上级法人或主管单位信息</div>
					<div class="business_ss-dm">
						<div class="business_title1">上级法人或主管单位名称：</div>
						<div class="business_input9">
							<input id="bookCharge.unitName"  value='<s:property value="bookCharge.unitName"/>'  class="easyui-textbox" data-options="width:400" />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title1">基本存款账户开户许可证核准号：</div>
						<div class="business_input9">
							<input id="bookCharge.checkNumber" value='<s:property value="bookCharge.checkNumber"/>'  class="easyui-textbox" data-options="width:400"  />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title1">组织机构代码：</div>
						<div class="business_input9">
							<input id="bookCharge.orgInstitCd" value='<s:property value="bookCharge.orgInstitCd"/>' class="easyui-textbox" data-options="width:400" />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">人员类别：</div>
						<div class="business_input9">
							<select id="bookCharge.linkManType" class="easyui-combobox" name="bookCharge.linkManType" style="width:100%;" data-options="panelHeight:'auto',editable:false">
								<option value="1" <s:if test="bookCharge.linkManType==1">selected='selected'</s:if>>法定代表人</option>
								<option value="2" <s:if test="bookCharge.linkManType==2">selected='selected'</s:if>>单位负责人</option>
							</select>
						</div>
						<div class="business_title2">姓名：</div>
						<div class="business_input9">
							<input id="bookCharge.linkMan" value='<s:property value="bookCharge.linkMan"/>'  class="easyui-textbox" style="width:100%;height:24px" />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title">证件种类：</div>
						<div class="business_input9">
							<select id="bookCharge.idType" class="easyui-combobox" name="bookCharge.idType" style="width:100%;" data-options="panelHeight:'auto',editable:false">
								<option value="1" <s:if test="bookCharge.idType==1">selected='selected'</s:if>>身份证</option>
								<option value="2" <s:if test="bookCharge.idType==2">selected='selected'</s:if>>军官证</option>
								<option value="3" <s:if test="bookCharge.idType==3">selected='selected'</s:if>>文职干部证</option>
								<option value="4" <s:if test="bookCharge.idType==4">selected='selected'</s:if>>警官证</option>
								<option value="5" <s:if test="bookCharge.idType==5">selected='selected'</s:if>>士兵证</option>
								<option value="6" <s:if test="bookCharge.idType==6">selected='selected'</s:if>>护照</option>
								<option value="7" <s:if test="bookCharge.idType==7">selected='selected'</s:if>>港、澳、台居民通行证</option>
								<option value="8" <s:if test="bookCharge.idType==8">selected='selected'</s:if>>户口簿</option>
								<option value="9" <s:if test="bookCharge.idType==9">selected='selected'</s:if>>其它合法身份证件</option>
							</select>
						</div>
						<div class="business_title2">证件号码 ：</div>
						<div class="business_input9">
							<input id="bookCharge.idNumber" value='<s:property value="bookCharge.idNumber"/>'  class="easyui-textbox" data-options="prompt:'请输入证件号码'" style="width:100%;height:24px" />
						</div>
					</div>
			</div>
		</div>
		<div id="recordDiv" style="width:800px;height:250px;">
			<div class="role_window">
				<div class="role_window_title14">以下栏目由开户银行审核后填写</div>
					<div class="business_ss-dm">
						<div class="business_title2">开户银行名称：</div>
						<div class="business_input9">
							<input id="openBankName"  value='<s:property value="openBankName"/>'  class="easyui-textbox" style="width:100%;height:24px" />
						</div>
						<div class="business_title4">开户银行代码：</div>
						<div class="business_input9">
							<input id="openBankCode" value='<s:property value="openBankCode"/>' class="easyui-textbox" style="width:100%;height:24px" />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">帐户名称：</div>
						<div class="business_input9">
							<input id="accountName" value='<s:property value="accountName"/>' class="easyui-textbox" style="width:100%;height:24px" />
						</div>
						<div class="business_title4">账号：</div>
						<div class="business_input9">
							<input id="accountCode" value='<s:property value="accountCode"/>' class="easyui-textbox" style="width:100%;height:24px" />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">基本存款账户开户许可证核号：</div>
						<div class="business_input9">
							<input id="checkNumber" value='<s:property value="checkNumber"/>' class="easyui-textbox" style="width:100%;height:24px" />
						</div>
						<div class="business_title4">开户日期：</div>
						<div class="business_input8">
							<input id="openDate" value="<s:date name="openDate" format="yyyy-MM-dd"/>"  class="easyui-datebox" style="width:100%;height:24px" />
						</div>
					</div>
				<div class="role_window_button" style="margin-top:30px;">
					<a href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="saveBook(4)">
						<span style="font-size:14px;">保存</span>
					</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-print'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="printToBook(this.id)">
						<span style="font-size:14px;">打印</span>
					</a>
					<a href="javascript:void(0)" name="recordBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="record(5)">
						<span style="font-size:14px;">备案</span>
					</a>
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
	<input id="vSave" type="hidden" value="0"/>
</body>
</html>
