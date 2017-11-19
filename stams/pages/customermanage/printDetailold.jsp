<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div id="printOpneBookDiv" class="easyui-window" title="开户申请书" data-options="modal:true,closed:true,iconCls:'ico_281'"
			style="width:80%;height:75%;">
	<!--第一个表格开始 -->
	<div id="depositorName"></div><!-- 存款人名称 -->
	<div id="mobileCode"></div><!-- 电话 -->
	<div id="registAddress"></div><!-- 营业执照注册地址 -->
	<div id="postCode"></div><!-- 邮编 -->
	<div id="officeAddress"></div><!-- 实际办公地址 -->
	<div id="postCodeNews"></div><!-- 邮编 -->
	<div id="peopleType"></div><!-- 存款人类别 -->
	<div id="orgInstitCd"></div><!-- 组织机构代码 -->
	<div id="orgInstitEndDate"></div><!-- 组织机构代码到期日 -->
	<div id="linkManType"></div><!-- 人员类别 -->
	<div id="linkMan"></div><!-- 姓名 -->
	<div id="idType"></div><!-- 证件种类 -->
	<div id="idNumber"></div><!-- 证件号码 -->
	<div id="linkIdEndDate"></div><!-- 证件到期日 -->
	<div id="accountCategory"></div><!-- 行业分类 -->
	<div id="registMoney"></div><!-- 注册资金及币种 -->
	<div id="areaCode"></div><!-- 地区代码 -->
	<div id="busiScope"></div><!-- 经营范围 -->
	<div id="fileType"></div><!-- 证明文件类型 -->
	<div id="fileNumber"></div><!-- 证明文件编码 -->
	<div id="fileEndDate"></div><!-- 证明文件到期日 -->
	<div id="fileTypeSecond"></div><!-- 证明文件类型2 -->
	<div id="fileNumberSecond"></div><!-- 证明文件编码2 -->
	<div id="fileEndDateSecond"></div><!-- 证明文件到期日2 -->
	<div id="countryTax"></div><!-- 税务登记证（国税）编号 -->
	<div id="areaTax"></div><!-- 税务登记证（地税）编号 -->
	<div id="accountType"></div><!-- 账户性质 -->
	<div id="coinType"></div><!-- 资金性质 -->
	<div id="year"></div><!-- 有效期-年 -->
	<div id="month"></div><!-- 有效期-月 -->
	<div id="day"></div><!-- 有效期-日 -->
	<!-- 第一个表格结束 -->
	<!-- 第二个表格开始 -->
	<div id="printChargeDiv">
		<div id="unitName"></div><!-- 上级法人或主管单位信息 -->
		<div id="checkNumber"></div><!-- 许可证核准号 -->
		<div id="orgInstitCd"></div><!-- 组织机构代码 -->
		<div id="linkManType"></div><!-- 人员类别 -->
		<div id="linkMan"></div><!-- 姓名 -->
		<div id="idType"></div><!-- 证件种类 -->
		<div id="idNumber"></div><!-- 证件号码 -->
		<div id="idEndDate"></div><!-- 证件到期日 -->
	</div>
	<!-- 第二个表格结束 -->
	<!-- 第三个表格开始 -->
	<div id="openBankName"></div><!-- 开户银行名称-->
	<div id="openBankCode"></div><!-- 开户银行代码 -->
	<div id="accountName"></div><!-- 账户名称 -->
	<div id="accountCode"></div><!-- 账号 -->
	<div id="checkNumber"></div><!-- 开户许可证核准号 -->
	<div id="openDate"></div><!-- 开户日期-->
	<!-- 第三个表格结束 -->
	<!-- 客户附加信息开始 -->
	<div id='accountEnName'></div><!--存款人英文名称-->
	<div id='faxCode'></div><!--传真号码-->
	<div id='companyType'></div><!--企业类型-->
	<div id='peopleSonType'></div><!--客户子类型-->
	<div id='busiType'></div><!--行业代码-->
	<div id='registDate'></div><!--注册日期：-->
	<div id='email'></div><!--电子邮件地址-->
	<div id='controlPerson'></div><!--实际控制人姓名-->
	<div id='idTypeControl'></div><!--实际控制人证件种类-->
	<div id='endDateControl'></div><!--实际控制人证件到期日-->
	<div id='idNoControl'></div><!--实际控制人证件号码-->
	<div id='applyMoney'></div><!--单位申请现金库存限额（3-4天零星备用金）-->
	<div id='passMoney'></div><!--银行批准库存限额-->
	<!-- 客户附加信息结束      财务负责人、控股股东、联系人都在客户对公信息、关联股东信息中-->
	<!-- 关联企业、股东信息 -->
	<div id="printRelationDiv">
		<div id='relationCompany'></div><!--关联企业信息    关联企业名称,法定代表人,组织机构代码,是否为控股股东 多个用“||”间隔-->
        <div id='relationPartner'></div><!--关联股东信息    开户银行留存股东姓名,证件种类,证件号码,是否为控股股东,证件到期日  多个用“||”间隔-->
        <div id='inputDate'></div><!--填表日期-->
	</div>
	<!-- 对公客户信息 -->
	<div id="printClintDiv">
		<div id='name'></div><!-- 客户名称 -->
		<div id='companyName'></div><!--公司名称-->
        <div id='registAddress'></div><!--注册地址-->
        <div id='postCodeRegist'></div><!--注册地址邮编-->
        <div id='officeAddress'></div><!--办公/通讯地址-->
        <div id='postCodeOffice'></div><!--办公/通讯地址邮编-->
        <div id='busiScope'></div><!--经营范围-->
        <div id='registMoney'></div><!--注册资本货币和金额-->
        <div id='officeTel'></div><!--办公电话（含区号）-->
        <div id='idNoOrg'></div><!--组织机构代码证件号码-->
        <div id='endDateOrg'></div><!--组织机构代码证件到期日-->
        <div id='idNoLicense'></div><!--营业执照证件号码-->
        <div id='endDateLicense'></div><!--营业执照证件到期日-->
        <div id='idNoTax'></div><!--税务登记证（地）-->
        <div id='idNoCountry'></div><!--税务登记证（国）-->
        <div id='endDateCountry'></div><!--税务登记证（国） 到期日-->
        <div id='endDateTax'></div><!--税务登记证（地） 到期日-->
        <div id='idNoCredit'></div><!--统一社会信用代码-->
        <div id='endDateCredit'></div><!--统一社会信用代码 到期日-->
        <div id='otherIdName'></div><!--其他证明文件名称-->
        <div id='idNoOther'></div><!--其他证明文件证件号码-->
        <div id='endDateOther'></div><!--其他证明文件证件到期日-->
        <div id='legalRepresentSurname'></div><!--法定代表人 姓-->
        <div id='legalRepresentName'></div><!--法定代表人 名-->
        <div id='idTypeLegal'></div><!--法定代表人 证件名称-->
        <div id='idNoLegal'></div><!--法定代表人 证件号码-->
        <div id='endDateLegal'></div><!--法定代表人 证件到期日或有效期-->
        <div id='nationalLegal'></div><!--法定代表人国籍-->
        <div id='birthDateLegal'></div><!--法定代表人出生日期-->
        <div id='busiCountry'></div><!--主要营业国家或地区-->
        <div id='publicCompany'></div><!--是否上市公司-->
        <div id='numEmp'></div><!--从业人数-->
        <div id='createDate'></div><!--创建日期-->
        <div id='accountCategory'></div><!--行业分类-->
        <div id='salesVolume'></div><!--年销售币种及销售额-->
        <div id='overseasAffiliate'></div><!--主要海外分支机构所在国家或地区-->
        <div id='overseasCust'></div><!--主要海外客户所在地-->
        <div id='highSeasons'></div><!--商业活动旺季（可多选）-->
        <div id='otherBusi'></div><!--其他业务-->
        <div id='otherContact'></div><!--其他联系方式（移动电话/电子邮件/传真等）-->
        <div id='moneyManSurname'></div><!--财务负责人  姓-->
        <div id='moneyManName'></div><!--财务负责人  名-->
        <div id='nationalMoney'></div><!--国籍-->
        <div id='birthDateMoney'></div><!--出生日期（年月日）-->
        <div id='idNameMoney'></div><!--证件名称-->
        <div id='idNoMoney'></div><!--证件号码-->
        <div id='endDateMoney'></div><!--证件到期日或有效期-->
        <div id='contactManSurname'></div><!--联系人  姓-->
        <div id='contactManName'></div><!--联系人  名-->
        <div id='nationalContact'></div><!--国籍-->
        <div id='birthDateContact'></div><!--出生日期（年月日）-->
        <div id='telContact'></div><!--联系电话-->
        <div id='emailContact'></div><!--电子邮件-->
        <div id='agentManSurname'></div><!--代办人  姓-->
        <div id='agentManName'></div><!--代办人  名-->
        <div id='nationalAgent'></div><!--国籍-->
        <div id='idNameAgent'></div><!--证件名称-->
        <div id='idNoAgent'></div><!--证件号码-->
        <div id='endDateAgent'></div><!--证件到期日或有效期-->
        <div id='partner'></div><!--主要股东   多个信息由，隔开，多条记录用||隔开-->
        <div id='beneficiary'></div><!--受益权人    多个信息由，隔开，多条记录用||隔开-->
	</div>
	<!-- 对公客户信息结束 -->
	<!-- 结算证（IC卡）开始 -->
	<div id="printCardDiv">
        <div id='userName'></div><!--持证（卡）人姓名-->	
        <div id='idNo'></div><!--身份证号码-->	
        <div id='companyCode'></div><!--单位账号-->	
        <div id='cardType'></div><!--结算证类型   主卡、副卡-->
        <!-- <div id='firstUserName'></div>姓名  主证（卡）持有人 = 持卡人
        <div id='firstUserId'></div>身份证号	 -->
        <div id='secondUserName'></div><!--姓名  副证（卡）持有人-->	
        <div id='secondUserId'></div><!--身份证号-->	
	</div>
	<!--  结算证（IC卡）结束 -->
	<!-- 结算账户相关业务授权开始 -->
	<div id="printAuthorizeDiv">
		<div id='authorizeCount'></div><!--授权总人数-->
        <div id='authorizePeople'></div><!--被授权人信息（姓名，证件类型，证件号码，联系电话，授权办理业务种类，业务项目数量（中文大写数字））    多个信息由，隔开，多条记录用||隔开-->
        <div id='authorizeContent'></div><!--授权业务  多个信息由，隔开-->
	</div>
	<!-- 结算账户相关业务授权结束 -->
	<!-- 开立专用、临时存款账户申请信息开始-->
	<div id="printShortDiv">
		<div id='departName'></div><!--内设机构（部门）名称-->
        <div id='departTel'></div><!--内设机构（部门）电话-->
        <div id='departAddress'></div><!--内设机构（部门）地址-->
        <div id='departPostCode'></div><!--内设机构（部门）邮编-->
        <div id='principleName'></div><!--姓名-->
        <div id='idEndDate'></div><!--证件到期日-->
        <div id='idType'></div><!--证件种类-->
        <div id='idNo'></div><!--证件号码-->
        <div id='type'></div><!--数据类型  1：专用存款账户 2：临时存款账户-->
	</div>
	<!-- 开立专用、临时存款账户申请信息结束-->
