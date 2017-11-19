<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="santai" uri="/tags/santai"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<div id="openSheetDiv" class="easyui-window" title="开销户电子登记簿编辑" data-options="modal:true,closed:true,iconCls:'ico_281'"
	style="width:80%;height:500px;">
	<!-- <div class="role_window"> -->
	<form name="editSheet" id="editSheet" action="">
	<div class="role_window">
		<div class="business_ss-dm">
			<div class="business_title">账号：</div>
			<div class="business_input2">
				<input id="accountCode" name="accountCode" disabled="disabled" class="easyui-textbox" data-options="prompt:'请输入账号'"
					style="width:100%;height:24px">
			</div>
			<div class="business_title">客户号：</div>
			<div class="business_input2">
				<input id="custCode" name="custCode"  class="easyui-numberbox"	disabled="disabled"
				data-options="prompt:'请输入客户号',validType:['length[0, 10]']"
				style="width:100%;height:24px">
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">机构号：</div>
			<div class="business_input2">
				<input id="orgCode" class="easyui-textbox" data-options="prompt:'请输入机构号'" disabled="disabled"
					style="width:100%;height:24px">
			</div>
			<div class="business_title">业务编号：</div>
			<div class="business_input2">
				<input id="busiCode" name="busiCode"  class="easyui-numberbox"	disabled="disabled"
				data-options="prompt:'请输入业务编号',validType:['length[0, 4]']"
				style="width:100%;height:24px">
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">科目号：</div>
			<div class="business_input2">
				<input id="itemCode" name="itemCode" class="easyui-textbox"	disabled="disabled"
				data-options="prompt:'请输入科目号',validType:['length[0, 4]']" 
				style="width:100%;height:24px">
			</div>
			<div class="business_title">账户名称：</div>
			<div class="business_input2">
				<input id="accountName" name="accountName" class="easyui-textbox" 
				data-options="prompt:'请输入账户名称',validType:['length[0, 60]']"
					style="width:100%;height:24px">
			</div>
		</div>	
		<div class="business_ss-dm">
			<div class="business_title">账户类型：</div>
			<div class="business_input2">
				<select id="accountType" name="accountType" style="width:100%" disabled="disabled">
					<option value='-1'>
								请选择
							</option>
							<option value='0'>
								基本帐户
							</option>
							<option value='1'>
								一般存款帐户
							</option>
							<option value='2'>
								临时存款帐户
							</option>
							<option value='3'>
								专用存款帐户
							</option>
							<option value='4'>
								结算帐户
							</option>
							<option value='5'>
								资本金
							</option>
							<option value='6'>
								贷款
							</option>
							<option value='7'>
								外债
							</option>
							<option value='8'>
								其他
							</option>
				</select>
			</div>
			<div class="business_title">账户状态：</div>
			<div class="business_input2">
				<select id="status" name="status" style="width:100%" disabled="disabled">
					<option value='-1'>
								请选择
							</option>
							<option value='1'>
								正常
							</option>
							<option value='0'>
								销户
							</option>
				</select>
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">开户日期：</div>
			<div class="business_input2">
				<input id="openDate" name="openDate" class="easyui-datebox" disabled="disabled" data-options="formatter:ww4,parser:w4"
					style="width:100%;height:24px">
			</div>
			<div class="business_title">销户日期：</div>
			<div class="business_input2">
				<input id="closeDate" name="closeDate" class="easyui-datebox" data-options="formatter:ww4,parser:w4"
				style="width:100%;height:24px" disabled="disabled">
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">变更字段：</div>
			<div class="business_input2">
				<input class="easyui-combobox" id="changeItem" name="changeItem" style="width:100%"  data-options="editable:false,multiple:true,panelHeight:'auto',textField: 'label',valueField:'value',
					data: [{
						label: '变更印鉴或公章',
						value: '0'
					},{
						label: '变更法人，不变更印鉴',
						value: '1'
					},{
						label: '变更网银管理',
						value: '2'
					},{
						label: '变更账户性质',
						value: '3'
					},{
						label: '变更注册资金及经营范围',
						value: '4'
					},{
						label: '其他变更',
						value: '5'
					}]" />
			</div>
			<div class="business_title">变更时间：</div>
			<div class="business_input2">
				<input id="changeTime" name="changeTim" class="easyui-datebox" data-options="formatter:ww4,parser:w4"
				style="width:100%;height:24px">
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">转久悬户日期：</div>
			<div class="business_input2">
				<input id="turnHangTime" name="turnHangTime" class="easyui-datebox" data-options="formatter:ww4,parser:w4"
				style="width:100%;height:24px">
			</div>
			<div class="business_title">办公电话(座机)：</div>
			<div class="business_input2">
				<input id="telCode" name="telCode" class="easyui-textbox" 
				data-options="prompt:'请输入办公电话(座机)',validType:['length[0, 60]']"
					style="width:100%;height:24px">
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">邮编：</div>
			<div class="business_input2">
				<input id="postCode" name="postCode" class="easyui-textbox" 
				data-options="prompt:'请输入邮编',validType:['length[0, 60]']"
					style="width:100%;height:24px">
			</div>
			<div class="business_title">联系人：</div>
			<div class="business_input2">
				<input id="linkMan" name="linkMan" class="easyui-textbox"	
				data-options="prompt:'请输入联系人',validType:['length[0, 60]']" 
				style="width:100%;height:24px">
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">注册号(执照编号)：</div>
			<div class="business_input2">
				<input id="licenseNo" name="licenseNo" class="easyui-textbox" 
				data-options="prompt:'请输入注册号(执照编号)',validType:['length[0, 60]']"
					style="width:100%;height:24px">
			</div>
			<div class="business_title">证件号码：</div>
			<div class="business_input2">
				<input id="idNumber" name="idNumber" class="easyui-textbox"	
				data-options="prompt:'请输入证件号码',validType:['length[0, 60]']" 
				style="width:100%;height:24px">
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">法人姓名：</div>
			<div class="business_input2">
				<input id="legalPerson" name="legalPerson" class="easyui-textbox" data-options="prompt:'请输入法人姓名'" style="width:100%;height:24px">
			</div>
			<div class="business_title">财务主管：</div>
			<div class="business_input2">
				<input id="firstMoneyMan" name="firstMoneyMan" class="easyui-textbox"	
				data-options="prompt:'请输入财务主管'"  style="width:100%;height:24px">
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">法人身份证有效期：</div>
			<div class="business_input2">
				<input id="idValidDate" name="idValidDate" class="easyui-textbox"
				data-options="prompt:'请输入法人身份证有效期',validType:['length[0, 60]']" 
				style="width:100%;height:24px">
			</div>
			<div class="business_title">注册地址：</div>
			<div class="business_input2">
				<input id="registAddress" name="registAddress" class="easyui-textbox" 
				data-options="prompt:'请输入注册地址',validType:['length[0, 60]']"
					style="width:100%;height:24px">
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">营业执照开始日期：</div>
			<div class="business_input2">
				<input id="licenseStartDate" name="licenseStartDate" class="easyui-textbox"
				 data-options="prompt:'请输入营业执照开始日期',validType:['length[0, 60]']"
					style="width:100%;height:24px">
			</div>
			<div class="business_title">营业执照截止日期：</div>
			<div class="business_input2">
				<input id="licenseEndDate" name="licenseEndDate" class="easyui-textbox"
					data-options="prompt:'请输入营业执照截止日期',validType:['length[0, 60]']" 
				style="width:100%;height:24px">
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">营业执照年检日期：</div>
			<div class="business_input2">
				<input id="licenseCheckDate" name="licenseCheckDate" class="easyui-textbox"
				 data-options="prompt:'请输入营业执照年检日期',validType:['length[0, 60]']"
					style="width:100%;height:24px">
			</div>
			<div class="business_title">开户许可证号：</div>
			<div class="business_input2">
				<input id="checkNumber" name="checkNumber" class="easyui-textbox"
				data-options="prompt:'请输入开户许可证号',validType:['length[0, 60]']" 
				style="width:100%;height:24px">
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">代码证编号：</div>
			<div class="business_input2">
				<input id="codeNumber" name="codeNumber" class="easyui-textbox" 
				data-options="prompt:'请输入代码证编号',validType:['length[0, 60]']"
					style="width:100%;height:24px">
			</div>
			<div class="business_title">代码证开始日期：</div>
			<div class="business_input2">
				<input id="codeStartDate" name="codeStartDate" class="easyui-textbox"	
				data-options="prompt:'请输入代码证开始日期',validType:['length[0, 60]']" 
				style="width:100%;height:24px">
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">代码证截止日期：</div>
			<div class="business_input2">
				<input id="codeEndDate" name="codeEndDate" class="easyui-textbox" 
				data-options="prompt:'请输入代码证截止日期',validType:['length[0, 60]']"
					style="width:100%;height:24px">
			</div>
			<div class="business_title">机构信用代码证编号：</div>
			<div class="business_input2">
				<input id="orgNumber" name="orgNumber" class="easyui-textbox" 
				data-options="prompt:'请输入机构信用代码证编号',validType:['length[0, 60]']" 
				style="width:100%;height:24px">
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">机构信用代码证开始日期：</div>
			<div class="business_input2">
				<input id="orgStartDate" name="orgStartDate" class="easyui-textbox" 
				data-options="prompt:'请输入机构信用代码证开始日期',validType:['length[0, 60]']"
					style="width:100%;height:24px">
			</div>
			<div class="business_title">机构信用代码证截止日期：</div>
			<div class="business_input2">
				<input id="orgEndDate" name="orgEndDate" class="easyui-textbox"	
				data-options="prompt:'请输入机构信用代码证截止日期',validType:['length[0, 60]']" 
				style="width:100%;height:24px">
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">代码证年检日期：</div>
			<div class="business_input2">
				<input id="codeCheckDate" name="codeCheckDate" class="easyui-textbox" 
				data-options="prompt:'请输入代码证年检日期',validType:['length[0, 60]']"
					style="width:100%;height:24px">
			</div>
			<div class="business_title">纳税人识别码(国税)：</div>
			<div class="business_input2">
				<input id="countryTax" name="countryTax" class="easyui-textbox"	
				data-options="prompt:'请输入纳税人识别码(国税)',validType:['length[0, 60]']" 
				style="width:100%;height:24px">
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">纳税人识别码(地税)：</div>
			<div class="business_input2">
				<input id="areaTax" name="areaTax" class="easyui-textbox" 
				data-options="prompt:'请输入纳税人识别码(地税)',validType:['length[0, 60]']"
					style="width:100%;height:24px">
			</div>
			<div class="business_title">税务证开始日期：</div>
			<div class="business_input2">
				<input id="taxStartDate" name="taxStartDate" class="easyui-textbox"	
				data-options="prompt:'请输入税务证开始日期',validType:['length[0, 60]']" 
				style="width:100%;height:24px">
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">税务证截止日期：</div>
			<div class="business_input2">
				<input id="taxEndDate" name="taxEndDate" class="easyui-textbox" 
				data-options="prompt:'请输入税务证截止日期',validType:['length[0, 60]']"
					style="width:100%;height:24px">
			</div>
			<div class="business_title">客户经理：</div>
			<div class="business_input2">
				<input id="customerManager" name="customerManager" class="easyui-textbox" 
				data-options="prompt:'请输入客户经理',validType:['length[0, 60]']"
					style="width:100%;height:24px">
			</div>
			
		</div>
		<div class="business_ss-dm">
			<div class="business_title">是否开通公司网银：</div>
			<div class="business_input8">
				<select id="isOnline" name="isOnline" style="width:100%" disabled="disabled" >
							<option value='1'>
								是
							</option>
							<option value='0'>
								否
							</option>
				</select>
			</div>
			<div class="business_title">是否开通网银直通车：</div>
			<div class="business_input8">
				<select id="isOnlineCar" name="isOnlineCar" style="width:100%" disabled="disabled" >
							<option value='1'>
								是
							</option>
							<option value='0'>
								否
							</option>
				</select>
			</div>
			<div class="business_title">是否开通手机银行：</div>
			<div class="business_input8">
				<select id="isMobileBank" name="isMobileBank" style="width:100%">
							<option value='1'>
								是
							</option>
							<option value='0'>
								否
							</option>
				</select>
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">是否开通及时语：</div>
			<div class="business_input8">
				<select id="isMessage" name="isMessage" style="width:100%">
							<option value='1'>
								是
							</option>
							<option value='0'>
								否
							</option>
				</select>
			</div>
			<div class="business_title">是否开通电子缴税：</div>
			<div class="business_input8">
				<select id="isElectronicTax" name="isElectronicTax" style="width:100%">
							<option value='1'>
								是
							</option>
							<option value='0'>
								否
							</option>
				</select>
			</div>
			<div class="business_title">是否开通协议存款：</div>
			<div class="business_input8">
				<select id="isAgreeDeposit" name="isAgreeDeposit" style="width:100%">
							<option value='1'>
								是
							</option>
							<option value='0'>
								否
							</option>
				</select>
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">是否开通理财功能：</div>
			<div class="business_input8">
				<select id="isFinanFunction" name="isFinanFunction" style="width:100%">
							<option value='1'>
								是
							</option>
							<option value='0'>
								否
							</option>
				</select>
			</div>
			<div class="business_title">是否开通支付密码器：</div>
			<div class="business_input8">
				<select id="isPayPassword" name="isPayPassword" style="width:100%">
							<option value='1'>
								是
							</option>
							<option value='0'>
								否
							</option>
				</select>
			</div>
			<div class="business_title">是否开通第三方存管：</div>
			<div class="business_input8">
				<select id="isThreeDeposit" name="isThreeDeposit" style="width:100%">
							<option value='1'>
								是
							</option>
							<option value='0'>
								否
							</option>
				</select>
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">是否开通利多多功能：</div>
			<div class="business_input8">
				<select id="isBehalfFunction" name="isBehalfFunction" style="width:100%">
							<option value='1'>
								是
							</option>
							<option value='0'>
								否
							</option>
				</select>
			</div>
			<div class="business_title">是否开通回单柜功能：</div>
			<div class="business_input8">
				<select id="isAtcFunction" name="isAtcFunction" style="width:100%">
							<option value='1'>
								是
							</option>
							<option value='0'>
								否
							</option>
				</select>
			</div>
			<div class="business_title">是否开通电子商业汇票：</div>
			<div class="business_input8">
				<select id="isElectronicDraft" name="isElectronicDraft" style="width:100%">
							<option value='1'>
								是
							</option>
							<option value='0'>
								否
							</option>
				</select>
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">是否开通现金支取计划：</div>
			<div class="business_input8">
				<select id="isCrashPlan" name="isCrashPlan" style="width:100%">
							<option value='1'>
								是
							</option>
							<option value='0'>
								否
							</option>
							
				</select>
			</div>
			<div class="business_title">是否开通综合电子账单：</div>
			<div class="business_input8">
				<select id="isElectronicBill" name="isElectronicBill" style="width:100%">
							<option value='1'>
								是
							</option>
							<option value='0'>
								否
							</option>
				</select>
			</div>
			<div class="business_title">是否开通电子特约商户：</div>
			<div class="business_input8">
				<select id="isElectronicCustomer" name="isElectronicCustomer" style="width:100%">
							<option value='1'>
								是
							</option>
							<option value='0'>
								否
							</option>
				</select>
			</div>
		</div>
		<div class="role_window_button">
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
				style="padding:5px 0px;width:15%; margin-right:10px;" onclick="saveSheet()">
				<span style="font-size:14px;">保存</span>
			</a>
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'ico_086'"
				style="padding:5px 0px;width:15%; margin-right:10px;" onclick="$('#openSheetDiv').window('close');">
				<span style="font-size:14px;">取消</span>
			</a>
		</div>
		</div>	
	<form>
	
</div>
