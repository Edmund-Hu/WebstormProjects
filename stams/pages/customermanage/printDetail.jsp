<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<script type="text/javascript" src="js/jQuery.Hz2Py-min.js"></script>

<script language="javascript" type="text/javascript">
	var openBookData;
	var LODOP; //声明为全局变量 
	
	function prn_print(pageNum) {
		if(pageNum==0){//开立单位银行结算账户申请书 无 附加客户信息
			alert("开立单位银行结算账户申请书 无附加客户信息");
			CreateForm0Page();
			//LODOP.PRINT(); 
			LODOP.PREVIEW();
		}
		if(pageNum==1){//开立单位银行结算账户申请书 + 附加客户信息
			alert("开立单位银行结算账户申请书 + 附加客户信息");
			CreateForm1Page();
			LODOP.PREVIEW();
		}
		if(pageNum==2){//对公客户信息表
			alert("对公客户信息表");
			CreateForm2Page();
			LODOP.PREVIEW();
		}
		if(pageNum==3){//关联企业、股东登记表
			alert("关联企业、股东登记表");
			CreateForm3Page();
			LODOP.PREVIEW();
		}
		if(pageNum==4){//人民币单位银行结算账户相关业务授权书
			alert("单位银行结算账户相关业务授权书");
			CreateForm4Page();
			LODOP.PREVIEW();
		}
		if(pageNum==5){//外部公司客户对账服务协议
			alert("外部公司客户对账服务协议");
			CreateForm5Page();
			LODOP.PREVIEW();
		}
		if(pageNum==6){//使用通用性支付密码器信息表
			alert("使用通用性支付密码器信息表");
			CreateForm6Page();
			LODOP.PREVIEW();
		}
		if(pageNum==7){//国内结算产品开办申请表
			alert("国内结算产品开办申请表");
			CreateForm7Page();
			LODOP.PREVIEW();
		}
		if(pageNum==8){//网上银行服务申请表
			alert("网上银行服务申请表");
			CreateForm8Page();
			LODOP.PREVIEW();
		}
		if(pageNum==91||pageNum==92){//银行结算证申请表
			alert("银行结算证申请表");
			if(pageNum==91){//正面
				CreateForm91Page();
				LODOP.PREVIEW();
			}
			/* if(pageNum==92){//背面
				CreateForm92Page();
				LODOP.PREVIEW();
			} */
			
		}
		if(pageNum==10){//代扣缴款协议书 null 代码  名称
			alert("代扣缴款协议书");
			CreateForm10Page();
			LODOP.PREVIEW();
		}
		if(pageNum==11){//专用/临时申请申请书附页
			alert("专用/临时申请申请书附页");
			CreateForm11Page();
			LODOP.PREVIEW();
		}
		if(pageNum==12){//中银单位结算卡
			alert("中银单位结算卡");
			CreateForm12Page();
			LODOP.PREVIEW();
		}
		if(pageNum==13){//自助卡申请
			alert("自助卡申请");
			CreateForm13Page();
			LODOP.PREVIEW();
		}
		if(pageNum==141){//综合服务协议
			alert("综合服务协议");
			CreateForm141Page();
			LODOP.PREVIEW();
		}
		if(pageNum==142){//综合服务协议产品
			alert("综合服务协议产品");
			CreateForm142Page();
			LODOP.PREVIEW();
		}
		if(pageNum==151){//对公短信通
			alert("对公短信通1");
			CreateForm151Page();
			LODOP.PREVIEW();
		}
		/* if(pageNum==152){//对公短信通
			alert("对公短信通2");
			CreateForm152Page();
			LODOP.PREVIEW();
		} */
		
		if(pageNum==16){//外汇账户开立
			alert("外汇账户开立");
			CreateForm16Page();
			LODOP.PREVIEW();
		}
		
		//CreateOneFormPage(pageNum);	
		//LODOP.PRINT(); 
		//LODOP.PREVIEW();
		//CreateOneFormPage();	
		//LODOP.PRINT();
		alert("打印成功！！！");
	};
	//开户申请书0
	function CreateForm0Page(){
		LODOP=getLodop();
		//LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		//LODOP.SET_PRINT_STYLE("Bold",1);
		//LODOP.ADD_PRINT_TEXT(50,231,260,39,"打印页面部分内容");
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\开立申请书1.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		LODOP.ADD_PRINT_TEXT(147,212,239,20,openBookData.accountName);/* 存款人名称 */
		LODOP.ADD_PRINT_TEXT(148,545,115,20,openBookData.mobileCode);/*  电话 */
		LODOP.ADD_PRINT_TEXT(171,212,240,20,openBookData.registAddress.split(",")[2]+openBookData.registAddress.split(",")[3]);/*  营业执照注册地址   包含了国家省市区“，”隔开 */
		LODOP.ADD_PRINT_TEXT(172,545,115,20,openBookData.postCode);/*  邮编 */
		LODOP.ADD_PRINT_TEXT(194,212,240,20,openBookData.officeAddress.split(",")[2]+openBookData.officeAddress.split(",")[3]);/*  实际办公地址 */
		LODOP.ADD_PRINT_TEXT(193,545,115,20,openBookData.postCodeNews);/*  邮编 */
		LODOP.ADD_PRINT_TEXT(212,212,100,20,openBookData.peopleType);/*  存款人类别 */
		LODOP.ADD_PRINT_TEXT(215,458,79,20, openBookData.orgInstitCd);/*  组织机构代码 */
		LODOP.ADD_PRINT_TEXT(215,544,115,20,openBookData.orgInstitEndDate);/*  组织机构代码到期日 */
		var linkManType =openBookData.linkManType;/*  人员类别 */
		if(linkManType != null && linkManType != "" && linkManType != undefined){
			if(linkManType == 1){				
				LODOP.ADD_PRINT_TEXT(236,173,20,20,"√");/*  人员类别打钩 */
			}else{
				LODOP.ADD_PRINT_TEXT(255,173,20,20,"√");/* 人员类别打钩 */
			}
		}	
		LODOP.ADD_PRINT_TEXT(237,294,155,20,openBookData.linkMan);/* 姓名 */
		LODOP.ADD_PRINT_TEXT(239,544,115,20,openBookData.linkIdEndDate);/* 证件到期日 */
		LODOP.ADD_PRINT_TEXT(259,294,155,20,openBookData.idTypeText);/* 证件种类 */
		LODOP.ADD_PRINT_TEXT(261,543,140,20,openBookData.idNumber);/* 证件号码 */ 
		var accountCategory = openBookData.accountCategory;/* 行业分类 */
		if(accountCategory != null && accountCategory != "" && accountCategory != undefined){
			if(accountCategory == "A"){
				LODOP.ADD_PRINT_HTM(279,230,20,20,"√");
			}else if(accountCategory == "B"){
				LODOP.ADD_PRINT_HTM(280,280,20,20,"√");
			}else if(accountCategory == "C"){
				LODOP.ADD_PRINT_HTM(281,320,20,20,"√");
			}else if(accountCategory == "D"){
				LODOP.ADD_PRINT_HTM(283,368,20,20,"√");
			}else if(accountCategory == "E"){
				LODOP.ADD_PRINT_HTM(281,410,20,20,"√");
			}else if(accountCategory == "F"){
				LODOP.ADD_PRINT_HTM(282,455,20,20,"√");
			}else if(accountCategory == "G"){
				LODOP.ADD_PRINT_HTM(282,497,20,20,"√");
			}else if(accountCategory == "H"){
				LODOP.ADD_PRINT_HTM(285,541,20,20,"√");
			}else if(accountCategory == "I"){
				LODOP.ADD_PRINT_HTM(283,579,20,20,"√");
			}else if(accountCategory == "J"){
				LODOP.ADD_PRINT_HTM(285,624,20,20,"√");
			}else if(accountCategory == "K"){
				LODOP.ADD_PRINT_HTM(298,236,20,20,"√");
			}else if(accountCategory == "L"){
				LODOP.ADD_PRINT_HTM(298,278,20,20,"√");
			}else if(accountCategory == "M"){
				LODOP.ADD_PRINT_HTM(298,325,20,20,"√");
			}else if(accountCategory == "N"){
				LODOP.ADD_PRINT_HTM(298,369,20,20,"√");
			}else if(accountCategory == "O"){
				LODOP.ADD_PRINT_HTM(300,412,20,20,"√");
			}else if(accountCategory == "P"){
				LODOP.ADD_PRINT_HTM(296,455,20,20,"√");
			}else if(accountCategory == "Q"){
				LODOP.ADD_PRINT_HTM(299,497,20,20,"√");
			}else if(accountCategory == "R"){
				LODOP.ADD_PRINT_HTM(297,539,20,20,"√");
			}else if(accountCategory == "S"){
				LODOP.ADD_PRINT_HTM(299,583,20,20,"√");
			}else if(accountCategory == "T"){
				LODOP.ADD_PRINT_HTM(300,624,20,20,"√");
			}
		}
		var registMoneyType = openBookData.registMoneyTypeText;
		LODOP.ADD_PRINT_TEXT(320,210,235,20, openBookData.registMoney+registMoneyType);/* 注册资金及币种 */
		LODOP.ADD_PRINT_TEXT(322,537,118,20, openBookData.areaCode);/* 地区代码 */
		LODOP.ADD_PRINT_TEXT(340,212,447,20,openBookData.busiScope);/* 经营范围 */
		LODOP.ADD_PRINT_TEXT(366,212,95,20, openBookData.fileTypeText);/* 证明文件类型*/
		//LODOP.ADD_PRINT_TEXT(387,212,95,20, $("#printOpneBookDiv>#fileTypeSecond").text());/* 证明文件类型2 */
		LODOP.ADD_PRINT_TEXT(366,383,100,20,openBookData.fileNumber);/* 证明文件编码 */
		//LODOP.ADD_PRINT_TEXT(387,383,100,20,$("#printOpneBookDiv>#fileNumberSecond").text());/* 证明文件编码2 */
		LODOP.ADD_PRINT_TEXT(366,561,100,20,openBookData.fileEndDate);/* 证明文件到期日 */
		//LODOP.ADD_PRINT_TEXT(388,560,100,20,$("#printOpneBookDiv>#fileEndDateSecond").text());/* 证明文件到期日2 */
		LODOP.ADD_PRINT_TEXT(411,209,121,20,openBookData.areaTax);/* 地税 */
		LODOP.ADD_PRINT_TEXT(413,457,195,20,openBookData.countryTax);/*国税  */
		
		var accountType = openBookData.accountType;/* 账户性质 */
		if(accountType == "0"){
			LODOP.ADD_PRINT_TEXT(454,297,20,20,"√");
		}else if(accountType == "1"){
			LODOP.ADD_PRINT_TEXT(453,391,20,20,"√");
		}else if(accountType <5){
			LODOP.ADD_PRINT_TEXT(454,484,20,20,"√");
		}else if(accountType <7){
			LODOP.ADD_PRINT_TEXT(454,580,20,20,"√");
		}
		
		LODOP.ADD_PRINT_TEXT(475,212,99,20,openBookData.coinType);/* 资金性质 */
		if(openBookData.accountEndDate!= null && openBookData.accountEndDate != "" && openBookData.accountEndDate != undefined){
			LODOP.ADD_PRINT_TEXT(479,458,47,20,openBookData.accountEndDate.split('-')[0]);/* 有效期-年 */
			LODOP.ADD_PRINT_TEXT(480,521,29,20,openBookData.accountEndDate.split('-')[1]);/* 有效期-月  */
			LODOP.ADD_PRINT_TEXT(481,560,27,20,openBookData.accountEndDate.split('-')[2]);/* 有效期-日 */
		}
		var charge = openBookData.bookCharge;
		LODOP.ADD_PRINT_TEXT(521,333,324,20,charge.unitName);/* 上级法人或主管单位信息 */
		LODOP.ADD_PRINT_TEXT(544,333,105,20,charge.checkNumber);/* 许可证核准号 */
		LODOP.ADD_PRINT_TEXT(546,553,105,20,charge.orgInstitCd);/* 组织机构代码 */
		var linkManType = charge.linkManType;/*  人员类别 */
		if(linkManType != null && linkManType != "" && linkManType != undefined){
			if(linkManType == 1){				
				LODOP.ADD_PRINT_TEXT(567,169,20,20,"√");/*  人员类别--法人打钩 */
			}else{
				LODOP.ADD_PRINT_TEXT(586,168,20,20,"√");/* 人员类别--单位负责人打钩 */
			}
		}	
		LODOP.ADD_PRINT_TEXT(568,333,105,20,charge.linkMan);/* 人员姓名 */
		LODOP.ADD_PRINT_TEXT(569,554,105,20,charge.idEndDate);/* 证件到期日 */
		LODOP.ADD_PRINT_TEXT(591,333,105,20,charge.idTypeText);/* 证件种类 */
		LODOP.ADD_PRINT_TEXT(590,554,105,20,charge.idNumber);/* 证件号码 */
		LODOP.ADD_PRINT_TEXT(630,198,157,20,openBookData.openBankName);/* 开户银行名称 */
		LODOP.ADD_PRINT_TEXT(653,198,158,20,openBookData.accountName);/* 账户名称 */
		LODOP.ADD_PRINT_TEXT(631,504,157,20,openBookData.openBankCode);/* 开户银行代码 */
		LODOP.ADD_PRINT_TEXT(654,504,156,20,openBookData.accountCode);/* 账号*/
		LODOP.ADD_PRINT_TEXT(681,342,137,20,openBookData.checkNumber);/* 开户许可证核准号 */
		LODOP.ADD_PRINT_TEXT(680,569,100,20,openBookData.openDate);/* 开户日期 */
	};
	//开户申请书1
	function CreateForm1Page(){
		LODOP=getLodop();
		//LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		//LODOP.SET_PRINT_STYLE("Bold",1);
		//LODOP.ADD_PRINT_TEXT(50,231,260,39,"打印页面部分内容");
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\开立申请书2.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		LODOP.ADD_PRINT_TEXT(147,212,239,20,openBookData.accountName);/* 存款人名称 */
		LODOP.ADD_PRINT_TEXT(148,545,115,20,openBookData.mobileCode);/*  电话 */
		LODOP.ADD_PRINT_TEXT(171,212,240,20,openBookData.registAddress.split(",")[2]+openBookData.registAddress.split(",")[3]);/*  营业执照注册地址   包含了国家省市区“，”隔开 */
		LODOP.ADD_PRINT_TEXT(172,545,115,20,openBookData.postCode);/*  邮编 */
		LODOP.ADD_PRINT_TEXT(194,212,240,20,openBookData.officeAddress.split(",")[2]+openBookData.officeAddress.split(",")[3]);/*  实际办公地址 */
		LODOP.ADD_PRINT_TEXT(193,545,115,20,openBookData.postCodeNews);/*  邮编 */
		LODOP.ADD_PRINT_TEXT(212,212,100,20,openBookData.peopleType);/*  存款人类别 */
		LODOP.ADD_PRINT_TEXT(215,458,79,20, openBookData.orgInstitCd);/*  组织机构代码 */
		LODOP.ADD_PRINT_TEXT(215,544,115,20,openBookData.orgInstitEndDate);/*  组织机构代码到期日 */
		var linkManType =openBookData.linkManType;/*  人员类别 */
		if(linkManType != null && linkManType != "" && linkManType != undefined){
			if(linkManType == 1){				
				LODOP.ADD_PRINT_TEXT(236,173,20,20,"√");/*  人员类别打钩 */
			}else{
				LODOP.ADD_PRINT_TEXT(255,173,20,20,"√");/* 人员类别打钩 */
			}
		}	
		LODOP.ADD_PRINT_TEXT(237,294,155,20,openBookData.linkMan);/* 姓名 */
		LODOP.ADD_PRINT_TEXT(239,544,115,20,openBookData.linkIdEndDate);/* 证件到期日 */
		LODOP.ADD_PRINT_TEXT(259,294,155,20,openBookData.idTypeText);/* 证件种类 */
		LODOP.ADD_PRINT_TEXT(261,543,120,20,openBookData.idNumber);/* 证件号码 */ 
		var accountCategory = openBookData.accountCategory;/* 行业分类 */
		if(accountCategory != null && accountCategory != "" && accountCategory != undefined){
			if(accountCategory == "A"){
				LODOP.ADD_PRINT_HTM(279,230,20,20,"√");
			}else if(accountCategory == "B"){
				LODOP.ADD_PRINT_HTM(280,280,20,20,"√");
			}else if(accountCategory == "C"){
				LODOP.ADD_PRINT_HTM(281,320,20,20,"√");
			}else if(accountCategory == "D"){
				LODOP.ADD_PRINT_HTM(283,368,20,20,"√");
			}else if(accountCategory == "E"){
				LODOP.ADD_PRINT_HTM(281,410,20,20,"√");
			}else if(accountCategory == "F"){
				LODOP.ADD_PRINT_HTM(282,455,20,20,"√");
			}else if(accountCategory == "G"){
				LODOP.ADD_PRINT_HTM(282,497,20,20,"√");
			}else if(accountCategory == "H"){
				LODOP.ADD_PRINT_HTM(285,541,20,20,"√");
			}else if(accountCategory == "I"){
				LODOP.ADD_PRINT_HTM(283,579,20,20,"√");
			}else if(accountCategory == "J"){
				LODOP.ADD_PRINT_HTM(285,624,20,20,"√");
			}else if(accountCategory == "K"){
				LODOP.ADD_PRINT_HTM(298,236,20,20,"√");
			}else if(accountCategory == "L"){
				LODOP.ADD_PRINT_HTM(298,278,20,20,"√");
			}else if(accountCategory == "M"){
				LODOP.ADD_PRINT_HTM(298,325,20,20,"√");
			}else if(accountCategory == "N"){
				LODOP.ADD_PRINT_HTM(298,369,20,20,"√");
			}else if(accountCategory == "O"){
				LODOP.ADD_PRINT_HTM(300,412,20,20,"√");
			}else if(accountCategory == "P"){
				LODOP.ADD_PRINT_HTM(296,455,20,20,"√");
			}else if(accountCategory == "Q"){
				LODOP.ADD_PRINT_HTM(299,497,20,20,"√");
			}else if(accountCategory == "R"){
				LODOP.ADD_PRINT_HTM(297,539,20,20,"√");
			}else if(accountCategory == "S"){
				LODOP.ADD_PRINT_HTM(299,583,20,20,"√");
			}else if(accountCategory == "T"){
				LODOP.ADD_PRINT_HTM(300,624,20,20,"√");
			}
		}
		var registMoneyType = openBookData.registMoneyTypeText;
		LODOP.ADD_PRINT_TEXT(320,210,235,20, openBookData.registMoney+registMoneyType);/* 注册资金及币种 */
		LODOP.ADD_PRINT_TEXT(322,537,118,20, openBookData.areaCode);/* 地区代码 */
		LODOP.ADD_PRINT_TEXT(340,212,447,20,openBookData.busiScope);/* 经营范围 */
		LODOP.ADD_PRINT_TEXT(366,212,95,20, openBookData.fileTypeText);/* 证明文件类型*/
		//LODOP.ADD_PRINT_TEXT(387,212,95,20, $("#printOpneBookDiv>#fileTypeSecond").text());/* 证明文件类型2 */
		LODOP.ADD_PRINT_TEXT(366,383,100,20,openBookData.fileNumber);/* 证明文件编码 */
		//LODOP.ADD_PRINT_TEXT(387,383,100,20,$("#printOpneBookDiv>#fileNumberSecond").text());/* 证明文件编码2 */
		LODOP.ADD_PRINT_TEXT(366,561,100,20,openBookData.fileEndDate);/* 证明文件到期日 */
		//LODOP.ADD_PRINT_TEXT(388,560,100,20,$("#printOpneBookDiv>#fileEndDateSecond").text());/* 证明文件到期日2 */
		LODOP.ADD_PRINT_TEXT(411,209,121,20,openBookData.areaTax);/* 地税 */
		LODOP.ADD_PRINT_TEXT(413,457,195,20,openBookData.countryTax);/*国税  */
		
		var accountType = openBookData.accountType;/* 账户性质 */
		if(accountType == "0"){
			LODOP.ADD_PRINT_TEXT(454,297,20,20,"√");
		}else if(accountType == "1"){
			LODOP.ADD_PRINT_TEXT(453,391,20,20,"√");
		}else if(accountType <5){
			LODOP.ADD_PRINT_TEXT(454,484,20,20,"√");
		}else if(accountType <7){
			LODOP.ADD_PRINT_TEXT(454,580,20,20,"√");
		}
		
		LODOP.ADD_PRINT_TEXT(475,212,99,20,openBookData.coinType);/* 资金性质 */
		if(openBookData.accountEndDate!= null && openBookData.accountEndDate != "" && openBookData.accountEndDate != undefined){
			LODOP.ADD_PRINT_TEXT(479,458,47,20,openBookData.accountEndDate.split('-')[0]);/* 有效期-年 */
			LODOP.ADD_PRINT_TEXT(480,521,29,20,openBookData.accountEndDate.split('-')[1]);/* 有效期-月  */
			LODOP.ADD_PRINT_TEXT(481,560,27,20,openBookData.accountEndDate.split('-')[2]);/* 有效期-日 */
		}
		var charge = openBookData.bookCharge;
		LODOP.ADD_PRINT_TEXT(521,333,324,20,charge.unitName);/* 上级法人或主管单位信息 */
		LODOP.ADD_PRINT_TEXT(544,333,105,20,charge.checkNumber);/* 许可证核准号 */
		LODOP.ADD_PRINT_TEXT(546,553,105,20,charge.orgInstitCd);/* 组织机构代码 */
		var linkManType = charge.linkManType;/*  人员类别 */
		if(linkManType != null && linkManType != "" && linkManType != undefined){
			if(linkManType == 1){				
				LODOP.ADD_PRINT_TEXT(567,169,20,20,"√");/*  人员类别--法人打钩 */
			}else{
				LODOP.ADD_PRINT_TEXT(586,168,20,20,"√");/* 人员类别--单位负责人打钩 */
			}
		}	
		LODOP.ADD_PRINT_TEXT(568,333,105,20,charge.linkMan);/* 人员姓名 */
		LODOP.ADD_PRINT_TEXT(569,554,105,20,charge.idEndDate);/* 证件到期日 */
		LODOP.ADD_PRINT_TEXT(591,333,105,20,charge.idTypeText);/* 证件种类 */
		LODOP.ADD_PRINT_TEXT(590,554,105,20,charge.idNumber);/* 证件号码 */
		LODOP.ADD_PRINT_TEXT(630,198,157,20,openBookData.openBankName);/* 开户银行名称 */
		LODOP.ADD_PRINT_TEXT(653,198,158,20,openBookData.accountName);/* 账户名称 */
		LODOP.ADD_PRINT_TEXT(631,504,157,20,openBookData.openBankCode);/* 开户银行代码 */
		LODOP.ADD_PRINT_TEXT(654,504,156,20,openBookData.accountCode);/* 账号*/
		LODOP.ADD_PRINT_TEXT(681,342,137,20,openBookData.checkNumber);/* 开户许可证核准号 */
		LODOP.ADD_PRINT_TEXT(680,569,100,20,openBookData.openDate);/* 开户日期 */
		
		LODOP.ADD_PRINT_TEXT(840,188,293,20,openBookData.accountEnName);/* "存款人英文名称" */
		LODOP.ADD_PRINT_TEXT(841,555,111,20,openBookData.faxCode);//"传真号码"
		LODOP.ADD_PRINT_TEXT(861,144,164,20,openBookData.companyType);//"企业类型"
		LODOP.ADD_PRINT_TEXT(862,391,100,20,openBookData.peopleSonType);//"客户子类型"
		LODOP.ADD_PRINT_TEXT(863,556,110,20,openBookData.busiType);//"行业代码"
		LODOP.ADD_PRINT_TEXT(882,144,258,20,openBookData.registDate);/*"注册日期"*/
		LODOP.ADD_PRINT_TEXT(883,502,160,20,openBookData.email);/*"电子邮件地址"*/
		LODOP.ADD_PRINT_TEXT(922,197,110,20,openBookData.firstMoneyMan);/*"财务负责人姓名"*/
		LODOP.ADD_PRINT_TEXT(924,312,89,20, openBookData.clientInfo.idNameMoneyText);/*"财务入证件种类"*/
		LODOP.ADD_PRINT_TEXT(924,408,84,20, openBookData.clientInfo.endDateMoney);/*"财务负责人证件到期日"*/
		LODOP.ADD_PRINT_TEXT(923,495,166,20,openBookData.clientInfo.idNoMoney);/*"财务负责人证件号码"*/
		LODOP.ADD_PRINT_TEXT(944,196,110,20,openBookData.partnerPeople);/*"控股股东人姓名"*/
		LODOP.ADD_PRINT_TEXT(943,312,88,20, openBookData.idTypePartnerText);/*"控股股东证件种类"*/
		LODOP.ADD_PRINT_TEXT(943,409,84,20, openBookData.endDatePartner);/*"控股股东证件到期日"*/
		LODOP.ADD_PRINT_TEXT(944,493,169,20,openBookData.idNoPartner);/*"控股股东证件号码"*/
		LODOP.ADD_PRINT_TEXT(964,195,110,20,openBookData.controlPeople);/*"实际控制人姓名"*/
		LODOP.ADD_PRINT_TEXT(965,313,90,20, openBookData.idTypeControlText);/*"实际控制人证件种类"*/
		LODOP.ADD_PRINT_TEXT(964,409,85,20, openBookData.endDateControl);/*"实际控制让人证件到期日"*/
		LODOP.ADD_PRINT_TEXT(966,495,165,20,openBookData.idNoControl);/*"实际控制人证件号码"*/
		LODOP.ADD_PRINT_TEXT(985,158,239,20,openBookData.stockHolder);/*"联系人姓名"*/
		LODOP.ADD_PRINT_TEXT(987,487,172,20,openBookData.clientInfo.telContact);/*"联系人电话"*/
		LODOP.ADD_PRINT_TEXT(1007,352,49,20,openBookData.applyMoney);/*"单位申请现金库存限额"*/
		LODOP.ADD_PRINT_TEXT(1008,592,69,20,openBookData.passMoney);/*"银行批准库存限额"*/
	};
	function CreateForm2Page(){
		LODOP=getLodop();
		//LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		//LODOP.SET_PRINT_STYLE("Bold",1);
		//LODOP.ADD_PRINT_TEXT(50,231,260,39,"打印页面部分内容");
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\对公客户信息.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		
		LODOP.ADD_PRINT_TEXT(90,88,10,20,"√");/*"操作类型选择-创建"*/
		//LODOP.ADD_PRINT_TEXT(87,184,10,20,  openBookData.);/*"操作类型选择-变更"*/
		//LODOP.ADD_PRINT_TEXT(90,544,58,20,  openBookData.);/*"表头年"*/
		//LODOP.ADD_PRINT_TEXT(91,617,23,20,  openBookData.);/*"表头月"*/
		//LODOP.ADD_PRINT_TEXT(91,648,21,20,  openBookData.);/*"表头日"*/
		LODOP.ADD_PRINT_TEXT(131,225,446,20,openBookData.depositorName);/*"客户名称"*/
		LODOP.ADD_PRINT_TEXT(150,432,81,20, openBookData.registAddress.split(",")[0]);/*"国家"*/
		LODOP.ADD_PRINT_TEXT(152,610,63,20, openBookData.registAddress.split(",")[1]);/*"直辖市"*/
		LODOP.ADD_PRINT_TEXT(167,165,100,20,openBookData.registAddress.split(",")[2]);/*"市/区"*/
		LODOP.ADD_PRINT_TEXT(168,331,223,20,openBookData.registAddress.split(",")[3]);/*"地址"*/
		LODOP.ADD_PRINT_TEXT(171,600,74,20, openBookData.postCode);/*"邮编"*/
		LODOP.ADD_PRINT_TEXT(188,417,100,20,openBookData.officeAddress.split(",")[0]);/*"国家"*/
		LODOP.ADD_PRINT_TEXT(191,600,85,20, openBookData.officeAddress.split(",")[1]);/*"直辖市"*/
		LODOP.ADD_PRINT_TEXT(206,166,110,20,openBookData.officeAddress.split(",")[2]);/*"市/区"*/
		LODOP.ADD_PRINT_TEXT(207,332,217,20,openBookData.officeAddress.split(",")[3]);/*"地址"*/
		LODOP.ADD_PRINT_TEXT(210,601,75,20, openBookData.postCodeNews);/*"邮编"*/
		LODOP.ADD_PRINT_TEXT(227,328,347,20,openBookData.busiScope);/*"经营范围"*/
		LODOP.ADD_PRINT_TEXT(251,340,337,20,openBookData.registMoney+openBookData.registMoneyTypeText);/*"注册资本货币和金额"*/
		LODOP.ADD_PRINT_TEXT(272,330,280,20,openBookData.mobileCode);/*"办公电话"*/
		LODOP.ADD_PRINT_TEXT(308,334,166,20,openBookData.clientInfo.idNoCredit);/*"统一社会信用码"*/
		LODOP.ADD_PRINT_TEXT(309,507,171,20,openBookData.clientInfo.endDateCredit);/*"证件到期日"*/
		LODOP.ADD_PRINT_TEXT(328,334,169,20,openBookData.orgInstitCd);/*"组织机构代码证"*/
		LODOP.ADD_PRINT_TEXT(330,507,173,20,openBookData.orgInstitEndDate);/*"证件到期日"*/
		LODOP.ADD_PRINT_TEXT(347,334,168,20,openBookData.clientInfo.idNoLicense);/*"营业执照号码"*/
		LODOP.ADD_PRINT_TEXT(349,507,174,20,openBookData.clientInfo.endDateLicense);/*"营业执照到期日"*/
		LODOP.ADD_PRINT_TEXT(368,332,168,20,openBookData.countryTax);/*"国税登记证号码"*/
		LODOP.ADD_PRINT_TEXT(369,507,169,20,openBookData.clientInfo.endDateCountry);/*"国税登记证到期日"*/
		LODOP.ADD_PRINT_TEXT(387,210,116,20,openBookData.clientInfo.otherIdName);/*"其他证明文件名称"*/
		LODOP.ADD_PRINT_TEXT(390,332,170,20,openBookData.clientInfo.idNoOther);/*"其他证明文件号码"*/
		LODOP.ADD_PRINT_TEXT(391,507,174,20,openBookData.clientInfo.endDateOther);/*"其他证明文件证件到期日"*/
		LODOP.ADD_PRINT_TEXT(409,317,57,20, openBookData.clientInfo.legalRepresentSurname);/*"法定代表人姓"*/
		LODOP.ADD_PRINT_TEXT(409,393,100,20,openBookData.clientInfo.legalRepresentName);/*"法定代表人名"*/
		//LODOP.ADD_PRINT_TEXT(407,528,148,20,(openBookData.clientInfo.legalRepresentSurname+openBookData.clientInfo.legalRepresentName).toPinyin());/*"法定代表人拼音"*/
		LODOP.ADD_PRINT_TEXT(429,365,313,20,openBookData.idTypeText+"  "+openBookData.idNumber);/*"证件名称及号码"*/
		LODOP.ADD_PRINT_TEXT(451,513,165,20,openBookData.linkIdEndDate);/*"证件到期日或有效期"*/
		LODOP.ADD_PRINT_TEXT(469,276,69,20, openBookData.clientInfo.nationalLegal);/*"法定代表人国籍"*/
		LODOP.ADD_PRINT_TEXT(471,590,90,20, openBookData.clientInfo.birthDateLegal);/*"法定代表人出生日期"*/
		LODOP.ADD_PRINT_TEXT(488,367,312,20,openBookData.clientInfo.busiCountry);/*"主要经营国家或地区"*/
		if(openBookData.clientInfo.publicCompany=="0"){
			LODOP.ADD_PRINT_TEXT(510,296,14,20, "√");/*"是否上市-是"*/
		}
		if(openBookData.clientInfo.publicCompany=="1"){
			LODOP.ADD_PRINT_TEXT(509,364,14,20, "√");/*"是否上市-否"*/
		}
		LODOP.ADD_PRINT_TEXT(511,580,100,20,openBookData.clientInfo.numEmp);/*"从业人数"*/
		LODOP.ADD_PRINT_TEXT(531,293,121,20,openBookData.registDate);/*"创建日期"*/
		LODOP.ADD_PRINT_TEXT(533,602,80,20, openBookData.accountCategory);/*"行业分类"*/
		LODOP.ADD_PRINT_TEXT(552,372,307,20,openBookData.clientInfo.salesVolume);/*"年销售币种及销售额"*/
		LODOP.ADD_PRINT_TEXT(570,419,258,20,openBookData.clientInfo.overseasAffiliate);/*"主要海外分支机构所在国家或地区"*/
		LODOP.ADD_PRINT_TEXT(590,337,339,20,openBookData.clientInfo.overseasCust);/*"主要海外客户所在地"*/
		var highSeasons = openBookData.clientInfo.highSeasons;
		if(highSeasons.indexOf("W1")>-1){
			LODOP.ADD_PRINT_TEXT(607,359,15,20, "√");/*"商业活动旺季（1-3月）"*/
		}
		if(highSeasons.indexOf("W2")>-1){
			LODOP.ADD_PRINT_TEXT(607,439,15,20, "√");/*"商业活动旺季（4-6月）"*/
		}
		if(highSeasons.indexOf("W3")>-1){
			LODOP.ADD_PRINT_TEXT(609,519,15,20, "√");/*"商业活动旺季（7-9月）"*/
		}
		if(highSeasons.indexOf("W4")>-1){
			LODOP.ADD_PRINT_TEXT(607,601,15,20, "√");/*"商业活动旺季（10-12月）"*/
		}
		LODOP.ADD_PRINT_TEXT(629,262,418,20,openBookData.clientInfo.otherBusi);/*"其他业务"*/
		LODOP.ADD_PRINT_TEXT(645,469,213,20,openBookData.clientInfo.otherContact);/*"其他联系方式（移动电话/电子邮件/传真）"*/
		LODOP.ADD_PRINT_TEXT(668,292,60,20, openBookData.clientInfo.moneyManSurname);/*"财务负责人及拼音"*/
		LODOP.ADD_PRINT_TEXT(669,373,130,20,openBookData.clientInfo.moneyManName);/*"财务负责人名"*/
		//LODOP.ADD_PRINT_TEXT(671,534,143,20,(openBookData.clientInfo.moneyManSurname+openBookData.clientInfo.moneyManName).toPinyin());/*"财务负责人拼音"*/
		LODOP.ADD_PRINT_TEXT(689,261,94,20, openBookData.clientInfo.nationalMoney);/*"财务负责人国籍"*/
		LODOP.ADD_PRINT_TEXT(691,607,80,20, openBookData.clientInfo.birthDateMoney);/*"财务负责人出生日期"*/
		LODOP.ADD_PRINT_TEXT(712,337,340,20,openBookData.clientInfo.idNameMoneyText+"  "+openBookData.clientInfo.idNoMoney);/*"财务负责人证件及号码"*/
		LODOP.ADD_PRINT_TEXT(733,490,189,20,openBookData.clientInfo.endDateMoney);/*"证件到期日或有效期"*/
		LODOP.ADD_PRINT_TEXT(756,245,427,20,openBookData.clientInfo.idNoAgent);/*"财务负责人联系电话"*/
		LODOP.ADD_PRINT_TEXT(776,292,68,20, openBookData.clientInfo.contactManSurname);/*"联系人姓"*/
		LODOP.ADD_PRINT_TEXT(776,381,126,20,openBookData.clientInfo.contactManName);/*"联系人名"*/
		//LODOP.ADD_PRINT_TEXT(778,538,140,20,(openBookData.clientInfo.contactManSurname+openBookData.clientInfo.contactManName).toPinyin());/*"联系人拼音"*/
		LODOP.ADD_PRINT_TEXT(795,258,80,20, openBookData.clientInfo.nationalContact);/*"联系人国籍"*/
		LODOP.ADD_PRINT_TEXT(799,581,100,20,openBookData.clientInfo.birthDateContact);/*"联系人出生日期"*/
		LODOP.ADD_PRINT_TEXT(816,242,154,20,openBookData.clientInfo.telContact);/*"联系人电话"*/
		LODOP.ADD_PRINT_TEXT(817,498,180,20,openBookData.clientInfo.emailContact);/*"联系人电子邮件"*/
		var partners = openBookData.clientInfo.partner.split("||");
		for(var i = 0; i<partners.length; i++){
			if(i==3){
				break;
			}
			var partner = partners[i].split(",");
			LODOP.ADD_PRINT_TEXT(875+i*23,167,100,20,partner[0]);/*"主要股东姓名1"*/
			LODOP.ADD_PRINT_TEXT(876+i*23,272,84,20, getIdTypeText(partner[1]));/*"主要股东证件类型1"*/
			LODOP.ADD_PRINT_TEXT(877+i*23,361,121,20,partner[2]);/*"主要股东证件号码1"*/
			LODOP.ADD_PRINT_TEXT(878+i*23,491,90,20, partner[3]);/*"主要股东证件到期日1"*/
			LODOP.ADD_PRINT_TEXT(879+i*23,585,95,20, partner[4]);/*"控股比例1"*/
		}
		//LODOP.ADD_PRINT_TEXT(894,167,100,20,openBookData.);/*"主要股东姓名2"*/+23
		//LODOP.ADD_PRINT_TEXT(895,272,84,20, openBookData.);/*"主要股东证件类型2"*/
		//LODOP.ADD_PRINT_TEXT(895,361,121,20,openBookData.);/*"主要股东证件号码2"*/
		//LODOP.ADD_PRINT_TEXT(896,491,90,20, openBookData.);/*"主要股东证件到期日2"*/
		//LODOP.ADD_PRINT_TEXT(895,585,95,20, openBookData.);/*"控股比例2"*/
		//LODOP.ADD_PRINT_TEXT(916,167,100,20,openBookData.);/*"主要股东姓名3"*/
		//LODOP.ADD_PRINT_TEXT(916,272,84,20, openBookData.);/*"主要股东证件类型3"*/
		//LODOP.ADD_PRINT_TEXT(918,361,121,20,openBookData.);/*"主要股东证件号码3"*/
		//LODOP.ADD_PRINT_TEXT(919,491,90,20, openBookData.);/*"主要股东证件到期日3"*/
		//LODOP.ADD_PRINT_TEXT(919,585,95,20, openBookData.);/*"控股比例3"*/ 
		var beneficiaries = openBookData.clientInfo.beneficiary.split("||");
		for(var i = 0; i<beneficiaries.length; i++){
			if(i==2){
				break;
			}
			var beneficiary = beneficiaries[i].split(",");
			LODOP.ADD_PRINT_TEXT(942+i*23,167,100,20,beneficiary[0]);/*"授权人益姓名1"*/
			LODOP.ADD_PRINT_TEXT(943+i*23,272,84,20, getIdTypeText(beneficiary[1]));/*"授权人益证件类型1"*/
			LODOP.ADD_PRINT_TEXT(943+i*23,361,121,20,beneficiary[2]);/*"授权人益证件号码1"*/
			LODOP.ADD_PRINT_TEXT(944+i*23,491,90,20, beneficiary[3]);/*"授权人益证件到期日1"*/
			LODOP.ADD_PRINT_TEXT(945+i*23,585,95,20, beneficiary[4]);/*"控股比例1"*/
		}
		
		//LODOP.ADD_PRINT_TEXT(960,167,100,20,openBookData.);/*"授权人益姓名2"*/
		//LODOP.ADD_PRINT_TEXT(961,272,84,20, openBookData.);/*"授权人益证件类型2"*/
		//LODOP.ADD_PRINT_TEXT(963,361,121,20,openBookData.);/*"授权人益证件号码2"*/
		//LODOP.ADD_PRINT_TEXT(964,491,90,20, openBookData.);/*"授权人益证件到期日2"*/
		//LODOP.ADD_PRINT_TEXT(964,585,95,20, openBookData.);/*"控股比例2"*/
	}
	
	function CreateForm3Page(){
		LODOP=getLodop();
		//LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\关联企业表.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		var vCompany = openBookData.relationInfo.relationCompany;
		if(vCompany != null && vCompany != "" && vCompany != undefined){
			var companys = vCompany.split("||");
			for(var i=0; i<companys.length; i++){
				if(i==10){
					break;
				}
				var company = companys[i].split(",");
				if(company.length>1){
					LODOP.ADD_PRINT_TEXT(202+i*20, 96, 157, 20, company[0]);/* 关联企业 里 关联企业名称 */
					LODOP.ADD_PRINT_TEXT(203+i*20, 259, 123, 20,company[1]);/* 关联企业 里 法定代表人 */
					LODOP.ADD_PRINT_TEXT(204+i*20, 384, 144, 20,company[2]);/* 关联企业 里 组织机构代码*/
					LODOP.ADD_PRINT_TEXT(203+i*20, 532, 130, 20,company[3]);/* 关联企业 里 是否为控股股东 */
				}
			}
		}
		var vPartner = openBookData.relationInfo.relationPartner;
		if(vPartner != null && vPartner != "" && vPartner != undefined){
			var partners = vPartner.split("||");
			for(var i=0; i<partners.length; i++){
				var partner = partners[i].split(",");
				if(i==10){
					break;
				}
				if(partner.length>1){
					LODOP.ADD_PRINT_TEXT(452+i*20, 96, 101, 20,partner[0]);/* 关联股东 里 关联股东名称 */
					LODOP.ADD_PRINT_TEXT(452+i*20, 202, 87, 20,getIdTypeText(partner[1]));/* 关联股东 里 证件种类 */
					LODOP.ADD_PRINT_TEXT(452+i*20, 292, 150, 20,partner[2]);/* 关联股东 里 证件号码*/
					LODOP.ADD_PRINT_TEXT(452+i*20, 444, 90, 20, partner[3]);/* 关联股东 里证件到期日 */
					LODOP.ADD_PRINT_TEXT(452+i*20, 536, 125, 20,partner[4]);/* 关联股东 里 是否为控股股东 */
				}
			}
		}
	}
	
	function CreateForm4Page(){
		LODOP=getLodop();
		//LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\业务授权书（开立、变更、撤销均适用）.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		LODOP.ADD_PRINT_TEXT(126,110,183,20,openBookData.openBankName);/*"中国银行地址"*/
		LODOP.ADD_PRINT_TEXT(158,124,229,20,openBookData.depositorName);/*"单位名称"*/
		LODOP.ADD_PRINT_TEXT(160,392,137,20,openBookData.accountCode);/*"账号"*/
		LODOP.ADD_PRINT_TEXT(189,55,100,20, openBookData.linkMan);/*"法人名称"*/
		
		var vPeople = openBookData.authorize.authorizePeople.split('||');
		LODOP.ADD_PRINT_TEXT(189,250,100,20,toChineseNum(vPeople.length));/*"授权项大写"*/
		
		for(var i = 0; i<vPeople.length; i++){
			if(i==5){
				break;
			}
			var people = vPeople[i].split(',');
			if(people.length>1){
				LODOP.ADD_PRINT_TEXT(250+i*30,57,90,20,  people[0]);/*"姓名1"*/
				LODOP.ADD_PRINT_TEXT(250+i*30,150,75,20, getIdTypeText(people[1]));/*"证件类型1"*/
				LODOP.ADD_PRINT_TEXT(250+i*30,221,182,20,people[2]);/*"证件号码1"*/
				LODOP.ADD_PRINT_TEXT(250+i*30,411,95,20, people[4]);/*"联系电话1"*/
				var content = people[5].replace(".I","").replace(".J","").replace("I","").replace("J","").replace("K","I");
				LODOP.ADD_PRINT_TEXT(251+i*30,512,80,20, content);/*"授权项选择1"*/
				LODOP.ADD_PRINT_TEXT(251+i*30,612,26,20, toChineseNum(content.split(".").length));/*"授权项统计大写1"*/
			}
		}
		var vContent = openBookData.authorize.authorizeContent;
		LODOP.ADD_PRINT_TEXT(403,306,10,20,"√");/*"人民币单位银行结算账户类型-开户"*/
		LODOP.ADD_PRINT_TEXT(600,211,482,20,vContent.split(",")[0]);/*其他*/
		if(vContent.indexOf("D1")>-1){
			LODOP.ADD_PRINT_TEXT(492,375,10,20, "√");/*"预留签章样式类型-本单位公章"*/
		}
		if(vContent.indexOf("D2")>-1){
			LODOP.ADD_PRINT_TEXT(492,470,10,20, "√");/*"预留签章样式-财务专用章"*/
		}
		
	}
	
	function CreateForm5Page(){
		LODOP=getLodop();
		//LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\银企对账协议.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		//LODOP.ADD_PRINT_TEXT(135,415,10,20, openBookData.checkProto.);/*"对账地址类型-主账户地址"*/
		if(openBookData.checkProto.checkAddressType=="1"){
			LODOP.ADD_PRINT_TEXT(137,487,10,20, "√");/*"对账地址类型-注册地址"*/
		}else if(openBookData.checkProto.checkAddressType=="2"){
			LODOP.ADD_PRINT_TEXT(138,549,10,20, "√");/*"对账地址类型-办公地址"*/
		}else if(openBookData.checkProto.checkAddressType=="3"){
			LODOP.ADD_PRINT_TEXT(138,613,10,20, "√");/*"对账地址类型-临时地址"*/
		}else if(openBookData.checkProto.checkAddressType=="4"){
			LODOP.ADD_PRINT_TEXT(152,414,10,20, "√");/*"对账地址类型-其他地址"*/
			LODOP.ADD_PRINT_TEXT(166,401,61,15, openBookData.checkProto.checkAddressS);/*"省"*/
			LODOP.ADD_PRINT_TEXT(166,508,64,15, openBookData.checkProto.checkAddressZ);/*"市"*/
			LODOP.ADD_PRINT_TEXT(167,604,64,15, openBookData.checkProto.checkAddressQ);/*"区"*/
			LODOP.ADD_PRINT_TEXT(180,395,233,15,openBookData.checkProto.checkAddressD);/*"街道地址"*/
		}
		LODOP.ADD_PRINT_TEXT(192,561,89,15, openBookData.checkProto.checkPerson);/*"对账联系人姓名"*/
		//LODOP.ADD_PRINT_TEXT(202,459,100,15,openBookData.checkProto.checkPersonTel);/*"对账联系人电话"*/
		LODOP.ADD_PRINT_TEXT(206,589,107,15,openBookData.checkProto.checkPersonTel);/*"对账联系人手机"*/
		LODOP.ADD_PRINT_TEXT(219,497,60,15, openBookData.firstMoneyMan);/*"财务负责人姓名"*/
		//LODOP.ADD_PRINT_TEXT(216,603,79,15, openBookData.clientInfo.idNoAgent);/*"财务负责人联系电话"*/
		LODOP.ADD_PRINT_TEXT(232,405,100,15,openBookData.clientInfo.idNoAgent);/*"财务负责人手机"*/
	}
	
	function CreateForm6Page(){
		LODOP=getLodop();
		//LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\密码器信息表.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		LODOP.ADD_PRINT_TEXT(109,535,59,20, openBookData.openDate.split("-")[0]);/*"申请日期-年"*/
		LODOP.ADD_PRINT_TEXT(109,607,29,20, openBookData.openDate.split("-")[1]);/*"申请日期-月"*/
		LODOP.ADD_PRINT_TEXT(110,647,33,20, openBookData.openDate.split("-")[2]);/*"申请日期-日"*/
		LODOP.ADD_PRINT_TEXT(165,244,442,20,openBookData.depositorName);/*"单位名称"*/
		LODOP.ADD_PRINT_TEXT(192,244,441,20,openBookData.registAddress.split(",")[2]+openBookData.registAddress.split(",")[3]);/*"单位地址"*/
		LODOP.ADD_PRINT_TEXT(218,245,125,20,openBookData.postCode);/*"邮编"*/
		LODOP.ADD_PRINT_TEXT(220,510,174,20,openBookData.mobileCode);/*"电话"*/
	}
	function CreateForm7Page(){
		LODOP=getLodop();
		//LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\产品开办申请.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		//LODOP.ADD_PRINT_TEXT(115,526,100,20,);/*"申请编号"*/
		//LODOP.ADD_PRINT_TEXT(143,280,63,20, );/*"年"*/
		//LODOP.ADD_PRINT_TEXT(143,354,29,20, );/*"月"*/
		//LODOP.ADD_PRINT_TEXT(143,399,28,20, );/*"日"*/
		LODOP.ADD_PRINT_TEXT(165,231,402,20,openBookData.depositorName+" "+openBookData.accountCode);/*"单位及账号"*/
		LODOP.ADD_PRINT_TEXT(186,232,400,20,openBookData.openBankName);/*"开户行名称"*/
		if(openBookData.fileTypeText.indexOf("营业执照")>-1){
			LODOP.ADD_PRINT_TEXT(205,238,10,20, "√");/*"证件类型-营业执照"*/
		}else{
			LODOP.ADD_PRINT_TEXT(227,238,10,20, "√");/*"证件类型-其他证件"*/
		}
		LODOP.ADD_PRINT_TEXT(217,441,194,20,openBookData.fileNumber);/*"证件号码"*/
		LODOP.ADD_PRINT_TEXT(248,202,110,20,openBookData.linkMan);/*"法定代表人"*/
		LODOP.ADD_PRINT_TEXT(247,378,105,20,openBookData.stockHolder);/*"联系人"*/
		LODOP.ADD_PRINT_TEXT(247,563,75,20, openBookData.clientInfo.telContact);/*"联系电话"*/
		LODOP.ADD_PRINT_TEXT(268,184,452,20,openBookData.registAddress.split(",")[2]+openBookData.registAddress.split(",")[3]);/*"单位地址"*/
		var products = openBookData.productInfo.choseProducts;
		if(products.indexOf("PD1")>-1){
			LODOP.ADD_PRINT_TEXT(307,117,10,20, "√");/*"产品选择-中银单位结算卡"*/
		}
		if(products.indexOf("PD2")>-1){
			LODOP.ADD_PRINT_TEXT(307,253,10,20, "√");/*"产品选择-对公短信通"*/
		}
		if(products.indexOf("PD3")>-1){
			LODOP.ADD_PRINT_TEXT(307,359,10,20, "√");/*"产品选择-单位客户回单自助打印盖章"*/
		}
		if(products.indexOf("PD4")>-1){
			LODOP.ADD_PRINT_TEXT(307,573,10,20, "√");/*"产品选择-电子回单箱"*/
		}
	}
	function CreateForm8Page(){
		LODOP=getLodop();
		//LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\网银开办表.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		LODOP.ADD_PRINT_TEXT(136,96,312,20, openBookData.depositorName);/*"申请单位名称"*/
		LODOP.ADD_PRINT_TEXT(653,34,69,20,  openBookData.ebank.firstName);/*"网银操作员-姓名1"*/
		LODOP.ADD_PRINT_TEXT(654,104,89,20, openBookData.ebank.firstType);/*"网银操作员-角色功能1"*/
		LODOP.ADD_PRINT_TEXT(655,240,50,20, getIdTypeText(openBookData.ebank.firstIdType));/*"网银操作员-证件类型1"*/
		LODOP.ADD_PRINT_TEXT(654,294,130,20,openBookData.ebank.firstIdNo);/*"网银操作员-证件号码1"*/
		LODOP.ADD_PRINT_TEXT(654,430,82,20, openBookData.ebank.firstTel);/*"网银操作员-移动电话1"*/
		LODOP.ADD_PRINT_TEXT(677,33,68,20,  openBookData.ebank.secondName);/*"网银操作员信息-姓名2"*/
		LODOP.ADD_PRINT_TEXT(676,104,89,20, openBookData.ebank.secondType);/*"网银操作员-角色功能2"*/
		LODOP.ADD_PRINT_TEXT(678,239,52,20, getIdTypeText(openBookData.ebank.secondIdType));/*"网银操作员-证件类型2"*/
		LODOP.ADD_PRINT_TEXT(678,294,131,20,openBookData.ebank.secondIdNo);/*"网银操作员-证件号码2"*/
		LODOP.ADD_PRINT_TEXT(679,429,82,20, openBookData.ebank.secondTel);/*"网银操作员-移动电话2"*/
	}
	
	function CreateForm91Page(){
		LODOP=getLodop();
		//LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_MODE("PRINT_DUPLEX",2);//2-双面 1-不双面 0-不控制
		LODOP.SET_PRINT_MODE("PRINT_DEFAULTSOURCE",1);//1-纸盒 4-手动 7-自动 0-不控制
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\银行结算证申请表.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		LODOP.ADD_PRINT_TEXT(200,182,127,80,openBookData.depositorName);/*"单位名称"*/
		LODOP.ADD_PRINT_TEXT(202,506,163,20,openBookData.accountCode);/*"账号"*/
		LODOP.ADD_PRINT_TEXT(295,181,131,20,openBookData.fileTypeText);/*"单位证件名称"*/
		LODOP.ADD_PRINT_TEXT(296,499,175,20,openBookData.fileNumber);/*"单位证件号码"*/
		LODOP.ADD_PRINT_TEXT(401,183,130,20,openBookData.linkMan);/*"单位法定代表人"*/
		LODOP.ADD_PRINT_TEXT(401,501,172,20,openBookData.paymentCard.firstUserName);/*"持卡人姓名"*/
		//LODOP.ADD_PRINT_TEXT(520,318,171,20,openBookData.);/*"主卡"*/
		//LODOP.ADD_PRINT_TEXT(520,591,80,20, openBookData.);/*"副卡"*/
		
		//分页
		LODOP.NewPage();
		//背面内容
		LODOP.ADD_PRINT_TEXT(282,326,69,20, openBookData.paymentCard.firstUserName);/*"甲方主卡姓名"*/
		LODOP.ADD_PRINT_TEXT(281,487,177,20,openBookData.paymentCard.firstUserId);/*"甲方主卡身份证号"*/
		LODOP.ADD_PRINT_TEXT(371,492,100,20,openBookData.paymentCard.secondUserName);/*"甲方副卡姓名"*/
		LODOP.ADD_PRINT_TEXT(399,114,130,20,openBookData.paymentCard.secondUserId);/*"甲方副卡身份证号"*/
	}
	
	function CreateForm92Page(){
		LODOP=getLodop();
		//LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\关联企业表.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		LODOP.ADD_PRINT_TEXT(282,326,69,20, openBookData.paymentCard.firstUserName);/*"甲方主卡姓名"*/
		LODOP.ADD_PRINT_TEXT(281,487,177,20,openBookData.paymentCard.firstUserId);/*"甲方主卡身份证号"*/
		LODOP.ADD_PRINT_TEXT(371,492,100,20,openBookData.paymentCard.secondUserName);/*"甲方副卡姓名"*/
		LODOP.ADD_PRINT_TEXT(399,114,130,20,openBookData.paymentCard.secondUserId);/*"甲方副卡身份证号"*/
	}
	
	function CreateForm10Page(){//代扣缴款协议书
		LODOP=getLodop();
		//LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.SET_PRINT_MODE("PRINT_DUPLEX",2);//2-双面 1-不双面 0-不控制
		LODOP.SET_PRINT_MODE("PRINT_DEFAULTSOURCE",1);//1-纸盒 4-手动 7-自动 0-不控制
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\委托代扣税款2.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		//正面内容
		LODOP.ADD_PRINT_TEXT(227,191,215,20,openBookData.depositorName);/*"甲方纳税人"*/
		LODOP.ADD_PRINT_TEXT(258,191,212,20,openBookData.openBankName);/*"乙方银行名称"*/
		//分页
		LODOP.NewPage();
		//背面内容
		LODOP.ADD_PRINT_TEXT(500,215,167,20,openBookData.clientInfo.idNoCredit);/*"统一社会信用代码"*/
		LODOP.ADD_PRINT_TEXT(558,216,163,20,openBookData.depositorName);/*"纳税人名称"*/
		LODOP.ADD_PRINT_TEXT(619,217,161,20,openBookData.secondMoneyMan+" "+openBookData.secondTelCode);/*"征收机关名称、代码"*/
		LODOP.ADD_PRINT_TEXT(671,216,160,20,openBookData.stockHolder);/*"联系人"*/
		LODOP.ADD_PRINT_TEXT(724,217,159,20,openBookData.clientInfo.telContact);/*"联系电话"*/
		LODOP.ADD_PRINT_TEXT(777,217,158,20,openBookData.registAddress.split(",")[2]+openBookData.registAddress.split(",")[3]);/*"经营地址"*/
		LODOP.ADD_PRINT_TEXT(499,549,161,20,openBookData.openBankName);/*"开户银行名称"*/
		LODOP.ADD_PRINT_TEXT(561,547,159,20,openBookData.accountName);/*"账户名称"*/
		LODOP.ADD_PRINT_TEXT(622,545,162,20,openBookData.accountCode);/*"开户银行账号"*/
		LODOP.ADD_PRINT_TEXT(676,545,164,20,openBookData.openBankCode);/*"开户银行行号"*/
	}
	
	function CreateForm11Page(){
		LODOP=getLodop();
		//LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\内设机构申请书附页.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		LODOP.ADD_PRINT_TEXT(237,238,174,20,openBookData.depositorName);/*"存款人名称"*/
		LODOP.ADD_PRINT_TEXT(238,568,139,20,openBookData.dedicatedShort.departName);/*"内设机构（部门）名称"*/
		LODOP.ADD_PRINT_TEXT(276,238,465,20,openBookData.accountName);/*"账户名称"*/
		LODOP.ADD_PRINT_TEXT(308,238,463,20,openBookData.dedicatedShort.departTel);/*"内设机构（部门）电话"*/
		LODOP.ADD_PRINT_TEXT(340,238,464,20,openBookData.dedicatedShort.departAddress);/*"内设机构（部门）地址"*/
		LODOP.ADD_PRINT_TEXT(374,238,463,20,openBookData.dedicatedShort.departPostCode);/*"内设机构（部门）邮编"*/
		LODOP.ADD_PRINT_TEXT(408,314,100,20,openBookData.dedicatedShort.principleName);/*"姓名"*/
		LODOP.ADD_PRINT_TEXT(408,510,195,20,openBookData.dedicatedShort.idEndDate);/*"证件到期日"*/
		LODOP.ADD_PRINT_TEXT(442,313,100,20,getIdTypeText(openBookData.dedicatedShort.idType));/*"证件种类"*/
		LODOP.ADD_PRINT_TEXT(443,509,193,20,openBookData.dedicatedShort.idNo);/*"证件号码"*/
	}
	
	function CreateForm12Page(){
		LODOP=getLodop();
		//LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\中银单位结算卡开办申请.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		LODOP.ADD_PRINT_TEXT(86,117,186,20, openBookData.accountCode);/*"单位账号"*/
		LODOP.ADD_PRINT_TEXT(87,356,355,20, openBookData.depositorName);/*"单位名称"*/
		//LODOP.ADD_PRINT_TEXT(113,69,15,15,  openBookData.);/*"新申请主卡选择"*/
		//LODOP.ADD_PRINT_TEXT(112,187,261,20,openBookData.);/*"主卡卡号"*/
		LODOP.ADD_PRINT_TEXT(113,532,178,20,openBookData.productInfo.cardholderName);/*"指定持卡人姓名"*/
		LODOP.ADD_PRINT_TEXT(139,148,328,20,getIdTypeText(openBookData.productInfo.cardholderIdType)+" "+openBookData.productInfo.cardholderIdNo);/*"证件类型及号码"*/
		LODOP.ADD_PRINT_TEXT(139,530,179,20,openBookData.productInfo.cardholderTel);/*"手机号码"*/
		//LODOP.ADD_PRINT_TEXT(165,68,15,15,  openBookData.);/*"持主卡申请子卡1"*/
		//LODOP.ADD_PRINT_TEXT(164,190,257,20,openBookData.);/*"子卡1卡号"*/
		LODOP.ADD_PRINT_TEXT(165,531,182,20,openBookData.productInfo.cardholderName1);/*"指定持卡人姓名1"*/
		LODOP.ADD_PRINT_TEXT(191,148,332,20,getIdTypeText(openBookData.productInfo.cardholderIdType1)+" "+openBookData.productInfo.cardholderIdNo1);/*"证件类型及号码1"*/
		LODOP.ADD_PRINT_TEXT(191,530,178,20,openBookData.productInfo.cardholderTel1);/*"手机号码1"*/
		//LODOP.ADD_PRINT_TEXT(218,189,259,20,openBookData.);/*"子卡2卡号"*/
		//LODOP.ADD_PRINT_TEXT(215,67,15,14,  openBookData.);/*"持主卡申请子卡2选择"*/
		LODOP.ADD_PRINT_TEXT(216,532,178,20,openBookData.productInfo.cardholderName2);/*"持卡人姓名2"*/
		LODOP.ADD_PRINT_TEXT(241,148,329,20,getIdTypeText(openBookData.productInfo.cardholderIdType2)+" "+openBookData.productInfo.cardholderIdNo2);/*"证件类型及卡号2"*/
		LODOP.ADD_PRINT_TEXT(241,530,179,20,openBookData.productInfo.cardholderTel2);/*"手机号码2"*/
	}
	
	function CreateForm13Page(){
		LODOP=getLodop();
		//LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\自助卡申请.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		LODOP.ADD_PRINT_TEXT(196,160,426,20,openBookData.depositorName);/*"申请人"*/
		LODOP.ADD_PRINT_TEXT(481,147,100,20,openBookData.productInfo.userName);/*"姓名"*/
		LODOP.ADD_PRINT_TEXT(478,564,90,20, openBookData.productInfo.userTel);/*"联系电话（手机）"*/
	}
	
	function CreateForm141Page(){
		LODOP=getLodop();
		//LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\综合服务协议签署表.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		LODOP.ADD_PRINT_TEXT(186,101,272,20,openBookData.depositorName);/*"甲方名称"*/
		LODOP.ADD_PRINT_TEXT(251,104,263,20,openBookData.registAddress.split(",")[2]+openBookData.registAddress.split(",")[3]);/*"甲方地址"*/
		LODOP.ADD_PRINT_TEXT(313,115,257,20,openBookData.linkMan);/*"甲方负责人"*/
		LODOP.ADD_PRINT_TEXT(218,395,297,20,openBookData.openBankName);/*"乙方名称"*/
		LODOP.ADD_PRINT_TEXT(251,428,261,20,$("#bankAddress").val());/*"乙方地址"*/
		LODOP.ADD_PRINT_TEXT(425,90,10,20,  "√");/*"人民币单位银行结算账户管理协议"*/
		LODOP.ADD_PRINT_TEXT(448,90,10,20,  "√");/*"外部公司客户对账服务协议"*/
		LODOP.ADD_PRINT_TEXT(469,90,10,20,  "√");/*"网上银行企业客户服务协议"*/
		if(openBookData.protocolSign.useProtocol.indexOf("P4")>-1){
			LODOP.ADD_PRINT_TEXT(490,90,10,20, "√");/*"支付密码器"*/
		}
		LODOP.ADD_PRINT_TEXT(511,90,10,20,  "√");/*"银行结算证"*/
	}
	
	function CreateForm142Page(){
		LODOP=getLodop();
		//LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\综合服务协议签署表（产品用）.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		LODOP.ADD_PRINT_TEXT(184,101,272,20,openBookData.depositorName);/*"甲方名称"*/
		LODOP.ADD_PRINT_TEXT(246,104,263,20,openBookData.registAddress.split(",")[2]+openBookData.registAddress.split(",")[3]);/*"甲方地址"*/
		LODOP.ADD_PRINT_TEXT(308,115,257,20,openBookData.linkMan);/*"甲方负责人"*/
		LODOP.ADD_PRINT_TEXT(213,395,297,20,openBookData.openBankName);/*"乙方名称"*/
		LODOP.ADD_PRINT_TEXT(251,428,261,20,$("#bankAddress").val());/*"乙方地址"*/
		var products = openBookData.productInfo.choseProducts;
		if(products.indexOf("PD1")>-1){
			LODOP.ADD_PRINT_TEXT(427,85,10,20,"√");/*"产品选择-中银单位结算卡"*/
		}
		if(products.indexOf("PD2")>-1){
			LODOP.ADD_PRINT_TEXT(453,85,10,20,"√");/*"产品选择-对公短信通"*/
		}
		if(products.indexOf("PD3")>-1){
			LODOP.ADD_PRINT_TEXT(479,85,10,20,"√");/*"产品选择-单位客户回单自助打印盖章"*/
		}
		if(products.indexOf("PD4")>-1){
			LODOP.ADD_PRINT_TEXT(504,85,10,20,"√");/*"产品选择-电子回单箱"*/
		}
	}
	
	function CreateForm152Page(){
		LODOP=getLodop();
		//LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\关联企业表.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		var noteInfo = openBookData.productInfo.openNoteInfo.split("||");
		for(var i = 0; i<noteInfo.length; i++){
			if(i==3){
				break;
			}
			var personInfo = noteInfo[i].split(',');
			if(personInfo.length<2){
				break;
			}
			LODOP.ADD_PRINT_TEXT(211+i*273,217,131,20,personInfo[0]);/*"姓名1"*/
			LODOP.ADD_PRINT_TEXT(211+i*273,421,167,20,personInfo[1]);/*"手机号码1"*/
			if(personInfo[2]==1){
				LODOP.ADD_PRINT_TEXT(240+i*273,116,12,12,"√");/*"证件类型选择-身份证"*/
			}
			if(personInfo[2]==2){
				LODOP.ADD_PRINT_TEXT(239+i*273,169,12,12,"√");/*"证件类型选择-军官证"*/
			}
			if(personInfo[2]==3){
				LODOP.ADD_PRINT_TEXT(240+i*273,223,12,12,"√");/*"证件类型选择-其他"*/
			}
			var idNo = personInfo[3];/*证件号码*/
			for(var j= 0;j<idNo.length; j++){
				LODOP.ADD_PRINT_TEXT(236+i*273,346+j*20,20,20,idNo.substring(j,j+1));/*"证件号1"*/
			}
		}
	}
	
	function CreateForm151Page(){
		LODOP=getLodop();
		//LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_MODE("PRINT_DUPLEX",2);//2-双面 1-不双面 0-不控制
		LODOP.SET_PRINT_MODE("PRINT_DEFAULTSOURCE",1);//1-纸盒 4-手动 7-自动 0-不控制
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\对公短信通客户信息表.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		LODOP.ADD_PRINT_TEXT(586,263,100,20,openBookData.depositorName);
		
		//分页
		LODOP.NewPage();
		//背面内容
		var noteInfo = openBookData.productInfo.openNoteInfo.split("||");
		for(var i = 0; i<noteInfo.length; i++){
			if(i==3){
				break;
			}
			var personInfo = noteInfo[i].split(',');
			if(personInfo.length<2){
				break;
			}
			LODOP.ADD_PRINT_TEXT(211+i*273,125,131,20,"0"+i);/*"姓名1"*/
			LODOP.ADD_PRINT_TEXT(211+i*273,217,131,20,personInfo[0]);/*"姓名1"*/
			LODOP.ADD_PRINT_TEXT(211+i*273,421,167,20,personInfo[1]);/*"手机号码1"*/
			if(personInfo[2]==1){
				LODOP.ADD_PRINT_TEXT(240+i*273,116,12,12,"√");/*"证件类型选择-身份证"*/
			}
			if(personInfo[2]==2){
				LODOP.ADD_PRINT_TEXT(239+i*273,169,12,12,"√");/*"证件类型选择-军官证"*/
			}
			if(personInfo[2]==3){
				LODOP.ADD_PRINT_TEXT(240+i*273,223,12,12,"√");/*"证件类型选择-其他"*/
			}
			var idNo = personInfo[3];/*证件号码*/
			for(var j= 0;j<idNo.length; j++){
				LODOP.ADD_PRINT_TEXT(236+i*273,346+j*20,20,20,idNo.substring(j,j+1));/*"证件号1"*/
			}
		}
	}
	
	function CreateForm16Page(){
		LODOP=getLodop();
		//LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\外汇账户开立.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
	
		LODOP.ADD_PRINT_TEXT(86,224,431,20, openBookData.depositorName);/*"存款人名称"*/
		LODOP.ADD_PRINT_TEXT(106,224,240,20,openBookData.registAddress.split(",")[2]+openBookData.registAddress.split(",")[3]);/*"注册地址"*/
		LODOP.ADD_PRINT_TEXT(127,224,240,20,openBookData.officeAddress.split(",")[2]+openBookData.officeAddress.split(",")[3]);/*"通信地址"*/
		LODOP.ADD_PRINT_TEXT(106,554,100,20,openBookData.postCode);/*"注册地址邮编"*/
		LODOP.ADD_PRINT_TEXT(127,555,100,20,openBookData.postCodeNews);/*"通信地址邮编"*/
		LODOP.ADD_PRINT_TEXT(147,223,82,20, openBookData.peopleType);/*"存款人类别"*/
		LODOP.ADD_PRINT_TEXT(147,472,86,20, openBookData.orgInstitCd);/*"组织机构代码"*/
		LODOP.ADD_PRINT_TEXT(147,557,100,20,openBookData.orgInstitEndDate);/*"到期日"*/
		var linkManType =openBookData.linkManType;/*  人员类别 */
		if(linkManType != null && linkManType != "" && linkManType != undefined){
			if(linkManType == 1){				
				LODOP.ADD_PRINT_TEXT(166,185,20,20,"√");/* 人员类别打钩 */
			}else{
				LODOP.ADD_PRINT_TEXT(187,185,20,20,"√");/* 人员类别打钩 */
			}
		}
		LODOP.ADD_PRINT_TEXT(166,308,158,20,openBookData.linkMan);/*"法定代表人姓名"*/
		LODOP.ADD_PRINT_TEXT(167,556,100,20,openBookData.linkIdEndDate);/*"证件到期日"*/
		LODOP.ADD_PRINT_TEXT(187,307,154,20,openBookData.idTypeText);/*"证件种类"*/
		LODOP.ADD_PRINT_TEXT(188,556,130,20,openBookData.idNumber);/*"证件号码"*/
		var accountCategory = openBookData.accountCategory;/* 行业分类 */
		if(accountCategory != null && accountCategory != "" && accountCategory != undefined){
			if(accountCategory == "A"){
				LODOP.ADD_PRINT_HTM(206,286,20,20,"√");
			}else if(accountCategory == "B"){
				LODOP.ADD_PRINT_HTM(206,320,20,20,"√");
			}else if(accountCategory == "C"){
				LODOP.ADD_PRINT_HTM(207,356,20,20,"√");
			}else if(accountCategory == "D"){
				LODOP.ADD_PRINT_HTM(208,391,20,20,"√");
			}else if(accountCategory == "E"){
				LODOP.ADD_PRINT_HTM(207,425,20,20,"√");
			}else if(accountCategory == "F"){
				LODOP.ADD_PRINT_HTM(208,458,20,20,"√");
			}else if(accountCategory == "G"){
				LODOP.ADD_PRINT_HTM(208,495,20,20,"√");
			}else if(accountCategory == "H"){
				LODOP.ADD_PRINT_HTM(207,529,20,20,"√");
			}else if(accountCategory == "I"){
				LODOP.ADD_PRINT_HTM(208,564,20,20,"√");
			}else if(accountCategory == "J"){
				LODOP.ADD_PRINT_HTM(207,597,20,20,"√");
			}else if(accountCategory == "K"){
				LODOP.ADD_PRINT_HTM(221,289,20,20,"√");
			}else if(accountCategory == "L"){
				LODOP.ADD_PRINT_HTM(221,323,20,20,"√");
			}else if(accountCategory == "M"){
				LODOP.ADD_PRINT_HTM(222,357,20,20,"√");
			}else if(accountCategory == "N"){
				LODOP.ADD_PRINT_HTM(222,393,20,20,"√");
			}else if(accountCategory == "O"){
				LODOP.ADD_PRINT_HTM(221,425,20,20,"√");
			}else if(accountCategory == "P"){
				LODOP.ADD_PRINT_HTM(220,459,20,20,"√");
			}else if(accountCategory == "Q"){
				LODOP.ADD_PRINT_HTM(220,496,20,20,"√");
			}else if(accountCategory == "R"){
				LODOP.ADD_PRINT_HTM(220,532,20,20,"√");
			}else if(accountCategory == "S"){
				LODOP.ADD_PRINT_HTM(221,564,20,20,"√");
			}else if(accountCategory == "T"){
				LODOP.ADD_PRINT_HTM(221,597,20,20,"√");
			}
		}
		LODOP.ADD_PRINT_TEXT(243,227,242,20,openBookData.registMoney+openBookData.registMoneyTypeText);/*"注册币种及金额"*/
		LODOP.ADD_PRINT_TEXT(245,556,100,20,openBookData.areaCode);/*"地区代码"*/
		//LODOP.ADD_PRINT_TEXT(269,226,239,20,openBookData.);/*"主管财务负责人"*/
		//LODOP.ADD_PRINT_TEXT(270,556,100,20,openBookData.);/*"主管财务负责人电话"*/
		//LODOP.ADD_PRINT_TEXT(296,225,242,20,openBookData.);/*"主管账户负责人"*/
		//LODOP.ADD_PRINT_TEXT(295,553,100,20,openBookData.);/*"主管账户负责人电话"*/
		LODOP.ADD_PRINT_TEXT(317,225,428,20,openBookData.busiScope);/*"经营范围"*/
		LODOP.ADD_PRINT_TEXT(340,225,100,20,openBookData.fileTypeText);/*"证明文件种类1"*/
		LODOP.ADD_PRINT_TEXT(338,398,100,20,openBookData.fileNumber);/*"证明文件编号1"*/
		LODOP.ADD_PRINT_TEXT(338,576,85,20, openBookData.fileEndDate);/*"证明文件到期日1"*/
		
		LODOP.ADD_PRINT_TEXT(380,225,167,20,openBookData.areaTax);/*"地税登记证号码"*/
		LODOP.ADD_PRINT_TEXT(378,503,154,20,openBookData.countryTax);/*"国税登记证号码"*/
		//LODOP.ADD_PRINT_TEXT(417,366,20,20, openBookData.);/*"账户性质-经常"*/
		//LODOP.ADD_PRINT_TEXT(418,520,20,20, openBookData.);/*"账户性质-资本"*/
		//LODOP.ADD_PRINT_TEXT(438,224,429,20,openBookData.);/*"账户币别"*/
		//LODOP.ADD_PRINT_TEXT(461,224,429,20,openBookData.);/*"账户限额"*/
		LODOP.ADD_PRINT_TEXT(482,225,100,20,openBookData.coinType);/*"资金性质"*/
		if(openBookData.accountEndDate!= null && openBookData.accountEndDate != "" && openBookData.accountEndDate != undefined){
			LODOP.ADD_PRINT_TEXT(481,472,48,20,openBookData.accountEndDate.split('-')[0]);/* 有效期-年 */
			LODOP.ADD_PRINT_TEXT(480,532,25,20,openBookData.accountEndDate.split('-')[1]);/* 有效期-月  */
			LODOP.ADD_PRINT_TEXT(481,566,29,20,openBookData.accountEndDate.split('-')[2]);/* 有效期-日 */
		}
		var charge = openBookData.bookCharge;
		LODOP.ADD_PRINT_TEXT(519,339,105,20,charge.unitName);/*"上级法人或主管单位名称"*/
		LODOP.ADD_PRINT_TEXT(519,558,100,20,charge.orgInstitCd);/*"组织机构代码"*/
		var linkManType = charge.linkManType;/*  人员类别 */
		if(linkManType != null && linkManType != "" && linkManType != undefined){
			if(linkManType == 1){				
				LODOP.ADD_PRINT_TEXT(541,180,20,20,"√");/*  人员类别--法人打钩 */
			}else{
				LODOP.ADD_PRINT_TEXT(560,177,20,20,"√");/* 人员类别--单位负责人打钩 */
			}
		}	
		LODOP.ADD_PRINT_TEXT(543,338,105,20,charge.linkMan);/*"姓名"*/
		LODOP.ADD_PRINT_TEXT(564,337,105,20,charge.idTypeText);/*"证件种类"*/
		LODOP.ADD_PRINT_TEXT(540,557,100,20,charge.idEndDate);/*"证件到期日"*/
		LODOP.ADD_PRINT_TEXT(562,558,100,20,charge.idNumber);/*"证件号码"*/
		//LODOP.ADD_PRINT_TEXT(582,217,439,20,openBookData.);/*"账户收入范围"*/
		//LODOP.ADD_PRINT_TEXT(603,217,436,20,openBookData.);/*"账户支出范围"*/
		LODOP.ADD_PRINT_TEXT(645,187,302,20,openBookData.accountEnName);/*"存款人英文名称"*/
		LODOP.ADD_PRINT_TEXT(643,553,100,20,openBookData.faxCode);/*"传真号码"*/
		LODOP.ADD_PRINT_TEXT(666,170,49,20, openBookData.companyType);/*"企业类型"*/
		//LODOP.ADD_PRINT_TEXT(666,273,54,20, openBookData.);/*"贷款卡号"*/
		LODOP.ADD_PRINT_TEXT(666,402,85,20, openBookData.peopleSonType);/*"客户子类型"*/
		LODOP.ADD_PRINT_TEXT(666,567,89,20, openBookData.busiType);/*"行业代码"*/
		LODOP.ADD_PRINT_TEXT(690,173,206,20,openBookData.registDate);/*"注册日期"*/
		LODOP.ADD_PRINT_TEXT(690,472,180,20,openBookData.email);/*"电子邮箱地址"*/
		LODOP.ADD_PRINT_TEXT(734,225,90,20, openBookData.firstMoneyMan);/*"财务负责人姓名"*/
		LODOP.ADD_PRINT_TEXT(735,318,80,20, openBookData.clientInfo.idNameMoneyText);/*"财务入证件种类"*/
		LODOP.ADD_PRINT_TEXT(734,388,100,20,openBookData.clientInfo.endDateMoney);/*"财务负责人证件到期*/
		LODOP.ADD_PRINT_TEXT(735,491,163,20,openBookData.clientInfo.idNoMoney);/*"财务负责人证件号码"*/
		LODOP.ADD_PRINT_TEXT(758,224,90,20, openBookData.partnerPeople);/*"控股股东人姓名"*/
		LODOP.ADD_PRINT_TEXT(759,318,80,20, openBookData.idTypePartnerText);/*"控股股东证件种类"*/
		LODOP.ADD_PRINT_TEXT(760,387,100,20,openBookData.endDatePartner);/*"控股股东证件到期日"*/
		LODOP.ADD_PRINT_TEXT(759,492,158,20,openBookData.idNoPartner);/*"控股股东证件号码"*/
		LODOP.ADD_PRINT_TEXT(778,224,89,20, openBookData.controlPeople);/*"实际控制人姓名"*/
		LODOP.ADD_PRINT_TEXT(781,318,80,20, openBookData.idTypeControlText);/*"实际控制人证件种类"*/
		LODOP.ADD_PRINT_TEXT(780,387,100,20,openBookData.endDateControl);/*"实际控制让人证件到期日"*/
		LODOP.ADD_PRINT_TEXT(778,494,158,20,openBookData.idNoControl);/*"实际控制人证件号码"*/
		
		var vPeople = openBookData.authorize.authorizePeople.split('||');
		var count  = 0;
		for(var i = 0; i<vPeople.length; i++){
			if(count==2){
				break;
			}
			var people = vPeople[i].split(',');
			if(people.length>1){
				if(people[5].indexOf("H")>-1){
					LODOP.ADD_PRINT_TEXT(802+count*21,255,64,20,  people[0]);/*"姓名1"*/
					LODOP.ADD_PRINT_TEXT(802+count*21,388,100,20, people[4]);/*"联系电话1"*/
					count++;
				}
			}
		}
		//LODOP.ADD_PRINT_TEXT(802,255,64,20, openBookData.);/*"大额交易确认人姓名1"*/
		//LODOP.ADD_PRINT_TEXT(802,388,100,20,openBookData.);/*"移动电话1"*/
		//LODOP.ADD_PRINT_TEXT(799,573,79,20, openBookData.);/*"办公室电话1"*/
		//LODOP.ADD_PRINT_TEXT(823,254,62,20, openBookData.);/*"大额交易确认人2"*/
		//LODOP.ADD_PRINT_TEXT(824,389,100,20,openBookData.);/*"移动电话2"*/
		//LODOP.ADD_PRINT_TEXT(822,571,85,20, openBookData.);/*"办公室电话2"*/
		
		LODOP.ADD_PRINT_TEXT(867,213,146,20,openBookData.openBankName);/*"开户银行名称"*/
		LODOP.ADD_PRINT_TEXT(866,493,162,20,openBookData.openBankCode);/*"开户银行代码"*/
		LODOP.ADD_PRINT_TEXT(886,213,146,20,openBookData.accountName);/*"账户名称"*/
		LODOP.ADD_PRINT_TEXT(888,494,161,20,openBookData.accountCode);/*"账号"*/
		//LODOP.ADD_PRINT_TEXT(906,226,136,20,openBookData.checkNumber);/*"开户人开户核准证编号"*/
		LODOP.ADD_PRINT_TEXT(908,576,79,20, openBookData.openDate);/*"开户日期"*/
	}
</script>
