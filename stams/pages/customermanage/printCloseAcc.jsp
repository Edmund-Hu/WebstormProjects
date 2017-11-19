<%@ page language="java" pageEncoding="UTF-8"%>
<script language="javascript" type="text/javascript">
	var closeAccData;
	var LODOP; //声明为全局变量 
	function prn_print(pageNum) {
		if(pageNum==0){//授权书
			CreateForm0Page();	
			//LODOP.PRINT();
			LODOP.PREVIEW();
		}
		if(pageNum==1){//
			CreateForm1Page();	
			//LODOP.PRINT();
			LODOP.PREVIEW();
		}
		
		if(pageNum==2){//外汇
			CreateForm2Page();	
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
		
		LODOP.ADD_PRINT_TEXT(126,110,183,20,closeAccData.openBankName);/*"中国银行地址"*/
		LODOP.ADD_PRINT_TEXT(158,124,229,20,closeAccData.companyName);/*"单位名称"*/
		LODOP.ADD_PRINT_TEXT(160,392,137,20,closeAccData.accountCode);/*"账号"*/
		LODOP.ADD_PRINT_TEXT(189,55,100,20, closeAccData.newLinkMan);/*"法人名称"*/
		
		var vPeople = closeAccData.authorizePeople.split('||');
		LODOP.ADD_PRINT_TEXT(189,239,100,20,toChineseNum(vPeople.length));/*"授权项大写"*/
		
		for(var i = 0; i<vPeople.length; i++){
			if(i==5){
				break;
			}
			var people = vPeople[i].split(',');
			if(people.length>1){
				LODOP.ADD_PRINT_TEXT(250+i*30,57,90,20,  people[0]);/*"姓名1"*/
				LODOP.ADD_PRINT_TEXT(250+i*30,150,69,20, getIdTypeText(people[1]));/*"证件类型1"*/
				LODOP.ADD_PRINT_TEXT(250+i*30,221,182,20,people[2]);/*"证件号码1"*/
				LODOP.ADD_PRINT_TEXT(250+i*30,411,95,20, people[4]);/*"联系电话1"*/
				LODOP.ADD_PRINT_TEXT(251+i*30,512,80,20, people[5]);/*"授权项选择1"*/
				LODOP.ADD_PRINT_TEXT(251+i*30,612,26,20, toChineseNum(people[5].split(".").length));/*"授权项统计大写1"*/
			}
		}
		var vContent = closeAccData.authorizeContent;
		LODOP.ADD_PRINT_TEXT(399,404,10,20,"√");/*"人民币单位银行结算账户类型-撤销"*/
		LODOP.ADD_PRINT_TEXT(606,211,482,20,vContent.split(",")[0]);/*其他*/
		if(vContent.indexOf("D1")>-1){
			LODOP.ADD_PRINT_TEXT(490,377,10,20, "√");/*"预留签章样式类型-本单位公章"*/
		}
		if(vContent.indexOf("D2")>-1){
			LODOP.ADD_PRINT_TEXT(489,472,10,20, "√");/*"预留签章样式-财务专用章"*/
		}
		if(vContent.indexOf("E1")>-1){
			LODOP.ADD_PRINT_TEXT(513,337,10,20,"√");/*"变更预留签章样式类型-个人签章"*/
		}
		if(vContent.indexOf("E2")>-1){
			LODOP.ADD_PRINT_TEXT(512,431,10,20,"√");/*"变更预留签章样式类型-本单位公章"*/
		}
		if(vContent.indexOf("E3")>-1){
			LODOP.ADD_PRINT_TEXT(512,526,10,20,"√");/*"变更预留签章样式类型-财务专用章"*/
		}
	}
	
	function CreateForm1Page(){
		LODOP=getLodop();
		LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\撤销申请书.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
		
		LODOP.ADD_PRINT_TEXT(176,207,467,20,closeAccData.accountName);/*"账户名称"*/
		LODOP.ADD_PRINT_TEXT(204,206,467,20,closeAccData.openBankName);/*"开户银行名称"*/
		LODOP.ADD_PRINT_TEXT(232,207,200,20,closeAccData.openBankCode);/*"开户银行代码"*/
		LODOP.ADD_PRINT_TEXT(233,473,200,20,closeAccData.accountCode);/*"账号"*/
		
		var accountType = closeAccData.accountType;/* 账户性质 */
		if(accountType == "0"){
			LODOP.ADD_PRINT_TEXT(260,281,15,20,"√");
		}else if(accountType == "1"){
			LODOP.ADD_PRINT_TEXT(259,366,15,20,"√");
		}else if(accountType <5){
			LODOP.ADD_PRINT_TEXT(258,450,15,20,"√");
		}else if(accountType <7){
			LODOP.ADD_PRINT_TEXT(258,535,15,20,"√");
		}
		LODOP.ADD_PRINT_TEXT(289,207,465,20,closeAccData.checkNumber);/*"开户许可证核准号"*/
		
		LODOP.ADD_PRINT_TEXT(315,206,464,55,closeAccData.closeReason);/*"销户原因"*/
		if(closeAccData.blankProof==1){
			LODOP.ADD_PRINT_TEXT(375,221,15,20, "√");/*"有（否）未用重要空白凭证-无"*/
		}
		if(closeAccData.blankProof==2){
			LODOP.ADD_PRINT_TEXT(398,220,15,20, "√");/*"有（否）未用重要空白凭证-有，第一项"*/
		}
		if(closeAccData.blankProof==3){
			LODOP.ADD_PRINT_TEXT(419,220,15,20, "√");/*"有（否）未用重要空白凭证-有，第二项"*/
		}
		if(closeAccData.blankProof==4){
			LODOP.ADD_PRINT_TEXT(461,221,15,20, "√");/*"有（否）未用重要空白凭证-有，第三项"*/
		}
		LODOP.ADD_PRINT_TEXT(511,304,105,20,closeAccData.accountBalance);/*"账户余额"*/
		LODOP.ADD_PRINT_TEXT(511,536,147,20,closeAccData.interest);/*"利息"*/
		if(closeAccData.checked==1){
			LODOP.ADD_PRINT_TEXT(535,465,20,20, "√");/*"账户核对-是"*/
		}
		if(closeAccData.checked==0){
			LODOP.ADD_PRINT_TEXT(535,533,20,20, "√");/*"账户核对-否"*/
		}
		LODOP.ADD_PRINT_TEXT(560,291,260,20,closeAccData.operator);/*"单位经办人"*/
		LODOP.ADD_PRINT_TEXT(585,211,194,20,closeAccData.inputMoney);/*"本息汇入行"*/
		LODOP.ADD_PRINT_TEXT(583,481,194,20,closeAccData.inputAccount);/*"汇入账号"*/
		LODOP.ADD_PRINT_TEXT(611,199,121,20,closeAccData.name);/*"授权人姓名"*/
		LODOP.ADD_PRINT_TEXT(650,124,65,20, getIdTypeText(closeAccData.idType));/*"证件种类"*/
		LODOP.ADD_PRINT_TEXT(649,269,111,20,closeAccData.idNo);/*"证件号码"*/
		LODOP.ADD_PRINT_TEXT(668,154,74,20, closeAccData.idEndDate);/*"证件到期日"*/
		LODOP.ADD_PRINT_TEXT(668,307,100,20,closeAccData.mobile);/*"联系电话"*/
	}
	
	function CreateForm2Page(){
		LODOP=getLodop();
		LODOP.SET_LICENSES("北京中电亿商网络技术有限责任公司","653726081798577778794959892839","","");
		//LODOP.PRINT_INIT("Lodop测试");
		LODOP.SET_PRINT_STYLE("FontSize",10);
		LODOP.ADD_PRINT_SETUP_BKIMG("C:\\Users\\ZQ\\Desktop\\moban\\外汇账户撤销.jpg");
		LODOP.SET_SHOW_MODE("BKIMG_WIDTH",763);
		LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",1078);LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",1);
	
		LODOP.ADD_PRINT_TEXT(207,223,408,20,closeAccData.accountName);/*"中文账户名"*/
		//LODOP.ADD_PRINT_TEXT(246,225,403,20,closeAccData.);/*"英文账户名"*/
		//LODOP.ADD_PRINT_TEXT(274,169,464,55,closeAccData.);/*"详细地址"*/
		//LODOP.ADD_PRINT_TEXT(351,173,131,20,closeAccData.);/*"邮编"*/
		//LODOP.ADD_PRINT_TEXT(353,376,258,20,closeAccData.);/*"电话"*/
		LODOP.ADD_PRINT_TEXT(404,173,126,20,closeAccData.accountCode);/*"账号"*/
		//LODOP.ADD_PRINT_TEXT(403,458,20,20, closeAccData.);/*"账户性质-经常"*/
		//LODOP.ADD_PRINT_TEXT(401,582,20,20, closeAccData.);/*"账户性质-资本"*/
		LODOP.ADD_PRINT_TEXT(458,174,130,20,closeAccData.accountBalance);/*"账户余额"*/
		//LODOP.ADD_PRINT_TEXT(459,375,57,20, closeAccData.);/*"币种"*/
		LODOP.ADD_PRINT_TEXT(457,493,153,20,closeAccData.interest);/*"利息"*/
		//LODOP.ADD_PRINT_TEXT(516,221,421,20,closeAccData.);/*"开户核准件编号"*/
		LODOP.ADD_PRINT_TEXT(557,176,474,50,closeAccData.closeReason);/*"销户原因"*/
		LODOP.ADD_PRINT_TEXT(621,188,456,20,closeAccData.inputMoney);/*"本息汇入行"*/
		LODOP.ADD_PRINT_TEXT(686,188,456,20,closeAccData.inputAccount);/*"汇入行账号"*/
		if(closeAccData.checked==1){
			LODOP.ADD_PRINT_TEXT(734,349,20,20, "√");/*"账户核对-是"*/
		}
		if(closeAccData.checked==0){
			LODOP.ADD_PRINT_TEXT(735,419,20,20, "√");/*"账户核对-否"*/
		}
		LODOP.ADD_PRINT_TEXT(736,536,116,20,closeAccData.operator);/*"经办人"*/
	}
	
</script>