</div>
<script language="javascript" type="text/javascript">
	var LODOP; //声明为全局变量 
	function prn_print() {
		
		CreateOneFormPage();	
		//LODOP.PRINT();
		LODOP.PREVIEW();
		alert("打印成功！！！");
	};
	function CreateOneFormPage(){
		LODOP=getLodop();
		LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",8);
		//LODOP.SET_PRINT_STYLE("Bold",1);
		//LODOP.ADD_PRINT_TEXT(50,231,260,39,"打印页面部分内容");
		/* 第一个表格开始  */
 		LODOP.ADD_PRINT_HTM(155,205,450,60,$("#printOpneBookDiv #depositorName").text());/* 存款人名称 */
		LODOP.ADD_PRINT_HTM(155,610,450,60,$("#printOpneBookDiv #mobileCode").text());/*  电话 */
		LODOP.ADD_PRINT_HTM(178,205,450,60,$("#printOpneBookDiv #registAddress").text().replace(",",""));/*  营业执照注册地址   包含了国家省市区“，”隔开 */
		LODOP.ADD_PRINT_HTM(178,610,450,60,$("#printOpneBookDiv #postCode").text());/*  邮编 */
		LODOP.ADD_PRINT_HTM(178,432,450,60,$("#printOpneBookDiv #officeAddress").text().replace(",",""));/*  实际办公地址 */
		LODOP.ADD_PRINT_HTM(178,610,450,60,$("#printOpneBookDiv #postCodeNews").text());/*  邮编 */
		LODOP.ADD_PRINT_HTM(178,610,450,60,$("#printOpneBookDiv #peopleType").text());/*  存款人类别 */
		LODOP.ADD_PRINT_HTM(178,610,450,60,$("#printOpneBookDiv #orgInstitEndCd").text());/*  组织机构代码 */
		LODOP.ADD_PRINT_HTM(178,610,450,60,$("#printOpneBookDiv #orgInstitEndDate").text());/*  组织机构代码到期日 */
		var linkManType = $("#printOpneBookDiv #linkManType").text();/*  人员类别 */
		if(linkManType != null && linkManType != "" && linkManType != undefined){
			if(linkManType == 1){				
				LODOP.ADD_PRINT_HTM(231,167,450,60,"√");/*  人员类别打钩 */
			}else{
				LODOP.ADD_PRINT_HTM(256,167,450,60,"√");/* 人员类别打钩 */
			}
		}		
		LODOP.ADD_PRINT_HTM(228,320,450,60,$("#printOpneBookDiv #linkMan").text());/* 姓名 */
		LODOP.ADD_PRINT_HTM(228,320,450,60,$("#printOpneBookDiv #linkIdEndDate").text());/* 证件到期日 */
		var idType = $("#printOpneBookDiv #idType").text();/* 证件种类 */
		if(idType != null && idType != "" && idType != undefined){
			if(idType==1){
				LODOP.ADD_PRINT_HTM(253,320,450,60,"居民身份证");
			}else if(idType==2){
				LODOP.ADD_PRINT_HTM(253,320,450,60,"临时身份证");
			}else if(idType==3){
				LODOP.ADD_PRINT_HTM(253,320,450,60,"护照");
			}else if(idType==4){
				LODOP.ADD_PRINT_HTM(253,320,450,60,"户口簿");
			}else if(idType==5){
				LODOP.ADD_PRINT_HTM(253,320,450,60,"军人身份证件");
			}else if(idType==6){
				LODOP.ADD_PRINT_HTM(253,320,450,60,"武装警察身份证件");
			}else if(idType==7){
				LODOP.ADD_PRINT_HTM(253,320,450,60,"港澳居民往来内地通行证");
			}else if(idType==8){
				LODOP.ADD_PRINT_HTM(253,320,450,60,"外交人员身份证");
			}else if(idType==9){
				LODOP.ADD_PRINT_HTM(253,320,450,60,"外国人居留许可证");
			}else if(idType==10){
				LODOP.ADD_PRINT_HTM(253,320,450,60,"边民出入境通行证");
			}else if(idType==11){
				LODOP.ADD_PRINT_HTM(253,320,450,60,"其它");
			}
		}
		LODOP.ADD_PRINT_HTM(253,488,450,60,$("#printOpneBookDiv #idNumber").text());/* 证件号码 */ 
		var accountCategory = $("#printOpneBookDiv #accountCategory").text();/* 行业分类 */
		if(accountCategory != null && accountCategory != "" && accountCategory != undefined){
			if(accountCategory == "A"){
				LODOP.ADD_PRINT_HTM(279,248,450,60,"√");
			}else if(accountCategory == "B"){
				LODOP.ADD_PRINT_HTM(279,290,450,60,"√");
			}else if(accountCategory == "C"){
				LODOP.ADD_PRINT_HTM(279,332,450,60,"√");
			}else if(accountCategory == "D"){
				LODOP.ADD_PRINT_HTM(279,374,450,60,"√");
			}else if(accountCategory == "E"){
				LODOP.ADD_PRINT_HTM(279,416,450,60,"√");
			}else if(accountCategory == "F"){
				LODOP.ADD_PRINT_HTM(279,458,450,60,"√");
			}else if(accountCategory == "G"){
				LODOP.ADD_PRINT_HTM(279,500,450,60,"√");
			}else if(accountCategory == "H"){
				LODOP.ADD_PRINT_HTM(279,542,450,60,"√");
			}else if(accountCategory == "I"){
				LODOP.ADD_PRINT_HTM(279,584,450,60,"√");
			}else if(accountCategory == "J"){
				LODOP.ADD_PRINT_HTM(279,626,450,60,"√");
			}else if(accountCategory == "K"){
				LODOP.ADD_PRINT_HTM(298,248,450,60,"√");
			}else if(accountCategory == "L"){
				LODOP.ADD_PRINT_HTM(298,290,450,60,"√");
			}else if(accountCategory == "M"){
				LODOP.ADD_PRINT_HTM(298,332,450,60,"√");
			}else if(accountCategory == "N"){
				LODOP.ADD_PRINT_HTM(298,374,450,60,"√");
			}else if(accountCategory == "O"){
				LODOP.ADD_PRINT_HTM(298,416,450,60,"√");
			}else if(accountCategory == "P"){
				LODOP.ADD_PRINT_HTM(298,458,450,60,"√");
			}else if(accountCategory == "Q"){
				LODOP.ADD_PRINT_HTM(298,500,450,60,"√");
			}else if(accountCategory == "R"){
				LODOP.ADD_PRINT_HTM(298,542,450,60,"√");
			}else if(accountCategory == "S"){
				LODOP.ADD_PRINT_HTM(298,584,450,60,"√");
			}else if(accountCategory == "T"){
				LODOP.ADD_PRINT_HTM(298,626,450,60,"√");
			}
		}
		LODOP.ADD_PRINT_HTM(322,205,450,60,$("#printOpneBookDiv #registMoney").text());/* 注册资金及币种 */
		LODOP.ADD_PRINT_HTM(322,488,450,60,$("#printOpneBookDiv #areaCode").text());/* 地区代码 */
		LODOP.ADD_PRINT_HTM(347,205,"80%","80%",$("#printOpneBookDiv #busiScope").text());/* 经营范围 */
		LODOP.ADD_PRINT_HTM(372,488,450,60,$("#printOpneBookDiv #fileType").text());/* 证明文件类型*/
		LODOP.ADD_PRINT_HTM(372,488,450,60,$("#printOpneBookDiv #fileNumber").text());/* 证明文件编码 */
		LODOP.ADD_PRINT_HTM(372,488,450,60,$("#printOpneBookDiv #fileEndDate").text());/* 证明文件到期日 */
		LODOP.ADD_PRINT_HTM(372,488,450,60,$("#printOpneBookDiv #fileTypeSecond").text());/* 证明文件类型2 */
		LODOP.ADD_PRINT_HTM(372,488,450,60,$("#printOpneBookDiv #fileNumberSecond").text());/* 证明文件编码2 */
		LODOP.ADD_PRINT_HTM(372,488,450,60,$("#printOpneBookDiv #fileEndDateSecond").text());/* 证明文件到期日2 */
		LODOP.ADD_PRINT_HTM(422,320,450,60,$("#printOpneBookDiv #areaTax").text());/* 税务登记证（地税）编号*/
		LODOP.ADD_PRINT_HTM(422,320,450,60,$("#printOpneBookDiv #countryTax").text());/* 税务登记证（国税）编号*/
		var accountType = $("#printOpneBookDiv #accountType").text();/* 账户性质 */
		if(accountType != null && accountType != "" && accountType != undefined){
			if(accountType == 0){
				LODOP.ADD_PRINT_HTM(473,300,450,60,"√");
			}else if(accountType == 1){
				LODOP.ADD_PRINT_HTM(473,398,450,60,"√");
			}else if(accountType == 2){
				LODOP.ADD_PRINT_HTM(473,496,450,60,"√");
			}else if(accountType == 3){
				LODOP.ADD_PRINT_HTM(473,594,450,60,"√");
			}
		}
		LODOP.ADD_PRINT_HTM(497,205,450,60,$("#printOpneBookDiv #coinType").text());/* 资金性质  */
		LODOP.ADD_PRINT_HTM(497,528,450,60,$("#printOpneBookDiv #year").text());/* 有效期-年 */
		LODOP.ADD_PRINT_HTM(497,600,450,60,$("#printOpneBookDiv #month").text());/* 有效期-月  */
		LODOP.ADD_PRINT_HTM(497,638,450,60,$("#printOpneBookDiv #day").text());/* 有效期-日 */
		
		/* 第一个表格结束 */
		/* 第二个表格开始 */
		LODOP.ADD_PRINT_HTM(633,301,450,60,$("#printChargeDiv #unitName").text());/* 上级法人或主管单位信息 */
		LODOP.ADD_PRINT_HTM(661,301,450,60,$("#printChargeDiv #checkNumber").text());/* 许可证核准号 */
		LODOP.ADD_PRINT_HTM(661,582,450,60,$("#printChargeDiv #orgInstitCd").text());/* 组织机构代码 */
		var linkManType = $("#printChargeDiv #linkManType").text();/*  人员类别 */
		if(linkManType != null && linkManType != "" && linkManType != undefined){
			if(linkManType == 1){				
				LODOP.ADD_PRINT_HTM(231,167,450,60,"√");/*  人员类别打钩 */
			}else{
				LODOP.ADD_PRINT_HTM(256,167,450,60,"√");/* 人员类别打钩 */
			}
		}	
		LODOP.ADD_PRINT_HTM(689,301,450,60,$("#printChargeDiv #linkMan").text());/* 法定代表人姓名 */
		LODOP.ADD_PRINT_HTM(228,320,450,60,$("#printChargeDiv #linkIdEndDate").text());/* 证件到期日 */
		var idType = $("#printChargeDiv #idType").text();/* 证件种类 */
		if(idType != null && idType != "" && idType != undefined){
			if(idType==1){
				LODOP.ADD_PRINT_HTM(253,320,450,60,"居民身份证");
			}else if(idType==2){
				LODOP.ADD_PRINT_HTM(253,320,450,60,"临时身份证");
			}else if(idType==3){
				LODOP.ADD_PRINT_HTM(253,320,450,60,"护照");
			}else if(idType==4){
				LODOP.ADD_PRINT_HTM(253,320,450,60,"户口簿");
			}else if(idType==5){
				LODOP.ADD_PRINT_HTM(253,320,450,60,"军人身份证件");
			}else if(idType==6){
				LODOP.ADD_PRINT_HTM(253,320,450,60,"武装警察身份证件");
			}else if(idType==7){
				LODOP.ADD_PRINT_HTM(253,320,450,60,"港澳居民往来内地通行证");
			}else if(idType==8){
				LODOP.ADD_PRINT_HTM(253,320,450,60,"外交人员身份证");
			}else if(idType==9){
				LODOP.ADD_PRINT_HTM(253,320,450,60,"外国人居留许可证");
			}else if(idType==10){
				LODOP.ADD_PRINT_HTM(253,320,450,60,"边民出入境通行证");
			}else if(idType==11){
				LODOP.ADD_PRINT_HTM(253,320,450,60,"其它");
			}
		}
		LODOP.ADD_PRINT_HTM(717,488,450,60,$("#printChargeDiv #idNumber").text());/* 证件号码 */
		/* 第二个表格结束*/
		/* 第三个表格开始*/
		LODOP.ADD_PRINT_HTM(779,248,450,60,$("#printOpneBookDiv #openBankName").text());/* 开户银行名称 */
		LODOP.ADD_PRINT_HTM(779,488,450,60,$("#printOpneBookDiv #openBankCode").text());/* 开户银行代码 */
		LODOP.ADD_PRINT_HTM(807,248,450,60,$("#printOpneBookDiv #accountName").text());/* 账户名称 */
		LODOP.ADD_PRINT_HTM(807,488,450,60,$("#printOpneBookDiv #accountCode").text());/* 账号*/
		LODOP.ADD_PRINT_HTM(835,301,450,60,$("#printOpneBookDiv #checkNumber").text());/* 开户许可证核准号 */
		LODOP.ADD_PRINT_HTM(835,582,450,60,$("#printOpneBookDiv #openDate").text());/* 开户日期 */
		/* 第三个表格结束 */
		
		/*客户附加信息  */
		LODOP.ADD_PRINT_HTM(779,248,450,60,$("#printOpneBookDiv #accountEnName").text());/* 存款人英文名称 */
		LODOP.ADD_PRINT_HTM(779,488,450,60,$("#printOpneBookDiv #faxCode").text());/* 传真号码 */
		LODOP.ADD_PRINT_HTM(807,248,450,60,$("#printOpneBookDiv #accountName").text());/* 企业类型 */
		LODOP.ADD_PRINT_HTM(807,488,450,60,$("#printOpneBookDiv #peopleSonType").text());/* 客户子类型*/
		LODOP.ADD_PRINT_HTM(835,301,450,60,$("#printOpneBookDiv #busiType").text());/* 行业代码 */
		LODOP.ADD_PRINT_HTM(835,582,450,60,$("#printOpneBookDiv #registDate").text());/* 注册日期 */
		LODOP.ADD_PRINT_HTM(779,248,450,60,$("#printOpneBookDiv #email").text());/* 电子邮件地址 */
		
		LODOP.ADD_PRINT_HTM(779,248,450,60,$("#printClintDiv #moneyManSurname").text()+$("#printClintDiv #moneyManName").text());/* 对公客户信息 里 财务负责人 */
		LODOP.ADD_PRINT_HTM(779,248,450,60,$("#printClintDiv #idNameMoney").text());/* 对公客户信息 里 财务负责人证件种类 */
		LODOP.ADD_PRINT_HTM(779,248,450,60,$("#printClintDiv #endDateMoney").text());/* 对公客户信息 里 财务负责人证件到期日 */
		LODOP.ADD_PRINT_HTM(835,301,450,60,$("#printClintDiv #idNoMoney").text());/* 对公客户信息 里 财务负责人证件号码 */
		
		var vPartner = $("#printClintDiv #partner").text().split("||")[0];
		if(vPartner != null && vPartner != "" && vPartner != undefined){
			var partner = vPartner.split(",");
			LODOP.ADD_PRINT_HTM(779,488,450,60,partner[0]);/* 对公客户信息 里 第一个股东姓名 */
			LODOP.ADD_PRINT_HTM(807,248,450,60,partner[1]);/* 对公客户信息 里 第一个股东证件种类 */
			LODOP.ADD_PRINT_HTM(807,488,450,60,partner[2]);/*对公客户信息 里 第一个股东证件到期日*/
			LODOP.ADD_PRINT_HTM(835,301,450,60,partner[3]);/* 对公客户信息 里 第一个股东证件号码 */
		}
		LODOP.ADD_PRINT_HTM(835,301,450,60,$("#printClintDiv #contactManSurname").text()+$("#printClintDiv #contactManName").text());/* 对公客户信息 里 联系人姓名 */
		LODOP.ADD_PRINT_HTM(835,301,450,60,$("#printClintDiv #telContact").text());/* 对公客户信息 里联系人电话 */
		LODOP.ADD_PRINT_HTM(779,488,450,60,$("#printOpneBookDiv #controlPerson").text());/* 实际控制人姓名 */
		LODOP.ADD_PRINT_HTM(807,248,450,60,$("#printOpneBookDiv #idTypeControl").text());/* 实际控制人证件种类 */
		LODOP.ADD_PRINT_HTM(807,488,450,60,$("#printOpneBookDiv #endDateControl").text());/*实际控制人证件到期日*/
		LODOP.ADD_PRINT_HTM(835,301,450,60,$("#printOpneBookDiv #idNoControl").text());/* 实际控制人证件号码 */
		LODOP.ADD_PRINT_HTM(835,582,450,60,$("#printOpneBookDiv #applyMoney").text());/* 单位申请现金库存限额（3-4天零星备用金） */
		LODOP.ADD_PRINT_HTM(835,301,450,60,$("#printOpneBookDiv #passMoney").text());/* 银行批准库存限额 */
	};
	//关联企业 股东
	function CreateSecondFormPage(){
		var vCompany = $("#printRelationDiv #relationCompany").text();
		if(vCompany != null && vCompany != "" && vCompany != undefined){
			var companys = vCompany.split("||");
			for(var i=0; i<companys.length; i++){
				var company = companys[i].split(",");
				//增加行高
				LODOP.ADD_PRINT_HTM(779,488,450,60,company[0]);/* 关联企业 里 关联企业名称 */
				LODOP.ADD_PRINT_HTM(807,248,450,60,company[1]);/* 关联企业 里 法定代表人 */
				LODOP.ADD_PRINT_HTM(807,488,450,60,company[2]);/* 关联企业 里 组织机构代码*/
				LODOP.ADD_PRINT_HTM(835,301,450,60,company[3]);/* 关联企业 里 是否为控股股东 */
			}
		}
		var vPartner = $("#printRelationDiv #relationPartner").text();
		if(vPartner != null && vPartner != "" && vPartner != undefined){
			var partners = vPartner.split("||");
			for(var i=0; i<partners.length; i++){
				var partner = partners[i].split(",");
				//增加行高
				LODOP.ADD_PRINT_HTM(779,488,450,60,partner[0]);/* 关联股东 里 关联股东名称 */
				LODOP.ADD_PRINT_HTM(807,248,450,60,partner[1]);/* 关联股东 里 证件种类 */
				LODOP.ADD_PRINT_HTM(807,488,450,60,partner[2]);/* 关联股东 里 证件号码*/
				LODOP.ADD_PRINT_HTM(835,301,450,60,partner[3]);/* 关联股东 里证件到期日 */
				LODOP.ADD_PRINT_HTM(835,301,450,60,partner[4]);/* 关联股东 里 是否为控股股东 */
			}
		}
	}
	//对公客户信息
	function CreateThirdFormPage(){
        LODOP.ADD_PRINT_HTM(779,248,450,60,$("#printClintDiv #name").text());/* 客户名称 */
        var registAddress = $("#printClintDiv #registAddress").text().split(","); 
		LODOP.ADD_PRINT_HTM(779,488,450,60,registAddress[0]);/* 注册地址 国家 */
		LODOP.ADD_PRINT_HTM(779,488,450,60,registAddress[0]);/* 注册地址 省/自治区/直辖市 */
		LODOP.ADD_PRINT_HTM(779,488,450,60,registAddress[0]);/* 注册地址 市/区 */
		LODOP.ADD_PRINT_HTM(779,488,450,60,registAddress[0]);/* 注册地址 地址 */
		LODOP.ADD_PRINT_HTM(807,248,450,60,$("#printClintDiv #postCodeRegist").text());/* 注册地址 邮编 */
		var officeAddress = $("#printClintDiv #officeAddress").text().split(",");
		LODOP.ADD_PRINT_HTM(779,488,450,60,officeAddress[0]);/* 办公/通讯地址 国家 */
		LODOP.ADD_PRINT_HTM(779,488,450,60,officeAddress[0]);/* 办公/通讯地址 省/自治区/直辖市 */
		LODOP.ADD_PRINT_HTM(779,488,450,60,officeAddress[0]);/* 办公/通讯地址 市/区 */
		LODOP.ADD_PRINT_HTM(779,488,450,60,officeAddress[0]);/* 办公/通讯地址 地址 */
		LODOP.ADD_PRINT_HTM(807,248,450,60,$("#printClintDiv #postCodeOffice").text());/* 办公/通讯地址 邮编 */
		LODOP.ADD_PRINT_HTM(807,248,450,60,$("#printClintDiv #busiScope").text());/* 经营范围 */
		LODOP.ADD_PRINT_HTM(807,488,450,60,$("#printClintDiv #registMoney").text());/*注册资本货币和金额*/
		LODOP.ADD_PRINT_HTM(835,301,450,60,$("#printClintDiv #officeTel").text());/* 办公电话 */
		LODOP.ADD_PRINT_HTM(835,582,450,60,$("#printClintDiv #idNoOrg").text());/* 组织机构代码*/
		LODOP.ADD_PRINT_HTM(779,248,450,60,$("#printClintDiv #endDateOrg").text());/* 证件到期日 */
		LODOP.ADD_PRINT_HTM(835,582,450,60,$("#printClintDiv #idNoLicense").text());/* 营业执照代码*/
		LODOP.ADD_PRINT_HTM(779,248,450,60,$("#printClintDiv #endDateLicense").text());/* 证件到期日 */
		var idNoCountry = $("#printClintDiv #idNoCountry").text();
		if(idNoCountry != null && idNoCountry != "" && idNoCountry != undefined){
			LODOP.ADD_PRINT_HTM(835,582,450,60,idNoCountry);/* 税务登记证（国） */
			LODOP.ADD_PRINT_HTM(779,248,450,60,$("#printClintDiv #endDateCountry").text());/* 证件到期日 */
		}else{
			LODOP.ADD_PRINT_HTM(835,582,450,60,$("#printClintDiv #idNoTax").text());/* 税务登记证（地） */
			LODOP.ADD_PRINT_HTM(779,248,450,60,$("#printClintDiv #endDateTax").text());/* 证件到期日 */
		}
		LODOP.ADD_PRINT_HTM(835,582,450,60,$("#printClintDiv #idNoCredit").text());/* 统一社会信用代码*/
		LODOP.ADD_PRINT_HTM(779,248,450,60,$("#printClintDiv #endDateCredit").text());/* 证件到期日 */
		LODOP.ADD_PRINT_HTM(835,582,450,60,$("#printClintDiv #otherIdName").text());/* 其他证明文件名称*/
		LODOP.ADD_PRINT_HTM(779,248,450,60,$("#printClintDiv #idNoOther").text());/* 其他证明文件证件号码 */
		LODOP.ADD_PRINT_HTM(835,582,450,60,$("#printClintDiv #endDateOther").text());/* 其他证明文件证件到期日*/
		LODOP.ADD_PRINT_HTM(779,248,450,60,$("#printClintDiv #legalRepresentSurname").text());/* 法定代表人 姓 */
		LODOP.ADD_PRINT_HTM(779,248,450,60,$("#printClintDiv #legalRepresentName").text());/* 法定代表人 名 */
		LODOP.ADD_PRINT_HTM(779,248,450,60,$("#printClintDiv #idTypeLegal").text());/* 法定代表人 证件名称  */
		LODOP.ADD_PRINT_HTM(835,582,450,60,$("#printClintDiv #idNoLegal").text());/* 法定代表人 证件号码*/
		LODOP.ADD_PRINT_HTM(779,248,450,60,$("#printClintDiv #endDateLegal").text());/* 法定代表人 证件到期日或有效期 */
		LODOP.ADD_PRINT_HTM(779,248,450,60,$("#printClintDiv #nationalLegal").text());/* 法定代表人国籍*/
		LODOP.ADD_PRINT_HTM(779,248,450,60,$("#printClintDiv #birthDateLegal").text());/* 法定代表人出生日期 */
		
	}
</script>
