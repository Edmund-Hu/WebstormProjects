<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="santai" uri="/tags/santai"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>账管系统开户</title>
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
<script type="text/javascript" src="js/common/validate.js"></script>
<script type="text/javascript" src="js/auto.js" ></script>
<script type="text/javascript">
	loading.show();
	//上一步、下一步
	var curr=1;
	function nextStep(){
  		if(curr!=null){
  			var useProtocol = "";
  			$('#protocol input:checkbox:checked').each(function(){
  				useProtocol += ($(this).val()+",");
  			});
  			if(useProtocol==""){
  				alert("请选择需要办理的业务协议");
  				return;
  			}
  			
  			if(!$('#divstep'+curr.toString()).form('validate')){
  				return;
  			};
       		$('#divstep'+curr.toString()).hide();
         	curr=Number(curr)+1;
        	$('#divstep'+curr.toString()).show();
        	if(curr==3){
        		$("#nextStep").hide();
        	}
        	$("#preStep").show();
   		}else{
          	$('#divstep1').show();
         	curr=1;
   		}
	}
	function preStep(){
  		if(curr!=null){
  			if(!$('#divstep'+curr.toString()).form('validate')){
  				return;
  			};
       		$('#divstep'+curr.toString()).hide();
         	curr=Number(curr)-1;
        	$('#divstep'+curr.toString()).show();
        	if(curr==1){
        		$("#preStep").hide();
        	}
        	$("#nextStep").show();
   		}else{
          	$('#divstep1').show();
         	curr=1;
   		}
	}
	$(function(){
		//controlBtnShow();
		
		controlCardInfo();
		
		/* $("#openBookDiv #accountType").combobox({
			onChange:function(){
				var vAccountType = $("#openBookDiv #accountType").combobox("getValue");
				controlDivShow(vAccountType);
			}
		}) */
		//存款人名称  和账户名 可能相同
		$("input",$("#openBookDiv #depositorName").next("span")).blur(function(){
			$("#recordDiv #accountName").textbox('setValue',$("#openBookDiv #depositorName").textbox("getValue"));
		})
		
		//如果选择的是身份证   出生日期则 从身份证截取
		$("input",$("#openBookDiv #depositorName").next("span")).blur(function(){
			$("#recordDiv #accountName").textbox('setValue',$("#openBookDiv #depositorName").textbox("getValue"));
		})
		
		//控制账户类型  需要填写的存在差异
		$("#openBasicAcc #accountType").combobox({
			onChange:function(){
				var vAccountType = $("#openBasicAcc #accountType").combobox("getValue");
				$("#openBookDiv #accountType").combobox("setValue",vAccountType);
				controlDivShow(vAccountType);
			}
		})
		
		$("#openBookDiv #accountType").combobox({
			onChange:function(){
				var vAccountType = $("#openBookDiv #accountType").combobox("getValue");
				controlDivShow(vAccountType);
			}
		})
		
		//征收机关  选中一个  另外一个置为 空
		$("#secondTelCode1,#secondTelCode2").combobox({
			onSelect:function(){
				var value = $(this).combobox("getValue");
				if(value!=""&&value!=null){
					$("#secondTelCode1,#secondTelCode2").combobox("setValue","");
				}
				$(this).combobox("setValue", value);
			}
		})
		
		
		var vAccountType = $("#openBookDiv #accountType").combobox("getValue");
		controlDivShow(vAccountType);
		
		init();
		var sts = $("#handleStatus").textbox("getValue");
		if(sts!=""){
			$("#openBasicAcc").window('close');
			if(sts>2){
				//页面不可编辑
				/* $("div input").each(
				function(){
					try{
						$(this).textbox('readonly',true);
					}catch(e){
						$(this).attr("disabled",true);
					}
				});
				$("div select").each(
				function(){
					$(this).combobox('readonly',true);
				});
				$("td a").each(
				function(){
						$(this).remove();
				}); */
			}
		}
		if(sts>2){
			$("#stepBtn").hide();
		}else{
			$("div[id*='divstep']").hide();
			$("#preStep").hide();
			$("div[id='divstep1']").show();
		} 
		
		if($('#checkRadio input:radio:checked').val()!="4"){
			$("#checkDiv").hide();
		}
		
		//对账单的寄送地址选择
		$(":radio[name='checkAddressType']").change(
			function(){
	        	if($(this).val()=="4"){
					$("#checkDiv").show();
				}else{
					$("#checkDiv").hide();
					$("#checkDiv input").val("");
				}
	   	 	}
		);
		$("#PD1Div,#PD2Div,#PD3Div,#PD4Div").window("close");
		$(":checkbox[name='PD']").change(
			function(){
				if($(this).is(':checked')){
					$("#"+$(this).val()+"Div").window("open");
				}else{
					//$("#"+$(this).val()+"Div input").val("");
				}
		   	}
		);
		
		loading.hide();
	})
	
	//处理证件信息   选择了三证合一   不用再填写证件信息
	function controlCardInfo(){
		$("#SZ").click(function(){
			if($(this).is(':checked')){
				var idNo = $("#divstep1 #fileNumber").textbox("getValue"); 
				var idEndDate = $("#divstep1 #fileEndDate").textbox("getValue");
				if(idNo==""||idEndDate==""){
					alert("请先输入证明文件编号和到期日");
					$(this).attr("checked",false);
					return;
				}
				
				$(".idNoCredit").textbox("setValue", idNo);
				$(".endDateCredit").textbox("setValue", idEndDate);
				$("#orgInstitCd").textbox("setValue", idNo.substring(8,17));
				$("#orgInstitEndDate").textbox("setValue", idEndDate);
				$(".idNoLicense").textbox("setValue", idNo);
				$(".endDateLicense").textbox("setValue", idEndDate);
				$("#countryTax").textbox("setValue", idNo);
				$(".endDateCountry").textbox("setValue", idEndDate);
				$("#areaTax").textbox("setValue", idNo);
				$(".endDateTax").textbox("setValue", idEndDate);
				         
				$("#cardInfoDiv").hide();
			}else{
				$("#cardInfoDiv input").val("");
				$("#cardInfoDiv").show();
			}
		});
	}
	
	//验证
	$.extend($.fn.validatebox.defaults.rules, {    
	    maxLength: {    
	        validator: function(value, param){  
	            return value.length <= param[0];    
	        },    
	        message: '最多输入{0}位字符.'   
	    },
	    number: {
			validator: function (value, param) {
				return /^[0-9]+.?[0-9]*$/.test(value);
			},
			message: '只能包括数字.'
		},
		englishCheckSub:{
			validator:function(value){
				return /^[a-zA-Z0-9]+$/.test(value);
			},
			message:"只能包括英文字母、数字."
		}
	});
	
	/**
	*动态添加表格行
	**/
	function addtr(table, col){
		var _len = $("#"+table+" tr").length;
		var row = "";
		for(var i=0; i<col ; i++){
			row +="<td><input class='easyui-textbox' style='width:100%;height:24px' /></td>";
		}
		$("#"+table).append("<tr id=" + _len + " align='center' >" +row+
			"<td><a href=\'#\' onclick=\"deltr(\'"+table+"\'," + _len + ")\">删除</a></td>" +
			"</tr>");
		 //$.parser.parse();
		$.parser.parse("#"+table);
	}
	
	//增加对公短信通 客户信息
	function addNoteInfo(){
		var _len = $("#dgkehu_tb tr").length;
		$("#dgkehu_tb").append("<tr id=" + _len + " align='center' >" +
				"<td><input class='easyui-textbox auto-input' alt='name' style='width:100%;height:24px' /></td>" +
				"<td><input class='easyui-textbox' alt='tel' style='width:100%;height:24px' /></td>" +
				"<td>"+
					"<select class='easyui-combobox' style='width:100%;' data-options='editable:false'>"+
						"<option value='1' >身份证</option>"+
						"<option value='2' >军官证</option>"+
						"<option value='3' >其他</option>"+
					"</select>"+
				"</td>" +
				"<td><input class='easyui-textbox' alt='card' style='width:100%;height:24px' /></td>" +
				"<td><a href=\'#\' onclick=\"deltr(\'dgkehu_tb\'," + _len + ")\">删除</a></td>" +
				"</tr>");
		 //$.parser.parse();
		$.parser.parse("#dgkehu_tb "+" tr[id='"+ _len +"']");
		autoInit("dgkehu_tb");
	}
	
	//增加授权人
	function addAuthorize(table){
		var dataStr = "data:[{a:'A',b:'A'},{a:'B',b:'B'},{a:'C',b:'C'},{a:'D',b:'D'},{a:'F',b:'F'},"+
		              	    "{a:'G',b:'G'},{a:'H',b:'H'},{a:'I',b:'I'},{a:'J',b:'J'},{a:'K',b:'K'}]"; 
		var _len = $("#"+table+" tr").length;
		$("#"+table).append("<tr id=" + _len + " align='center' >" +
			"<td><input class='easyui-textbox auto-input' alt='name' style='width:100%;height:24px' /></td>" +
			'<td>'+
				"<input class='easyui-combobox' alt='idType' style='width:100%;height:24px' url='getTypeEnum.action?typeCode=ID_TYPE'"+ 
				"data-options="+'"'+"valueField:'typeValue', textField:'typeName',editable:false"+'" '+" >"+
			'</td>'+
			"<td><input class='easyui-textbox' alt='card' style='width:100%;height:24px' /></td>" +
			"<td><input class='easyui-datebox' alt='date' style='width:100%;height:24px' data-options='editable:false' /></td>" +
			"<td><input class='easyui-textbox' alt='tel' style='width:100%;height:24px' /></td>" +
			"<td>"+
				"<input class='easyui-combobox' data-options="+'"'+"separator:'.',multiple:'true',editable:false,valueField:'a',textField:'b',"+dataStr+'"'+"style='width:100%;height:24px' >"+
			"</td>" +
			"<td><a href=\'#\' onclick=\"deltr(\'"+table+"\'," + _len + ")\">删除</a></td>" +
			"</tr>");
		 //$.parser.parse();
		$.parser.parse("#"+table+" tr[id='"+ _len +"']");
		autoInit(table);
	}
	
	//增加对公客户信息 的股东 和受益人tr
	function addClintTbtr(table){
		var _len = $("#"+table+" tr").length;
		$("#"+table).append("<tr id=" + _len + " align='center' >" +
			"<td><input class='easyui-textbox auto-input' alt='name' style='width:100%;height:24px' /></td>" +
			'<td>'+
			"<input class='easyui-combobox' alt='idType' style='width:100%;height:24px' url='getTypeEnum.action?typeCode=ID_TYPE'"+ 
			"data-options="+'"'+"valueField:'typeValue', textField:'typeName',editable:false"+'" '+" >"+
			'</td>'+
			"<td><input class='easyui-textbox' alt='card' style='width:100%;height:24px' /></td>" +
			"<td><input class='easyui-datebox' alt='date' style='width:100%;height:24px' data-options='editable:false' /></td>" +
			"<td><input class='easyui-textbox' style='width:100%;height:24px' /></td>" +
			"<td><a href=\'#\' onclick=\"deltr(\'"+table+"\'," + _len + ")\">删除</a></td>" +
			"</tr>");
		 //$.parser.parse();
		$.parser.parse("#"+table+" tr[id='"+ _len +"']");
		autoInit(table);
	}
	
	/**
	动态删除行
	*/
	var deltr = function(table,index) {
		this.$("#"+table+" tr[id='" + index + "']").remove(); //删除当前行
	}
	
	function gettrVal(table, col){
		var str="";
		var row = 1;
		$("#"+table).find("tr").each(function(){
			if(row==1){
				row++;
				return;
			}
			if(row>2){
				str+="||";
			}
		    var tdArr = $(this).children();
		    for(var i=0; i< col; i++){
		    	var vtd = "";
		    	if(i==5){//授权人中的多选下拉获取值
		    		vtd = tdArr.eq(i).children().combo("getText").trim().replace(",","，");
		    	}else{
		    		vtd = tdArr.eq(i).children().textbox("getValue").trim().replace(",","，");
		    	}
		    	if(i<col-1){
		    		str += vtd+",";
		    	}else{
		    		str += vtd;
		    	}
		    }
		    row++;
		})
		return str;
	} 
	
	function init(){
		var vRegistAddress = $("#openBookDiv #registAddress").textbox("getValue").split(',');
		$("#registAddressG").textbox("setValue",vRegistAddress[0]);
		$("#registAddressS").textbox("setValue",vRegistAddress[1]);
		$("#registAddressQ").textbox("setValue",vRegistAddress[2]);
		$("#registAddressD").textbox("setValue",vRegistAddress[3]);
		var vOfficeAddress = $("#openBookDiv #officeAddress").textbox("getValue").split(',');
		$("#officeAddressG").textbox("setValue",vOfficeAddress[0]);
		$("#officeAddressS").textbox("setValue",vOfficeAddress[1]);
		$("#officeAddressQ").textbox("setValue",vOfficeAddress[2]);
		$("#officeAddressD").textbox("setValue",vOfficeAddress[3]);
		
		/* <select class="easyui-combobox" style="width:100%;" data-options="editable:false">'+
		'<option value=""></option>'+
		'<option value="居民身份证" >居民身份证</option>'+
		'<option value="临时身份证" >临时身份证</option>'+
		'<option value="护照" >护照</option>'+
		'<option value="户口簿" >户口簿</option>'+
		'<option value="军人身份证件" >军人身份证件</option>'+
		'<option value="武装警察身份证件" >武装警察身份证件</option>'+
		'<option value="港澳居民往来内地通行证" >港澳居民往来内地通行证</option>'+
		'<option value="外交人员身份证" >外交人员身份证</option>'+
		'<option value="外国人居留许可证" >外国人居留许可证</option>'+
		'<option value="边民出入境通行证" >边民出入境通行证</option>'+
		'<option value="其他" >其他</option>'+
		'</select> */
		//对公客户信息 股东
		var vClientPartner = $("#openBookDiv #partner").textbox("getValue").split('||');
		for(var i = 0; i<vClientPartner.length; i++){
			var partner = vClientPartner[i].split(',');
			if(partner.length>1){
				$("#guquan_tb").append("<tr id=" + i + " align='center' >" +
				"<td><input class='easyui-textbox auto-input' alt='name' style='width:100%;height:24px' value='"+partner[0]+"' /></td>" +
				'<td>'+
					"<input class='easyui-combobox' alt='idType' style='width:100%;height:24px' url='getTypeEnum.action?typeCode=ID_TYPE'"+ 
					"data-options="+'"'+"valueField:'typeValue',textField:'typeName',editable:false"+'" '+"value='"+partner[1]+"' >"+
				'</td>'+
				"<td><input class='easyui-textbox' alt='card' style='width:100%;height:24px'  value='"+partner[2]+"'/></td>" +
				"<td><input class='easyui-datebox' alt='date' style='width:100%;height:24px' value='"+partner[3]+"' data-options='editable:false' /></td>" +
				"<td><input class='easyui-textbox' style='width:100%;height:24px' value='"+partner[4]+"' /></td>" +
				"<td><a href=\'#\' onclick=\"deltr(\'guquan_tb\'," + i + ")\">删除</a></td>" +
				"</tr>");
				
				/* $("#guquan_tb tr[id='"+ i +"']").children().eq(1).children().combobox("select",partner[1]); */
				$("#guquan_tb tr[id='"+ i +"']").children().eq(1).children().find("option[value='"+partner[1]+"']").attr("selected",true);
			 	//$.parser.parse();
				$.parser.parse("#guquan_tb");
				autoInit("guquan_tb");
			}
		}
		
		//对公客户信息受益权人
		var vBeneficiary = $("#openBookDiv #beneficiary").textbox("getValue").split('||');
		for(var i = 0; i<vBeneficiary.length; i++){
			var beneficiary = vBeneficiary[i].split(',');
			if(beneficiary.length>1){
				$("#quanyi_tb").append("<tr id=" + i + " align='center' >" +
				"<td><input class='easyui-textbox auto-input' alt='name' style='width:100%;height:24px' value='"+beneficiary[0]+"' /></td>" +
				'<td>'+
					"<input class='easyui-combobox' alt='idType' style='width:100%;height:24px' url='getTypeEnum.action?typeCode=ID_TYPE'"+ 
					"data-options="+'"'+"valueField:'typeValue', textField:'typeName',editable:false"+'" '+"value='"+beneficiary[1]+"' >"+
				'</td>'+
				"<td><input class='easyui-textbox' alt='card' style='width:100%;height:24px' value='"+beneficiary[2]+"'/></td>" +
				"<td><input class='easyui-datebox' alt='date' style='width:100%;height:24px' value='"+beneficiary[3]+"' data-options='editable:false' /></td>" +
				"<td><input class='easyui-textbox' style='width:100%;height:24px' value='"+beneficiary[4]+"' /></td>" +
				"<td><a href=\'#\' onclick=\"deltr(\'quanyi_tb\'," + i + ")\">删除</a></td>" +
				"</tr>");
			 	//$.parser.parse();
			 	$("#quanyi_tb tr[id='"+ i +"']").children().eq(1).children().find("option[value='"+beneficiary[1]+"']").attr("selected",true);
				$.parser.parse("#quanyi_tb");
				autoInit("quanyi_tb");
			}
		}
		
		//关联企业
		var vCompany = $("#openBookDiv #relationCompany").textbox("getValue").split('||');
		for(var i = 0; i<vCompany.length; i++){
			var company = vCompany[i].split(',');
			if(company.length>1){
				$("#glqiye_tb").append("<tr id=" + i + " align='center' >" +
				"<td><input class='easyui-textbox' style='width:100%;height:24px' value='"+company[0]+"' /></td>" +
				"<td><input class='easyui-textbox' style='width:100%;height:24px' value='"+company[1]+"' /></td>" +
				"<td><input class='easyui-textbox' style='width:100%;height:24px' value='"+company[2]+"' /></td>" +
				"<td><input class='easyui-textbox' style='width:100%;height:24px' value='"+company[3]+"' /></td>" +
				"<td><a href=\'#\' onclick=\"deltr(\'glqiye_tb\'," + i + ")\">删除</a></td>" +
				"</tr>");
			 	//$.parser.parse();
				$.parser.parse("#glqiye_tb");
			}
		}
		
		//股东
		var vRelationPartner = $("#openBookDiv #relationPartner").textbox("getValue").split('||');
		for(var i = 0; i<vRelationPartner.length; i++){
			var partner = vRelationPartner[i].split(',');
			if(partner.length>1){
				$("#glgudong_tb").append("<tr id=" + i + " align='center' >" +
				"<td><input class='easyui-textbox auto-input' alt='name' style='width:100%;height:24px' value='"+partner[0]+"' /></td>" +
				'<td>'+
					"<input class='easyui-combobox' alt='idType' style='width:100%;height:24px' url='getTypeEnum.action?typeCode=ID_TYPE'"+ 
					"data-options="+'"'+"valueField:'typeValue', textField:'typeName',editable:false"+'" '+"value='"+partner[1]+"' >"+
				'</td>'+
				"<td><input class='easyui-textbox' alt='card' style='width:100%;height:24px' value='"+partner[2]+"'/></td>" +
				"<td><input class='easyui-datebox' alt='date' style='width:100%;height:24px' value='"+partner[3]+"' data-options='editable:false' /></td>" +
				"<td><input class='easyui-textbox' style='width:100%;height:24px' value='"+partner[4]+"' /></td>" +
				"<td><a href=\'#\' onclick=\"deltr(\'glgudong_tb\'," + i + ")\">删除</a></td>" +
				"</tr>");
			 	//$.parser.parse();
			 	$("#glgudong_tb tr[id='"+ i +"']").children().eq(1).children().find("option[value='"+partner[1]+"']").attr("selected",true);
				$.parser.parse("#glgudong_tb");
				autoInit("glgudong_tb");
			}
		}
		
		//对公短信通 客户信息
		var vOpenNoteInfo = $("#openBookDiv #openNoteInfo").textbox("getValue").split('||');
		for(var i = 0; i<vOpenNoteInfo.length; i++){
			var personInfo = vOpenNoteInfo[i].split(',');
			if(personInfo.length>1){
				$("#dgkehu_tb").append("<tr id=" + i + " align='center' >" +
				"<td><input class='easyui-textbox auto-input' alt='name' style='width:100%;height:24px' value='"+personInfo[0]+"' /></td>" +
				"<td><input class='easyui-textbox' alt='tel' style='width:100%;height:24px' value='"+personInfo[1]+"'/></td>" +
				"<td>"+
					"<select class='easyui-combobox' style='width:100%;' value='"+personInfo[2]+"' data-options='editable:false'>"+
						"<option value='1' >身份证</option>"+
						"<option value='2' >军官证</option>"+
						"<option value='3' >其他</option>"+
					"</select>"+
				"</td>" +
				"<td><input class='easyui-textbox' alt='card' style='width:100%;height:24px' value='"+personInfo[3]+"' /></td>" +
				"<td><a href=\'#\' onclick=\"deltr(\'dgkehu_tb\'," + i + ")\">删除</a></td>" +
				"</tr>");
			 	//$.parser.parse();
			 	$("#dgkehu_tb tr[id='"+ i +"']").children().eq(1).children().find("option[value='"+personInfo[2]+"']").attr("selected",true);
				$.parser.parse("#dgkehu_tb");
				autoInit("dgkehu_tb");
			}
		}
		
		//被授权办理业务人
		var vPeople = $("#openBookDiv #authorizePeople").textbox("getValue").split('||');
		var dataStr = "data:[{a:'A',b:'A'},{a:'B',b:'B'},{a:'C',b:'C'},{a:'D',b:'D'},{a:'F',b:'F'},"+
  	    "{a:'G',b:'G'},{a:'H',b:'H'},{a:'I',b:'I'},{a:'J',b:'J'},{a:'K',b:'K'}]";
		for(var i = 0; i<vPeople.length; i++){
			var people = vPeople[i].split(',');
			if(people.length>1){
				$("#shouquan_tb").append("<tr id=" + i + " align='center' >" +
				"<td><input class='easyui-textbox auto-input' alt='name' style='width:100%;height:24px' value='"+people[0]+"' /></td>" +
				'<td>'+
				"<input class='easyui-combobox' alt='idType' style='width:100%;height:24px' url='getTypeEnum.action?typeCode=ID_TYPE'"+ 
				"data-options="+'"'+"valueField:'typeValue', textField:'typeName',editable:false"+'" '+"value='"+people[1]+"' >"+
				'</td>'+
				"<td><input class='easyui-textbox' alt='card' style='width:100%;height:24px' value='"+people[2]+"' /></td>" +
				"<td><input class='easyui-datebox' alt='date' style='width:100%;height:24px' value='"+people[3]+"' data-options='editable:false'/></td>" +
				"<td><input class='easyui-textbox' alt='tel' style='width:100%;height:24px' value='"+people[4]+"' /></td>" +
				"<td>"+
				"<input class='easyui-combobox' data-options="+'"'+"separator:'.',multiple:'true',editable:false,valueField:'a',textField:'b',"+dataStr+'"'+" value='"+people[5]+"' style='width:100%;height:24px' >"+
				"</td>" +
				"<td><a href=\'#\' onclick=\"deltr(\'shouquan_tb\'," + i + ")\">删除</a></td>" +
				"</tr>");
			 	//$.parser.parse();
				$.parser.parse("#shouquan_tb");
				autoInit("shouquan_tb");
			}
		}
		
		//被授权的内容
		var vContent = $("#openBookDiv #authorizeContent").textbox("getValue").split(",");
		/* $("#G").textbox("setValue",vContent[0]);//电话号码
		$("#H").textbox("setValue",vContent[1]);//卡号
		$("#I").textbox("setValue",vContent[2]);//其他 */
		$("#I").textbox("setValue",vContent[0]);//其他
		
		if(vContent.length>1){
			for(var i=1; i<vContent.length; i++){
				$("#"+vContent[i]).attr("checked", true);
			}
		}
		
		//商业活动旺季
		var vHighSeasons = $("#openBookDiv #highSeasons").textbox("getValue");
		if(vHighSeasons!=""&&vHighSeasons!=null){
			var highSeasons = $("#openBookDiv #highSeasons").textbox("getValue").split(",");
			for(var i=0; i<highSeasons.length; i++){
				$("#sywj #"+highSeasons[i]).attr("checked", true);
			}
		}
		
		//开办产品选择项
		var vChoseProducts = $("#openBookDiv #choseProducts").textbox("getValue");
		if(vChoseProducts!=""&&vChoseProducts!=null){
			var choseProducts = vChoseProducts.split(",");
			for(var i=0; i<choseProducts.length; i++){
				$("#products #"+choseProducts[i]).attr("checked", true);
			}
		}
		
		
		//协议选择
		var vUseProtocols = $("#openBookDiv #useProtocol").textbox("getValue");
		if(vUseProtocols!=""&&vUseProtocols!=null){
			var useProtocols = $("#openBookDiv #useProtocol").textbox("getValue").split(",");
			for(var i=0; i<useProtocols.length; i++){
				$("#protocol #"+useProtocols[i]).attr("checked", true);
			};
		}
		
	}
	
	function controlDivShow(accountType){
		if(accountType=="0"){//基本
			$("#shortDiv").hide();
			$("#dedicatedDiv").hide();
			/* $("#openCommAcc").hide(); 
			$("#fileNumberDiv").show();*/
			$("#checkNumberDiv").hide();
			$("#coinTypeDiv").hide();
			$("#accountEndDateDiv").hide();
		}
		if(accountType=="1"){//一般
			$("#shortDiv").hide();
			$("#dedicatedDiv").hide();
			/* $("#openCommAcc").show(); 
			$("#fileNumberDiv").hide();*/
			$("#checkNumberDiv").show();
			$("#coinTypeDiv").hide();
			$("#accountEndDateDiv").hide();
		}
		if(accountType=="2"||accountType=="3"||accountType=="4"){//专用
			$("#shortDiv").hide();
			$("#dedicatedDiv").show();
			/* $("#openCommAcc").hide(); 
			$("#fileNumberDiv").show();*/
			$("#checkNumberDiv").show();
			$("#coinTypeDiv").show();
			$("#accountEndDateDiv").hide();
		}
		if(accountType=="5"||accountType=="6"){//临时
			$("#dedicatedDiv").hide();
			$("#shortDiv").show();
			/* $("#openCommAcc").hide(); 
			$("#fileNumberDiv").show();*/
			$("#checkNumberDiv").show();
			$("#coinTypeDiv").hide();
			$("#accountEndDateDiv").show();
		}
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
	
	function getBasicInfo(){
		/* var dateArr=["openDate","licenseEndDate"]; */
		
		var accountType = $("#openBasicAcc #accountType").textbox("getValue");
		
		if(trim(accountType)==""){
			alert("账户类型不能为空");
			return;
		}
		var dataJson = {};
		dataJson["accountType"] = accountType;
		
		//是一般户 ,从人行获取基本户信息
		if(accountType=="3"){
			
			var isQualified;
			$("#openCommAcc .business_ss-dm input[id]").each(function(){
				var name = $(this).attr('id');
				var value = $(this).textbox("getValue");
				dataJson[name] = value;
				/* isQualified=validatePre(name,value);
				if(!isQualified){
					return false;
				} */
			});
			/* if(!isQualified){
				return false;
			} */
			$("#openCommAcc .business_ss-dm select[id]").each(function(){
				var name = $(this).attr('id');
				var value = $(this).combobox("getValue");
				dataJson[name] = value;
				/* isQualified=validatePre(name,value);
				if(!isQualified){
					return false;
				} */
			});
			
			/* if(!isQualified){
				return false;
			} */
			loading.show();
			var ajax = new stAjax("getBasicInfo.action");
			ajax.setData(dataJson);
			ajax.setSuccessCallback(function(data) {
				loading.hide();
				if(data.success){
					//将获取的数据返显
					if (data.data){
						$("#openBookDiv .business_ss-dm input[id],#recordDiv .business_ss-dm input[id]").each(
							function() {
								var name = $(this).attr('id');
								names=name.split(".");
								if ((data.data)[name]!=null) {
									$(this).textbox('setValue',(data.data)[name]);
								}
								if(names.length>1){
									$(this).textbox('setValue',(data.data.clientInfo)[names[1]]);
								}
								if(name=="authorizePeople"){
									$(this).textbox('setValue',(data.data.authorize)[name]);
								}
								if(name=="authorizeContent"){
									$(this).textbox('setValue',(data.data.authorize)[name]);
								}
								if(name=="useProtocol"){
									$(this).textbox('setValue',(data.data.protocolSign)[name]);
								}
								if(name=="partner"){
									$(this).textbox('setValue',(data.data.clientInfo)[name]);
								}
								if(name=="beneficiary"){
									$(this).textbox('setValue',(data.data.clientInfo)[name]);
								}
								if(name=="highSeasons"){
									$(this).textbox('setValue',(data.data.clientInfo)[name]);
								}
								if(name=="relationCompany"){
									$(this).textbox('setValue',(data.data.relationInfo)[name]);
								}
								if(name=="relationPartner"){
									$(this).textbox('setValue',(data.data.relationInfo)[name]);
								}
								if(name=="protocolSign.appoint"){
									$(this).textbox('setValue',(data.data.protocolSign)[names[1]]);
								}
						});
						$("#openBookDiv .business_ss-dm select[id],#recordDiv .business_ss-dm select[id]").each(
							function(){
								var name = $(this).attr('id');
								$(this).combobox('setValue',(data.data)[name]);
								if(name=="clientInfo.publicCompany"){
									if((data.data.clientInfo)["publicCompany"]!=null){
										$(this).combobox('setValue',""+(data.data.clientInfo)["publicCompany"]);
									}
								}
							});
						$("#paymentCardDiv .business_ss-dm input[id]").each(
							function(){
								var name = $(this).attr('id');
								name=name.split(".")[1];
								if(data.data.paymentCard!=null){
									$(this).textbox('setValue',(data.data.paymentCard)[name]);
								}
						});
						$("#paymentCardDiv .business_ss-dm select[id]").each(
							function(){
								var name = $(this).attr('id');
								name=name.split(".")[1];
								$(this).combobox('setValue',(data.data.paymentCard)[name]);
						});
						$("#chargeDiv .business_ss-dm input[id]").each(
							function(){
								var name = $(this).attr('id');
								name=name.split(".")[1];
								if(data.data.bookCharge!=null){
									$(this).textbox('setValue',(data.data.bookCharge)[name]);
								}
						});
						$("#chargeDiv .business_ss-dm select[id]").each(
							function(){
								var name = $(this).attr('id');
								name=name.split(".")[1];
								$(this).combobox('setValue',(data.data.bookCharge)[name]);
						});
						$('#openBasicAcc').window('close');
						//隐藏时添加表格时输入框没有宽度
						$("div[id*='divstep']").show();
						init();
						$("div[id*='divstep']").hide();
						$("div[id='divstep"+curr+"']").show();
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
		}else{//从工商获取客户信息
			var fileNumber = $("#openBasicAcc #fileNumber").textbox("getValue");
			if(trim(fileNumber)==""){
				alert("企业注册号不能为空");
				return;
			}
			dataJson["fileNumber"]=fileNumber;
			loading.show();
			var ajax = new stAjax("getAICInfo.action");
			ajax.setData(dataJson);
			ajax.setSuccessCallback(function(data) {
				loading.hide();
				if(data.success){
					//将获取的数据返显
					if (data.data){
						$("#openBookDiv .business_ss-dm input[id],#recordDiv .business_ss-dm input[id]").each(
							function() {
								var name = $(this).attr('id');
								names=name.split(".");
								if ((data.data)[name]!=null) {
									$(this).textbox('setValue',(data.data)[name]);
								}
								if(names.length>1){
									$(this).textbox('setValue',(data.data.clientInfo)[names[1]]);
								}
								if(name=="authorizePeople"){
									$(this).textbox('setValue',(data.data.authorize)[name]);
								}
								if(name=="authorizeContent"){
									$(this).textbox('setValue',(data.data.authorize)[name]);
								}
								if(name=="useProtocol"){
									$(this).textbox('setValue',(data.data.protocolSign)[name]);
								}
								if(name=="partner"){
									$(this).textbox('setValue',(data.data.clientInfo)[name]);
								}
								if(name=="beneficiary"){
									$(this).textbox('setValue',(data.data.clientInfo)[name]);
								}
								if(name=="highSeasons"){
									$(this).textbox('setValue',(data.data.clientInfo)[name]);
								}
								if(name=="relationCompany"){
									$(this).textbox('setValue',(data.data.relationInfo)[name]);
								}
								if(name=="relationPartner"){
									$(this).textbox('setValue',(data.data.relationInfo)[name]);
								}
								if(name=="protocolSign.appoint"){
									$(this).textbox('setValue',(data.data.protocolSign)[names[1]]);
								}
						});
						$("#openBookDiv .business_ss-dm select[id],#recordDiv .business_ss-dm select[id]").each(
							function(){
								var name = $(this).attr('id');
								$(this).combobox('setValue',(data.data)[name]);
								if(name=="clientInfo.publicCompany"){
									if((data.data.clientInfo)["publicCompany"]!=null){
										$(this).combobox('setValue',""+(data.data.clientInfo)["publicCompany"]);
									}
								}
							});
						$("#paymentCardDiv .business_ss-dm input[id]").each(
							function(){
								var name = $(this).attr('id');
								name=name.split(".")[1];
								if(data.data.paymentCard!=null){
									$(this).textbox('setValue',(data.data.paymentCard)[name]);
								}
						});
						$("#paymentCardDiv .business_ss-dm select[id]").each(
							function(){
								var name = $(this).attr('id');
								name=name.split(".")[1];
								$(this).combobox('setValue',(data.data.paymentCard)[name]);
						});
						$("#chargeDiv .business_ss-dm input[id]").each(
							function(){
								var name = $(this).attr('id');
								name=name.split(".")[1];
								if(data.data.bookCharge!=null){
									$(this).textbox('setValue',(data.data.bookCharge)[name]);
								}
						});
						$("#chargeDiv .business_ss-dm select[id]").each(
							function(){
								var name = $(this).attr('id');
								name=name.split(".")[1];
								$(this).combobox('setValue',(data.data.bookCharge)[name]);
						});
						$('#openBasicAcc').window('close');
						//隐藏时添加表格时输入框没有宽度
						$("div[id*='divstep']").show();
						init();
						$("div[id*='divstep']").hide();
						$("div[id='divstep"+curr+"']").show();
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
		
	}
	
	function saveBook(sts,direct) {
		
		if(!$('#divstep'+curr.toString()).form('validate')){
				return;
		};
		
		var dataJson = {};
		$("#handleStatus").textbox('setValue', sts);
		/* var vOrgCode = $("#vOrgCode").val();
		$("#openBookDiv #orgCode").textbox("setValue",vOrgCode); */
		/* if(sts>1){
			if(!$("#recordDiv").form('validate')){
				return;
			};
		} */
		//协议选择
		var useProtocol = "";
		$('#protocol input:checkbox:checked').each(function(){
			useProtocol += ($(this).val()+",");
		});
		if(useProtocol==""){
			alert("请选择需要办理的业务协议");
			return;
		}
		useProtocol=useProtocol.substring(0,useProtocol.length-1);
		dataJson["protocolSign.useProtocol"]=useProtocol;
		
		//地址
		var vRegistAddress = $("#registAddressG").val().trim().replace(",","，")+","+$("#registAddressS").val().trim().replace(",","，")+","
			+$("#registAddressQ").val().trim().replace(",","，")+","+$("#registAddressD").val().trim().replace(",","，");
		$("#openBookDiv #registAddress").textbox("setValue",vRegistAddress);
		var vOfficeAddress = $("#officeAddressG").val().trim().replace(",","，")+","+$("#officeAddressS").val().trim().replace(",","，")+","
			+$("#officeAddressQ").val().trim().replace(",","，")+","+$("#officeAddressD").val().trim().replace(",","，");
		$("#officeAddress").textbox("setValue",vOfficeAddress);
		
		//对公客户信息 股东 权益人信息
		var vClientPartner =  gettrVal('guquan_tb',5);
		if(vClientPartner.length>600){
			alert("股权及受益权人信息中主要股东填写过多。");
			return;
		}
		dataJson["clientInfo.partner"] = vClientPartner;
		//第一行为控股股东
		//partnerPeople idTypePartner endDatePartner idNoPartner 
		var mainPartnerInfo = vClientPartner.split("||")[0].split(",");
		if(mainPartnerInfo.length>4){
			dataJson["partnerPeople"] = mainPartnerInfo[0];
			dataJson["idTypePartner"] = mainPartnerInfo[1];
			dataJson["idNoPartner"] = mainPartnerInfo[2];
			dataJson["endDatePartner"] = mainPartnerInfo[3];
		}

		var vBeneficiary =  gettrVal('quanyi_tb',5);
		if(vBeneficiary.length>600){
			alert("股权及受益权人信息受权益人填写过多。");
			return;
		}
		dataJson["clientInfo.beneficiary"] = vBeneficiary;
		//第一行为控制人
		//controlPeople idTypeControl endDateControl idNoControl
		var mainControlInfo = vBeneficiary.split("||")[0].split(",");
		if(mainControlInfo.length>4){
			dataJson["controlPeople"] = mainControlInfo[0];
			dataJson["idTypeControl"] = mainControlInfo[1];
			dataJson["idNoControl"] = mainControlInfo[2];
			dataJson["endDateControl"] = mainControlInfo[3];
		}
		
		//关联企业 股东
		var vCompany =  gettrVal('glqiye_tb',4);
		if(vCompany.length>600){
			alert("关联企业信息填写过多。");
			return;
		}
		dataJson["relationInfo.relationCompany"] = vCompany;

		var vPartner =  gettrVal('glgudong_tb',5);
		if(vPartner.length>600){
			alert("关联股东信息填写过多。");
			return;
		}
		dataJson["relationInfo.relationPartner"] = vPartner;
		
		var highSeasons = "";
		//商业活动旺季
		$('#sywj input:checkbox:checked').each(function(){
			highSeasons += ($(this).val()+",");
		});
		
		highSeasons=highSeasons.substring(0,highSeasons.length-1);
		dataJson["clientInfo.highSeasons"]=highSeasons;
		
		//结算账户授权
		//被授权人信息
		var vsq =  gettrVal('shouquan_tb',6);
		//alert(vsq);
		if(vsq.length>600){
			alert("结算账户相关业务授权中被授权人信息填写过多。");
			return;
		}
		dataJson["authorize.authorizePeople"] = vsq;

		//选中F G I J的指定人 
		var authorizePeoples = vsq.split("||");
		for(var i = 0 ; i<authorizePeoples.length; i++){
			var peopleInfos = authorizePeoples[i].split(",");
			if(peopleInfos.length<6){
				break;
			}
			if(peopleInfos[5].indexOf("F")>-1){
				dataJson["paymentCard.firstUserName"] = peopleInfos[0];
				dataJson["paymentCard.firstUserId"] = peopleInfos[2];
			}
			if(peopleInfos[5].indexOf("G")>-1){
				dataJson["paymentCard.secondUserName"] = peopleInfos[0];
				dataJson["paymentCard.secondUserId"] = peopleInfos[2];
			}
			if(peopleInfos[5].indexOf("I")>-1){
				dataJson["ebank.firstName"] = peopleInfos[0];
				dataJson["ebank.firstType"] = "经办人";
				dataJson["ebank.firstIdType"] = peopleInfos[1];
				dataJson["ebank.firstIdNo"] = peopleInfos[2];
				dataJson["ebank.firstTel"] = peopleInfos[4];
			}
			if(peopleInfos[5].indexOf("J")>-1){
				dataJson["ebank.secondName"] = peopleInfos[0];
				dataJson["ebank.secondType"] = "授权人";
				dataJson["ebank.secondIdType"] = peopleInfos[1];
				dataJson["ebank.secondIdNo"] = peopleInfos[2];
				dataJson["ebank.secondTel"] = peopleInfos[4];
			}
		}
		
		//办理业务
		/* var tel = $("#G").val().trim().replace(",","，");//电话号码
		var cardNo = $("#H").val().trim().replace(",","，");//卡号 */
		var other = $("#I").val().trim().replace(",","，");//其他
		var content = /* tel+","+cardNo+","+ */other; 
		$('#authorizeDiv input:checkbox:checked').each(function(){
			content += (","+$(this).val());
		});
		//alert(content);
        dataJson["authorize.authorizeContent"] = content;
       	
      	//开办产品选择项
		var choseProducts = "";
		$('#products input:checkbox:checked').each(function(){
			choseProducts += ($(this).val()+",");
			
			//选中的协议 需要的字段上传
			if($(this).val()=="PD2"){
				var vOpenNote = gettrVal('dgkehu_tb',4);
				if(vOpenNote.length>300){
					alert("对公短信客户添加过多");
					return;
				}
				dataJson["productInfo.openNoteInfo"] = vOpenNote;
			}else{
				$("#"+$(this).val()+"Div .business_ss-dm input[id]").each(function(){
					var name = $(this).attr('id');
					var value = $(this).textbox("getValue").trim();
					dataJson[name] = value;
				});
			}
			
		});
		
		choseProducts=choseProducts.substring(0,choseProducts.length-1);
		dataJson["productInfo.choseProducts"]=choseProducts;
        
		$("#openBookDiv .business_ss-dm input[id],#recordDiv .business_ss-dm input[id],#chargeDiv .business_ss-dm input[id],#paymentCardDiv .business_ss-dm input[id]")
			.each(function(){
				var name = $(this).attr('id');
				if(name=="W1"||name=="W2"||name=="W3"||name=="W4"){
					//商业旺季   复选框
				}else{
					var value = $(this).textbox("getValue").trim();
					//代扣缴税款    征收机关处理
					if(name == "secondTelCode1" && value!=null && value!="" ){
						//  征收机关名称
						dataJson["secondMoneyMan"] = $(this).textbox("getText");
						//  征收机关代码
						dataJson["secondTelCode"] = value;
					}else if(name == "secondTelCode2" && value!=null && value!="" ){
						//  征收机关名称
						dataJson["secondMoneyMan"] = $(this).textbox("getText");
						//  征收机关代码
						dataJson["secondTelCode"] = value;
					}else{
						dataJson[name] = value;
					}
				}
		});
		$("#openBookDiv .business_ss-dm select[id],#recordDiv .business_ss-dm select[id],#chargeDiv .business_ss-dm select[id],#paymentCardDiv .business_ss-dm select[id]")
				.each(function() {
 					var name = $(this).attr('id');
					var value = $(this).combobox("getValue").trim();
					/* if(name=="peopleType" && value==14){
						$("#accountName").textbox("setValue","个体户"+$("#accountName").textbox("getValue"));
						dataJson['accountName'] = "个体户"+$("#accountName").textbox("getValue");
					} */
					dataJson[name] = value; 
		});
		var vAccountType = $("#openBookDiv #accountType").combobox("getValue");
		//账户类型为临时和专用时
		if(vAccountType>1){
			var divName = "";
			if(vAccountType<5){
				divName = "dedicatedDiv";
			}else{
				divName = "shortDiv";
			}
			$("#"+divName+" .role_window input[id]").each(function(){
				var name = $(this).attr('id');
				var value = $(this).textbox("getValue").trim();
				dataJson[name] = value;
			});
			$("#"+divName+" .role_window select[id]").each(function() {
				var name = $(this).attr('id');
				var value = $(this).combobox("getValue").trim();
				dataJson[name] = value; 
			});
		}
		
		//对账单寄送地址选择
		var checkAddressType = $('#checkRadio input:radio:checked').val();
		dataJson["checkProto.checkAddressType"] = checkAddressType;

		//处理开户申请书中未填写的法人  和对公客户信息相同
		dataJson["linkMan"] = dataJson["clientInfo.legalRepresentSurname"]+dataJson["clientInfo.legalRepresentName"];
		dataJson["linkIdEndDate"] = dataJson["clientInfo.endDateLegal"];
		dataJson["idType"] = dataJson["clientInfo.idTypeLegal"];
		dataJson["idNumber"] = dataJson["clientInfo.idNoLegal"];
		
		//处理财务负责人姓名
		dataJson["firstMoneyMan"] = dataJson["clientInfo.moneyManSurname"]+dataJson["clientInfo.moneyManName"];
		//处理联系人姓名 
		dataJson["stockHolder"] = dataJson["clientInfo.contactManSurname"]+dataJson["clientInfo.contactManName"];
		
		dataJson["clientInfo.createDate"] = dataJson["registDate"];
		//行业分类  行业代码相同
		dataJson["busiType"] = dataJson["accountCategory"];
		//存款人类别/客户子类型
		dataJson["peopleSonType"] = dataJson["peopleType"];
		
		loading.show();
		var ajax = new stAjax("saveBasicOpenBook.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data) {
			loading.hide();
			if (data.success) {
				$("#activeId").textbox('setValue', data.data.activeId);
				$("#handleStatus").textbox('setValue', data.data.handleStatus);
				$(".bookCharge").textbox("setValue", data.data.bookCharge.activeId);
				$(".protocolSign").textbox("setValue", data.data.protocolSign.activeId);
				$(".clientInfo").textbox('setValue', data.data.clientInfo.activeId);
				$(".paymentCard").textbox('setValue', data.data.paymentCard.activeId);
				$(".authorize").textbox('setValue', data.data.authorize.activeId);
				$(".relationInfo").textbox('setValue', data.data.relationInfo.activeId);
				$(".dedicatedShort").textbox('setValue', data.data.dedicatedShort.activeId);
				$(".checkProto").textbox("setValue", data.data.checkProto.activeId);
				$(".ebank").textbox("setValue", data.data.ebank.activeId);
				$(".productInfo").textbox("setValue", data.data.productInfo.activeId);
				$("#vSave").val(1);
				if(direct){
					window.location.href="accountShow.action?hstatus=0";
				}
				//controlBtnShow();
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
	
	function record(sts){
		var dataJson = {};
		$("#handleStatus").textbox('setValue', sts);
		/* var vOrgCode = $("#vOrgCode").val();
		$("#openBookDiv #orgCode").textbox("setValue",vOrgCode); */
		
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
	
	//客户端打印
	function printToBook(activeId){
		$.messager.confirm('提示:', '如果打印前做过修改请先保存，否则修改将不起效果，你确认要打印吗?', function(event) {
		if (event) {
			var dataJson = {};
			if(activeId == null || activeId == "" || activeId == undefined){
				activeId = $("#activeId").textbox("getValue");
			}else{
				activeId = activeId.substring(6);
			}
			if(activeId == null || activeId == "" || activeId == undefined){
				alert("打印前请先保存");
				return;
			}else{
				dataJson["activeId"]=activeId;
			}
			
			var ajax = new stAjax("printOpenBook.action");
			ajax.setData(dataJson);
			ajax.setSuccessCallback(function(data) {
				if(data.success){			
					/* $('#printOpneBookDiv>div').each(function(){
						var name=$(this).attr('id');
						if(name=="printChargeDiv"){
							$('#printChargeDiv div').each(function(){
								var name=$(this).attr('id');
								$(this).text("");//清空数据
								if(data.data.bookCharge!=null){
									$(this).append((data.data.bookCharge)[name]);
								}
							});
						}else if(name=="printClintDiv"){
							$('#printClintDiv div').each(function(){
								var name=$(this).attr('id');
								$(this).text("");//清空数据
								if(data.data.clientInfo!=null){
									$(this).append((data.data.clientInfo)[name]);
								}
							});
						}else if(name=="printRelationDiv"){
							$('#printRelationDiv div').each(function(){
								var name=$(this).attr('id');
								$(this).text("");//清空数据
								if(data.data.relationInfo!=null){
									$(this).append((data.data.relationInfo)[name]);
								}
							});
						}else if(name=="printCardDiv"){
							$('#printCardDiv div').each(function(){
								var name=$(this).attr('id');
								$(this).text("");//清空数据
								if(data.data.paymentCard!=null){
									$(this).append((data.data.paymentCard)[name]);
								}
							});
						}else if(name=="printAuthorizeDiv"){
							$('#printAuthorizeDiv div').each(function(){
								var name=$(this).attr('id');
								$(this).text("");//清空数据
								if(data.data.authorize!=null){
									$(this).append((data.data.authorize)[name]);
								}
							});
						}else if(name=="printShortDiv"){
							$('#printShortDiv div').each(function(){
								var name=$(this).attr('id');
								$(this).text("");//清空数据
								if(data.data.dedicatedShort!=null){
									$(this).append((data.data.dedicatedShort)[name]);
								}
							});
						}else{
							$(this).text("");//清空数据
							if(data.data.bookCharge!=null){
								$(this).append((data.data)[name]);//赋值
							}
						}
					});
					var accountEndDate = (data.data)["accountEndDate"];
					if(accountEndDate != null && accountEndDate.length > 9){
						var year = accountEndDate.substring(0,4);
						var month = accountEndDate.substring(5,7);
						var day = accountEndDate.substring(8,10);
						$("#printOpneBookDiv #year").text("");//清空数据
						$("#printOpneBookDiv #year").append(year);//赋值
						$("#printOpneBookDiv #month").text("");//清空数据
						$("#printOpneBookDiv #month").append(month);//赋值
						$("#printOpneBookDiv #day").text("");//清空数据
						$("#printOpneBookDiv #day").append(day);//赋值
					} */
					openBookData = data.data;
					var pageNum = $("#pageChose").combobox("getValue");
					prn_print(pageNum);
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
	 
	
	function setOfficeAddress(){
		$("#officeAddressG").textbox("setValue",$("#registAddressG").textbox("getValue"));
		$("#officeAddressS").textbox("setValue",$("#registAddressS").textbox("getValue"));
		$("#officeAddressQ").textbox("setValue",$("#registAddressQ").textbox("getValue"));
		$("#officeAddressD").textbox("setValue",$("#registAddressD").textbox("getValue"));
		$("#postCodeNews").textbox("setValue",$("#postCode").textbox("getValue"));
	}
	
	
	
	
</script>
</head>
<body>
	<div class="easyui-panel" title="人行账管系统——开存款账户" iconCls="ico_281" style="width:100%;" data-options="fit:true">
		<form id="openBookForm">
		<div id="openBookDiv" style="width:100%">
			<div id="divstep1">
			<div class="role_window">
				<div class="business_title10">请仔细阅读以下协议,请选择需遵守的业务协议：</div>
				<div  style="height: 60px;">
					<div class="business_title">协议：</div>
					<div id="protocol" class="business_input10" style="padding-top: 4px;font-size: 18px;">
						<label style="width: 210px"><input id="P1" type="checkbox" checked="checked" disabled="disabled" value="P1" />
							<a href="<%=request.getContextPath()%>/paymentCardBack.html" target="_blank" style="color:blue;">人民币单位银行结算账户管理协议</a>
						</label>
						<label style="width: 210px"><input id="P2" type="checkbox" checked="checked" disabled="disabled" value="P2" />
						<a href="<%=request.getContextPath()%>/paymentCardBack.html" target="_blank" style="color:blue;">外部公司客户对账服务协议</a>
						</label>
						<label style="width: 210px"><input id="P3" type="checkbox" checked="checked" disabled="disabled" value="P3" />
						<a href="<%=request.getContextPath()%>/paymentCardBack.html" target="_blank" style="color:blue;">网上银行企业客户服务协议</a>
						</label><br />
						<label style="width: 210px"><input id="P4" type="checkbox" value="P4" />
						<a href="<%=request.getContextPath()%>/paymentCardBack.html" target="_blank" style="color:blue;">支付密码器(中国银行使用通用性支付密码器信息表、支付密码器使用协议)</a>
						</label>
						<label style="width: 210px"><input id="P5" type="checkbox" checked="checked" disabled="disabled" value="P5" />
						<a href="<%=request.getContextPath()%>/paymentCardBack.html" target="_blank" style="color:blue;">银行结算证(银行结算证申请表、结算证使用协议)</a>
						</label>
					</div>
				</div>
				
				<!-- <div class="role_window_title14" style="float: left;">为开户信息</div> -->
				<div class="business_ss-dm">
					<div class="business_input8" style="display:none">
						<input id="orgCode" class="easyui-textbox" value='<s:property value="orgCode"/>'  />
						<input id="handleStatus" class="easyui-textbox" value='<s:property value="handleStatus"/>' />
						<input id="activeId" class="easyui-textbox" value='<s:property value="activeId"/>' />
						<input id="bookCharge.activeId" class="easyui-textbox bookCharge" value='<s:property value="bookCharge.activeId"/>' />
						<input id="protocolSign.activeId" class="easyui-textbox protocolSign" value='<s:property value="protocolSign.activeId"/>' />
						<input id="clientInfo.activeId" class="easyui-textbox clientInfo" value='<s:property value="clientInfo.activeId"/>' />
						<input id="paymentCard.activeId" class="easyui-textbox paymentCard" value='<s:property value="paymentCard.activeId"/>' />
						<input id="authorize.activeId" class="easyui-textbox authorize" value='<s:property value="authorize.activeId"/>' />
						<input id="relationInfo.activeId" class="easyui-textbox relationInfo" value='<s:property value="relationInfo.activeId"/>' />
						<input id="dedicatedShort.activeId" class="easyui-textbox dedicatedShort" value='<s:property value="dedicatedShort.activeId"/>' />
						<input id="checkProto.activeId" class="easyui-textbox checkProto" value='<s:property value="checkProto.activeId"/>' />
						<input id="productInfo.activeId" class="easyui-textbox productInfo" value='<s:property value="productInfo.activeId"/>' />
						<input id="ebank.activeId" class="easyui-textbox ebank" value='<s:property value="ebank.activeId"/>' />
						<input id="dedicatedShort.type" class="easyui-textbox" value='<s:property value="dedicatedShort.type"/>' />
						<input id="orgId" class="easyui-textbox" value=''  />
						<input id="basic_account_id" class="easyui-textbox" value=''  />
						<input id="registAddress" class="easyui-textbox" value='<s:property value="registAddress"/>' />
						<input id="officeAddress" class="easyui-textbox" value='<s:property value="officeAddress"/>'/>
						<input id="partner" class="easyui-textbox" value='<s:property value="clientInfo.partner"/>'/>
						<input id="beneficiary" class="easyui-textbox" value='<s:property value="clientInfo.beneficiary"/>'/>
						<input id="highSeasons" class="easyui-textbox" value='<s:property value="clientInfo.highSeasons"/>'/>
						<input id="choseProducts" class="easyui-textbox" value='<s:property value="productInfo.choseProducts"/>'/>
						<input id="relationCompany" class="easyui-textbox" value='<s:property value="relationInfo.relationCompany"/>' />
						<input id="relationPartner" class="easyui-textbox" value='<s:property value="relationInfo.relationPartner"/>' />
						<input id="authorizePeople" class="easyui-textbox" value='<s:property value="authorize.authorizePeople"/>'/>
						<input id="authorizeContent" class="easyui-textbox" value='<s:property value="authorize.authorizeContent"/>'/>
						<input id="useProtocol" class="easyui-textbox" value='<s:property value="protocolSign.useProtocol"/>'/>
						<input id="openNoteInfo" class="easyui-textbox openNoteInfo" value='<s:property value="productInfo.openNoteInfo"/>' />
					</div>
					<div class="business_title2">存款人名称：</div>
					<div class="business_input8">
						<input id="depositorName" class="easyui-textbox" style="width:100%;height:24px" data-options="required:true,validType:'maxLength[60]'" value='<s:property value="depositorName"/>'/>
					</div>
					<div class="business_title2">存款人英文名称：</div>
					<div class="business_input8">
						<input id="accountEnName" class="easyui-textbox" style="width:100%;height:24px" data-options="validType:'maxLength[60]'" value='<s:property value="accountEnName"/>'/>
					</div>
				</div>
				
				<%-- <div class="business_ss-dm">
					<div class="business_title2">姓名：</div>
					<div class="business_input8">
						<input id="linkMan" class="easyui-textbox" value='<s:property value="linkMan"/>'  style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div> 
					<div class="business_title2">证件到期日：</div>
					<div class="business_input12">
						<input id="linkIdEndDate" class="easyui-datebox" value='<s:property value="linkIdEndDate"/>' style="width:100%;" data-options="validType:'maxLength[60]',editable:false"/>
					</div> 
				</div>--%>
				<%-- <div class="business_ss-dm">
					<div class="business_title2">证件种类：</div>
					<div class="business_input8">
						<select id="idType" class="easyui-combobox" name="idType" style="width:100%;" data-options="panelHeight:'auto',editable:false,validType:'maxLength[60]'">
							<option value=""></option>
							<option value="1" <s:if test="idType==1">selected='selected'</s:if>>居民身份证</option>
							<option value="2" <s:if test="idType==2">selected='selected'</s:if>>临时身份证</option>
							<option value="3" <s:if test="idType==3">selected='selected'</s:if>>护照</option>
							<option value="4" <s:if test="idType==4">selected='selected'</s:if>>户口簿</option>
							<option value="5" <s:if test="idType==5">selected='selected'</s:if>>军人身份证件</option>
							<option value="6" <s:if test="idType==6">selected='selected'</s:if>>武装警察身份证件</option>
							<option value="7" <s:if test="idType==7">selected='selected'</s:if>>港澳居民往来内地通行证</option>
							<option value="8" <s:if test="idType==8">selected='selected'</s:if>>外交人员身份证</option>
							<option value="9" <s:if test="idType==9">selected='selected'</s:if>>外国人居留许可证</option>
							<option value="10" <s:if test="idType==10">selected='selected'</s:if>>边民出入境通行证</option>
							<option value="11" <s:if test="idType==11">selected='selected'</s:if>>其他</option>
						</select>
						<input id="idType" class="easyui-textbox" value='<s:property value="idType"/>'  style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">证件号码：</div>
					<div class="business_input8">
						<input id="idNumber" class="easyui-textbox" value='<s:property value="idNumber"/>'  style="width:100%;height:24px" data-options="validType:['englishCheckSub','maxLength[60]']" />
					</div>
				</div> --%>
				<div class="business_ss-dm">
					<div class="business_title2">证明文件种类：</div>
					<div class="business_input8">
						<input class="easyui-combobox" id="fileType" name="fileType" style="width:100%;height:24px" url='getTypeEnum.action?typeCode=FILE_TYPE' 
							data-options="editable:false,valueField:'typeValue', textField:'typeName'" value='<s:property value="fileType"/>' >
						<%-- <input id="fileType" class="easyui-textbox" value='<s:property value="fileType"/>'  style="width:100%;height:24px" data-options="validType:'maxLength[60]'" /> --%>
					</div>
					<div class="business_title2">证明文件编号：</div>
					<div class="business_input8">
						<input id="fileNumber" class="easyui-textbox" style="width:100%;height:24px" data-options="validType:['englishCheckSub','maxLength[60]']" value='<s:property value="fileNumber"/>'/>
					</div>
					<div class="business_title2">证明文件到期日：</div>
					<div class="business_input12">
						<input id="fileEndDate" class="easyui-datebox" value='<s:property value="fileEndDate"/>' style="width:100%;" data-options="validType:'maxLength[60]',editable:false"/>
					</div>
				</div>
				<div class="business_ss-dm1">
					<div class="business_title2">已完成三证合一：</div>
					<div class="business_input8">
						<label><input id="SZ" name="PD" type="checkbox" />完成</label>
					</div>
				</div>
				<div id="cardInfoDiv" class="role_window" >
				<div class="business_ss-dm">
					<div class="business_title4">统一社会信用代码证件号码：</div>
					<div class="business_input8">
						<input id="clientInfo.idNoCredit" class="easyui-textbox idNoCredit"  style="width:100%;height:24px" value='<s:property value="clientInfo.idNoCredit"/>' data-options="validType:['englishCheckSub','maxLength[30]']"/>
					</div>
					<div class="business_title4">统一社会信用代码证件到期日：</div>
					<div class="business_input8">
						<input id="clientInfo.endDateCredit" class="easyui-datebox endDateCredit" value='<s:property value="clientInfo.endDateCredit"/>' style="width:100%;" data-options="validType:'maxLength[60]',editable:false"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title4">组织机构代码证件号码：</div>
					<div class="business_input8">
						<input id="orgInstitCd" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="orgInstitCd"/>' data-options="validType:['englishCheckSub','maxLength[30]']"/>
					</div>
					<div class="business_title4">组织机构代码证件到期日：</div>
					<div class="business_input8">
						<input id="orgInstitEndDate" class="easyui-datebox" value='<s:property value="orgInstitEndDate"/>' style="width:100%;" data-options="validType:'maxLength[60]',editable:false"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title4">营业执照证件号码：</div>
					<div class="business_input8">
						<input id="clientInfo.idNoLicense" class="easyui-textbox idNoLicense"  style="width:100%;height:24px" value='<s:property value="clientInfo.idNoLicense"/>' data-options="validType:['englishCheckSub','maxLength[30]']"/>
					</div>
					<div class="business_title4">营业执照证件到期日：</div>
					<div class="business_input8">
						<input id="clientInfo.endDateLicense" class="easyui-datebox endDateLicense" value='<s:property value="clientInfo.endDateLicense"/>' style="width:100%;" data-options="validType:'maxLength[60]',editable:false"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title4">税务登记证（国）证件号码：</div>
					<div class="business_input8">
						<input id="countryTax" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="countryTax"/>' data-options="validType:['englishCheckSub','maxLength[30]']"/>
					</div>
					<div class="business_title4">税务登记证（国）证件到期日：</div>
					<div class="business_input8">
						<input id="clientInfo.endDateCountry" class="easyui-datebox endDateCountry" value='<s:property value="clientInfo.endDateCountry"/>' style="width:100%;" data-options="validType:'maxLength[60]',editable:false"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title4">税务登记证（地）证件号码：</div>
					<div class="business_input8">
						<input id="areaTax" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="areaTax"/>' data-options="validType:['englishCheckSub','maxLength[30]']"/>
					</div>
					<div class="business_title4">税务登记证（地）证件到期日：</div>
					<div class="business_input8">
						<input id="clientInfo.endDateTax" class="easyui-datebox endDateTax" value='<s:property value="clientInfo.endDateTax"/>' style="width:100%;" data-options="validType:'maxLength[60]',editable:false"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">其他证明文件：</div>
					<div class="business_input8">
						<input id="clientInfo.otherIdName" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="clientInfo.otherIdName"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">证件号码：</div>
					<div class="business_input12">
						<input id="clientInfo.idNoOther" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="clientInfo.idNoOther"/>' data-options="validType:['englishCheckSub','maxLength[30]']"/>
					</div>
					<div class="business_title2">证件到期日：</div>
					<div class="business_input8">
						<input id="clientInfo.endDateOther" class="easyui-datebox" value='<s:property value="clientInfo.endDateOther"/>' style="width:100%;" data-options="validType:'maxLength[60]',editable:false"/>
					</div>
				</div>
				</div>
				<div class="business_ss-dm" style="height: 60px;">
					<div class="business_title2">经营范围：</div>
					<div class="business_input10">
						<input id="busiScope" class="easyui-textbox" value='<s:property value="busiScope"/>' data-options="multiline:true" style="width:100%;height:50px" />
					</div>
				</div>
				<div class="business_title2">注册地址：</div>
				<div class="business_ss-dm1">
					<div class="business_title2">国家：</div>
					<div class="business_input8">
						<input id="registAddressG" class="easyui-textbox" value="中国"  style="width:100%;height:24px" data-options="validType:'maxLength[15]'"/>
					</div>
					<div class="business_title2">省/自治区/直辖市：</div>
					<div class="business_input8">
						<input id="registAddressS" class="easyui-textbox"  style="width:100%;height:24px" data-options="validType:'maxLength[15]'"/>
					</div>
					<div class="business_title2">市/区：</div>
					<div class="business_input8">
						<input id="registAddressQ" class="easyui-textbox"  style="width:100%;height:24px" data-options="validType:'maxLength[15]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">地址：</div>
					<div class="business_input9">
						<input id="registAddressD" class="easyui-textbox"  style="width:100%;height:24px" data-options="validType:'maxLength[50]'"/>
					</div>
					<div class="business_title2">邮编：</div>
					<div class="business_input12">
						<input id="postCode" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="postCode"/>' data-options="validType:['number','maxLength[20]']"/>
					</div>
				</div>
				<div class="business_title2">通讯地址：</div>
				<div class="business_ss-dm1">
					<div class="business_title2">国家：</div>
					<div class="business_input8">
						<input id="officeAddressG" class="easyui-textbox" value="中国"   style="width:100%;height:24px" data-options="validType:'maxLength[15]'"/>
					</div>
					<div class="business_title2">省/自治区/直辖市：</div>
					<div class="business_input8">
						<input id="officeAddressS" class="easyui-textbox"  style="width:100%;height:24px" data-options="validType:'maxLength[15]'"/>
					</div>
					<div class="business_title2">市/区：</div>
					<div class="business_input8">
						<input id="officeAddressQ" class="easyui-textbox"  style="width:100%;height:24px" data-options="validType:'maxLength[15]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">地址：</div>
					<div class="business_input9">
						<input id="officeAddressD" class="easyui-textbox"  style="width:100%;height:24px" data-options="validType:'maxLength[50]'"/>
					</div>
					<div class="business_title2">邮编：</div>
					<div class="business_input12">
						<input id="postCodeNews" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="postCodeNews"/>' data-options="validType:['number','maxLength[20]']"/>
					</div>
					<div class="business_input12">
						<a href="#" class="easyui-linkbutton" style="width:120px;height:24px;padding-left:10px;" onclick="setOfficeAddress();">设置为注册地址</a>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">注册日期：</div>
					<div class="business_input8">
						<input id="registDate" class="easyui-datebox" style="width:100%;height:24px" value='<s:property value="registDate"/>' data-options="validType:'maxLength[60]',editable:false"/>
					</div>
					<div class="business_title2">注册资金：</div>
					<div class="business_input8">
						<input id="registMoney" class="easyui-textbox" value='<s:property value="registMoney"/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">注册货币：</div>
					<div class="business_input8">
						<input class="easyui-combobox" id="registMoneyType" name="registMoneyType"  value='<s:property value="registMoneyType"/>'style="width:100%;height:24px" url='getTypeEnum.action?typeCode=REGIST_MONEY_TYPE' 
							data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  >
						<%-- <select id="registMoneyType" class="easyui-combobox" name="registMoneyType" style="width:100%;" data-options="panelHeight:'auto',editable:false">
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
						</select> --%>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">地区代码：</div>
					<div class="business_input8">
						<input id="areaCode" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="areaCode"/>' data-options="validType:['englishCheckSub','maxLength[60]']"/>
					</div>
					<div class="business_title2">传真号码：</div>
					<div class="business_input8">
						<input id="faxCode" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="faxCode"/>' data-options="validType:['englishCheckSub','maxLength[60]']"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">办公电话：</div>
					<div class="business_input8">
						<input id="mobileCode" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="mobileCode"/>' data-options="validType:'maxLength[20]'"/>
					</div>
					<div class="business_title2">电子邮件地址：</div>
					<div class="business_input8">
						<input id="email" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="email"/>' data-options="validType:'email'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">存款人类别：</div>
					<div class="business_input8">
						<input class="easyui-combobox" id="peopleType" name="peopleType"  value='<s:property value="peopleType"/>'style="width:100%;height:24px" url='getTypeEnum.action?typeCode=PROPOSER_TYPE' 
							data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  >
					</div>
					<%-- <div class="business_title2">行业代码：</div>
					<div class="business_input8">
						<input id="busiType" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="busiType"/>' data-options="validType:['englishCheckSub','maxLength[60]']"/>
					</div> --%>
					<div class="business_title2">行业分类：</div>
					<div class="business_input8">
						<%-- <select id="accountCategory" class="easyui-combobox" style="width:100%;" data-options="validType:'maxLength[60]',editable:false">
							<option value=""></option>
							<option value="A" <s:if test='accountCategory=="A"'>selected='selected'</s:if>>农、林、牧、渔业</option>
							<option value="B" <s:if test='accountCategory=="B"'>selected='selected'</s:if>>采矿业</option>
							<option value="C" <s:if test='accountCategory=="C"'>selected='selected'</s:if>>制造业</option>
							<option value="D" <s:if test='accountCategory=="D"'>selected='selected'</s:if>>电力、燃气及水的生产供应业</option>
							<option value="E" <s:if test='accountCategory=="E"'>selected='selected'</s:if>>建筑业</option>
							<option value="F" <s:if test='accountCategory=="F"'>selected='selected'</s:if>>交通运输、仓储和邮政业</option>
							<option value="G" <s:if test='accountCategory=="G"'>selected='selected'</s:if>>信息传输、计算机服务和软件业</option>
							<option value="H" <s:if test='accountCategory=="H"'>selected='selected'</s:if>>批发和零售业</option>
							<option value="I" <s:if test='accountCategory=="I"'>selected='selected'</s:if>>住宿和餐饮业</option>
							<option value="J" <s:if test='accountCategory=="J"'>selected='selected'</s:if>>金融业</option>
							<option value="K" <s:if test='accountCategory=="K"'>selected='selected'</s:if>>房地产业</option>
							<option value="L" <s:if test='accountCategory=="L"'>selected='selected'</s:if>>租赁和商务服务业</option>
							<option value="M" <s:if test='accountCategory=="M"'>selected='selected'</s:if>>科学研究、技术服务业和地质勘察业</option>
							<option value="N" <s:if test='accountCategory=="N"'>selected='selected'</s:if>>水利、环境和公共设施管理业</option>
							<option value="O" <s:if test='accountCategory=="O"'>selected='selected'</s:if>>居民服务和其他服务业</option>
							<option value="P" <s:if test='accountCategory=="P"'>selected='selected'</s:if>>教育业</option>
							<option value="Q" <s:if test='accountCategory=="Q"'>selected='selected'</s:if>>卫生、社会保障和社会福利业</option>
							<option value="R" <s:if test='accountCategory=="R"'>selected='selected'</s:if>>文化、体育和娱乐业</option>
							<option value="S" <s:if test='accountCategory=="S"'>selected='selected'</s:if>>公共管理和社会组织</option>
							<option value="T" <s:if test='accountCategory=="T"'>selected='selected'</s:if>>其他行业</option>
						</select> --%>
						<input class="easyui-combobox" id="accountCategory" name="accountCategory"  value='<s:property value="accountCategory"/>' style="width:100%;height:24px" url='getTypeEnum.action?typeCode=CATEGORY' 
							data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  >
					</div>
					<div class="business_title2">企业类型：</div>
					<div class="business_input8">
						<%-- <select id="companyType" class="easyui-combobox" style="width:100%;" data-options="validType:'maxLength[60]',editable:false">
							<option value=""></option>
							<option value="A" <s:if test='companyType=="A"'>selected='selected'</s:if>>内资—国有企业</option>
							<option value="B" <s:if test='companyType=="B"'>selected='selected'</s:if>>内资—集体企业</option>
							<option value="C" <s:if test='companyType=="C"'>selected='selected'</s:if>>内资—股份合作企业</option>
							<option value="D" <s:if test='companyType=="D"'>selected='selected'</s:if>>内资—联营企业</option>
							<option value="E" <s:if test='companyType=="E"'>selected='selected'</s:if>>内资—国有独资有限责任公司</option>
							<option value="F" <s:if test='companyType=="F"'>selected='selected'</s:if>>内资—其他有限责任公司</option>
							<option value="G" <s:if test='companyType=="G"'>selected='selected'</s:if>>内资—股份有限公司</option>
							<option value="H" <s:if test='companyType=="H"'>selected='selected'</s:if>>内资—私营企业</option>
							<option value="I" <s:if test='companyType=="I"'>selected='selected'</s:if>>内资—其他企业</option>
							<option value="J" <s:if test='companyType=="J"'>selected='selected'</s:if>>港、澳、台商投资—合资经营企业</option>
							<option value="K" <s:if test='companyType=="K"'>selected='selected'</s:if>>港、澳、台商投资—合作经营企业</option>
							<option value="L" <s:if test='companyType=="L"'>selected='selected'</s:if>>港、澳、台商投资—独资经营企业 </option>
							<option value="M" <s:if test='companyType=="M"'>selected='selected'</s:if>>港、澳、台商投资—股份有限公司</option>
							<option value="N" <s:if test='companyType=="N"'>selected='selected'</s:if>>外商投资—中外合资经营企业</option>
							<option value="O" <s:if test='companyType=="O"'>selected='selected'</s:if>>外商投资—中外合作经营企业</option>
							<option value="P" <s:if test='companyType=="P"'>selected='selected'</s:if>>外商投资—外商独资企业</option>
							<option value="Q" <s:if test='companyType=="Q"'>selected='selected'</s:if>>外商投资—股份有限公司</option>
							<option value="R" <s:if test='companyType=="R"'>selected='selected'</s:if>>其他类型客户</option>
						</select> --%>
						<input class="easyui-combobox" id="companyType" name="companyType"  value='<s:property value="companyType"/>' style="width:100%;height:24px" url='getTypeEnum.action?typeCode=COMPANY_TYPE' 
							data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  >
					</div>
				</div>
				<%-- <div class="business_ss-dm">
					<div class="business_title2">证明文件种类2：</div>
					<div class="business_input8">
						<input id="fileTypeSecond" class="easyui-textbox" value='<s:property value="fileTypeSecond"/>'  style="width:100%;height:24px" data-options="validType:'maxLength[60]'" />
					</div>
					<div class="business_title2">证明文件编号2：</div>
					<div class="business_input8">
						<input id="fileNumberSecond" class="easyui-textbox" value='<s:property value="fileNumberSecond"/>' style="width:100%;height:24px" data-options="validType:['englishCheckSub','maxLength[60]']" />
					</div>
					<div class="business_title2">证明文件到期日2：</div>
					<div class="business_input12">
						<input id="fileEndDateSecond" class="easyui-datebox" value='<s:property value="fileEndDateSecond"/>' style="width:100%;" data-options="validType:'maxLength[60]',editable:false"/>
					</div>
				</div> --%>
				<%-- <div class="business_ss-dm">
					<div class="business_title2">客户子类型：</div>
					<div class="business_input8">
						<select id="peopleSonType" class="easyui-combobox" style="width:100%;" data-options="panelHeight:'auto',editable:false">
							<option value=""></option>
							<option value="201" <s:if test='peopleSonType=="201"'>selected='selected'</s:if>>企业法人</option>
							<option value="202" <s:if test='peopleSonType=="202"'>selected='selected'</s:if>>非法人企业</option>
							<option value="203" <s:if test='peopleSonType=="203"'>selected='selected'</s:if>>国家机关</option>
							<option value="204" <s:if test='peopleSonType=="204"'>selected='selected'</s:if>>实行预算管理的事业单位</option>
							<option value="205" <s:if test='peopleSonType=="205"'>selected='selected'</s:if>>非预算管理的事业单位</option>
							<option value="206" <s:if test='peopleSonType=="206"'>selected='selected'</s:if>>团级（含）以上军队、武警部队及分散执勤的支（分）队</option>
							<option value="207" <s:if test='peopleSonType=="207"'>selected='selected'</s:if>>社会团体</option>
							<option value="208" <s:if test='peopleSonType=="208"'>selected='selected'</s:if>>具有社会团体法人资格的工会组织</option>
							<option value="209" <s:if test='peopleSonType=="209"'>selected='selected'</s:if>>民办非企业组织</option>
							<option value="210" <s:if test='peopleSonType=="210"'>selected='selected'</s:if>>外地常设机构</option>
							<option value="211" <s:if test='peopleSonType=="211"'>selected='selected'</s:if>>外国驻华机构</option>
							<option value="212" <s:if test='peopleSonType=="212"'>selected='selected'</s:if>>有字号的个体工商户</option>
							<option value="213" <s:if test='peopleSonType=="213"'>selected='selected'</s:if>>无字号的个体工商户</option>
							<option value="214" <s:if test='peopleSonType=="214"'>selected='selected'</s:if>>居民委员会、村民委员会、社区委员会</option>
							<option value="215" <s:if test='peopleSonType=="215"'>selected='selected'</s:if>>单位设立的独立核算的附属机构</option>
							<option value="216" <s:if test='peopleSonType=="216"'>selected='selected'</s:if>>其他组织</option>
							<option value="217" <s:if test='peopleSonType=="217"'>selected='selected'</s:if>>使、领馆</option>
							<option value="218" <s:if test='peopleSonType=="218"'>selected='selected'</s:if>>宗教组织</option>
							<option value="219" <s:if test='peopleSonType=="219"'>selected='selected'</s:if>>国外企业</option>
							<option value="220" <s:if test='peopleSonType=="220"'>selected='selected'</s:if>>外国政府机构</option>
						</select>
						<input class="easyui-combobox" id="peopleSonType" name="peopleSonType" style="width:100%;height:24px" url='getTypeEnum.action?typeCode=PROPOSER_TYPE' 
							data-options="editable:false,valueField:'typeValue', textField:'typeName'" value='<s:property value="peopleSonType"/>' >
					</div> 
				</div>--%>
				<div class="business_ss-dm">
					<div class="business_title2">账户性质：</div>
					<div class="business_input8" >
						<select id="accountType" class="easyui-combobox" name="accountType" style="width:100%;" data-options="<%-- required:true, --%>panelHeight:'auto'<%-- ,readonly:true --%>,editable:false,validType:'maxLength[60]'">
							<option value="0" selected='selected'>基本账户</option>
							<option value="1" <s:if test="accountType==1">selected='selected'</s:if>>一般账户</option>
							<option value="2" <s:if test="accountType==2">selected='selected'</s:if>>预算单位专用存款账户</option>
							<option value="3" <s:if test="accountType==3">selected='selected'</s:if>>特殊单位专用存款账户</option>
							<option value="4" <s:if test="accountType==4">selected='selected'</s:if>>非预算单位专用存款账户</option>
							<option value="5" <s:if test="accountType==5">selected='selected'</s:if>>临时机构临时存款账户</option>
							<option value="6" <s:if test="accountType==6">selected='selected'</s:if>>非临时机构临时存款账户</option>
						</select>
					</div>
					<div id="checkNumberDiv">
						<div class="business_title">基本存款账户开户许可证核准号：</div>
						<div class="business_input8">
							<input id="checkNumber" style="width:100%;" class="easyui-textbox" value='<s:property value="checkNumber"/>' data-options="validType:['englishCheckSub','maxLength[20]']"/>
						</div>
					</div>
					<div id="coinTypeDiv">
					<div class="business_title2">资金性质：</div>
					<div class="business_input8">
						<input id="coinType" class="easyui-textbox" value='<s:property value="coinType"/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					</div>
					<div id="accountEndDateDiv">
					<div class="business_title2">有效日期至：</div>
					<div class="business_input12">
						<input id="accountEndDate" class="easyui-datebox" value="<s:property value="accountEndDate" />" style="width:100%;height:24px" data-options="validType:'maxLength[60]',editable:false" />
					</div>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title4">银行代扣税征收机关(国家)名称：</div>
					<div class="business_input8">
						<input class="easyui-combobox" id="secondTelCode1" <s:if test='%{secondTelCode.substring(0, 1)=="1"}'>value='<s:property value="secondTelCode" />'</s:if><s:else>value=''</s:else>
						    style="width:100%;height:24px" url='getTypeEnum.action?typeCode=TAX_COUNTRY_CODE' 
							data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  >
					</div>
					<div class="business_title4">银行代扣税征收机关(地方)名称：</div>
					<div class="business_input8">
						<input class="easyui-combobox" id="secondTelCode2" <s:if test='%{secondTelCode.substring(0, 1)=="2"}'>value='<s:property value="secondTelCode" />'</s:if><s:else>value=""</s:else>
						    style="width:100%;height:24px" url='getTypeEnum.action?typeCode=TAX_AREA_CODE' 
							data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  >
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title4">单位申请现金库存限额（3-4天零星备用金）：</div>
					<div class="business_input8">
						<input id="applyMoney" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="applyMoney"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title4">银行批准库存限额（银行填写）：</div>
					<div class="business_input8">
						<input id="passMoney" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="passMoney"/>' data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
			</div>
			</div>
			<div id="divstep2">
			<div class="role_window">
				<div class="business_ss-dm">
					<div class="business_title2">人员类别：</div>
					<div class="business_input8">
						<select id="linkManType" class="easyui-combobox" style="width:100%;" data-options="required:true,panelHeight:'auto',editable:false,validType:'maxLength[60]'">
							<option value=""></option>
							<option value="1" <s:if test="linkManType==1">selected='selected'</s:if>>法定代表人</option>
							<option value="2" <s:if test="linkManType==2">selected='selected'</s:if>>单位负责人</option>
						</select>
					</div>
				</div>

				<div class="business_ss-dm" style="height:auto;display:block;">
				<div class="business_title2">法定代表人：</div>
				<table class="auto-table" >
					<tr>
						<td>姓</td>
						<td>名</td>
						<td>证件名称</td>
						<td>证件号码</td>
						<td>证件到期日</td>
						<td>联系电话</td>
					</tr>
					<tr align='center'>
						<td>
							<input id="clientInfo.legalRepresentSurname" alt="name" class="easyui-textbox  auto-input"  style="width:100%;height:24px" value='<s:property value="clientInfo.legalRepresentSurname"/>' data-options="validType:'maxLength[25]'"/>
						</td>
						<td>
							<input id="clientInfo.legalRepresentName" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="clientInfo.legalRepresentName"/>' data-options="validType:'maxLength[25]'"/>
						</td>
						<td>
							<input class="easyui-combobox" alt="idType"  id="clientInfo.idTypeLegal"  value='<s:property value="clientInfo.idTypeLegal"/>'style="width:100%;height:24px" url='getTypeEnum.action?typeCode=ID_TYPE' 
								data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  >
						</td>
						<td>
							<input id="clientInfo.idNoLegal" alt="card" class="easyui-textbox idNoLegal" style="width:100%;height:24px" value='<s:property value="clientInfo.idNoLegal"/>' data-options="validType:['englishCheckSub','maxLength[30]']"/>
						</td>
						<td>
							<input id="clientInfo.endDateLegal" alt="date" class="easyui-datebox"  style="width:100%;height:24px" value='<s:property value="clientInfo.endDateLegal"/>' data-options="validType:'maxLength[60]',editable:false"/>
						</td>
						<td>
							<input id="firstTelCode" alt="tel" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="firstTelCode"/>' data-options="validType:['englishCheckSub','maxLength[30]']"/>
						</td>
					</tr>
				</table>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">国籍：</div>
					<div class="business_input19">
						<input id="clientInfo.nationalLegal" class="easyui-textbox"  style="width:100%;height:24px" <s:if test='clientInfo.nationalLegal!=""'>value='<s:property value="clientInfo.nationalLegal"/>'</s:if><s:else>value="中国"</s:else> data-options="validType:'maxLength[25]'"/>
					</div>
					<div class="business_title2">出生日期：</div>
					<div class="business_input8">
						<input id="clientInfo.birthDateLegal" class="easyui-datebox birthDateLegal" style="width:100%;height:24px" value='<s:property value="clientInfo.birthDateLegal"/>' data-options="validType:'maxLength[25]',editable:false"/>
					</div>
				</div>
				<div class="business_ss-dm" style="height:auto;display:block;">
				<div class="business_title2">财务负责人：</div>
				<table class="auto-table" >
					<tr>
						<td>姓</td>
						<td>名</td>
						<td>证件名称</td>
						<td>证件号码</td>
						<td>证件到期日</td>
						<td>联系电话</td>
					</tr>
					<tr align='center'>
						<td>
							<input id="clientInfo.moneyManSurname" alt="name" class="easyui-textbox auto-input" style="width:100%;height:24px" value='<s:property value="clientInfo.moneyManSurname"/>' data-options="validType:'maxLength[25]'"/>
						</td>
						<td>
							<input id="clientInfo.moneyManName" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="clientInfo.moneyManName"/>' data-options="validType:'maxLength[25]'"/>
						</td>
						<td>
							<input class="easyui-combobox" alt="idType"  id="clientInfo.idNameMoney"  value='<s:property value="clientInfo.idNameMoney"/>'style="width:100%;height:24px" url='getTypeEnum.action?typeCode=ID_TYPE' 
								data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  >
						</td>
						<td>
							<input id="clientInfo.idNoMoney" alt="card" class="easyui-textbox idNoLegal" style="width:100%;height:24px" value='<s:property value="clientInfo.idNoMoney"/>' data-options="validType:['englishCheckSub','maxLength[30]']"/>
						</td>
						<td>
							<input id="clientInfo.endDateMoney" alt="date" class="easyui-datebox"  style="width:100%;height:24px" value='<s:property value="clientInfo.endDateMoney"/>' data-options="validType:'maxLength[60]',editable:false"/>
						</td>
						<td>
							<input id="clientInfo.idNoAgent" alt="tel" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="clientInfo.idNoAgent"/>' data-options="required:true,validType:['englishCheckSub','maxLength[30]']"/>
						</td>
					</tr>
				</table>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">国籍：</div>
					<div class="business_input19">
						<input id="clientInfo.nationalMoney" class="easyui-textbox" style="width:100%;height:24px" <s:if test='clientInfo.nationalMoney!=""'>value='<s:property value="clientInfo.nationalMoney"/>'</s:if><s:else>value="中国"</s:else> data-options="required:true,validType:'maxLength[25]'"/>
					</div>
					<div class="business_title2">出生日期：</div>
					<div class="business_input8">
						<input id="clientInfo.birthDateMoney" class="easyui-datebox" style="width:100%;height:24px" value='<s:property value="clientInfo.birthDateMoney"/>' data-options="required:true,validType:'maxLength[60]',editable:false"/>
					</div>
				</div>
				<div class="business_ss-dm" style="height:auto;display:block;">
				<div class="business_title2">联系人：</div>
				<table class="auto-table" >
					<tr>
						<td>姓</td>
						<td>名</td>
						<td>证件名称</td>
						<td>证件号码</td>
						<td>证件到期日</td>
						<td>联系电话</td>
					</tr>
					<tr align='center'>
						<td>
							<input id="clientInfo.contactManSurname" alt="name" class="easyui-textbox auto-input" style="width:100%;height:24px" value='<s:property value="clientInfo.contactManSurname"/>' data-options="validType:'maxLength[25]'"/>
						</td>
						<td>
							<input id="clientInfo.contactManName" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="clientInfo.contactManName"/>' data-options="validType:'maxLength[25]'"/>
						</td>
						<td>
							<input class="easyui-combobox" alt="idType"  id="clientInfo.idNameContact"  value='<s:property value="clientInfo.idNameContact"/>'style="width:100%;height:24px" url='getTypeEnum.action?typeCode=ID_TYPE' 
								data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  >
						</td>
						<td>
							<input id="clientInfo.idNoContact" alt="card" class="easyui-textbox idNoLegal"  style="width:100%;height:24px" value='<s:property value="clientInfo.idNoContact"/>' data-options="validType:['englishCheckSub','maxLength[30]']"/>
						</td>
						<td>
							<input id="clientInfo.endDateContact" alt="date" class="easyui-datebox" style="width:100%;height:24px" value='<s:property value="clientInfo.endDateContact"/>' data-options="validType:'maxLength[60]',editable:false"/>
						</td>
						<td>
							<input id="clientInfo.telContact" alt="tel" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="clientInfo.telContact"/>' data-options="required:true,validType:['englishCheckSub','maxLength[30]']"/>
						</td>
					</tr>
				</table>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">国籍：</div>
					<div class="business_input19">
						<input id="clientInfo.nationalContact" class="easyui-textbox" style="width:100%;height:24px" <s:if test='clientInfo.nationalContact!=""'>value='<s:property value="clientInfo.nationalContact"/>'</s:if><s:else>value="中国"</s:else> data-options="required:true,validType:'maxLength[25]'"/>
					</div>
					<div class="business_title2">出生日期：</div>
					<div class="business_input8">
						<input id="clientInfo.birthDateContact" class="easyui-datebox" style="width:100%;height:24px" value='<s:property value="clientInfo.birthDateContact"/>' data-options="required:true,validType:'maxLength[60]',editable:false"/>
					</div>
					<div class="business_title2">电子邮件：</div>
					<div class="business_input8">
						<input id="clientInfo.emailContact" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="clientInfo.emailContact"/>' data-options="required:true,validType:'email'"/>
					</div>
				</div>
				<div id="authorizeDiv" style="width:100%">
				<!-- <div class="role_window_title14" style="float: left;">结算账户相关业务授权信息</div> -->
				<div class="business_ss-dm1">
					<div class="business_title2">被授权人：</div>
					<div>
						<table id="shouquan_tb" class="auto-table">
							<tr>
								<td>姓名</td>
								<td>证件类型</td>
								<td>证件号码</td>
								<td>证件到期日</td>
								<td>联系电话</td>
								<td>授权办理业务种类</td>
							</tr>
						</table>
						<div style="border:2px; border-color:#00CC00;  margin-left:20%;margin-top:20px">
							<input type="button"  value="增加" onclick="addAuthorize('shouquan_tb')"/>
						</div>
					</div>
				</div>
				<div class="business_ss-dm1" style="margin-top: 40px;">
					<div class="business_title2">办理业务种类：</div>
					<div >
						<table>
							<tr>
								<td>
									A、办理单位银行结算账户开户手续
								</td>
							</tr>
							<tr>
								<td>
									B、办理企业网上银行相关业务:领取网上银行客户认证工具(“动态l1令牌E-Token”/ “数字证书令牌” “USBkey”及相应密码信封)
								</td>
							</tr>
							<tr>
								<td>
									C、签署综合服务协议
								</td>
							</tr>
							<tr>
								<td>
									D、预留签章式样：将其个人签章及
									<label><input id="D1" name="D" type="checkbox" value="D1" />本单位公章</label> 
									<label><input id="D2" name="D" type="checkbox" value="D2" />财务专用章作为预留银行印鉴 </label> 
								</td>
							</tr>
							<!-- <tr>
								<td>
									E、变更预留签章式样：变更
									<label><input id="E1" name="E" type="checkbox" value="E1" />个人签章及</label> 
									<label><input id="E2" name="E" type="checkbox" value="E2" />本单位公章 </label> 
									<label><input id="E3" name="E" type="checkbox" value="E3" />财务专用章 </label> 
								</td>
							</tr> -->
							<tr>
								<td>
									F、作为结算证主卡指定持卡人
								</td>
							</tr>
							<tr>
								<td>
									G、作为结算证副卡指定持卡人
								</td>
							</tr>
							<tr>
								<td>
									H、作为我单位大额交易有权确认人员(原则上应为两人)
								</td>
							</tr>
							<tr>
								<td>
									I、作为网银操作员-经办人
								</td>
							</tr>
							<tr>
								<td>
									J、作为网银操作员-授权人
								</td>
							</tr>
							<tr>
								<td>
									K、其他：
									<input id="I" style="width:40%;" class="easyui-textbox"  data-options="validType:'maxLength[120]'"/>
								</td>
							</tr>
						</table>
					</div>
				</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">对账联系人姓名：</div>
					<div class="business_input8">
						<input id="checkProto.checkPerson" style="width:100%;" class="easyui-textbox prodata autoin" objtype='2' value='<s:property value="checkProto.checkPerson"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">对账联系人电话：</div>
					<div class="business_input8">
						<input id="checkProto.checkPersonTel" style="width:100%;" class="easyui-textbox prodata" objtype='2' value='<s:property value="checkProto.checkPersonTel"/>' data-options="validType:'maxLength[60]'" />
					</div>
				</div>
				<div class="business_title2">对账单的寄送地址：</div>
				<div class="business_ss-dm1" style="padding-left: 13%;">
					<div id="checkRadio">
						<label><input name="checkAddressType" <s:if test='checkProto.checkAddressType=="1"'>checked="checked"</s:if> type="radio" value="1" />注册地址</label> 
						<label><input name="checkAddressType" <s:if test='checkProto.checkAddressType=="2"'>checked="checked"</s:if><s:if test='checkProto.checkAddressType==""'>checked="checked"</s:if> type="radio" value="2" />办公地址</label> 
						<label><input name="checkAddressType" <s:if test='checkProto.checkAddressType=="3"'>checked="checked"</s:if> type="radio" value="3" />临时地址 </label> 
						<label><input name="checkAddressType" <s:if test='checkProto.checkAddressType=="4"'>checked="checked"</s:if> type="radio" value="4" />其它地址 </label>
					</div>
				</div>
				<div id= "checkDiv">
				<div class="business_ss-dm">
					<div class="business_title2">省(自治区)：</div>
					<div class="business_input8">
						<input id="checkProto.checkAddressS" class="easyui-textbox" value='<s:property value="checkProto.checkAddressS"/>' style="width:100%;height:24px" data-options="validType:'maxLength[15]'"/>
					</div>
					<div class="business_title2">市(州)：</div>
					<div class="business_input8">
						<input id="checkProto.checkAddressZ" class="easyui-textbox" value='<s:property value="checkProto.checkAddressZ"/>' style="width:100%;height:24px" data-options="validType:'maxLength[15]'"/>
					</div>
					<div class="business_title2">区(县)：</div>
					<div class="business_input8">
						<input id="checkProto.checkAddressQ" class="easyui-textbox" value='<s:property value="checkProto.checkAddressQ"/>' style="width:100%;height:24px" data-options="validType:'maxLength[15]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">详细地址：</div>
					<div class="business_input9">
						<input id="checkProto.checkAddressD" class="easyui-textbox" value='<s:property value="checkProto.checkAddressD"/>' style="width:100%;height:24px" data-options="validType:'maxLength[50]'"/>
					</div>
				</div>
				</div>
				<div class="business_ss-dm1">
					<div class="business_title2">主要股东：</div>
					<div >
						<table id="guquan_tb" class="auto-table">
							<tr>
								<td>姓名/名称</td>
								<td>证件种类</td>
								<td>证件号码</td>
								<td>证件到期日</td>
								<td>控股比例(%)</td>
								<!-- <td>操作</td> -->
							</tr>
							
						</table>
						<div style="border:2px; border-color:#00CC00;  margin-left:20%;margin-top:20px">
							<input type="button" value="增加" onclick="addClintTbtr('guquan_tb')" />
							<!-- <input type="button" id="getGQData_btn" value="获取表格数据" onclick="gettrVal('guquan_tb',5)" /> -->
						</div>
					</div>
					<div class="business_title2">收益权人：</div>
					<div >
						<table id="quanyi_tb" class="auto-table">
							<tr>
								<td>姓名/名称</td>
								<td>证件种类</td>
								<td>证件号码</td>
								<td>证件到期日</td>
								<td>控股比例</td>
								<!-- <td>操作</td> -->
							</tr>
							
						</table>
						<div style="border:2px; border-color:#00CC00;  margin-left:20%;margin-top:20px">
							<input type="button"  value="增加" onclick="addClintTbtr('quanyi_tb')"/>
							<!-- <input type="button" id="getGQData_btn" value="获取表格数据" onclick="gettrVal('guquan_tb',5)" /> -->
						</div>
					</div>
				</div>
			</div>
			
			</div>
			<div id="divstep3">
			<div class="role_window" >
				<!-- <div class="role_window_title14" style="float: left;">经营信息</div> -->
				<div class="business_ss-dm">
					<div class="business_title2">主要营业国家或地区：</div>
					<div class="business_input8">
						<input id="clientInfo.busiCountry" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="clientInfo.busiCountry"/>' data-options="validType:'maxLength[25]'"/>
					</div>
				</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">是否上市公司：</div>
					<div class="business_input8">
						<select id="clientInfo.publicCompany" class="easyui-combobox" style="width:100%;" data-options="validType:'maxLength[60]',editable:false">
							<option value=""></option>
							<option value="0" <s:if test='clientInfo.publicCompany=="0"'>selected='selected'</s:if>>是上市公司</option>
							<option value="1" <s:if test='clientInfo.publicCompany=="1"'>selected='selected'</s:if>>不是上市公司</option>
						</select>
					</div>
					<div class="business_title2">从业人数：</div>
					<div class="business_input8">
						<input id="clientInfo.numEmp" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="clientInfo.numEmp"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<%-- <div class="business_title2">创建日期：</div>
					<div class="business_input8">
						<input id="clientInfo.createDate" class="easyui-datebox" style="width:100%;height:24px" value='<s:property value="clientInfo.createDate"/>' data-options="required:true,validType:'maxLength[60]',editable:false"/>
					</div> --%>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">年销售币种及销售额：</div>
					<div class="business_input8">
						<input id="clientInfo.salesVolume" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="clientInfo.salesVolume"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">主要海外分支机构所在国家或地区：</div>
					<div class="business_input8">
						<input id="clientInfo.overseasAffiliate" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="clientInfo.overseasAffiliate"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">主要海外客户所在地：</div>
					<div class="business_input8">
						<input id="clientInfo.overseasCust" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="clientInfo.overseasCust"/>' data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div id="sywj" class="business_ss-dm">
					<div class="business_title2">商业活动旺季（可多选）：</div>
					<div class="business_input8">
						<%-- <input id="clientInfo.highSeasons" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="clientInfo.highSeasons"/>'/> --%>
						<label><input id="W1" name="W" type="checkbox" value="W1" />1-3月</label> 
						<label><input id="W2" name="W" type="checkbox" value="W2" />4-6月 </label> 
						<label><input id="W3" name="W" type="checkbox" value="W3" />7-9月 </label>
						<label><input id="W4" name="W" type="checkbox" value="W4" />10-12月 </label>  
					</div>
					<div class="business_title2">其他业务：</div>
					<div class="business_input8">
						<input id="clientInfo.otherBusi" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="clientInfo.otherBusi"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">其他联系方式（移动电话/电子邮件/传真等）：</div>
					<div class="business_input8">
						<input id="clientInfo.otherContact" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="clientInfo.otherContact"/>' data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm1">
				<div class="business_title2">关联企业：</div>
				<div>
					<table id="glqiye_tb">
						<tr>
							<td>关联企业名称</td>
							<td>法定代表人</td>
							<td>组织机构代码</td>
							<td>是否为控股股东</td>
						</tr>
					</table>
					<div style="border:2px; border-color:#00CC00;  margin-left:20%;margin-top:20px">
						<input type="button"  value="增加" onclick="addtr('glqiye_tb',4)"/>
					</div>
				</div>
				<div class="business_title2">股东/出资人为自然人时：</div>
				<div>
					<table id="glgudong_tb" class="auto-table">
						<tr>
							<td>股东姓名</td>
							<td>证件种类</td>
							<td>证件号码</td>
							<td>证件到期日</td>
							<td>是否为控股股东</td>
						</tr>
					</table>
					<div style="border:2px; border-color:#00CC00;  margin-left:20%;margin-top:20px">
						<input type="button"  value="增加" onclick="addClintTbtr('glgudong_tb')"/>
					</div>
				</div>
				</div>
			<div id="chargeDiv" style="width:100%;">
			<div class="role_window">
				<div id="dedicatedDiv" style="width:100%;">
				<div class="role_window">
				<!-- <div class="role_window_title14">专用存款账户申请信息</div> -->
				<div class="business_ss-dm">
					<div class="business_title">内设机构（部门）名称：</div>
					<div class="business_input8">
						<input id="dedicatedShort.departName" style="width:100%;" class="easyui-textbox" value='<s:property value="dedicatedShort.departName"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">内设机构（部门）电话：</div>
					<div class="business_input8">
						<input id="dedicatedShort.departTel" style="width:100%;" class="easyui-textbox" value='<s:property value="dedicatedShort.departTel"/>' data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">内设机构（部门）地址：</div>
					<div class="business_input8">
						<input id="dedicatedShort.departAddress" style="width:100%;" class="easyui-textbox" value='<s:property value="dedicatedShort.departAddress"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">内设机构（部门）邮编：</div>
					<div class="business_input8">
						<input id="dedicatedShort.departPostCode" style="width:100%;" class="easyui-textbox" value='<s:property value="dedicatedShort.departPostCode"/>' data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">内设机构（部门）负责人姓名：</div>
					<div class="business_input8">
						<input id="dedicatedShort.principleName" style="width:100%;" class="easyui-textbox" value='<s:property value="dedicatedShort.principleName"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">证件到期日：</div>
					<div class="business_input8">
						<input id="dedicatedShort.idEndDate" style="width:100%;" class="easyui-datebox" value='<s:property value="dedicatedShort.idEndDate"/>' data-options="editable:false,validType:'maxLength[60]'" />
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">证件种类：</div>
					<div class="business_input8">
						<input class="easyui-combobox" id="dedicatedShort.idType" name="dedicatedShort.idType"  value='<s:property value="dedicatedShort.idType"/>'style="width:100%;height:24px" url='getTypeEnum.action?typeCode=ID_TYPE' 
							data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  >
					</div>
					<div class="business_title2">证件号码：</div>
					<div class="business_input8">
						<input id="dedicatedShort.idNo" style="width:100%;" class="easyui-textbox" value='<s:property value="dedicatedShort.idNo"/>' data-options="validType:['englishCheckSub','maxLength[30]']"/>
					</div>
				</div>
			</div>
			</div>
			<div id="shortDiv" style="width:100%;">
			<div class="role_window">
				<!-- <div class="role_window_title14">临时存款账户申请信息</div> -->
				<div class="business_ss-dm">
					<div class="business_title">项目部名称：</div>
					<div class="business_input8">
						<input id="dedicatedShort.departName" style="width:100%;" class="easyui-textbox" value='<s:property value="dedicatedShort.departName"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">项目部电话：</div>
					<div class="business_input8">
						<input id="dedicatedShort.departTel" style="width:100%;" class="easyui-textbox" value='<s:property value="dedicatedShort.departTel"/>' data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">项目部地址：</div>
					<div class="business_input8">
						<input id="dedicatedShort.departAddress" style="width:100%;" class="easyui-textbox" value='<s:property value="dedicatedShort.departAddress"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">项目部邮编：</div>
					<div class="business_input8">
						<input id="dedicatedShort.departPostCode" style="width:100%;" class="easyui-textbox" value='<s:property value="dedicatedShort.departPostCode"/>' data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">项目部负责人姓名：</div>
					<div class="business_input8">
						<input id="dedicatedShort.principleName" style="width:100%;" class="easyui-textbox" value='<s:property value="dedicatedShort.principleName"/>' data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title2">证件到期日：</div>
					<div class="business_input8">
						<input id="dedicatedShort.idEndDate" style="width:100%;" class="easyui-datebox" value='<s:property value="dedicatedShort.idEndDate"/>' data-options="editable:false,validType:'maxLength[60]'" />
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">证件种类：</div>
					<div class="business_input8">
						<input class="easyui-combobox" id="dedicatedShort.idType" name="dedicatedShort.idType"  value='<s:property value="dedicatedShort.idType"/>'style="width:100%;height:24px" url='getTypeEnum.action?typeCode=ID_TYPE' 
							data-options="valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  >
					</div>
					<div class="business_title2">证件号码：</div>
					<div class="business_input8">
						<input id="dedicatedShort.idNo" style="width:100%;" class="easyui-textbox" value='<s:property value="dedicatedShort.idNo"/>' data-options="validType:['englishCheckSub','maxLength[30]']"/>
					</div>
				</div>
			</div>
			</div>
					<div class="role_window_title14" style="float: left;">存款人上级法人或主管单位信息</div>
					<div class="business_ss-dm">
						<div class="business_title">上级法人或主管单位名称：</div>
						<div class="business_input9">
							<input id="bookCharge.unitName" style="width:100%;" class="easyui-textbox" value='<s:property value="bookCharge.unitName"/>' data-options="validType:'maxLength[60]'" />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title">基本存款账户开户许可证核准号：</div>
						<div class="business_input8">
							<input id="bookCharge.checkNumber" style="width:100%;" class="easyui-textbox" value='<s:property value="bookCharge.checkNumber"/>' data-options="validType:['englishCheckSub','maxLength[20]']"/>
						</div>
						<div class="business_title2">组织机构代码：</div>
						<div class="business_input8">
							<input id="bookCharge.orgInstitCd" style="width:100%;" class="easyui-textbox" value='<s:property value="bookCharge.orgInstitCd"/>' data-options="validType:['englishCheckSub','maxLength[30]']"/>
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title">人员类别：</div>
						<div class="business_input8">
							<select id="bookCharge.linkManType" class="easyui-combobox" name="bookCharge.linkManType" style="width:100%;" data-options="panelHeight:'auto',editable:false">
								<option value="" ></option>
								<option value="1" <s:if test="bookCharge.linkManType==1">selected='selected'</s:if>>法定代表人</option>
								<option value="2" <s:if test="bookCharge.linkManType==2">selected='selected'</s:if>>单位负责人</option>
							</select>
						</div>
						<div class="business_title2">姓名：</div>
						<div class="business_input8">
							<input id="bookCharge.linkMan" class="easyui-textbox" value='<s:property value="bookCharge.linkMan"/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
						</div>
						<div class="business_title2">证件到期日：</div>
						<div class="business_input12">
							<input id="bookCharge.idEndDate" class="easyui-datebox" value='<s:property value="bookCharge.idEndDate"/>' format="yyyy-MM-dd" style="width:100%;" data-options="validType:'maxLength[60]',editable:false" />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title">证件种类：</div>
						<div class="business_input8">
							<input class="easyui-combobox" id="bookCharge.idType" name="bookCharge.idType"  value='<s:property value="bookCharge.idType"/>'style="width:100%;height:24px" url='getTypeEnum.action?typeCode=ID_TYPE' 
							data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  >
						</div>
						<div class="business_title2">证件号码 ：</div>
						<div class="business_input8">
							<input id="bookCharge.idNumber" class="easyui-textbox" value='<s:property value="bookCharge.idNumber"/>' data-options="prompt:'请输入证件号码'" style="width:100%;height:24px" data-options="validType:['englishCheckSub','maxLength[30]']"/>
						</div>
					</div>
					<div id="products" class="business_title10">请选择需办理的国内结算产品：
						<label><input id="PD1" name="PD" type="checkbox" value="PD1" />
							<a href="<%=request.getContextPath()%>/paymentCardBack.html" target="_blank" style="color:blue;">中银单位结算卡</a>
						</label> 
						<label><input id="PD2" name="PD" type="checkbox" value="PD2" />
							<a href="<%=request.getContextPath()%>/paymentCardBack.html" target="_blank" style="color:blue;">对公短信通</a>
						</label> 
						<label><input id="PD3" name="PD" type="checkbox" value="PD3" />
							<a href="<%=request.getContextPath()%>/paymentCardBack.html" target="_blank" style="color:blue;">单位客户回单自助打印盖章</a>
						</label> 
						<label><input id="PD4" name="PD" type="checkbox" value="PD4" />
							<a href="<%=request.getContextPath()%>/paymentCardBack.html" target="_blank" style="color:blue;">电子回单箱</a>
						</label> 
					</div>
			</div>
			<div class="role_window_button" style="margin-top:30px;">
					<%-- <a id="checkPassBtn" href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
						style="padding:3px 0px;width:20%; margin-right:10px;display:none;" onclick="saveBook(2)">
						<span style="font-size:14px;">核对通过</span>
					</a> --%>
					<div class="business_title2">表单选择：</div>
					<div class="business_input8">
					<select id="pageChose" class="easyui-combobox" style="width:100%;" data-options="editable:false">
						<option value="0" >开立单位银行结算账户申请书无附加客户信息</option>
						<option value="1" >开立单位银行结算账户申请书含附加客户信息</option>
						<option value="2" >对公客户信息表</option>
						<option value="3" >关联企业、股东登记表</option>
						<option value="4" >单位银行结算账户相关业务授权书</option>
						<option value="5" >外部公司客户对账服务协议</option>
						<option value="8" >网上银行服务申请表</option>
						<option value="91" >银行结算证申请表</option>
						<!-- <option value="92" >结算证使用协议</option> -->
						<option value="10" >代扣缴款协议书</option>
						<option value="6" >使用通用性支付密码器信息表</option>
						<option value="7" >国内结算产品开办申请表</option>
						<option value="11" >专用/临时申请申请书附页</option>
						<option value="12" >中银单位结算卡开办申请表</option>
						<option value="13" >青岛市分行自助卡申请表</option>
						<option value="141" >综合服务协议签署表</option>
						<option value="142" >综合服务协议签署表-产品</option>
						<option value="151" >对公短信通产品开办须知</option>
						<option value="16" >外汇账户开立表</option>
						<!-- <option value="152" >对公短信通客户信息表</option> -->
					</select>
					</div>
					<a id="printBtn" href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-print'"
						style="padding:3px 0px;width:20%; margin-left:10px;float: left;" onclick="printToBook('')">
						<span style="font-size:14px;">打印</span>
					</a>
					<a id="toCheckBtn" href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
						style="padding:3px 0px;width:20%; margin-right:10px;float: left;" onclick="saveBook(1,1)">
						<span style="font-size:14px;">提交核对</span>
					</a>
				</div>
			</div>
			<div class="role_window">
				<%-- <div class="business_ss-dm">
					<div class="business_title2">实际控制人姓名：</div>
					<div class="business_input8">
						<input id="controlPeople" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="controlPeople"/>' data-options="required:true,validType:'maxLength[50]'"/>
					</div>
					<div class="business_title2">证件种类：</div>
					<div class="business_input8">
						<input id="idTypeControl" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="idTypeControl"/>' data-options="required:true,validType:'maxLength[25]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">证件号码：</div>
					<div class="business_input8">
						<input id="idNoControl" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="idNoControl"/>' data-options="required:true,validType:['englishCheckSub','maxLength[30]']"/>
					</div>
					<div class="business_title2">证件到期日：</div>
					<div class="business_input8">
						<input id="endDateControl" class="easyui-datebox"  style="width:100%;height:24px" value='<s:property value="endDateControl"/>' data-options="required:true,validType:'maxLength[60]',editable:false"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">控股股东姓名：</div>
					<div class="business_input8">
						<input id="partnerPeople" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="partnerPeople"/>' data-options="required:true,validType:'maxLength[25]'"/>
					</div>
					<div class="business_title2">证件名称：</div>
					<div class="business_input8">
						<input id="idTypePartner" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="idTypePartner"/>' data-options="required:true,validType:'maxLength[25]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">证件到期日：</div>
					<div class="business_input8">
						<input id="endDatePartner" class="easyui-datebox"  style="width:100%;height:24px" value='<s:property value="endDatePartner"/>' data-options="required:true,validType:'maxLength[60]',editable:false"/>
					</div>
					<div class="business_title2">证件号码：</div>
					<div class="business_input8">
						<input id="idNoPartner" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="idNoPartner"/>' data-options="required:true,validType:['englishCheckSub','maxLength[30]']"/>
					</div>
				</div>
				<div class="business_title2">代办人信息：</div>
				<br />
				<div class="business_ss-dm">
					<div class="business_title2">姓：</div>
					<div class="business_input19">
						<input id="clientInfo.agentManSurname" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="clientInfo.agentManSurname"/>' data-options="validType:'maxLength[25]'"/>
					</div>
					<div class="business_title6">名：</div>
					<div class="business_input19">
						<input id="clientInfo.agentManName" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="clientInfo.agentManName"/>' data-options="validType:'maxLength[25]'"/>
					</div>
					<div class="business_title6">国籍：</div>
					<div class="business_input19">
						<input id="clientInfo.nationalAgent" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="clientInfo.nationalAgent"/>' data-options="validType:'maxLength[25]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title2">证件名称：</div>
					<div class="business_input8">
						<input id="clientInfo.idNameAgent" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="clientInfo.idNameAgent"/>' data-options="validType:'maxLength[25]'"/>
					</div>
					<div class="business_title6">证件号码：</div>
					<div class="business_input12">
						<input id="clientInfo.idNoAgent" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="clientInfo.idNoAgent"/>' data-options="validType:['englishCheckSub','maxLength[30]']"/>
					</div>
					<div class="business_title6">证件到期日：</div>
					<div class="business_input12">
						<input id="clientInfo.endDateAgent" class="easyui-datebox"  style="width:100%;height:24px" value='<s:property value="clientInfo.endDateAgent"/>' data-options="validType:'maxLength[60]',editable:false"/>
					</div>
				</div> --%>
			</div>
			</div>
		<div id="divstep4">
		<%-- <div id="paymentCardDiv" style="width: 100%;">
			<div class="role_window">
				<div class="role_window_title14">银行结算证（IC卡）申请信息</div>
				<div class="business_ss-dm">
					<div class="business_title">持证（卡）人姓名：</div>
					<div class="business_input8">
						<input id="paymentCard.userName" style="width:100%;" class="easyui-textbox" value='<s:property value="paymentCard.userName"/>'  data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title">身份证号码：</div>
					<div class="business_input8">
						<input id="paymentCard.idNo" style="width:100%;" class="easyui-textbox" value='<s:property value="paymentCard.idNo"/>'  data-options="validType:['englishCheckSub','maxLength[30]']"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">单位账号：</div>
					<div class="business_input8">
						<input id="paymentCard.companyCode" style="width:100%;" class="easyui-textbox" value='<s:property value="paymentCard.companyCode"/>'  data-options="validType:['englishCheckSub','maxLength[30]']"/>
					</div>
					<div class="business_title">结算证类型：</div>
					<div class="business_input8">
						<select id="paymentCard.cardType" class="easyui-combobox" name="paymentCard.cardType" style="width:100%;" data-options="panelHeight:'auto',editable:false,validType:'maxLength[60]'">
							<option value=""></option>
							<option value="1" <s:if test='paymentCard.cardType==1'>selected='selected'</s:if>>主卡</option>
							<option value="2" <s:if test='paymentCard.cardType==2'>selected='selected'</s:if>>副卡</option>
						</select>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">副证（卡）持有人：</div>
					<div class="business_input8">
						<input id="paymentCard.secondUserName" style="width:100%;" class="easyui-textbox" value='<s:property value="paymentCard.secondUserName"/>'  data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title">身份证号码：</div>
					<div class="business_input8">
						<input id="paymentCard.secondUserId" style="width:100%;" class="easyui-textbox" value='<s:property value="paymentCard.secondUserId"/>'  data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title">背面协议：</div>
					<div class="business_input8">
						<a href="<%=request.getContextPath()%>/paymentCardBack.html" target="_blank" style="color:blue;">请仔细阅读并确认背面的协议条款</a>
					</div>
				</div>
			</div>
		</div> --%>
		</div>
		</form>
		<div id="recordDiv" style="width:100%;height:250px;display: none;">
			<div class="role_window">
				<div class="role_window_title14">栏目由开户银行审核后填写</div>
					<div class="business_ss-dm">
						<div class="business_title">开户银行名称：</div>
						<div class="business_input9">
							<input id="openBankName" class="easyui-textbox" value='<s:property value="openBankName"/>' data-options="validType:'maxLength[60]',editable:false" style="width:100%;height:24px" />
						</div>
						<div class="business_title2">开户银行代码：</div>
						<div class="business_input9">
							<input id="openBankCode" class="easyui-textbox" value='<s:property value="openBankCode"/>' data-options="validType:['englishCheckSub','maxLength[12]']" style="width:100%;height:24px" />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title">账户名称：</div>
						<div class="business_input9">
							<input id="accountName" class="easyui-textbox" value='<s:property value="accountName"/>' data-options="validType:'maxLength[60]'" style="width:100%;height:24px" />
						</div>
						<div class="business_title2">账号：</div>
						<div class="business_input9">
							<input id="accountCode" class="easyui-textbox" value='<s:property value="accountCode"/>' style="width:100%;height:24px" data-options="validType:['number','maxLength[17]']"/>
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">开户日期：</div>
						<div class="business_input8">
							<input id="openDate" class="easyui-datebox" value="<s:date name="openDate" format="yyyy-MM-dd"/>" style="width:100%;height:24px" data-options="required:true,editable:false" />
						</div>
					</div>
			</div>
		</div>
		<div id="stepBtn" class="role_window_button" style="margin-top:30px;">
			<div class="role_window">
			<a id="preStep" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-091'"
				style="padding:3px 0px;width:20%; margin-right:10px;" onclick="preStep()">
				<span style="font-size:14px;">上一步</span>
			</a>
			<a href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
				style="padding:3px 0px;width:20%; margin-right:10px;" onclick="saveBook(<s:if test='handleStatus==null'>0</s:if><s:property value="handleStatus"/>)">
				<span style="font-size:14px;">暂存</span>
			</a>
			<a id="nextStep" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-101'"
				style="padding:3px 0px;width:20%; margin-right:10px;" onclick="nextStep()">
				<span style="font-size:14px;">下一步</span>
			</a>
			</div>
		</div>
		
		
		<div id="openBasicAcc" class="easyui-window" title="开户类型选择" data-options="modal:true,iconCls:'ico_171'"
			style="width:600px;padding:10px;">
			<div class="business_ss-dm">
				<div class="business_title" style="width:35%">账户类型：</div>
				<div class="business_input2">
					<select id="accountType" class="easyui-combobox" style="width:100%;" data-options="panelHeight:'auto',editable:false">
						<option value=""></option>
						<option value="0" >基本账户</option>
						<option value="1" >一般账户</option>
						<option value="2" >预算单位专用存款账户</option>
						<option value="3" >特殊单位专用存款账户</option>
						<option value="4" >非预算单位专用存款账户</option>
						<option value="5" >临时机构临时存款账户</option>
						<option value="6" >非临时机构临时存款账户</option>
					</select>
				</div>
			</div>
			<div id="fileNumberDiv" class="business_ss-dm">
				<div class="business_title" style="width:35%">营业执照号：</div>
				<div class="business_input2">
					<input id="fileNumber" class="easyui-textbox"  style="width:100%;height:24px" />
				</div>
			</div>
			
			<%-- <div id="openCommAcc">
				<div class="business_ss-dm">
					<div class="business_title" style="width:35%">基本存款账户开户许可证核准号：</div>
					<div class="business_input2">
						<input id="checkNumber" class="easyui-textbox" data-options="  validType:['englishCheckSub','maxLength[20]']" style="width:100%;height:24px" />
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title" style="width:35%">账号：</div> 
					<div class="business_input2">
						<input id="accountCode" class="easyui-textbox" data-options="  validType:['number','maxLength[17]']" 
							style="width:100%;height:24px" />
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title" style="width:35%">商业银行机构代码：</div>
					<div class="business_input2">
						<input id="openBankCode" class="easyui-textbox" value='<s:property value="openBankCode"/>' disabled="disabled" 
						data-options="required:'true'" style="width:100%;height:24px"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title" style="width:35%">商业银行机构名称：</div>
					<div class="business_input2">
						<input id="openBankName" class="easyui-textbox" disabled="disabled" value='<s:property value="openBankName"/>'
							style="width:100%;height:24px"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title" style="width:35%">基本户开户地地区代码：</div>
					<div class="business_input2">
						<input id="areaCode" class="easyui-textbox" data-options="  validType:['englishCheckSub','maxLength[60]']" style="width:100%;height:24px" />
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title" style="width:35%">开户日期：</div>
					<div class="business_input2">
						<input id="openDate" class="easyui-datebox" style="width:100%;height:24px" value="<s:date name="openDate" format="yyyy-MM-dd"/>"
							 data-options="required:true,editable:false"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title" style="width:35%">证明文件类型：</div>
					<div class="business_input2">
						<select id="commonFileType" class="easyui-combobox" name="commonFileType" style="width:100%"
							data-options="panelHeight:'auto',editable:false">
							<option value="07" <s:if test='commonFileType=="07"'>selected='selected'</s:if>>其他结算需要的证明</option>
							<option value="06" <s:if test='commonFileType=="06"'>selected='selected'</s:if>>借款合同</option>
						</select>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title" style="width:35%">证明文件编号：</div>
					<div class="business_input2">
						<input id="commonFileNumber" name="commonFileNumber" class="easyui-textbox" data-options="required:'true',missingMessage:'当操作员选择“借款合同”时,证明文件编号为必输项,反之可以为空'"
							style="width:100%;height:24px" />
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title" style="width:35%">备注：</div>
					<div class="business_input2">
						<input class="easyui-textbox" style="width:100%;height:24px" />
					</div>
				</div>
			</div> --%>
			<div class="role_window_button">
				<!-- <div><label style="font-size: 14px;font-weight: bold;">两者录入一项即可</label></div> -->
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'ico_090'"
					style="padding:5px 0px;width:20%; margin-right:10px;" onclick="getBasicInfo()">
					<span style="font-size:14px;">下一步</span>
				</a>
			</div>
		</div>
		<div id="PD1Div" class="easyui-window" title="开办中银单位结算卡" data-options="modal:true,iconCls:'ico_171'"
			style="width:780px;padding:10px;">
			<div class="business_ss-dm" style="height:auto;display:block;">
				<table class="auto-table" >
					<tr>
						<td>结算卡类型</td>
						<td>姓名</td>
						<td>证件类型</td>
						<td>证件号码</td>
						<td>手机号码</td>
					</tr>
					<tr align='center'>
						<td>
							主卡持卡人：
						</td>
						<td>
							<input id="productInfo.cardholderName" alt="name" class="easyui-textbox auto-input" style="width:100%;height:24px" value='<s:property value="productInfo.cardholderName"/>' data-options="validType:'maxLength[25]'"/>
						</td>
						<td>
							<input class="easyui-combobox" alt="idType"  id="productInfo.cardholderIdType"  value='<s:property value="productInfo.cardholderIdType"/>'style="width:100%;height:24px" url='getTypeEnum.action?typeCode=ID_TYPE' 
								data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  >
						</td>
						<td>
							<input id="productInfo.cardholderIdNo" alt="card" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="productInfo.cardholderIdNo"/>' data-options="validType:'maxLength[25]'"/>
						</td>
						<td>
							<input id="productInfo.cardholderTel" alt="tel" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="productInfo.cardholderTel"/>' data-options="validType:'maxLength[30]'"/>
						</td>
					</tr>
					<tr align='center'>
						<td>
							子卡1持卡人：
						</td>
						<td>
							<input id="productInfo.cardholderName1" alt="name" class="easyui-textbox auto-input" style="width:100%;height:24px" value='<s:property value="productInfo.cardholderName1"/>' data-options="validType:'maxLength[25]'"/>
						</td>
						<td>
							<input class="easyui-combobox" alt="idType"  id="productInfo.cardholderIdType1"  value='<s:property value="productInfo.cardholderIdType1"/>'style="width:100%;height:24px" url='getTypeEnum.action?typeCode=ID_TYPE' 
								data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  >
						</td>
						<td>
							<input id="productInfo.cardholderIdNo1" alt="card" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="productInfo.cardholderIdNo1"/>' data-options="validType:'maxLength[25]'"/>
						</td>
						<td>
							<input id="productInfo.cardholderTel1" alt="tel" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="productInfo.cardholderTel1"/>' data-options="validType:'maxLength[30]'"/>
						</td>
					</tr>
					<tr align='center'>
						<td>
							子卡2持卡人：
						</td>
						<td>
							<input id="productInfo.cardholderName2" alt="name" class="easyui-textbox auto-input" style="width:100%;height:24px" value='<s:property value="productInfo.cardholderName2"/>' data-options="validType:'maxLength[25]'"/>
						</td>
						<td>
							<input class="easyui-combobox" alt="idType"  id="productInfo.cardholderIdType2"  value='<s:property value="productInfo.cardholderIdType2"/>'style="width:100%;height:24px" url='getTypeEnum.action?typeCode=ID_TYPE' 
								data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  >
						</td>
						<td>
							<input id="productInfo.cardholderIdNo2" alt="card" class="easyui-textbox" style="width:100%;height:24px" value='<s:property value="productInfo.cardholderIdNo2"/>' data-options="validType:'maxLength[25]'"/>
						</td>
						<td>
							<input id="productInfo.cardholderTel2" alt="tel" class="easyui-textbox"  style="width:100%;height:24px" value='<s:property value="productInfo.cardholderTel2"/>' data-options="validType:'maxLength[30]'"/>
						</td>
					</tr>
				</table>
			</div>
			
					<%-- <div class="business_title4">主卡持卡人姓名：</div>
					<div class="business_input13">
						<input id="productInfo.cardholderName" name="productInfo.cardholderName" class="easyui-textbox" value='<s:property value="productInfo.cardholderName"/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title5">证件类型：</div>
					<div class="business_input13">
						<input class="easyui-combobox" id="productInfo.cardholderIdType" name="productInfo.cardholderIdType"  value='<s:property value="productInfo.cardholderIdType"/>'style="width:100%;height:24px" 
						url='getTypeEnum.action?typeCode=ID_TYPE' data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  >
					</div>
					<div class="business_title4">证件号码：</div>
					<div class="business_input13">
						<input id="productInfo.cardholderIdNo" name="productInfo.cardholderIdNo" class="easyui-textbox" value='<s:property value="productInfo.cardholderIdNo"/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title5">手机号码：</div>
					<div class="business_input13">
						<input id="productInfo.cardholderTel" name="productInfo.cardholderTel" class="easyui-textbox" value='<s:property value="productInfo.cardholderTel"/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
				<div class="business_ss-dm">
					<div class="business_title4">子卡1持卡人姓名：</div>
					<div class="business_input13">
						<input id="productInfo.cardholderName1" name="productInfo.cardholderName1" class="easyui-textbox" value='<s:property value="productInfo.cardholderName1"/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title5">证件类型：</div>
					<div class="business_input13">
						<input class="easyui-combobox" id="productInfo.cardholderIdType1" name="productInfo.cardholderIdType1"  value='<s:property value="productInfo.cardholderIdType1"/>'style="width:100%;height:24px" 
						url='getTypeEnum.action?typeCode=ID_TYPE' data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  >
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title4">证件号码：</div>
					<div class="business_input13">
						<input id="productInfo.cardholderIdNo1" name="productInfo.cardholderIdNo1" class="easyui-textbox" value='<s:property value="productInfo.cardholderIdNo1"/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title5">手机号码：</div>
					<div class="business_input13">
						<input id="productInfo.cardholderTel1" name="productInfo.cardholderTel1" class="easyui-textbox" value='<s:property value="productInfo.cardholderTel1"/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title4">子卡2持卡人姓名：</div>
					<div class="business_input13">
						<input id="productInfo.cardholderName2" name="productInfo.cardholderName2" class="easyui-textbox" value='<s:property value="productInfo.cardholderName2"/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title5">证件类型：</div>
					<div class="business_input13">
						<input class="easyui-combobox" id="productInfo.cardholderIdType2" name="productInfo.cardholderIdType2"  value='<s:property value="productInfo.cardholderIdType2"/>'style="width:100%;height:24px" 
						url='getTypeEnum.action?typeCode=ID_TYPE' data-options="editable:false,valueField:'typeValue', textField:'typeName',validType:'maxLength[60]'"  >
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title4">证件号码：</div>
					<div class="business_input13">
						<input id="productInfo.cardholderIdNo2" name="productInfo.cardholderIdNo2" class="easyui-textbox" value='<s:property value="productInfo.cardholderIdNo2"/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title5">手机号码：</div>
					<div class="business_input13">
						<input id="productInfo.cardholderTel2" name="productInfo.cardholderTel2" class="easyui-textbox" value='<s:property value="productInfo.cardholderTel2"/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
				</div> --%>
			<div class="role_window_button">
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'ico_090'"
					style="padding:5px 0px;width:20%; margin-right:10px;" onclick="$('#PD1Div').window('close');">
					<span style="font-size:14px;">确认开通</span>
				</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'ico_086'"
					style="padding:5px 0px;width:20%; margin-right:10px;" onclick="$('#PD1Div').window('close');">
					<span style="font-size:14px;">取消开通</span>
				</a>
			</div>
		</div>
		<div id="PD2Div" class="easyui-window" title="开办对公短信通 " data-options="modal:true,iconCls:'ico_171'"
			style="width:780px;padding:10px;">
				<div class="business_title2">对公短信通短信接收人：</div>
				<div>
					<table id="dgkehu_tb" class="auto-table">
						<tr>
							<td>姓名</td>
							<td>手机号码</td>
							<td>证件类型</td>
							<td>证件号码</td>
						</tr>
					</table>
					<div style="border:2px; border-color:#00CC00;  margin-left:20%;margin-top:20px">
						<input type="button"  value="增加" onclick="addNoteInfo()"/>
					</div>
				</div>
				<%-- <div class="business_ss-dm">
					<div class="business_title4">姓名：</div>
					<div class="business_input8">
						<input id="" class="easyui-textbox" value='<s:property value=""/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
					<div class="business_title5">手机号码：</div>
					<div class="business_input8">
						<input id="" class="easyui-textbox" value='<s:property value=""/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
				</div>
				<div class="business_ss-dm">
					<div class="business_title4">证件类型：</div>
					<div class="business_input8">
						<select id="" class="easyui-combobox" name="" style="width:100%;" data-options="editable:false">
							<option value="1" >身份证</option>
							<option value="2" >军官证</option>
							<option value="3" >其他</option>
						</select>
					</div>
					<div class="business_title5">证件号码：</div>
					<div class="business_input8">
						<input id="" class="easyui-textbox" value='<s:property value=""/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
					</div>
				</div> --%>
			<div class="role_window_button">
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'ico_090'"
					style="padding:5px 0px;width:20%; margin-right:10px;" onclick="$('#PD2Div').window('close');">
					<span style="font-size:14px;">确认开通</span>
				</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'ico_086'"
					style="padding:5px 0px;width:20%; margin-right:10px;" onclick="$('#PD2Div').window('close');">
					<span style="font-size:14px;">取消开通</span>
				</a>
			</div>
		</div>
		<div id="PD3Div" class="easyui-window" title="开办单位客户回单自助打印盖章" data-options="modal:true,iconCls:'ico_171'"
			style="width:780px;padding:10px;">
			<div class="business_ss-dm">
				<div class="business_title4">回单箱持卡人姓名：</div>
				<div class="business_input13">
					<input id="productInfo.userName" name="productInfo.userName" class="easyui-textbox" value='<s:property value="productInfo.userName"/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
				</div>
				<div class="business_title5">联系电话(手机)：</div>
				<div class="business_input13">
					<input id="productInfo.userTel" name="productInfo.userTel" class="easyui-textbox" value='<s:property value="productInfo.userTel"/>' style="width:100%;height:24px" data-options="validType:'maxLength[60]'"/>
				</div>
			</div>
			<div class="role_window_button">
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'ico_090'"
					style="padding:5px 0px;width:20%; margin-right:10px;" onclick="$('#PD3Div').window('close');">
					<span style="font-size:14px;">确认开通</span>
				</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'ico_086'"
					style="padding:5px 0px;width:20%; margin-right:10px;" onclick="$('#PD3Div').window('close');">
					<span style="font-size:14px;">取消开通</span>
				</a>
			</div>
		</div>
		<div id="PD4Div" class="easyui-window" title="开办电子回单箱" data-options="modal:true,iconCls:'ico_171'"
			style="width:780px;padding:10px;">
				确认开办电子回单箱
			<div class="role_window_button">
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'ico_090'"
					style="padding:5px 0px;width:20%; margin-right:10px;" onclick="$('#PD4Div').window('close');">
					<span style="font-size:14px;">确认开通</span>
				</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'ico_086'"
					style="padding:5px 0px;width:20%; margin-right:10px;" onclick="$('#PD4Div').window('close');">
					<span style="font-size:14px;">取消开通</span>
				</a>
			</div>
		</div>
	</div>
	<!-- 打印界面 -->
	<jsp:include page="printDetail.jsp" />
	<input id="vOpenBankCode" type="hidden" value='<s:property value="openBankCode"/>'/>
	<input id="vOpenBankName" type="hidden" value='<s:property value="openBankName"/>'/>
	<input id="vCurr" type="hidden" value="<s:date name="openDate" format="yyyy-MM-dd"/>"/>
	<input id="vOrgCode" type="hidden" value="<s:property value="orgCode" />" />
	<input id="bankAddress" type="hidden" value='<s:property value="bankAddress"/>'/>
</body>
</html>
