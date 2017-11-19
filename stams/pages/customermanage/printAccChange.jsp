<%@ page language="java" pageEncoding="UTF-8"%>
<script language="javascript" type="text/javascript">
	var accChangeData;
	var LODOP; //声明为全局变量 
	function prn_print(pageNum) {
		if(pageNum==0){//授权书
			CreateForm0Page();	
			//LODOP.PRINT();
			LODOP.PREVIEW();
		}
		if(pageNum==1){//无附加信息
			CreateForm1Page();	
			//LODOP.PRINT();
			LODOP.PREVIEW();
		}
		if(pageNum==2){//含附加信息
			CreateForm2Page();	
			//LODOP.PRINT();
			LODOP.PREVIEW();
		}
		if(pageNum==3){//关联企业
			CreateForm3Page();	
			//LODOP.PRINT();
			LODOP.PREVIEW();
		}
		if(pageNum==4){//临时、专用变更
			CreateForm4Page();	
			//LODOP.PRINT();
			LODOP.PREVIEW();
		}
		if(pageNum==5){//预留印鉴变更
			CreateForm5Page();	
			//LODOP.PRINT();
			LODOP.PREVIEW();
		}
		
		if(pageNum==6){//临时存款账户展期申请书
			CreateForm6Page();	
			//LODOP.PRINT();
			LODOP.PREVIEW();
		}
		if(pageNum==7){//补换发开户许可证
			CreateForm7Page();	
			//LODOP.PRINT();
			LODOP.PREVIEW();
		}
		if(pageNum==8){//外汇
			CreateForm8Page();	
			//LODOP.PRINT();
			LODOP.PREVIEW();
		}
	}
	
	function CreateForm0Page(){
		LODOP=getLodop();
		LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\业务授权书（开立、变更、撤销均适用）.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		LODOP.ADD_PRINT_TEXT(126,110,183,20,accChangeData.openBankName);/*"中国银行地址"*/
		LODOP.ADD_PRINT_TEXT(158,124,229,20,accChangeData.companyName);/*"单位名称"*/
		LODOP.ADD_PRINT_TEXT(160,392,137,20,accChangeData.accountCode);/*"账号"*/
		LODOP.ADD_PRINT_TEXT(189,55,100,20, accChangeData.newLinkMan);/*"法人名称"*/
		
		var vPeople = accChangeData.authorizePeople.split('||');
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
				LODOP.ADD_PRINT_TEXT(251+i*30,512,80,20, people[5]);/*"授权项选择1"*/
				LODOP.ADD_PRINT_TEXT(251+i*30,612,26,20, toChineseNum(people[5].split(".").length));/*"授权项统计大写1"*/
			}
		}
		var vContent = accChangeData.authorizeContent;
		LODOP.ADD_PRINT_TEXT(403,306,10,20,"√");/*"人民币单位银行结算账户类型-变更"*/
		LODOP.ADD_PRINT_TEXT(600,211,482,20,vContent.split(",")[0]);/*其他*/
		if(vContent.indexOf("D1")>-1){
			LODOP.ADD_PRINT_TEXT(492,375,10,20, "√");/*"预留签章样式类型-本单位公章"*/
		}
		if(vContent.indexOf("D2")>-1){
			LODOP.ADD_PRINT_TEXT(492,470,10,20, "√");/*"预留签章样式-财务专用章"*/
		}
		if(vContent.indexOf("E1")>-1){
			LODOP.ADD_PRINT_TEXT(515,334,10,20,"√");/*"变更预留签章样式类型-个人签章"*/
		}
		if(vContent.indexOf("E2")>-1){
			LODOP.ADD_PRINT_TEXT(515,428,10,20,"√");/*"变更预留签章样式类型-本单位公章"*/
		}
		if(vContent.indexOf("E3")>-1){
			LODOP.ADD_PRINT_TEXT(515,523,10,20,"√");/*"变更预留签章样式类型-财务专用章"*/
		}
	}
	
	function CreateForm1Page(){
		LODOP=getLodop();
		LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\变更申请书1.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		LODOP.ADD_PRINT_TEXT(178,235,421,20,accChangeData.oldAccountName);/*"账户名称"*/
		LODOP.ADD_PRINT_TEXT(199,235,143,20,accChangeData.openBankCode);/*"开户银行代码"*/
		LODOP.ADD_PRINT_TEXT(199,472,185,20,accChangeData.accountCode);/*"账号"*/
		var accountType = accChangeData.accountType;/* 账户性质 */
		if(accountType == "0"){
			LODOP.ADD_PRINT_TEXT(221,282,15,20,"√");
		}else if(accountType == "1"){
			LODOP.ADD_PRINT_TEXT(221,356,15,20,"√");
		}else if(accountType <5){
			LODOP.ADD_PRINT_TEXT(221,431,15,20,"√");
		}else if(accountType <7){
			LODOP.ADD_PRINT_TEXT(221,504,15,20,"√");
		}
		LODOP.ADD_PRINT_TEXT(243,234,423,20,accChangeData.checkNumber);/*"开户许可证核准号"*/
		LODOP.ADD_PRINT_TEXT(285,236,422,20,accChangeData.accountName);/*"账户名称"*/
		LODOP.ADD_PRINT_TEXT(307,236,206,20,accChangeData.registAddress.split(",")[2]+accChangeData.registAddress.split(",")[3]);/*"注册地址"*/
		LODOP.ADD_PRINT_TEXT(329,235,205,20,accChangeData.officeAddress.split(",")[2]+accChangeData.officeAddress.split(",")[3]);/*"通讯地址"*/
		LODOP.ADD_PRINT_TEXT(308,516,137,20,accChangeData.postCode);/*"注册地址邮政编码"*/
		LODOP.ADD_PRINT_TEXT(329,516,136,20,accChangeData.postCodeNews);/*"通讯地址邮政编码"*/
		LODOP.ADD_PRINT_TEXT(351,235,419,20,accChangeData.mobileCode);/*"电话"*/
		LODOP.ADD_PRINT_TEXT(372,234,419,20,accChangeData.registMoney+accChangeData.registMoneyTypeText);/*"注册资本币种及金额"*/
		LODOP.ADD_PRINT_TEXT(394,234,422,20,accChangeData.fileTypeText);/*"证明文件种类"*/
		LODOP.ADD_PRINT_TEXT(416,234,193,20,accChangeData.fileNumber);/*"证明文件编号"*/
		LODOP.ADD_PRINT_TEXT(416,516,141,20,accChangeData.fileEndDate);/*"文件到期日"*/
		LODOP.ADD_PRINT_TEXT(438,234,429,20,accChangeData.busiScope);/*"经营范围"*/
		LODOP.ADD_PRINT_TEXT(461,288,374,20,accChangeData.linkMan);/*"姓名"*/
		LODOP.ADD_PRINT_TEXT(483,289,136,20,getIdTypeText(accChangeData.idType));/*"证件种类"*/
		LODOP.ADD_PRINT_TEXT(481,517,147,20,accChangeData.linkIdEndDate);/*"证件到期日"*/
		LODOP.ADD_PRINT_TEXT(504,289,372,20,accChangeData.idNumber);/*"证件号码"*/
		LODOP.ADD_PRINT_TEXT(554,291,372,20,accChangeData.chargeCheckNumber);/*"上级法人或主管单位的基本存款账户核准号"*/
		LODOP.ADD_PRINT_TEXT(582,291,370,20,accChangeData.chargeLinkMan);/*"姓名"*/
		LODOP.ADD_PRINT_TEXT(604,290,135,20,getIdTypeText(accChangeData.chargeIdType));/*"证件种类"*/
		LODOP.ADD_PRINT_TEXT(603,517,145,20,accChangeData.chargeLicenseEndDate);/*"证件到期日"*/
		LODOP.ADD_PRINT_TEXT(625,290,374,20,accChangeData.chargeIdNumber);/*"证件号码"*/
	}
	
	function CreateForm2Page(){
		LODOP=getLodop();
		LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\变更申请书2.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		LODOP.ADD_PRINT_TEXT(178,235,421,20,accChangeData.oldAccountName);/*"账户名称"*/
		LODOP.ADD_PRINT_TEXT(199,235,143,20,accChangeData.openBankCode);/*"开户银行代码"*/
		LODOP.ADD_PRINT_TEXT(199,472,185,20,accChangeData.accountCode);/*"账号"*/
		var accountType = accChangeData.accountType;/* 账户性质 */
		if(accountType == "0"){
			LODOP.ADD_PRINT_TEXT(221,282,15,20,"√");
		}else if(accountType == "1"){
			LODOP.ADD_PRINT_TEXT(221,356,15,20,"√");
		}else if(accountType <5){
			LODOP.ADD_PRINT_TEXT(221,431,15,20,"√");
		}else if(accountType <7){
			LODOP.ADD_PRINT_TEXT(221,504,15,20,"√");
		}
		LODOP.ADD_PRINT_TEXT(243,234,423,20,accChangeData.checkNumber);/*"开户许可证核准号"*/
		LODOP.ADD_PRINT_TEXT(285,236,422,20,accChangeData.accountName);/*"账户名称"*/
		LODOP.ADD_PRINT_TEXT(307,236,206,20,accChangeData.registAddress.split(",")[2]+accChangeData.registAddress.split(",")[3]);/*"注册地址"*/
		LODOP.ADD_PRINT_TEXT(329,235,205,20,accChangeData.officeAddress.split(",")[2]+accChangeData.officeAddress.split(",")[3]);/*"通讯地址"*/
		LODOP.ADD_PRINT_TEXT(308,516,137,20,accChangeData.postCode);/*"注册地址邮政编码"*/
		LODOP.ADD_PRINT_TEXT(329,516,136,20,accChangeData.postCodeNews);/*"通讯地址邮政编码"*/
		LODOP.ADD_PRINT_TEXT(351,235,419,20,accChangeData.mobileCode);/*"电话"*/
		LODOP.ADD_PRINT_TEXT(372,234,419,20,accChangeData.registMoney+accChangeData.registMoneyTypeText);/*"注册资本币种及金额"*/
		LODOP.ADD_PRINT_TEXT(394,234,422,20,accChangeData.fileTypeText);/*"证明文件种类"*/
		LODOP.ADD_PRINT_TEXT(416,234,193,20,accChangeData.fileNumber);/*"证明文件编号"*/
		LODOP.ADD_PRINT_TEXT(416,516,141,20,accChangeData.fileEndDate);/*"文件到期日"*/
		LODOP.ADD_PRINT_TEXT(438,234,429,20,accChangeData.busiScope);/*"经营范围"*/
		LODOP.ADD_PRINT_TEXT(461,288,374,20,accChangeData.linkMan);/*"姓名"*/
		LODOP.ADD_PRINT_TEXT(483,289,136,20,getIdTypeText(accChangeData.idType));/*"证件种类"*/
		LODOP.ADD_PRINT_TEXT(481,514,147,20,accChangeData.linkIdEndDate);/*"证件到期日"*/
		LODOP.ADD_PRINT_TEXT(504,289,372,20,accChangeData.idNumber);/*"证件号码"*/
		LODOP.ADD_PRINT_TEXT(554,291,372,20,accChangeData.chargeCheckNumber);/*"上级法人或主管单位的基本存款账户核准号"*/
		LODOP.ADD_PRINT_TEXT(582,291,370,20,accChangeData.chargeLinkMan);/*"姓名"*/
		LODOP.ADD_PRINT_TEXT(604,290,135,20,getIdTypeText(accChangeData.chargeIdType));/*"证件种类"*/
		LODOP.ADD_PRINT_TEXT(603,517,145,20,accChangeData.chargeLicenseEndDate);/*"证件到期日"*/
		LODOP.ADD_PRINT_TEXT(625,290,374,20,accChangeData.chargeIdNumber);/*"证件号码"*/
		
		LODOP.ADD_PRINT_TEXT(809,177,312,20,accChangeData.accountEnName);/*"存款人英文名称"*/
		LODOP.ADD_PRINT_TEXT(810,554,115,20,accChangeData.faxCode);/*"传真号码"*/
		LODOP.ADD_PRINT_TEXT(831,137,169,20,accChangeData.companyType);/*"企业类型"*/
		LODOP.ADD_PRINT_TEXT(831,386,100,20,accChangeData.peopleSonType);/*"客户子类型"*/
		LODOP.ADD_PRINT_TEXT(831,554,115,20,accChangeData.busiType);/*"行业代码"*/
		LODOP.ADD_PRINT_TEXT(853,136,293,20,accChangeData.registDate);/*"注册日期"*/
		LODOP.ADD_PRINT_TEXT(852,518,147,20,accChangeData.email);/*"电子邮件地址"*/
		LODOP.ADD_PRINT_TEXT(897,192,116,20,accChangeData.clientMoneyManName);/*"财务负责人姓名"*/
		LODOP.ADD_PRINT_TEXT(897,310,115,20,getIdTypeText(accChangeData.clientIdNameMoney));/*"财务负责人证件种类"*/
		LODOP.ADD_PRINT_TEXT(897,430,115,20,accChangeData.clientEndDateMoney);/*"财务负责人证件到期日"*/
		LODOP.ADD_PRINT_TEXT(897,551,115,20,accChangeData.clientIdNoMoney);/*"财务负责人证件号码"*/
		LODOP.ADD_PRINT_TEXT(919,192,116,20,accChangeData.partnerPeople);/*"控股股东姓名"*/
		LODOP.ADD_PRINT_TEXT(919,310,115,20,getIdTypeText(accChangeData.idTypePartner));/*"控股股东证件种类"*/
		LODOP.ADD_PRINT_TEXT(918,430,115,20,accChangeData.endDatePartner);/*"控股股东证件到期日"*/
		LODOP.ADD_PRINT_TEXT(918,551,115,20,accChangeData.idNoPartner);/*"控股股东证件号码"*/
		LODOP.ADD_PRINT_TEXT(941,192,116,20,accChangeData.controlPeople);/*"实际控制人姓名"*/
		LODOP.ADD_PRINT_TEXT(940,310,115,20,getIdTypeText(accChangeData.idTypeControl));/*"实际控制人证件种类"*/
		LODOP.ADD_PRINT_TEXT(940,430,115,20,accChangeData.endDateControl);/*"实际控制人证件到期日"*/
		LODOP.ADD_PRINT_TEXT(940,551,115,20,accChangeData.idNoControl);/*"实际控制人证件号码"*/
		LODOP.ADD_PRINT_TEXT(962,180,200,20,accChangeData.clientContactManName);/*"联系人姓名"*/
		LODOP.ADD_PRINT_TEXT(962,510,200,20,accChangeData.clientTelContact);/*"联系人电话"*/
	}
	
	function CreateForm3Page(){
		LODOP=getLodop();
		LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\关联企业表.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
	
		var vCompany = accChangeData.relationCompany;
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
		var vPartner = accChangeData.relationPartner;
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
		LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\变更内设机构附页.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		LODOP.ADD_PRINT_TEXT(216,250,432,20,accChangeData.depositorName);/*"存款人名称"*/
		LODOP.ADD_PRINT_TEXT(246,250,431,20,accChangeData.oldAccountName);/*"账户名称"*/
		LODOP.ADD_PRINT_TEXT(275,250,110,20,accChangeData.openBankCode);/*"开户银行代码"*/
		LODOP.ADD_PRINT_TEXT(275,414,268,20,accChangeData.accountCode);/*"账号"*/
		LODOP.ADD_PRINT_TEXT(305,250,435,20,accChangeData.checkNumber);/*"开户许可证核准号"*/
		LODOP.ADD_PRINT_TEXT(364,248,436,20,accChangeData.departName);/*"项目部名称"*/
		LODOP.ADD_PRINT_TEXT(393,248,433,20,accChangeData.departTel);/*"项目部电话"*/
		LODOP.ADD_PRINT_TEXT(422,248,433,20,accChangeData.departAddress);/*"项目部地址"*/
		LODOP.ADD_PRINT_TEXT(450,247,435,20,accChangeData.departPostCode);/*"项目部邮编"*/
		LODOP.ADD_PRINT_TEXT(479,322,357,20,accChangeData.principleName);/*"项目部负责人姓名"*/
		LODOP.ADD_PRINT_TEXT(509,322,361,20,getIdTypeText(accChangeData.idType));/*"项目部负责人证件类型"*/
		LODOP.ADD_PRINT_TEXT(540,321,355,20,accChangeData.idNo);/*"项目部负责人证件号码"*/
	}
	
	function CreateForm5Page(){
		LODOP=getLodop();
		LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\变更预留印鉴申请书.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		LODOP.ADD_PRINT_TEXT(141,246,125,20,$("#bankName").val());/*"银行名称"*/
		LODOP.ADD_PRINT_TEXT(165,258,253,20,accChangeData.companyName);/*"单位名称"*/
		LODOP.ADD_PRINT_TEXT(189,220,217,20,accChangeData.accountCode);/*"账号"*/
		var chose = accChangeData.changeTypes;
		if(chose.indexOf("1")>-1){
			LODOP.ADD_PRINT_TEXT(239,189,10,20, "√");/*"变更原因-单位公章/财务专用章"*/
		}
		if(chose.indexOf("1")>-1){
			LODOP.ADD_PRINT_TEXT(263,189,10,20, "√");/*"变更原因-法定代表人或单位负责人"*/
		}
		if(chose.indexOf("1")>-1){
			LODOP.ADD_PRINT_TEXT(312,189,10,20, "√");/*"变更原因-被授权的签字人"*/
		}
		if(chose.indexOf("1")>-1){
			LODOP.ADD_PRINT_TEXT(335,189,10,20, "√");/*"变更原因-其他"*/
		}
		LODOP.ADD_PRINT_TEXT(261,397,89,20, accChangeData.beforeManName);/*"取消"*/
		LODOP.ADD_PRINT_TEXT(260,547,95,20, accChangeData.afterManName);/*"变更为"*/
		LODOP.ADD_PRINT_TEXT(285,210,201,20,accChangeData.afterManId);/*"身份证号码"*/
		LODOP.ADD_PRINT_TEXT(285,533,100,20,accChangeData.afterManDate);/*"身份证到期日"*/
		LODOP.ADD_PRINT_TEXT(335,315,210,20,accChangeData.other);/*"其他"*/
		//LODOP.ADD_PRINT_TEXT(384,162,21,20, accChangeData.);/*"人数"*/
		LODOP.ADD_PRINT_TEXT(448,107,95,20, accChangeData.name1);/*"姓名1"*/
		LODOP.ADD_PRINT_TEXT(449,207,75,20, getIdTypeText(accChangeData.idType1));/*"证件种类1"*/
		LODOP.ADD_PRINT_TEXT(448,290,174,20,accChangeData.idNo1);/*"证件号码1"*/
		LODOP.ADD_PRINT_TEXT(448,471,105,20,accChangeData.idEndDate1);/*"证件到期日1"*/
		LODOP.ADD_PRINT_TEXT(448,582,100,20,accChangeData.tel1);/*"联系电话1"*/
		LODOP.ADD_PRINT_TEXT(480,107,95,20, accChangeData.name2);/*"姓名2"*/
		LODOP.ADD_PRINT_TEXT(480,207,75,20, getIdTypeText(accChangeData.idType2));/*"证件种类2"*/
		LODOP.ADD_PRINT_TEXT(480,288,175,20,accChangeData.idNo2);/*"证件号码2"*/
		LODOP.ADD_PRINT_TEXT(479,472,105,20,accChangeData.idEndDate2);/*"证件到期日2"*/
		LODOP.ADD_PRINT_TEXT(479,582,100,20,accChangeData.tel2);/*"联系电话2"*/
		LODOP.ADD_PRINT_TEXT(509,108,95,20, accChangeData.name3);/*"姓名3"*/
		LODOP.ADD_PRINT_TEXT(509,207,75,20, getIdTypeText(accChangeData.idType3));/*"证件种类3"*/
		LODOP.ADD_PRINT_TEXT(511,289,173,20,accChangeData.idNo3);/*"证件号码3"*/
		LODOP.ADD_PRINT_TEXT(511,472,105,20,accChangeData.idEndDate3);/*"证件到期日3"*/
		LODOP.ADD_PRINT_TEXT(511,582,100,20,accChangeData.tel3);/*"联系电话3"*/
		LODOP.ADD_PRINT_TEXT(575,173,100,20,accChangeData.doManName);/*"我单位人员名称"*/
		LODOP.ADD_PRINT_TEXT(606,209,78,20, getIdTypeText(accChangeData.doManIdType));/*"身份证件种类"*/
		LODOP.ADD_PRINT_TEXT(605,358,160,20,accChangeData.doManIdNo);/*"证件号码"*/
		LODOP.ADD_PRINT_TEXT(638,197,127,20,accChangeData.doManEndDate);/*"证件到期日"*/
		LODOP.ADD_PRINT_TEXT(638,419,163,20,accChangeData.doManTel);/*"联系电话"*/
		LODOP.ADD_PRINT_TEXT(663,223,38,20, accChangeData.useDate.split("-")[0]);/*"年"*/
		LODOP.ADD_PRINT_TEXT(663,262,28,20, accChangeData.useDate.split("-")[1]);/*"月"*/
		LODOP.ADD_PRINT_TEXT(663,303,32,20, accChangeData.useDate.split("-")[2]);/*"日"*/
		LODOP.ADD_PRINT_TEXT(662,493,77,20, accChangeData.oldProveNo);/*"编号"*/
	}
	
	function CreateForm6Page(){
		LODOP=getLodop();
		LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\临时存款账户展期申请书.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		LODOP.ADD_PRINT_TEXT(182,206,473,20,accChangeData.depositorName);/*"存款人名称"*/
		LODOP.ADD_PRINT_TEXT(212,205,475,20,accChangeData.registAddress);/*"地址"*/
		LODOP.ADD_PRINT_TEXT(239,204,157,20,accChangeData.postCode);/*"邮编"*/
		LODOP.ADD_PRINT_TEXT(242,527,160,20,accChangeData.mobileCode);/*"电话"*/
		LODOP.ADD_PRINT_TEXT(270,203,157,20,accChangeData.accountCode);/*"账号"*/
		LODOP.ADD_PRINT_TEXT(269,527,159,20,accChangeData.checkNumber);/*"开户核准号"*/
		if(accChangeData.openDate.split("-").length==3){
			LODOP.ADD_PRINT_TEXT(295,230,49,20, accChangeData.openDate.split("-")[0]);/*"开户年"*/
			LODOP.ADD_PRINT_TEXT(295,294,30,20, accChangeData.openDate.split("-")[1]);/*"开户月"*/
			LODOP.ADD_PRINT_TEXT(295,327,30,20, accChangeData.openDate.split("-")[2]);/*"开户日"*/
		}
		if(accChangeData.accountEndDate.split("-").length==3){
			LODOP.ADD_PRINT_TEXT(296,552,48,20, accChangeData.accountEndDate.split("-")[0]);/*"有效期年"*/
			LODOP.ADD_PRINT_TEXT(296,617,30,20, accChangeData.accountEndDate.split("-")[1]);/*"有效期月"*/
			LODOP.ADD_PRINT_TEXT(296,650,30,20, accChangeData.accountEndDate.split("-")[2]);/*"有效期日"*/
		}
		LODOP.ADD_PRINT_TEXT(327,205,159,20,accChangeData.fileTypeText);/*"开户证明文件种类"*/
		LODOP.ADD_PRINT_TEXT(328,530,163,20,accChangeData.fileEndDate);/*"开户证明文件有效期至"*/
		LODOP.ADD_PRINT_TEXT(383,81,278,175,accChangeData.extendReason);/*"展期原因"*/
		if(accChangeData.extendEndDate.split("-").length==3){
			LODOP.ADD_PRINT_TEXT(573,222,62,20, accChangeData.extendEndDate.split("-")[0]);/*"申请展期有效期年"*/
			LODOP.ADD_PRINT_TEXT(573,294,29,20, accChangeData.extendEndDate.split("-")[1]);/*"申请展期有效期月"*/
			LODOP.ADD_PRINT_TEXT(573,329,28,20, accChangeData.extendEndDate.split("-")[2]);/*"申请展期有效期日"*/
		}
		if(accChangeData.passExtendEndDate.split("-").length==3){
			LODOP.ADD_PRINT_TEXT(573,552,48,20, accChangeData.passExtendEndDate.split("-")[0]);/*"批准展期有效期年"*/
			LODOP.ADD_PRINT_TEXT(573,617,30,20, accChangeData.passExtendEndDate.split("-")[1]);/*"批准展期有效期月"*/
			LODOP.ADD_PRINT_TEXT(573,650,30,20, accChangeData.passExtendEndDate.split("-")[2]);/*"批准展期有效期日"*/
		}
		
		LODOP.ADD_PRINT_TEXT(604,204,154,20,accChangeData.fileTypeExtendText);/*"证明文件种类"*/
		if(accChangeData.fileEndDateExtend.split("-").length==3){
			LODOP.ADD_PRINT_TEXT(603,554,57,20, accChangeData.fileEndDateExtend.split("-")[0]);/*"展期证明文件有效期年"*/
			LODOP.ADD_PRINT_TEXT(603,619,32,20, accChangeData.fileEndDateExtend.split("-")[1]);/*"展期证明文件有效期月"*/
			LODOP.ADD_PRINT_TEXT(603,654,30,20, accChangeData.fileEndDateExtend.split("-")[2]);/*"展期证明文件有效期日"*/
		}
		
	}
	function CreateForm7Page(){
		LODOP=getLodop();
		LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\补换发开户许可证.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
	
		LODOP.ADD_PRINT_TEXT(220,171,508,20,accChangeData.accountName);/*"账户名称"*/
		LODOP.ADD_PRINT_TEXT(274,234,447,20,accChangeData.openBankName);/*"开户行名称"*/
		LODOP.ADD_PRINT_TEXT(327,230,170,20,accChangeData.openBankCode);/*"开户行代码"*/
		LODOP.ADD_PRINT_TEXT(328,493,189,20,accChangeData.accountCode);/*"账号"*/
		if(accChangeData.accountType==0){
			LODOP.ADD_PRINT_TEXT(379,340,25,25, "√");/*"账户性质选择-基本"*/
		}
		if(accChangeData.accountType==5){
			LODOP.ADD_PRINT_HTM(379,409,25,25, "√");/*"账户性质选择-临时"*/
		}
		if(accChangeData.accountType==2){
			LODOP.ADD_PRINT_HTM(379,526,25,25, "√");/*"账户性质选择-预算"*/
		}
		if(accChangeData.accountType==1){
			LODOP.ADD_PRINT_HTM(380,641,25,25, "√");/*"账户性质选择-QFII（专用）"*/
		}
		LODOP.ADD_PRINT_TEXT(430,235,441,50,accChangeData.applyReason);/*"申请补（换）发原因"*/
		LODOP.ADD_PRINT_TEXT(494,233,441,20,accChangeData.checkNumber);/*"原开户许可证核准号"*/
	}
	
	function CreateForm8Page(){
		LODOP=getLodop();
		LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\外汇账户变更.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		LODOP.ADD_PRINT_TEXT(137,245,406,20,accChangeData.oldAccountName);/*"账户名称"*/
		LODOP.ADD_PRINT_TEXT(157,245,141,20,accChangeData.openBankCode);/*"开户银行代码"*/
		LODOP.ADD_PRINT_TEXT(157,505,143,20,accChangeData.accountCode);/*"账号"*/
		//LODOP.ADD_PRINT_TEXT(178,318,20,20, "账户性质选择-经常项目");
		//LODOP.ADD_PRINT_TEXT(178,558,20,20, "账户性质选择-资本项目");
		LODOP.ADD_PRINT_TEXT(199,243,401,20,accChangeData.checkNumber);/*"开户许可证核准号"*/
		LODOP.ADD_PRINT_TEXT(241,247,398,20,accChangeData.accountName);/*"账户名称"*/
		LODOP.ADD_PRINT_TEXT(260,246,214,20,accChangeData.registAddress.split(",")[2]+accChangeData.registAddress.split(",")[3]);/*"注册地址"*/
		LODOP.ADD_PRINT_TEXT(261,531,115,20,accChangeData.officeAddress.split(",")[2]+accChangeData.officeAddress.split(",")[3]);/*"通讯地址"*/
		LODOP.ADD_PRINT_TEXT(281,530,115,20,accChangeData.postCode);/*"注册地址邮政编码"*/
		LODOP.ADD_PRINT_TEXT(281,245,213,20,accChangeData.postCodeNews);/*"通讯地址邮政编码"*/
		LODOP.ADD_PRINT_TEXT(300,245,401,20,accChangeData.mobileCode);/*"电话"*/
		LODOP.ADD_PRINT_TEXT(322,247,401,20,accChangeData.registMoney+accChangeData.registMoneyTypeText);/*"注册资本币种及金额"*/
		LODOP.ADD_PRINT_TEXT(343,247,402,20,accChangeData.fileTypeText);/*"证明文件种类"*/
		LODOP.ADD_PRINT_TEXT(363,247,184,20,accChangeData.fileNumber);/*"证明文件编号"*/
		LODOP.ADD_PRINT_TEXT(363,530,116,20,accChangeData.fileEndDate);/*"文件到期日"*/
		LODOP.ADD_PRINT_TEXT(384,246,404,20,accChangeData.busiScope);/*"经营范围"*/
		LODOP.ADD_PRINT_TEXT(404,301,344,20,accChangeData.linkMan);/*"姓名"*/
		LODOP.ADD_PRINT_TEXT(424,301,135,20,getIdTypeText(accChangeData.idType));/*"证件种类"*/
		LODOP.ADD_PRINT_TEXT(424,531,115,20,accChangeData.linkIdEndDate);/*"证件到期日"*/
		LODOP.ADD_PRINT_TEXT(445,301,343,20,accChangeData.idNumber);/*"证件号码"*/
		LODOP.ADD_PRINT_TEXT(492,300,338,20,accChangeData.chargeCheckNumber);/*"上级法人或主管单位的基本存款账户核准号"*/
		LODOP.ADD_PRINT_TEXT(526,300,352,20,accChangeData.chargeLinkMan);/*"姓名"*/
		LODOP.ADD_PRINT_TEXT(547,301,132,20,getIdTypeText(accChangeData.chargeIdType));/*"证件种类"*/
		LODOP.ADD_PRINT_TEXT(547,531,121,20,accChangeData.chargeLicenseEndDate);/*"证件到期日"*/
		LODOP.ADD_PRINT_TEXT(568,301,350,20,accChangeData.chargeIdNumber);/*"证件号码"*/
		LODOP.ADD_PRINT_TEXT(749,187,290,20,accChangeData.accountEnName);/*"存款人英文名称"*/
		LODOP.ADD_PRINT_TEXT(750,543,105,20,accChangeData.faxCode);/*"传真号码"*/
		LODOP.ADD_PRINT_TEXT(773,152,50,20, accChangeData.companyType);/*"企业类型"*/
		//LODOP.ADD_PRINT_TEXT(773,262,52,20, "贷款卡号");
		LODOP.ADD_PRINT_TEXT(774,379,100,20,accChangeData.peopleSonType);/*"客户子类型"*/
		LODOP.ADD_PRINT_TEXT(773,541,105,20,accChangeData.busiType);/*"行业代码"*/
		LODOP.ADD_PRINT_TEXT(796,188,451,20,accChangeData.email);/*"电子邮箱地址"*/
		LODOP.ADD_PRINT_TEXT(843,192,120,20,accChangeData.clientMoneyManName);/*"财务负责人姓名"*/
		LODOP.ADD_PRINT_TEXT(843,313,75,20, getIdTypeText(accChangeData.clientIdNameMoney));/*"财务负责人证件种类"*/
		LODOP.ADD_PRINT_TEXT(843,385,95,20, accChangeData.clientEndDateMoney);/*"财务负责人证件到期日"*/
		LODOP.ADD_PRINT_TEXT(842,489,166,20,accChangeData.clientIdNoMoney);/*"财务负责人证件号码"*/
		LODOP.ADD_PRINT_TEXT(866,191,115,20,accChangeData.partnerPeople);/*"控股股东姓名"*/
		LODOP.ADD_PRINT_TEXT(867,314,75,20, getIdTypeText(accChangeData.idTypePartner));/*"控股股东证件种类"*/
		LODOP.ADD_PRINT_TEXT(867,385,100,20,accChangeData.endDatePartner);/*"控股股东证件到期日"*/
		LODOP.ADD_PRINT_TEXT(865,489,160,20,accChangeData.idNoPartner);/*"控股股东证件号码"*/
		LODOP.ADD_PRINT_TEXT(890,191,110,20,accChangeData.controlPeople);/*"实际控制人姓名"*/
		LODOP.ADD_PRINT_TEXT(889,316,75,20, getIdTypeText(accChangeData.idTypeControl));/*"实际控制人证件种类"*/
		LODOP.ADD_PRINT_TEXT(890,384,100,20,accChangeData.endDateControl);/*"实际控制人证件到期日"*/
		LODOP.ADD_PRINT_TEXT(890,487,158,20,accChangeData.idNoControl);/*"实际控制人证件号码"*/
		
		var vPeople = accChangeData.authorizePeople.split('||');
		var count  = 0;
		for(var i = 0; i<vPeople.length; i++){
			if(count==2){
				break;
			}
			var people = vPeople[i].split(',');
			if(people.length>1){
				if(people[5].indexOf("H")>-1){
					LODOP.ADD_PRINT_TEXT(914+count*22,246,62,20,  people[0]);/*"姓名1"*/
					LODOP.ADD_PRINT_TEXT(914+count*22,374,110,20, people[4]);/*"联系电话1"*/
					count++;
				}
			}
		}
	}
</script>
