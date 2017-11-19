<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="santai" uri="/tags/santai"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div id="openBookDiv" class="easyui-window" title="开户管理" data-options="modal:true,closed:true,iconCls:'ico_281'"
	style="width:800px;height:500px;padding:10px;">
	<div class="role_window">
		<div class="business_ss-dm">
			<div class="business_title">电话：</div>
			<div class="business_input2">
				<input id="mobileCode" class="easyui-textbox" data-options="prompt:'请输入电话'"
					style="width:100%;height:24px">
			</div>
			<div class="business_title">地区代码：</div>
			<div class="business_input2">
				<input id="areaCode" class="easyui-textbox"
					style="width:100%;height:24px">
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">营业执照注册地址：</div>
			<div class="business_input3">
				<input id="registAddress" class="easyui-textbox" data-options="prompt:'请输入营业执照注册地址'"
					style="width:100%;height:24px">
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">实际办公地址：</div>
			<div class="business_input3">
				<input id="officeAddress" class="easyui-textbox" data-options="prompt:'请输入营业执照注册地址'"
					style="width:100%;height:24px">
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">存款人类别：</div>
			<div class="business_input2">
				<select id="linkManType" class="easyui-combobox" name="" style="width:100%"
					data-options="panelHeight:'auto'">
					<option value="0">法定代表人</option>
					<option value="1">单位负责人</option>
				</select>
			</div>
			<div class="business_title">证明文件类型：</div>
			<div class="business_input2">
				<input id="fileType" class="easyui-textbox" data-options="prompt:'请输入机构名称'"
					style="width:100%;height:24px">
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">姓名：</div>
			<div class="business_input3">
				<input id="linkMan" class="easyui-textbox" data-options="prompt:'请输入营业执照注册地址'"
					style="width:100%;height:24px">
			</div>
		</div>
		<div class="business_ss-dm">
			<div class="business_title">证件种类：</div>
			<div class="business_input2">
				<select id="idType" class="easyui-combobox" name="" style="width:100%"
					data-options="panelHeight:'auto'">
					<option value="1">身份证</option>
					<option value="2">临时身份证</option>
					<option value="3">护照</option>
				</select>
			</div>
			<div class="business_title">证件号码：</div>
			<div class="business_input2">
				<input id="idNumber" class="easyui-textbox" data-options="prompt:'请输入机构号'"
					style="width:100%;height:24px">
			</div>
			<div class="business_input2" style="display:none">
				<input id="orgCode" class="easyui-textbox" value='<s:property value="orgCode" />'  />
				<input id="handleStatus" class="easyui-textbox" value='' style="display:none" />
				<input id="activeId" class="easyui-textbox" value='' style="display:none" />
			</div>
		</div>
		<div class="role_window_button">
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
				style="padding:5px 0px;width:15%; margin-right:10px;" onclick="saveBook()">
				<span style="font-size:14px;">保存</span>
			</a>
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-print'"
				style="padding:5px 0px;width:15%; margin-right:10px;" onclick="printToBook()">
				<span style="font-size:14px;">打印</span>
			</a>
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'ico_086'"
				style="padding:5px 0px;width:15%; margin-right:10px;">
				<span style="font-size:14px;">取消</span>
			</a>
		</div>
		<div id="recordDiv" class="easyui-window" title="开户管理" data-options="modal:true,closed:true,iconCls:'ico_171'"
			style="width:400px;height:200px;padding:10px;">
			<div class="role_window">
				<div class="accounts_management">已经成功保存，请备案</div>
				<div class="accounts_managemen_center">
					<div class="accounts_managemen_title">开户银行名称：</div>
					<div class="business_input5">
						<input id="openBankName" class="easyui-textbox" data-options="prompt:'请输入机构号'"
							style="width:100%;height:24px">
					</div>
				</div>
				<div class="accounts_managemen_center">
					<div class="accounts_managemen_title">基本存款帐户开户许可证核准号：</div>
					<div class="business_input5">
						<input id="checkNumber" class="easyui-textbox" data-options="prompt:'请输入机构号'"
							style="width:100%;height:24px">
					</div>
				</div>
				<div class="accounts_managemen_center">
					<div class="accounts_managemen_title">开户银行代码：</div>
					<div class="business_input5">
						<input id="openBankCode" class="easyui-textbox" data-options="prompt:'请输入机构号'"
							style="width:100%;height:24px">
					</div>
				</div>
				<div class="role_window_button">
					<a href="javascript:void(0)" target="role" class="easyui-linkbutton" data-options="iconCls:'ico_287'"
						style="padding:3px 0px;width:20%; margin-right:10px;">
						<span style="font-size:14px;" onclick="saveBook()">备案</span>
					</a>
					<a href="javascript:void(0)" target="role" class="easyui-linkbutton" data-options="iconCls:'ico_086'"
						style="padding:3px 0px;width:20%; margin-right:10px;">
						<span style="font-size:14px;">取消</span>
					</a>
				</div>
			</div>
		</div>
	</div>
</div>