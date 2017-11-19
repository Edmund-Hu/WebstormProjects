<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="santai" uri="/tags/santai"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>账管系统开基本户</title>
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
		var sts = $("#handleStatus").textbox("getValue");
		if(sts!=""){
			$("#openBasicAcc").window('close');
			if(sts==5){
				$("div .business_ss-dm input[id]").each(
				function(){
					$(this).textbox('readonly',true);
				});
				$("div .business_ss-dm select[id]").each(
				function(){
					$(this).combobox('readonly',true);
				});
			}
			controlBtnShow(sts);
		}
		
		$("input",$("#openBookDiv #accountName").next("span")).blur(function(){
			$("#recordDiv #accountName").textbox('setValue',$("#openBookDiv #accountName").textbox("getValue"));
		})
		
		$("#openBookDiv #accountCategory").combobox({
			onSelect:function(){
				var value = $("#openBookDiv #accountCategory").combobox("getValue");
				if(trim(value)==""){
				   alert("行业归属不能为空!");
				   return false;
				}
				addCalling(value);
			}
		});
	})
	
	//预先提交行业类型
	function addCalling(value){
		var dataJson={};
		dataJson["accountCategory"]=value;
		var ajax = new stAjax("addAccountCategory.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data) {
			if (data.success) {
				
				return false;
			}
			alert(data.msg ? data.msg : "提交行业归属失败！");
			return false;
		});
		ajax.setErrorCallback(function() {
			loading.hide();
			alert("提交行业归属失败！");
		});
		ajax.invoke();
	}
	
	function controlBtnShow(sts){
		if(sts==1 || sts==5){
			saveBtnControl('close');
			recordBtnControl('close');
		}else if(sts>1 && sts<4){
			saveBtnControl('open');
			recordBtnControl('close');
		}else if(sts==4){
			saveBtnControl('open');
			recordBtnControl('open');
		}else{
			saveBtnControl('open');
			recordBtnControl('close');
		}
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
	
	function recordBtnControl(sts){
		$(".role_window_button a[name='recordBtn']").each(function() {
			if(sts=='close'){
				$(this).hide();
			}else{
				$(this).show();
			}
		});
	}
	
	function openBasicAccount(){
		alert(123456);
		loading.show();
		var dateArr=["openDate","licenseEndDate"];
		var fileNumber = $("#openBasicAcc #fileNumber").textbox("getValue");
		if(trim(fileNumber)==""){
			alert("企业注册号不能为空");
			return;
		}
		var dataJson = {};
		dataJson["fileNumber"]=fileNumber;
		var ajax = new stAjax("getAICInfo.action");
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
									if(name=="registMoney"){
										$(this).textbox("setValue",transMoney((data.data)[name]));
									}else{
										$(this).textbox('setValue',(data.data)[name]);
									}
								}
							}
							
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
						});
					$("#chargeDiv .business_ss-dm input[id]").each(
						function() {
							var name = $(this).attr('id');
							name=name.split(".")[1];
							if(data.data.bookCharge!=null){
								$(this).textbox('setValue',(data.data.bookCharge)[name]);
							}
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
						});
						$('#openBasicAcc').window('close');
				}
				
				loading.hide();
				return false;
			}
			alert(data.msg ? data.msg : "操作失败！");
			return false;
		});
		ajax.setErrorCallback(function() {
			loading.hide();
			alert("从工商信息平台获取信息失败！");
		});

		ajax.invoke();
	}
	
	function saveBook(sts) {
		var dataJson = {};
		$("#handleStatus").textbox('setValue', sts);
		var vOrgCode = $("#vOrgCode").val();
		$("#openBookDiv #orgCode").textbox("setValue",vOrgCode);
		
		var flag = true;
		$("#openBookDiv .business_ss-dm input[id],#recordDiv .role_window input[id],#chargeDiv .role_window input[id]")
				.each(function() {
					var name = $(this).attr('id');
					var value = $(this).textbox("getValue");
					flag = validateForm(name,value);
					if(!flag){
						return false;
					}
					dataJson[name] = value;
				});
		$("#openBasicAcc .business_ss-dm select[id],#openBookDiv .business_ss-dm select[id]")
				.each(function() {
					var name = $(this).attr('id');
					var value = $(this).combobox("getValue");
					flag = validateForm(name,value);
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
		if(!flag){
			return;
		}
		var ajax = new stAjax("saveBasicOpenBook.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data) {
			if (data.success) {
				$("#activeId").textbox('setValue', data.data.activeId);
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
		$("#openBasicAcc .business_ss-dm select[id],#openBookDiv .business_ss-dm select[id]")
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
		var ajax = new stAjax("recordBasicOpenBook.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data) {
			if (data.success) {
				$("#vSave").val(1);
				alert(data.msg ? data.msg : "操作成功！");
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
	
	function validateForm(name,value){
		if(name=="bookCharge.orgInstitCd" || name=="orgInstitCd"){
			/* if (value == null || value == "") {
				return true;
			} else if (value.replace(/[^\x00-\xff]/gi, 'xx').length == 9) {
				return true;
			} else {
				alert("组织机构代码格式不正确!");
				return false;
			} */
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
		}else if(name=="accountCategory"){
			if(value == null || value == ""){
				alert("行业归属不能为空");
				return false;
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
		if(vSave==0){
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
		/* var iTop = (window.screen.availHeight-30-700)/2; //获得窗口的垂直位置;
		var iLeft = (window.screen.availWidth-10-700)/2; //获得窗口的水平位置;
		window.open('getBookById.action?activeId='+activeId, "打印窗口",'height=700,width=700,top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=auto,resizeable=no,location=no,status=no');
		 */
	}
</script>
</head>
<body>
	<div class="easyui-panel" title="人行账管系统——开基本存款账户" iconCls="ico_281" style="width:100%;" data-options="fit:false">
		<div id="openBasicAcc" class="easyui-window" title="基本存款账号" data-options="modal:true,iconCls:'ico_171'"
			style="width:500px;height:200px;padding:10px;">
			<div class="business_ss-dm">
				<div class="business_title" style="width:35%">营业执照号：</div>
				<div class="business_input2">
					<input id="fileNumber" class="easyui-textbox" style="width:100%;height:24px" />
				</div>
			</div>
			<div class="role_window_button">
				<!-- <div><label style="font-size: 14px;font-weight: bold;">两者录入一项即可</label></div> -->
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'ico_090'"
					style="padding:5px 0px;width:20%; margin-right:10px;" onclick="openBasicAccount()">
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
						<input id="mobileCode" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="mobileCode"/>' data-options="required:true"/>
					</div>
					<div class="business_title2">邮编：</div>
					<div class="business_input12">
						<input id="postCode" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="postCode"/>' data-options="required:true"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">营业执照注册地址：</div>
					<div class="business_input9">
						<input id="registAddress" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="registAddress"/>' data-options="required:true"/>
					</div>
					<div class="business_title">实际办公地址：</div>
					<div class="business_input9">
						<input id="officeAddress" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="officeAddress"/>'/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">组织机构代码：</div>
					<div class="business_input8">
						<input id="orgInstitCd" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="orgInstitCd"/>'/>
					</div>
					<div class="business_title">地区代码：</div>
					<div class="business_input8">
						<input id="areaCode" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="areaCode"/>'/>
					</div>
					<div class="business_title2">存款人类别：</div>
					<div class="business_input8">
						<select id="peopleType" class="easyui-combobox" name="peopleType" style="width:100%;" data-options="panelHeight:'auto',editable:false,required:true">
							<option value=""></option>
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
							<option value=""></option>
							<option value="1" <s:if test="linkManType==1">selected='selected'</s:if>>法定代表人</option>
							<option value="2" <s:if test="linkManType==2">selected='selected'</s:if>>单位负责人</option>
						</select>
					</div>
					<div class="business_title2">姓名：</div>
					<div class="business_input8">
						<input id="linkMan" class="easyui-textbox" value='<s:property value="linkMan"/>'  style="width:100%;height:24px" data-options="required:true"/>
					</div>
					<div class="business_title2">证件种类：</div>
					<div class="business_input8">
						<select id="idType" class="easyui-combobox" name="idType" style="width:100%;" data-options="panelHeight:'auto',editable:false,required:true">
							<option value=""></option>
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
						<input id="idNumber" class="easyui-textbox" value='<s:property value="idNumber"/>'  style="width:100%;height:24px" data-options="required:true" />
					</div>
					<div class="business_title2">行业归属：</div>
					<div class="business_input9">
						<select id="accountCategory" class="easyui-combobox" style="width:100%;" data-options="required:true,editable:false">
							<option value=""></option>
							<option value="A$$农、林、牧、渔业$$第一产业            $$1" <s:if test='accountCategory=="A"'>selected='selected'</s:if>>A:农、林、牧、渔业</option>
							<option value="B$$采矿业$$第二产业            $$2" <s:if test='accountCategory=="B"'>selected='selected'</s:if>>B:采掘业</option>
							<option value="C$$制造业$$第二产业            $$2" <s:if test='accountCategory=="C"'>selected='selected'</s:if>>C:制造业</option>
							<option value="D$$电力、煤气及水的生产和供应业$$第二产业            $$2" <s:if test='accountCategory=="D"'>selected='selected'</s:if>>D:电力、燃气及水的生产和供应业</option>
							<option value="E$$建筑业$$第二产业            $$2" <s:if test='accountCategory=="E"'>selected='selected'</s:if>>E:建筑业</option>
							<option value="F$$交通运输、仓储及邮政业$$第一层次            $$3" <s:if test='accountCategory=="F"'>selected='selected'</s:if>>F:交通运输、仓储和邮政业</option>
							<option value="G$$信息传输、计算机服务和软件业$$第二层次            $$4" <s:if test='accountCategory=="G"'>selected='selected'</s:if>>G:信息传输、计算机服务和软件业</option>
							<option value="H$$批发和零售业$$第二层次            $$4" <s:if test='accountCategory=="H"'>selected='selected'</s:if>>H:批发和零售业</option>
							<option value="I$$住宿和餐饮业$$第二层次            $$4" <s:if test='accountCategory=="I"'>selected='selected'</s:if>>I:住宿和餐饮业</option>
							<option value="J$$金融业$$第二层次            $$4" <s:if test='accountCategory=="J"'>selected='selected'</s:if>>J:金融业</option>
							<option value="K$$房地产业$$第二层次            $$4" <s:if test='accountCategory=="K"'>selected='selected'</s:if>>K:房地产业</option>
							<option value="L$$租赁和商务服务业$$第二层次            $$4" <s:if test='accountCategory=="L"'>selected='selected'</s:if>>L:租赁和商务服务业</option>
							<option value="M$$科学研究、技术服务和地质勘查业$$第三层次            $$5" <s:if test='accountCategory=="M"'>selected='selected'</s:if>>M:科学研究、技术服务业和地质勘察业</option>
							<option value="N$$水利、环境和公共设施管理业$$第三层次            $$5" <s:if test='accountCategory=="N"'>selected='selected'</s:if>>N:水利、环境和公共设施管理业</option>
							<option value="O$$居民服务和其他服务业$$第三层次            $$5" <s:if test='accountCategory=="O"'>selected='selected'</s:if>>O:居民服务和其他服务业</option>
							<option value="P$$教育$$第三层次            $$5" <s:if test='accountCategory=="P"'>selected='selected'</s:if>>P:教育</option>
							<option value="Q$$卫生、社会保障和社会福利业$$第三层次            $$5" <s:if test='accountCategory=="Q"'>selected='selected'</s:if>>Q:卫生、社会保障和社会福利业</option>
							<option value="R$$文化、体育和娱乐业$$第三层次            $$5" <s:if test='accountCategory=="R"'>selected='selected'</s:if>>R:文化、体育和娱乐业</option>
							<option value="S$$公共管理和社会组织$$第四层次            $$6" <s:if test='accountCategory=="S"'>selected='selected'</s:if>>S:公共管理和社会组织</option>
							<option value="T$$国际组织（其他行业）$$第四层次            $$6" <s:if test='accountCategory=="T"'>selected='selected'</s:if>>T:国际组织</option>
							<option value="U$$其他$$第一层次            $$3" <s:if test='accountCategory=="U"'>selected='selected'</s:if>>U:其他</option>
						</select>
					</div>
				</div>
				<div class="business_ss-dm">
				<div class="business_title2">资金币种：</div>
					<div class="business_input8">
						<select id="registMoneyType" class="easyui-combobox" name="registMoneyType" style="width:100%;" data-options="panelHeight:'auto',editable:false">
							<option value=""></option>
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
						<input id="registMoney" class="easyui-textbox" value='<s:property value="registMoney"/>' style="width:100%;height:24px" />
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
						<input id="busiScope" class="easyui-textbox" value='<s:property value="busiScope"/>' data-options="multiline:true" style="width:100%;height:50px" />
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">国税登记证号：</div>
					<div class="business_input9">
						<input id="countryTax" class="easyui-textbox" value='<s:property value="countryTax"/>' style="width:100%;height:24px" />
					</div>
					<div class="business_title">地税登记证号：</div>
					<div class="business_input9">
						<input id="areaTax" class="easyui-textbox" value='<s:property value="areaTax"/>' style="width:100%;height:24px" />
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">证明文件类型：</div>
					<div class="business_input8">
						<select id="fileType" class="easyui-combobox" name="state" style="width:100%;" data-options="panelHeight:'auto',editable:false,required:true">
							<option value=""></option>
							<option value="01" <s:if test='fileType=="01"'>selected='selected'</s:if>>营业执照</option>
							<option value="02" <s:if test='fileType=="02"'>selected='selected'</s:if>>批文</option>
							<option value="03" <s:if test='fileType=="03"'>selected='selected'</s:if>>登记证书</option>
							<option value="04" <s:if test='fileType=="04"'>selected='selected'</s:if>>开户证明</option>
						</select>
					</div>
					<div class="business_title">证明文件编号：</div>
					<div class="business_input8">
						<input id="fileNumber" class="easyui-textbox" style="width:100%;height:24px" data-options="required:true" value='<s:property value="fileNumber"/>'/>
					</div>
					<div class="business_title2">有效期至：</div>
					<div class="business_input8">
						<input id="licenseEndDate" class="easyui-datebox" value='<s:property value="licenseEndDate"/>' style="width:100%;" data-options="required:true"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">财务负责人姓名：</div>
					<div class="business_input8">
						<input id="firstMoneyMan" class="easyui-textbox" value='<s:property value="firstMoneyMan"/>'  style="width:100%;height:24px" />
					</div>
					<div class="business_title2">座机：</div>
					<div class="business_input8">
						<input id="firstTelCode" class="easyui-textbox"  value='<s:property value="firstTelCode"/>' style="width:100%;height:24px" />
					</div>
					<div class="business_title2">手机：</div>
					<div class="business_input8">
						<input id="firstMobileCode" class="easyui-textbox" value='<s:property value="firstMobileCode"/>' style="width:100%;height:24px" />
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">财务经办人姓名：</div>
					<div class="business_input8">
						<input id="secondMoneyMan" class="easyui-textbox" value='<s:property value="secondMoneyMan"/>'  style="width:100%;height:24px" />
					</div>
					<div class="business_title2">座机：</div>
					<div class="business_input8">
						<input id="secondTelCode" class="easyui-textbox" value='<s:property value="secondTelCode"/>'  style="width:100%;height:24px" />
					</div>
					<div class="business_title2">手机：</div>
					<div class="business_input8">
						<input id="secondMobileCode" class="easyui-textbox" value='<s:property value="secondMobileCode"/>' style="width:100%;height:24px" />
					</div>
					<div class="business_input8" style="display:none">
						<input id="orgCode" class="easyui-textbox" value='<s:property value="orgCode"/>'  />
						<input id="handleStatus" class="easyui-textbox" value='<s:property value="handleStatus"/>' />
						<input id="activeId" class="easyui-textbox" value='<s:property value="activeId"/>' />
						<input id="orgId" class="easyui-textbox" value=''  />
						<input id="basic_account_id" class="easyui-textbox" value=''  />
						<input id="accountType" class="easyui-textbox" value="0"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">股东或实际控股人：</div>
					<div class="business_input10">
						<input id="stockHolder" class="easyui-textbox" value='<s:property value="stockHolder"/>' style="width:100%;height:24px" />
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
							<input id="bookCharge.unitName" class="easyui-textbox" value='<s:property value="bookCharge.unitName"/>'  data-options="width:400" />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title1">基本存款账户开户许可证核准号：</div>
						<div class="business_input9">
							<input id="bookCharge.checkNumber" class="easyui-textbox" value='<s:property value="bookCharge.checkNumber"/>' data-options="width:400"  />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title1">组织机构代码：</div>
						<div class="business_input9">
							<input id="bookCharge.orgInstitCd" class="easyui-textbox" value='<s:property value="bookCharge.orgInstitCd"/>' data-options="width:400" />
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
							<input id="bookCharge.linkMan" class="easyui-textbox" value='<s:property value="bookCharge.linkMan"/>' style="width:100%;height:24px" />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title">证件种类：</div>
						<div class="business_input9">
							<select id="bookCharge.idType" class="easyui-combobox" name="bookCharge.idType" style="width:100%;" data-options="panelHeight:'auto',editable:false">
								<option value=""></option>
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
							<input id="bookCharge.idNumber" class="easyui-textbox" value='<s:property value="bookCharge.idNumber"/>' data-options="prompt:'请输入证件号码'" style="width:100%;height:24px" />
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
							<input id="openBankName" class="easyui-textbox" value='<s:property value="openBankName"/>' data-options="required:true" style="width:100%;height:24px" />
						</div>
						<div class="business_title4">开户银行代码：</div>
						<div class="business_input9">
							<input id="openBankCode" class="easyui-textbox" value='<s:property value="openBankCode"/>' data-options="required:true" style="width:100%;height:24px" />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">帐户名称：</div>
						<div class="business_input9">
							<input id="accountName" class="easyui-textbox" value='<s:property value="accountName"/>' data-options="required:true" style="width:100%;height:24px" />
						</div>
						<div class="business_title4">账号：</div>
						<div class="business_input9">
							<input id="accountCode" class="easyui-textbox" value='<s:property value="accountCode"/>' style="width:100%;height:24px" />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">账户性质：</div>
						<div class="business_input9">
							<input class="easyui-textbox" style="width:100%;height:24px" disabled="disabled" value="基本存款账户"/>
						</div>
						<div class="business_title4">申请日期：</div>
						<div class="business_input8">
							<input id="openDate" class="easyui-datebox" value="<s:date name="openDate" format="yyyy-MM-dd"/>" style="width:100%;height:24px" />
						</div>
					</div>
				<div class="role_window_button" style="margin-top:30px;">
					<a href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
						style="padding:3px 0px;width:20%; margin-right:10px;" onclick="saveBook(3)">
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
