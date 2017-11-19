<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="santai" uri="/tags/santai"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>开户申请书管理</title>
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
	loading.show();
	
	var orgUI = new OrgUI();
	function showOrg(){
		orgUI.show(function(p){
			if(p && p.length>0){
				$("#orgName").textbox('setValue', p[0].orgName);
				$("#orgCode").val(p[0].orgCode);
			}
		}, null, loading);
	}	
	
	$(function() {
		var pageType  =$("#type").val();
		if(pageType == 0){//大堂只能查刚创建
			$("#s1").hide();
			$("#st1").hide();
			$("#s2").show();
		}
		if(pageType == 1){//柜员端  查询非刚创建
			
		}
		if(pageType == 2){//报备页面只能显示待报备
			$("#s1").hide();
			$("#st1").hide();
		}

		$("#search").on("click", function() {
			$("#queryForm").submit();
		})
		
		//批量删除
		$("#delAll").on("click",function(){
				var accountfileds = new Array();
				var flag=true;
				$("#contentTbl").find("input[type='checkbox']:checked")
						.each(function() {
							if (/\d/.test($(this).val())) {
								accountfileds.push($(this).val());
							}
							var sts = $(this).next("input[name='hidden_sts']").val();
							if(sts==5){
								alert("不能删除已经备案的账号");
								flag=false;
								return false;
							}
						});
				if(flag){
					del(accountfileds.join(","), 1);
				}
			});
			
		loading.hide();
		
		//输入基本户开户许可证后自动填充地区代码
		$("input",$("#openCommAcc #checkNumber").next("span")).blur(function(){
			var vCheck = $(this).val();
			if(vCheck.length==14){
				$("#openCommAcc #areaCode").textbox('setValue',vCheck.substring(1,5)+"00");
			}
		})
	});
	
	function getQueryString(name) {
	    var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
	    var r = window.location.search.substr(1).match(reg);
	    if (r != null) {
	        return unescape(r[2]);
	    }
	    return null;
	}

	
	function selectAll(obj) {
		var c = 0;
		var sts;
		$("#" + obj).find("input[type='checkbox']").each(function() {
			if (c == 0) {
				sts = $(this).prop("checked");
			}
			if (sts) {
				$(this).prop('checked', true);
			} else {
				$(this).prop('checked', false);
			}
			c++;
		});
	}
	
	//弹出开户信息录入界面  handle为0表示新增;-1表示编辑;-2表示弹出备案;-3表示查看
	function openAccount(id) {
		var dateArr=["openDate","handlePeopleTime","handlePbcTime"];
		var dataJson = {};
		var isQualified;
		var accType=$("#openType #accountType").combobox("getValue");
		if (id=="") {
			$("#openCommAcc .business_ss-dm input[id],#openBasicAcc .business_ss-dm input[id]").each(function(){
				var name = $(this).attr('id');
				var value = $(this).textbox("getValue");
				dataJson[name] = value;
				if(accType==1){
					isQualified=validatePre(name,value);
				}
			});
			$("#openBasicAcc .business_ss-dm select[id],#openType .business_ss-dm select[id],#openCommAcc .business_ss-dm select[id]").each(function(){
				var name = $(this).attr('id');
				var value = $(this).combobox("getValue");
				dataJson[name] = value;
				if(accType==1){
					isQualified=validatePre(name,value);
				}
			});
			if(accType==1 && !isQualified){
				return;
			}
		} else {
			dataJson = {
				"activeId" : id
			};
		}

		var ajax = new stAjax("showOpenBook.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data) {
			if (data.success) {
				$('#openCommAcc').window('close');
				if (data.data) {
					$("#openBookDiv .business_ss-dm input[id],#openCommAcc .business_ss-dm input[id],#recordDiv .business_ss-dm input[id]").each(
						function() {
							var name = $(this).attr('id');
							if ((data.data)[name]!=null) {
								if($.inArray(name, dateArr)>=0){
									$(this).datebox('setValue',(data.data)[name]);
								}else{
									$(this).textbox('setValue',(data.data)[name]);
								}
							}
							/* if(name=="accountCategory"){
								$(this).combobox('setValue',(data.data)[name]);
							} */
							
					});
					$("#openType .business_ss-dm select[id],#openBookDiv .business_ss-dm select[id],#openCommAcc .business_ss-dm select[id],#recordDiv .business_ss-dm select[id]").each(
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
					/* $("#accountNameCopy2").textbox('setValue',data.data.accountName);
					$("#checkNumberCopy").textbox('setValue',data.data.checkNumber);
					$("#accountCodeCopy").textbox('setValue',data.data.accountCode); */
					
					controlBtnShow(data.data.handleStatus);
				}
				if(id==""){
					$('#openBookDiv').window('open');
				}
				//readonly();
				loading.hide();
				return false;
			}

			alert(data.msg ? data.msg : "操作失败！");
			return false;
		});
		ajax.setErrorCallback(function() {
			loading.hide();
			alert("服务器处理出现异常，开户失败！");
		});

		ajax.invoke();
	}

	function saveBook(sts,currpage, topage) {
		var dataJson = {};
		var value = $("#handleStatus").textbox('getValue');
		$('#handleStatus').textbox('setValue', sts);
		var vOrgCode = $("#vOrgCode").val();
		$("#openBookDiv #orgCode").textbox("setValue",vOrgCode);
		if($("#openCommAcc #accountCode").textbox("getValue")=="" && $("#recordDiv #accountCode").textbox("getValue")!=""){
			$("#openCommAcc #accountCode").textbox("setValue",$("#recordDiv #accountCode").textbox("getValue"));
		}
		
		var flag = validateForm(name,value);
		if(!flag){
			return;
		}
		
		$("#openBookDiv .business_ss-dm input[id],#openCommAcc .business_ss-dm input[id],#recordDiv .role_window input[id],#chargeDiv .role_window input[id]")
				.each(function() {
					var name = $(this).attr('id');
					var value = $(this).textbox("getValue");
					dataJson[name] = value;
				});
		$("#openBasicAcc .business_ss-dm select[id],#openType .business_ss-dm select[id],#openBookDiv .business_ss-dm select[id],#openCommAcc .business_ss-dm select[id]")
				.each(function() {
					var name = $(this).attr('id');
					var value = $(this).combobox("getValue");
					if(name=="peopleType" && value==14){
						$("#accountName").textbox("setValue","个体户"+$("#accountName").textbox("getValue"));
						dataJson['accountName'] = "个体户"+$("#accountName").textbox("getValue");
					}else if(name=="accountCategory"){
						value = "@"+value+":"+$(this).find("option:selected").attr("chanye");
					}
					dataJson[name] = value;
				});
		
		var ajax = new stAjax("saveOpenBook.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data) {
			if (data.success) {
				$("#activeId").textbox('setValue', data.data.activeId);
				changepage(currpage, topage);
				controlBtnShow(data.data.handleStatus);
				if(data.data.handleStatus==5){
					alert(data.msg ? data.msg : "操作成功！");
					reload();
				}
				return false;
			}
			alert(data.msg ? data.msg : "操作失败！");
			return false;
		});
		ajax.setErrorCallback(function() {
			loading.hide();
			alert("服务器处理出现异常，开户失败！");
		});

		ajax.invoke();
	}

	//删除开户信息
	function del(row, count) {
		if (trim(row) == "") {
			alert("请选择要删除的账户");
			return;
		}
		$.messager.confirm('提示:', '你确认要删除吗?', function(event) {
			if (event) {
				loading.show();
				var ajax = new stAjax("delOpenBook.action");
				if (0 == count) {
					row = row.split("del_")[1];
				}
				ajax.setData({
					id : row
				});
				ajax.setSuccessCallback(function(data) {
					loading.hide();
					if (data.success) {
						alert(data.msg ? data.msg : "操作成功！");
						reload();
						return false;
					}

					alert(data.msg ? data.msg : "操作失败！");
					return false;
				});
				ajax.setErrorCallback(function() {
					loading.hide();
					alert("服务器处理出现异常，注销失败！");
				});

				ajax.invoke();
			}
		});
	}

	function reload() {
		$("#queryForm").submit();
	}

	function edit(row) {
		if ("" == trim(row)) {
			alert("请选择需要编辑的账号");
			return;
		}
		redirect(row);
	}
	
	function openProduct(id){
		window.location.href="showOpenProduct.action?bookId="+id;
	} 
	
	function redirect(row){
		var sp=row.split("_");
		var handleStatus = sp[0];
		var id = sp[1];
		if(handleStatus=="5"){
			window.location.href="showCloseAccount.action?bookId="+id;
		}else{
			window.location.href="showOpenBasicAppoint.action?activeId="+id;
		}
		/*} else if(accType=="1"){
			window.location.href="showOpenComm.action?activeId="+id;
		} else if(accType=="2"){
			window.location.href="showAssistOpenBasic.action?activeId="+id;
		}*/
	}
	
	function record(row) {
		if ("" == trim(row)) {
			alert("请选择需要需要备案的账号");
			return;
		}
		redirect(row);
	}

	//客户端打印
	function printToBook(activeId){
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
			
			var ajax = new stAjax("printOpenBook.action");
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
					//prn_print();
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
		/* var iTop = (window.screen.availHeight-30-700)/2; //获得窗口的垂直位置;
		var iLeft = (window.screen.availWidth-10-700)/2; //获得窗口的水平位置;
		window.open('getBookById.action?activeId='+activeId, "打印窗口",'height=700,width=700,top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=auto,resizeable=no,location=no,status=no');
		 */
	}
	
	function readonly(){
		var accountType = $("#openType #accountType").combobox("getValue");
		if(accountType==1){
			$("#openBookDiv .business_ss-dm input[id],#recordDiv .role_window input[id],#chargeDiv .role_window input[id]")
				.each(function() {
					$(this).textbox('readonly',true);
				});
			$("#openBookDiv .business_ss-dm select[id],#chargeDiv .role_window select[id]")
				.each(function() {
					$(this).combobox('readonly',true);
				});
		}
	}
	
	function clearReadonly(){
		$("#openBookDiv .business_ss-dm input[id],#recordDiv .role_window input[id],#chargeDiv .role_window input[id]")
				.each(function() {
					$(this).textbox('readonly',false);
				});
			$("#openBookDiv .business_ss-dm select[id]")
				.each(function() {
					$(this).combobox('readonly',false);
				});
	}
	
	function view(row) {
		if ("" == trim(row)) {
			alert("请选择需要查看的账号");
			return;
		}
		redirect(row);
	}
	
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
		/* if($("#openType #accountType").combobox("getValue")==1){
			$(".role_window_button a[name='uploadBtn']").hide();
		}else{
			$(".role_window_button a[name='uploadBtn']").show();
		} */
		
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

	function changepage(currpage, topage) {
		if (currpage != "") {
			$('#' + currpage).window('close');
		}
		if (topage != "") {
			$('#' + topage).window('open');
		}
	}
	
	function add(){
		clearValues();
		$("#openCommAcc #openBankCode").textbox('setValue',$("#vOpenBankCode").val());
		$("#openCommAcc #openBankName").textbox('setValue',$("#vOpenBankName").val());
		$("#openCommAcc #openDate").datebox('setValue',$("#vCurr").val());
		$("#openType").window('open');
	}
	
	function selectOpenType(){
		var accountType = $("#openType #accountType").combobox("getValue");
		if(accountType==0){
			$("#openBasicAcc").window('open');
		}else if(accountType==1){
			$("#openCommAcc").window('open');
		}
		$("#openType").window('close');
	}
	
	function print(sts,row){
		$.messager.confirm('提示:', '你确认要打印吗?', function(event) {
			if (event) {
				var aid = $("#activeId").textbox('getValue');
				if(row==""){
					row = aid;
				}else{
					row = row.split("print_")[1];
				}
				if(row=="" || row==null){
					alert("打印前请先保存");
					return;
				}
				loading.show();
				var ajax = new stAjax("bookPrint.action");
				ajax.setData({
					activeId : row,
					handleStatus:sts
				});
				ajax.setSuccessCallback(function(data) {
					loading.hide();
					if (data.success) {
						alert(data.msg ? data.msg : "操作成功！");
						return false;
					}

					alert(data.msg ? data.msg : "操作失败！");
					return false;
				});
				ajax.setErrorCallback(function() {
					loading.hide();
					alert("服务器处理出现异常，打印失败！");
				});

				ajax.invoke();
			}
		});
	}
	
	function openBasicAccount(){
		var fileNumber = $("#openBasicAcc #fileNumberQuery").textbox("getValue");
		/* var accountName = $("#openBasicAcc #accountNameQuery").textbox("getValue");
		if(trim(fileNumber)=="" || trim(accountName)==""){
			alert("企业注册号和企业名必须有一个有值");
			return;
		} */
		if(trim(fileNumber)==""){
			alert("企业注册号不能为空");
			return;
		}
		openAccount("");
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
	  
	  function uploadWindow(){
	  	//先清空原来的控件
	  	$("#uploadForm .role_window div").empty();
	  	
	  	var peopleType = $("#openBookDiv #peopleType").combobox("getValue");
	  	var bizCode = peopleType+"01";
	  	var ajax = new stAjax("showOpenBook.action");
		ajax.setData({"biz_code":bizCode,"accountType":$("#openType #accountType").combobox("getValue"),"licNo":$("#recordDiv #accountCode").textbox("getValue")});
		ajax.setSuccessCallback(function(data) {
			if(data.success){
				var dataV=data.data;
				$("#orgId").textbox("setValue",dataV.orgCode);
				$("#basic_account_id").textbox("setValue",dataV.idNumber);
				//遍历list
				var list = dataV.other;
				var divText="";
				for ( var i = 0; i < list.length; i++) {
					var m=list[i];
					var txt="";
					var tmp1="BIZ_FILE_ID_='"+m.biz_FILE_ID_+"' ";
					var tmp2="data-options=\"prompt:'"+m.biz_FILE_NAME+"'";
					if(m.must_==1){
						tmp2+=",required:'true'";
					}
					tmp2+="\" ";
					txt="<div class='business_ss-dm' style='padding-left:22%'>"+"<input name='file' class='easyui-filebox' "+tmp1+tmp2+" style='width:300px' buttonText='选择文件'/></div>";
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
			alert("服务器处理出现异常，打印失败！");
		});

		ajax.invoke();
	  }
	  
	  function upload(){
	  	$("#uploadForm input[name='licNo']").val($("#recordDiv #accountCode").textbox("getValue"));
	  	var tmp="";
	  	$("#uploadForm .business_ss-dm input").each(function(){
	  		var v=$(this).attr("BIZ_FILE_ID_");
	  		if (v){
	  			//same as "营业执照.jpg":"6b2a1a43-d824-473f-a4a5-63edd4d7aee1";
	  			var p = $(this).textbox("getValue");//由于可能没有textbox属性，取值会报错
	  			if(p){
			  		tmp+=(p+":"+v+";");
	  			}
	  		}
	  	});
	  	$("#uploadForm input[name='tempArr']").val(tmp);
	  	$("#uploadForm").submit();
	  	$("#uploadDiv").window('close');
	  }
</script>
</head>
<body>
   <!--  <h2>文件下载内容：</h2><br/>  
    Dream.jpg:<a href="/stams/fileDownload.action?fileName=人民银行账户信息数据.xls">点击下载</a><br/>  
    jd2chm源码生成chm格式文档.rar:<a href="/stams/fileDownload.action?number=2">点击下载2</a>  --> 
    
    <!-- 　<form action="/stams/fileUpload.action" method="post" enctype="multipart/form-data">
    　　
        <input type="file" name="file" />
        <input type="submit" value="submit"/>
    </form> 
     -->
    
	<div class="easyui-panel" title="开户申请管理" iconCls="ico_281" style="width:100%;" data-options="fit:true">
		<!-- 查询 -->
		<form action="accountShow.action" id="queryForm" method="post" name="queryForm">
			<div class="business_ss-dm">
				<input type="hidden" id="type" name="hstatus" value="${type}" />
				<div class="title">
					<input type="hidden" id="orgCode" name="orgCode" value='<s:property value="orgCode" />' />
					所属机构：
				</div>
				<div class="business_input2" style="width:400px;">
					<input id="orgName" name="orgName" readonly="readonly"
						value='<s:property value="orgName" />' class="easyui-textbox" style="width: 78%; height: 24px" />
					<a id="showorg" onclick="showOrg();" name="showorg" href="#" plain="true"
						class="easyui-linkbutton list-buttom" iconCls="ico_197">选择</a>
				</div>
				<div class="title">用户类型：</div>
				<div class="input2">
					<select class="easyui-combobox" name="accountType" style="width:100%" data-options="panelHeight:'auto',editable:false">
						<option value="">请选择</option>
						<option value='0' <s:if test="accountType==0">selected='selected'</s:if>> 基本帐户</option>
						<option value='1' <s:if test="accountType==1">selected='selected'</s:if>>一般存款帐户</option>
						<option value='2' <s:if test="accountType==2">selected='selected'</s:if>>临时存款帐户</option>
						<option value='3' <s:if test="accountType==3">selected='selected'</s:if>>专用存款帐户</option>
					</select>
				</div>
				<div class="title">账号：</div>
				<div class="input2">
					<input name="accountCode" class="easyui-textbox" value="<s:property value="accountCode"/>" style="width:100%;height:24px" />
				</div>
				<!-- <div class="title">注册号：</div>
				<div class="input2">
					<input name="fileNumber" class="easyui-textbox" style="width:100%;height:24px" />
				</div> -->
			</div>
			<div class="business_ss-dm">
				<div class="title">开户时间：</div>
				<div class="input2" style="width: 400px;">
					<input name="startQueryDate" class="easyui-datebox" value="<s:property value="startQueryDate"/>"/> 至 <input name="endQueryDate" class="easyui-datebox" value="<s:property value="endQueryDate"/>" />
				</div>
				<div class="title" id="st1">状态：</div>
				<div class="input2" id="s1">
					<select id="handleStatusQry" class="easyui-combobox" name="handleStatus" style="width:100%"
						data-options="panelHeight:'auto',editable:false">
						<option value="">请选择</option>
						<option value="1" <s:if test="handleStatus==1">selected='selected'</s:if>>待核对</option>
						<option value="2" <s:if test="handleStatus==2">selected='selected'</s:if>>等待报备</option>
						<option value="3" <s:if test="handleStatus==3">selected='selected'</s:if>>完成开户</option>
						<option value="4" <s:if test="handleStatus==4">selected='selected'</s:if>>已变更</option>
						<option value="5" <s:if test="handleStatus==5">selected='selected'</s:if>>已销户</option>
					</select>
				</div>
				<div class="title">
					<a id="search" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'"
						style="padding:5px 0px;width:60%; height:24px;" onclick="search">
						<span style="font-size:14px;">搜索</span>
					</a>
				</div>
				<div class="title"  id="s2" style="display: none;">
					<a id="add" href="showOpenBasicAppoint.action" class="easyui-linkbutton" data-options="iconCls:'icon-add'"
						style="padding:5px 0px;width:60%; height:24px;" >
						<span style="font-size:14px;">新增</span>
					</a>
				</div>
				<%-- <div class="title" id="s3">
					<a id="edit" href="showAccountChange.action" class="easyui-linkbutton" data-options="iconCls:'icon-edit'"
						style="padding:5px 0px;width:60%; height:24px;">
						<span style="font-size:14px;">变更</span>
					</a>
				</div> --%>
			</div>
		</form>
		
		<!-- 表单 -->
		<div class="role_list">
			<table id="contentTbl" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<!-- <th class="th0"><input class="role_checkbox" name="" type="checkbox" value=""
						onclick="selectAll('contentTbl')" /></th> -->
					<th class="th1">序号</th>
					<th class="th1">账号</th>
					<th class="th1">存款人名称</th>
					<th class="th1">账户名称</th>
					<th class="th1">开户日期</th>
					<th class="th1">打印次数</th>
					<th class="th1">打印日期</th>
					<th class="th1">开户类型</th>
					<th class="th1">状态</th>
					<th class="th2">操作</th>
				</tr>
				<s:if test="page.data.size==0">
					<tr class="tr1_bg">
						<td colspan="11">无 记 录 !</td>
					</tr>
				</s:if>
				<s:else>
					<s:iterator value="page.data" status="index">
						<tr class="tr1_bg">
							<%-- <td class="td0">
								<input class="role_checkbox" name="" type="checkbox" value='<s:property value="activeId"/>' />
								<input name="hidden_sts" value="<s:property value="handleStatus" />" style="display:none"/>
							</td> --%>
							<td class="td1">
								<s:property value="#index.index+1" />
							</td>
							<td class="td4">
								<s:property value="accountCode" />
							</td>
							<td class="td4">
								<s:property value="depositorName" />
							</td>
							<td class="td4">
								<s:property value="accountName" />
							</td>
							<td class="td6">
								<s:date name="openDate" format="yyyy-MM-dd" />
							</td>
							<td class="td6">
								<s:property value="printCount" />
							</td>
							<td class="td6">
								<s:date name="printTime" format="yyyy-MM-dd" />
							</td>
							<td class="td6">
								<s:if test="accountType==0">基本账户</s:if>
								<s:elseif test="accountType==1">一般账户</s:elseif>
								<s:elseif test="accountType<5">专用账户</s:elseif>
								<s:elseif test="accountType<7">临时账户</s:elseif>
							</td>
							<td class="td6">
							<s:if test="handleStatus==0">待提交</s:if>
								<s:if test="handleStatus==1">待核对</s:if>
								<s:elseif test="handleStatus==2">等待报备</s:elseif>
								<s:elseif test="handleStatus==3">完成开户</s:elseif>
								<s:elseif test="handleStatus==4">已变更</s:elseif>
								<s:elseif test="handleStatus==5">已销户</s:elseif>
							</td>
							<td class="td4">
								<s:if test="handleStatus==0">
									<a href="#" id="<s:property value="accountType" />_<s:property value="activeId" />" onclick="edit(this.id)"
										class="easyui-linkbutton list-buttom" iconCls="icon-edit" plain="true">编辑</a>
									<a href="#" id="del_<s:property value="activeId" />" onclick="del(this.id,0)"
										class="easyui-linkbutton list-buttom " iconCls="ico_086" plain="true">删除</a>
								</s:if>
								<s:elseif test="handleStatus==1">
									<a href="#" id="<s:property value="accountType" />_<s:property value="activeId" />" onclick="edit(this.id)"
										class="easyui-linkbutton list-buttom" iconCls="icon-edit" plain="true">核对</a>
									<a href="#" onclick="del(this.id,0)" id="del_<s:property value="activeId" />"
									
										class="easyui-linkbutton list-buttom " iconCls="ico_086" plain="true">删除</a>
								</s:elseif>
								<s:elseif test="handleStatus==2">
									<a href="#" id="<s:property value="accountType" />_<s:property value="activeId" />" onclick="edit(this.id)"
										class="easyui-linkbutton list-buttom" iconCls="icon-edit" plain="true">报备</a>
								</s:elseif>
								<s:elseif test="handleStatus==3">
									<a href="#" class="easyui-linkbutton list-buttom" id="<s:property value="accountType" />_<s:property value="activeId" />" onclick="view(this.id)" iconCls="icon-more" plain="true" >查看</a>
								</s:elseif>
								<s:elseif test="handleStatus==4">
									<a href="#" class="easyui-linkbutton list-buttom" id="<s:property value="accountType" />_<s:property value="activeId" />" onclick="view(this.id)" iconCls="icon-more" plain="true" >查看</a>
								</s:elseif>
								<s:elseif test="handleStatus==5">
									<a href="#" class="easyui-linkbutton list-buttom" id="<s:property value="handleStatus" />_<s:property value="activeId" />" onclick="view(this.id)" iconCls="icon-more" plain="true" >查看销户原因</a>
								</s:elseif>
							</td>
						</tr>
					</s:iterator>
				</s:else>
			</table>
		</div>
		<!-- 打印界面 -->
		<jsp:include page="printDetail.jsp" />
		<div class="fole_pagination">
			<santai:search url='accountShow.action' result='<%=request.getAttribute("page")%>' params="" />
		</div>
	</div>
	<input id="vOpenBankCode" type="hidden" value='<s:property value="openBankCode"/>'/>
	<input id="vOpenBankName" type="hidden" value='<s:property value="openBankName"/>'/>
	<input id="vCurr" type="hidden" value="<s:date name="openDate" format="yyyy-MM-dd"/>"/>
	<input id="vOrgCode" type="hidden" value="<s:property value="orgCode" />" />
</body>
</html>
