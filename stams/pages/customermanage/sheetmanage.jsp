<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="santai" uri="/tags/santai"%>
<%@ taglib prefix="santai_ams" uri="/tags/santai_ams"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title><%=application.getInitParameter("siteName")%></title>
	<link rel="stylesheet" type="text/css" href="js/jquery/jquery-easyui/easyui.css" />
		<link rel="stylesheet" type="text/css" href="js/jquery/jquery-easyui/icon.css" />
		<link rel="stylesheet" type="text/css" href="css/main.css" />
		<script type="text/javascript" src="js/jquery/jquery.js"></script>
		<script type="text/javascript" src="js/jquery/jquery-easyui/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="js/jquery/jquery-easyui/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="js/santai.core.js"></script>
		<script type="text/javascript" src="js/common/common.js"></script>
    	
		<script language="javascript" type="text/javascript">
		
			loading.show();//显示loading动画
			var orgUI = new OrgUI();
			
			$(document).ready(function(){
				loading.hide();//页面加载完成，关闭loading
			});
			
			function showOrg(){
				orgUI.show(function(p){
					if(p && p.length>0){
						$("#orgName").textbox('setValue', p[0].orgName);
						$("#orgCode").val(p[0].orgCode);
					}
				}, null, loading);
			}	
									
			function checkvalue(){
				loading.show();//显示loading动画
			 	document.forms("querysheetForm").submit();
			 	return true;
			}

			function editDetail(accountCode){
				if(accountCode == "" || accountCode == undefined || accountCode == null){
					alert("参数错误!!!");
					return;
				}
				$("#openSheetDiv .business_ss-dm #changeItem").combobox('clear');
				openEdit(accountCode);
			};
			
			function openEdit(accountCode){
				var dataJson={accountCode:accountCode};
				var ajax = new stAjax("showOpenSheet.action");
				ajax.setData(dataJson);
				ajax.setSuccessCallback(function(data) {
					loading.hide();
					if (data.success) {
						windowCenter('openSheetDiv');
						$('#openSheetDiv').window('open');
						if(data.data){
							$("#openSheetDiv .business_ss-dm input[id]").each(function(){								
								var name=$(this).attr('id');
								if(name=="changeItem"){
									$(this).combobox('setValues',(data.data)[name]==null?"":(data.data)[name]);
								}else{
									$(".role_window #"+name).textbox('setValue',(data.data)[name]);
								}
							});
							$("#openSheetDiv .business_ss-dm select[id]").each(function(){
								var name=$(this).attr('id');
								//$(".role_window #"+name).combobox('setValue',(data.data)[name]);
								$(".role_window #"+name).val((data.data)[name]);
							});
						}
						return false;
					}

					alert(data.msg ? data.msg : "操作失败！");
					return false;
				});
				ajax.setErrorCallback(function() {
					loading.hide();
					alert("服务器处理出现异常，编辑查询失败！");
				});

				ajax.invoke();
			};
			
			function saveSheet(){
				if(!$("#editSheet").form('validate')){
					return false;
				}
				
				var dataJson = {};
				$("#openSheetDiv .business_ss-dm input[id]").each(function(){
					var name=$(this).attr('id');
					if(name=="changeItem"){
						var valArr=$(this).combobox("getValues");
						dataJson[name] = valArr.join(",");
					}else{
						dataJson[name]=$(this).textbox("getValue");
					}
				});
				$("#openSheetDiv .business_ss-dm select[id]").each(function(){
					var name=$(this).attr('id');
					dataJson[name]=$(this).val();//combobox("getValue");
				});
				var ajax = new stAjax("updateSheet.action");
				ajax.setData(dataJson);
				ajax.setSuccessCallback(function(data) {
					if(data.success){
						$("#openSheetDiv").window('close');
						alert("更新成功！");
						checkvalue();
						return false;
					}
					alert(data.msg ? data.msg : "操作失败！");
					return false;
				});
				ajax.setErrorCallback(function() {
					loading.hide();
					alert("服务器处理出现异常，更新失败！");
				});

				ajax.invoke();
			}

			//日期格式化
			function ww4(date){
		        var y = date.getFullYear();  
		        var m = date.getMonth()+1;  
		        var d = date.getDate();
		        return  y+""+(m<10?('0'+m):m)+""+(d<10?('0'+d):d);		          
		    }
		    function w4(s){
		    	if (!s) return new Date();
		    	var y = s.substring(0,4);  
	            var m =s.substring(4,6);  
	            var d = s.substring(6,8);
	            if (!isNaN(y) && !isNaN(m) && !isNaN(d)){  
	                return new Date(y,m-1,d);  
	            } else {
	                return new Date();  
	            }
		    }
		</script>
	</head>
		
	<body>
		<div class="easyui-panel" title="开销户电子登记簿" iconCls="ico_280"
			style="width: 100%;">
			<s:form action="querysheet" name="querysheetForm" id="querysheetForm"
				theme="simple" style="margin:0px; padding:0px; border:none;">
				<div id="w" class="easyui-window" title="选择机构"
					data-options="modal:true,closed:true,iconCls:'icon-left_jsgl'"
					style="width: 350px; height: 400px; padding: 10px;">
					<div class="easyui-panel">
						<ul id="changeTree" class="easyui-tree"></ul>
					</div>
				</div>

				<div class="business_ss-dm">
					<div class="title">
						<input type="hidden" id="orgCode" name="orgCode"
							value='<s:property value="orgCode" />' />
						所属机构：
					</div>
					<div class="business_input2" style="width:400px;">
						<input id="orgName" name="orgName" readonly="readonly"
							value='<s:property value="orgName" />' class="easyui-textbox"
							style="width: 85%; height: 24px" />
						<a id="showorg" onclick="showOrg()" name="showorg" href="#"
							class="easyui-linkbutton list-buttom" iconCls="ico_197">选择</a>
					</div>
					<div class="title">
						客户号：
					</div>
					<div class="input2">
						<input id="custCode" name="custCode"
							value='<s:property value="custCode" />' class="easyui-textbox"
							data-options="prompt:'请输入客户号'" style="width: 100%; height: 24px" />
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="title">
						账号：
					</div>
					<div class="input2">
						<input id="accountCode" name="accountCode"
							value='<s:property value="accountCode" />' class="easyui-textbox"
							data-options="prompt:'请输入账号'" style="width: 100%; height: 24px" />
					</div>
					<div class="title">
						账户类型：
					</div>
					<div class="input2">
						<select name="accountType" id="accountType" maxlength="68"
							style="width: 155px">
							<option value='-1'
								<s:if test="%{accountType==-1}">selected="selected"</s:if>>
								请选择
							</option>
							<option value='0'
								<s:if test="%{accountType==0}">selected="selected"</s:if>>
								基本帐户
							</option>
							<option value='1'
								<s:if test="%{accountType==1}">selected="selected"</s:if>>
								一般存款帐户
							</option>
							<option value='2'
								<s:if test="%{accountType==2}">selected="selected"</s:if>>
								临时存款帐户
							</option>
							<option value='3'
								<s:if test="%{accountType==3}">selected="selected"</s:if>>
								专用存款帐户
							</option>
							<option value='4'
								<s:if test="%{accountType==4}">selected="selected"</s:if>>
								结算帐户
							</option>
							<option value='5'
								<s:if test="%{accountType==5}">selected="selected"</s:if>>
								资本金
							</option>
							<option value='6'
								<s:if test="%{accountType==6}">selected="selected"</s:if>>
								贷款
							</option>
							<option value='7'
								<s:if test="%{accountType==7}">selected="selected"</s:if>>
								外债
							</option>
							<option value='8'
								<s:if test="%{accountType==8}">selected="selected"</s:if>>
								其他
							</option>

						</select>
					</div>
					<div class="title">
						账户状态：
					</div>
					<div class="input2">
						<select name="status" id="status" maxlength="68"
							style="width: 155px">
							<option value='-1'
								<s:if test="%{status==-1}">selected="selected"</s:if>>
								请选择
							</option>
							<option value='1'
								<s:if test="%{status==1}">selected="selected"</s:if>>
								正常
							</option>
							<option value='0' <s:if test="%{status==0}">selected="selected"</s:if>>
								销户
							</option>
							<option value='2' <s:if test="%{status==2}">selected="selected"</s:if>>
								只收不付冻结
							</option>
							<option value='3' <s:if test="%{status==3}">selected="selected"</s:if>>
								封闭冻结
							</option>
							<option value='5' <s:if test="%{status==5}">selected="selected"</s:if>>
								不动户转收益
							</option>
						</select>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="title">
						网上银行：
					</div>
					<div class="input2">
						<select name="isOnline" id="isOnline" maxlength="68"
							style="width: 155px">
							<option value=''
								<s:if test='isOnline == ""'>selected="selected"</s:if>>
								请选择
							</option>
							<option value='1'
								<s:if test='isOnline == "1"'>selected="selected"</s:if>>
								已开通
							</option>
							<option value='0' <s:if test='isOnline == "0"'>selected="selected"</s:if>>
								未开通
							</option>
						</select>
					</div>
					<div class="title">
						手机银行：
					</div>
					<div class="input2">
						<select name="isMobileBank" id="isMobileBank" maxlength="68"
							style="width: 155px">
							<option value=''
								<s:if test='isMobileBank == ""'>selected="selected"</s:if>>
								请选择
							</option>
							<option value='1'
								<s:if test='isMobileBank == "1"'>selected="selected"</s:if>>
								已开通
							</option>
							<option value='0' <s:if test='isMobileBank == "0"'>selected="selected"</s:if>>
								未开通
							</option>
						</select>
					</div>
					<div class="title">
						<a href="#" onclick="checkvalue();" class="easyui-linkbutton"
							data-options="iconCls:'icon-search'"
							style="padding: 5px 0px; width: 80%; height: 24px;"><span
							style="font-size: 14px;">查询</span> </a>
					</div>
				</div>
			</s:form>

			<div class="role_list">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
						<th width="30px" class="th1">
							序号
						</th>
						<th width="150px" class="th1">
							账号
						</th>
						<th width="100px" class="th1">
							客户号
						</th>
						<th class="th1">
							账户名
						</th>
						<th class="th1">
							账户类型
						</th>
						<th width="80px" class="th1">
							开户日期
						</th>
						<th width="80px" class="th1">
							销户日期
						</th>
						<th width="80px" class="th1">
							激活日期
						</th>
						<th class="th1" width="60px">
							账户状态
						</th>
						<th class="th1" width="70px">
							操作
						</th>

					</tr>
					<s:if test="page.data.size == 0">
						<tr>
							<td colspan="10" class="td">
								无 记 录 !
							</td>
						</tr>
					</s:if>
					<s:else>
						<s:iterator value="page.data" status="index">
							<s:if test="(#index.index+1)%2 == 1">
								<s:set name="td_cls" value="'tr1_bg'"></s:set>
							</s:if>
							<s:else>
								<s:set name="td_cls" value="'tr1_bg1'"></s:set>
							</s:else>
							<tr class='<s:property value="#td_cls" />'>
								<td class="td">
									<s:property value="#index.index+1" />
								</td>
								<td class="td">
									<s:property value="accountCode" />
									&nbsp;
								</td>
								<td class="td">
									<s:property value="custCode" />
									&nbsp;
								</td>
								<td class="td">
									<s:property value="accountName" />
									&nbsp;
								</td>
								<td class="td">
									<s:if test="accountType == 0">基本帐户</s:if>
									<s:elseif test="accountType == 1">一般存款帐户</s:elseif>
									<s:elseif test="accountType == 2">临时存款帐户</s:elseif>
									<s:elseif test="accountType == 3">专用存款帐户</s:elseif>
									<s:elseif test="accountType == 4">结算帐户</s:elseif>
									<s:elseif test="accountType == 5">资本金</s:elseif>
									<s:elseif test="accountType == 6">贷款</s:elseif>
									<s:elseif test="accountType == 7">外债</s:elseif>
									<s:elseif test="accountType == 8">
										<s:if test="depositType == 11">其他-对公整存整取款</s:if>
										<s:if test="depositType == 12">其他-对公大额存款</s:if>
										<s:elseif test="depositType == 15">其他-对公通知存款</s:elseif>
										<s:elseif test="depositType == 16">其他-对公大额通知存</s:elseif>
										<s:else>其他</s:else>
									</s:elseif>
								</td>
								<td class="td">
									<s:property value="openDate" />
									&nbsp;
								</td>
								<td class="td">
									<s:property value="closeDate" />
									&nbsp;
								</td>
								<td class="td">
									<s:property value="closeDate" />
									&nbsp;
								</td>
								<td class="td">
									<s:if test="status == 1">正常</s:if>
									<s:elseif test="status == 0">销户</s:elseif>
									<s:elseif test="status == 2">只收不付冻结</s:elseif>
									<s:elseif test="status == 3">封闭冻结</s:elseif>
									<s:elseif test="status == 5">不动户转收益</s:elseif>
									<s:else>其他</s:else>
								</td>
								<td class="td">
									<a href="#" id="edit_'${accountCode}' />" onclick="editDetail('${accountCode}');"class="easyui-linkbutton list-buttom" iconCls="icon-edit" plain="true">编辑</a>									
								</td>
							</tr>
						</s:iterator>
					</s:else>
				</table>
				<div class="fole_pagination" style="text-align: right;">
					<santai:search url='querysheet.action'
						result='<%=request.getAttribute("page")%>' params="" />
				</div>
				<!-- 开户申请书录入界面 -->
					<jsp:include page="openSheet.jsp" />
				<!-- 表单 -->
			</div>
		</div>
	</body>
</html>
