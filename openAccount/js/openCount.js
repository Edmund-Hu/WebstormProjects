loading.show();
	//上一步、下一步
	var curr=1;
	var flag=true;
	var step = true;  //step 内容加载标识
	var recordDiv = true; //
	var windonpanel = true; //
	function nextStep(){
  		if(curr!=null){
  			if(!$('#divstep'+curr.toString()).form('validate')){
  				return;
  			}; 
  			if(curr==1){
  				/*var accMoneyType = "";
  				$('#accBzDiv input:checkbox:checked').each(function(){
  					accMoneyType += ($(this).val()+",");
  				});
  				if(accMoneyType==""){
  					alert("请至少选择一个账户币种。");
  					$("#accBzDiv #BZ0").focus();
  					return;
  				}*/
  				var vAccountType = $("#openBasicAcc #accountType").combobox("getValue");
  				if(vAccountType==1){
  					var checkNumber = $("#checkNumber").textbox("getValue");
  					var basicAreaCode = $("#basicAreaCode").textbox("getValue");
  					if(checkNumber==null||checkNumber==""||basicAreaCode==null||basicAreaCode==""){
  						alert("账户性质为一般账户时,基本存款账户开户许可证核准号和地区代码必填");
  						$("#checkNumber").focus();
  						return;
  					}
  				}
  				//异步加载step2和step3的HTML
  					if(flag&&step){
  					
  		  			//load step2 
  		  				$.get("step2.txt",function(data){
  		  					$("#divstep2").css("display","block");
  		  					$("#divstep2").append(data);
  		  					$.parser.parse($("#divstep2"));
  		  				
  		  				});
  		  				//load step3
  		  				$.get("step3.txt",function(data){
  		  						$("#divstep3").css("display","block");
  		  						$("#divstep3").append(data);
  		  						$.parser.parse($("#divstep3"));
  		  						("input",$(".auto-input").next("span")).click(function(){
  		  							$(".listdiv").remove();
  		  							$(this).after("<div class='listdiv' onmouseover='mouseoverFun()' onmouseout='mouseoutFun()'><ul></ul></div>");
  		  							var p = $(this).position();
  		  							$(".listdiv").attr("style","width:"+$(this).width()+"px;left:"+p.left+"px;top:"+(p.top+22)+"px");
  		  							getAllInput();
  		  						});
  		  						//$("div[id='divstep3']").hide();
  		  						$("div[id*='divstep']").hide();
  		  	  					$("div[id='divstep2']").show();
  		  	  					//控制账户类型  需要填写的存在差异
  	  		  	  				var vAccountType = $("#openBookDiv #accountType").combobox("getValue");
  	  							controlDivShow(vAccountType);
  		  				});
  		  			step=false;
  				}
  				
  			}
  			
  			if(curr==2){
  				//验证授权信息
  	  			//被授权人信息
  				var vsq =  gettrVal('shouquan_tb',6);
  				var authorizePeoples = vsq.split("||");
  				var countA = 0;
  				var countH = 0;
  				var countI = 0;
  				var countJ = 0;

  				for(var i = 0 ; i<authorizePeoples.length; i++){
  					var peopleInfos = authorizePeoples[i].split(",");
  					if(peopleInfos.length<6){
  						break;
  					}
  					if(peopleInfos[5].indexOf("A")>-1){
  						countA ++;
  					}
  					if(peopleInfos[5].indexOf("F")>-1&&peopleInfos[5].indexOf("G")>-1){
  						alert("授权人中F项和G项不能授权给同一个人");
  						return;
  					}
  					if(peopleInfos[5].indexOf("I")>-1&&peopleInfos[5].indexOf("J")>-1){
  						alert("授权人中I项和J项不能授权给同一个人");
  						return;
  					}
  					if(peopleInfos[5].indexOf("H")>-1){
  						countH ++;
  					}
  					if(peopleInfos[5].indexOf("I")>-1){
  						countI ++;
  					}
  					if(peopleInfos[5].indexOf("J")>-1){
  						countJ ++;
  					}
  				}
  				if(countH<2){
  					alert("授权人中H项至少授权给两个人");
  					return;
  				}
  				if(countI<1){
  					alert("授权人中I项至少授权给一个人");
  					return;
  				}
  				if(countJ<1){
  					alert("J项至少授权给一个人");
  					return;
  				}
  				if(countA<1){
  					alert("A项至少授权给一个人");
  					return;
  				}else if(windonpanel&&recordDiv){
  					$.get("recordDiv.txt",function(data){
  						$("#recordDiv").css("display","block");
  						$("#recordDiv").append(data);
  						$.parser.parse($("#recordDiv"));
  						$("#recordDiv #accountName").textbox('setValue',$("#openBookDiv #depositorName").textbox("getValue"));
  						$("input",$("#openBookDiv #depositorName").next("span")).blur(function(){
  							$("#recordDiv #accountName").textbox('setValue',$("#openBookDiv #depositorName").textbox("getValue"));
  						})
  						$("#recordDiv").css("display","none");
  						});
  					
  					$.get("window.txt",function(data){
  						$("#windowpannel").css("display","block");
  						$("#windowpannel").append(data);
  						$.parser.parse($("#windowpannel"));
  						("input",$(".auto-input").next("span")).click(function(){
  							$(".listdiv").remove();
  							$(this).after("<div class='listdiv' onmouseover='mouseoverFun()' onmouseout='mouseoutFun()'><ul></ul></div>");
  							var p = $(this).position();
  							$(".listdiv").attr("style","width:"+$(this).width()+"px;left:"+p.left+"px;top:"+(p.top+22)+"px");
  							getAllInput();
  						});
  						$("#PD1Div,#PD2Div,#PD3Div,#PD4Div").window("close");
  					});
  				  					
  					$(":checkbox[name='PD']").each(function(){
  						$(this).click(function(){
  							var data = $("#pageChose").combobox("getData");
  							if($(this).prop("checked")==true){
  								$("#"+$(this).val()+"Div").window("open");
  								if($(this).val()=="PD1"){
  									data.push({ "text": "中银单位结算卡开办申请表", "value": "12" });
  									$("#pageChose").combobox("loadData",data);
  								}else if($(this).val()=="PD2"){
  									data.push({ "text": "对公短信通产品开办须知", "value": "151" });
  									$("#pageChose").combobox("loadData",data);
  								}else if($(this).val()=="PD3"){
  									data.push({ "text": "青岛市分行自助卡申请表", "value": "13" });
  									$("#pageChose").combobox("loadData",data);
  								}
  							}else{
  								if($(this).val()=="PD1"){
  									removeOption(data,"12");
  									$("#pageChose").combobox("loadData",data);
  								}else if($(this).val()=="PD2"){
  									removeOption(data,"151");
  									$("#pageChose").combobox("loadData",data);
  								}else if($(this).val()=="PD3"){
  									removeOption(data,"13");
  									$("#pageChose").combobox("loadData",data);
  								}
  							}
  						})
  					})
  					
  					recordDiv=false;
  					windonpanel=false;
  					
  				}
  			}
			
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
  			if(curr==3){
  				var highSeasons = "";
        		$('#sywj input:checkbox:checked').each(function(){
        			highSeasons += ($(this).val()+",");
        		});
        		highSeasons=highSeasons.substring(0,highSeasons.length-1);
        		if(highSeasons==""){
        			alert("商业活动旺季至少选择一个季度");
        			$("#W1").focus();
  					return;
        		}
        	}
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
		$("#basicInfoCheckW").window('close');
		//controlBtnShow();
		loading.show();
		controlCardInfo();
		

		//存款人名称  和账户名 可能相同
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
		//控制账户类型  需要填写的存在差异
		$("#openBookDiv #accountType").combobox({
			onChange:function(){
				var vAccountType = $("#openBookDiv #accountType").combobox("getValue");
				controlDivShow(vAccountType);
			}
		})
		
		var vAccountType = $("#openBookDiv #accountType").combobox("getValue");
		controlDivShow(vAccountType);
		init();
		

		
		//产品开办窗口控制
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
		var sts = $("#handleStatus").textbox("getValue");
		if(sts!=""){
			$("#openBasicAcc").window('close');
		}
		$("div[id*='divstep']").hide();
		$("#preStep").hide();
		$("div[id='divstep1']").show();
		
		//证明文件选择控制
		$("#openBookDiv #fileType").combobox({
			onChange:function(newValue,oldValue){
				var vAccountType = $("#openBookDiv #accountType").combobox("getValue");
				if(vAccountType==0||vAccountType==1){
					if(newValue>31&&newValue<100){
						if(newValue==51||newValue==36){
							
						}else{
							alert("基本、一般账户暂时不支持当前证明文件种类");
							$("#openBookDiv #fileType").combobox("setValue",oldValue);
						}
					}
				}
			}
		});
		
		loading.hide();
	})
	
	/**处理证件信息   选择了三证合一   不用再填写证件信息*/
	function controlCardInfo(){
		$("#SZ").click(function(){
			if($(this).is(':checked')){
				var idNo = $("#divstep1 #fileNumber").textbox("getValue"); 
				var idEndDate = $("#divstep1 #fileEndDate").textbox("getValue");
				var fileType = $("#divstep1 #fileType").combobox("getValue");
				if(fileType==21||fileType==22||fileType==31){
					
				}else{
					alert("如果已完成三证合一,证明文件编号请选择营业执照");
					$(this).attr("checked",false);
					return;
				}
				if(idNo==""||idEndDate==""){
					alert("请先输入证明文件编号和到期日");
					$(this).attr("checked",false);
					return;
				}
				if(idNo.length!=18){
					alert("如果已完成三证合一,证明文件编号请输入统一信用代码");
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
				"<td><input class='easyui-textbox auto-input' alt='name' data-options='required:true' style='width:100%;height:24px' /></td>" +
				"<td><input class='easyui-textbox' alt='tel' data-options='required:true' style='width:100%;height:24px' /></td>" +
				"<td>"+
					"<select class='easyui-combobox' style='width:100%;' data-options='required:true,editable:false'>"+
						"<option value='1' >身份证</option>"+
						"<option value='2' >军官证</option>"+
						"<option value='3' >其他</option>"+
					"</select>"+
				"</td>" +
				"<td><input class='easyui-textbox' alt='card' data-options='required:true' style='width:100%;height:24px' /></td>" +
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
			"<td><input class='easyui-textbox auto-input' alt='name' data-options='required:true' style='width:100%;height:24px' /></td>" +
			'<td>'+
				"<input class='easyui-combobox' alt='idType' style='width:100%;height:24px' url='getTypeEnum.action?typeCode=ID_TYPE'"+ 
				"data-options="+'"'+"valueField:'typeValue',required:true,textField:'typeName',editable:false"+'" '+" >"+
			'</td>'+
			"<td><input class='easyui-textbox' alt='card' data-options='required:true' style='width:100%;height:24px' /></td>" +
			"<td><input class='easyui-datebox' alt='date' style='width:100%;height:24px' data-options='required:true,validType:\"date\"' /></td>" +
			"<td><input class='easyui-textbox' alt='tel' data-options='required:true' style='width:100%;height:24px' /></td>" +
			"<td>"+
				"<input class='easyui-combobox' data-options="+'"'+"separator:'.',multiple:'true',required:true,editable:false,valueField:'a',textField:'b',"+dataStr+'"'+"style='width:100%;height:24px' >"+
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
			"<td><input class='easyui-textbox auto-input' alt='name' data-options='required:true' style='width:100%;height:24px' /></td>" +
			'<td>'+
			"<input class='easyui-combobox' alt='idType'  style='width:100%;height:24px' url='getTypeEnum.action?typeCode=ID_TYPE'"+ 
			"data-options="+'"'+"valueField:'typeValue',textField:'typeName',editable:false,required:true"+'" '+" >"+
			'</td>'+
			"<td><input class='easyui-textbox' alt='card' data-options='required:true' style='width:100%;height:24px' /></td>" +
			"<td><input class='easyui-datebox' alt='date' style='width:100%;height:24px' data-options='required:true,validType:\"date\"' /></td>" +
			"<td><input class='easyui-textbox' data-options='required:true' style='width:100%;height:24px' /></td>" +
			"<td><a href=\'#\' onclick=\"deltr(\'"+table+"\'," + _len + ")\">删除</a></td>" +
			"</tr>");
		 //$.parser.parse();
		$.parser.parse("#"+table+" tr[id='"+ _len +"']");
		autoInit(table);
	}
	
	function reloadAddress(){
		var vRegistAddress = $("#openBookDiv #registAddress").textbox("getValue").split(',');
		if(vRegistAddress.length<2){
			$("#registAddressG").textbox("setValue","中国");
		}else{
			$("#registAddressG").textbox("setValue",vRegistAddress[0]);
			$("#registAddressS").textbox("setValue",vRegistAddress[1]);
			$("#registAddressQ").textbox("setValue",vRegistAddress[2]);
			$("#registAddressD").textbox("setValue",vRegistAddress[3]);
		}
		var vOfficeAddress = $("#openBookDiv #officeAddress").textbox("getValue").split(',');
		if(vOfficeAddress.length<2){
			$("#officeAddressG").textbox("setValue","中国");
		}else{
			$("#officeAddressG").textbox("setValue",vOfficeAddress[0]);
			$("#officeAddressS").textbox("setValue",vOfficeAddress[1]);
			$("#officeAddressQ").textbox("setValue",vOfficeAddress[2]);
			$("#officeAddressD").textbox("setValue",vOfficeAddress[3]);
		}
	}
	
	function init(){
		reloadAddress();
		
		//对公客户信息 股东
		var vClientPartner = $("#openBookDiv #partner").textbox("getValue").split('||');
		for(var i = 0; i<vClientPartner.length; i++){
			var partner = vClientPartner[i].split(',');
			if(partner.length>1){
				$("#guquan_tb").append("<tr id=" + i + " align='center' >" +
				"<td><input class='easyui-textbox auto-input' alt='name' data-options='required:true' style='width:100%;height:24px' value='"+partner[0]+"' /></td>" +
				'<td>'+
					"<input class='easyui-combobox' alt='idType' style='width:100%;height:24px' url='getTypeEnum.action?typeCode=PARTNER_ID_TYPE'"+ 
					"data-options="+'"'+"valueField:'typeValue',textField:'typeName',required:true,editable:false"+'" '+"value='"+partner[1]+"' >"+
				'</td>'+
				"<td><input class='easyui-textbox' alt='card' data-options='required:true' style='width:100%;height:24px'  value='"+partner[2]+"'/></td>" +
				"<td><input class='easyui-datebox' alt='date' style='width:100%;height:24px' value='"+partner[3]+"' data-options='required:true,validType:\"date\"' /></td>" +
				"<td><input class='easyui-textbox' data-options='required:true' style='width:100%;height:24px' value='"+partner[4]+"' /></td>" +
				"<td><a href=\'#\' onclick=\"deltr(\'guquan_tb\'," + i + ")\">删除</a></td>" +
				"</tr>");
				
				/* $("#guquan_tb tr[id='"+ i +"']").children().eq(1).children().combobox("select",partner[1]); */
				$("#guquan_tb tr[id='"+ i +"']").children().eq(1).children().find("option[value='"+partner[1]+"']").attr("selected",true);
			 	//$.parser.parse();
				$.parser.parse("#guquan_tb");
				autoInit("guquan_tb");
			}else{
				$("#guquan_tb").append("<tr id=" + i + " align='center' >" +
						"<td><input class='easyui-textbox auto-input' alt='name' data-options='required:true' style='width:100%;height:24px' /></td>" +
						'<td>'+
							"<input class='easyui-combobox' alt='idType' style='width:100%;height:24px' url='getTypeEnum.action?typeCode=PARTNER_ID_TYPE'"+ 
							"data-options="+'"'+"valueField:'typeValue',textField:'typeName',required:true,editable:false"+'" '+">"+
						'</td>'+
						"<td><input class='easyui-textbox' alt='card' data-options='required:true' style='width:100%;height:24px' /></td>" +
						"<td><input class='easyui-datebox' alt='date' style='width:100%;height:24px' data-options='required:true,validType:\"date\"' /></td>" +
						"<td><input class='easyui-textbox' data-options='required:true' style='width:100%;height:24px'  /></td>" +
						"</tr>");
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
				"<td><input class='easyui-textbox auto-input' alt='name'  data-options='required:true' style='width:100%;height:24px' value='"+beneficiary[0]+"' /></td>" +
				'<td>'+
					"<input class='easyui-combobox' alt='idType' style='width:100%;height:24px' url='getTypeEnum.action?typeCode=PARTNER_ID_TYPE'"+ 
					"data-options="+'"'+"valueField:'typeValue', textField:'typeName',editable:false,required:true"+'" '+"value='"+beneficiary[1]+"' >"+
				'</td>'+
				"<td><input class='easyui-textbox' alt='card'  data-options='required:true' style='width:100%;height:24px' value='"+beneficiary[2]+"'/></td>" +
				"<td><input class='easyui-datebox' alt='date' style='width:100%;height:24px' value='"+beneficiary[3]+"' data-options='required:true,validType:\"date\"' /></td>" +
				"<td><input class='easyui-textbox'  data-options='required:true' style='width:100%;height:24px' value='"+beneficiary[4]+"' /></td>" +
				"<td><a href=\'#\' onclick=\"deltr(\'quanyi_tb\'," + i + ")\">删除</a></td>" +
				"</tr>");
			 	//$.parser.parse();
			 	$("#quanyi_tb tr[id='"+ i +"']").children().eq(1).children().find("option[value='"+beneficiary[1]+"']").attr("selected",true);
				$.parser.parse("#quanyi_tb");
				autoInit("quanyi_tb");
			}else{
				$("#quanyi_tb").append("<tr id=" + i + " align='center' >" +
						"<td><input class='easyui-textbox auto-input' alt='name'  data-options='required:true' style='width:100%;height:24px'  /></td>" +
						'<td>'+
							"<input class='easyui-combobox' alt='idType' style='width:100%;height:24px' url='getTypeEnum.action?typeCode=PARTNER_ID_TYPE'"+ 
							"data-options="+'"'+"valueField:'typeValue', textField:'typeName',editable:false,required:true"+'" '+">"+
						'</td>'+
						"<td><input class='easyui-textbox' alt='card'  data-options='required:true' style='width:100%;height:24px' /></td>" +
						"<td><input class='easyui-datebox' alt='date' style='width:100%;height:24px' data-options='required:true,validType:\"date\"' /></td>" +
						"<td><input class='easyui-textbox'  data-options='required:true' style='width:100%;height:24px'  /></td>" +
						"</tr>");
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
				"<td><input class='easyui-textbox auto-input' alt='name'  data-options='required:true' style='width:100%;height:24px' value='"+partner[0]+"' /></td>" +
				'<td>'+
					"<input class='easyui-combobox' alt='idType' style='width:100%;height:24px' url='getTypeEnum.action?typeCode=PARTNER_ID_TYPE'"+ 
					"data-options="+'"'+"valueField:'typeValue', textField:'typeName',editable:false,required:true"+'" '+"value='"+partner[1]+"' >"+
				'</td>'+
				"<td><input class='easyui-textbox' alt='card'  data-options='required:true' style='width:100%;height:24px' value='"+partner[2]+"'/></td>" +
				"<td><input class='easyui-datebox' alt='date' style='width:100%;height:24px' value='"+partner[3]+"' data-options='required:true,validType:\"date\"' /></td>" +
				"<td><input class='easyui-textbox'  data-options='required:true' style='width:100%;height:24px' value='"+partner[4]+"' /></td>" +
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
				"<td><input class='easyui-textbox auto-input' alt='name' data-options='required:true' style='width:100%;height:24px' value='"+personInfo[0]+"' /></td>" +
				"<td><input class='easyui-textbox' alt='tel' data-options='required:true' style='width:100%;height:24px' value='"+personInfo[1]+"'/></td>" +
				"<td>"+
					"<select class='easyui-combobox' style='width:100%;' value='"+personInfo[2]+"' data-options='editable:false,required:true'>"+
						"<option value='1' >身份证</option>"+
						"<option value='2' >军官证</option>"+
						"<option value='3' >其他</option>"+
					"</select>"+
				"</td>" +
				"<td><input class='easyui-textbox' alt='card' data-options='required:true' style='width:100%;height:24px' value='"+personInfo[3]+"' /></td>" +
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
				"<td><input class='easyui-textbox auto-input' alt='name' data-options='required:true' style='width:100%;height:24px' value='"+people[0]+"' /></td>" +
				'<td>'+
				"<input class='easyui-combobox' alt='idType' style='width:100%;height:24px' url='getTypeEnum.action?typeCode=ID_TYPE'"+ 
				"data-options="+'"'+"valueField:'typeValue', textField:'typeName',editable:false,required:true"+'" '+"value='"+people[1]+"' >"+
				'</td>'+
				"<td><input class='easyui-textbox' alt='card' data-options='required:true' style='width:100%;height:24px' value='"+people[2]+"' /></td>" +
				"<td><input class='easyui-datebox' alt='date' style='width:100%;height:24px' value='"+people[3]+"' data-options='required:true,validType:\"date\"'/></td>" +
				"<td><input class='easyui-textbox' alt='tel' data-options='required:true' style='width:100%;height:24px' value='"+people[4]+"' /></td>" +
				"<td>"+
				"<input class='easyui-combobox' data-options="+'"'+"separator:'.',multiple:'true',required:true,editable:false,valueField:'a',textField:'b',"+dataStr+'"'+" value='"+people[5]+"' style='width:100%;height:24px' >"+
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
	
		$("#I").textbox("setValue",vContent[0]);//其他
		
		if(vContent.length>1){
			for(var i=1; i<vContent.length; i++){
				$("#"+vContent[i]).attr("checked", true);
			}
		}
		
		//账户币种
		var vAccMoneyType = $("#openBookDiv #vAccMoneyType").textbox("getValue");
		if(vAccMoneyType!=""&&vAccMoneyType!=null){
			var accMoneyType = vAccMoneyType.split(",");
			for(var i=0; i<accMoneyType.length; i++){
				$("#accBzDiv #BZ"+accMoneyType[i]).attr("checked", true);
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
			$("#openCommAcc").hide(); 
			$("#fileNumberDiv").show();
			$("#checkNumberDiv").hide();
			$("#checkNumber").textbox("setValue","");
			$("#coinTypeDiv").hide();
			$("#coinType").combobox("setValue","");
			$("#accountEndDateDiv").hide();
			$("#accountEndDate").datebox("setValue","");
			$("#applyMoneyDiv").show();
			$("#applyMoney").textbox("setValue","");
			$("#passMoney").textbox("setValue","");
		}
		if(accountType=="1"){//一般
			$("#shortDiv").hide();
			$("#dedicatedDiv").hide();
			$("#openCommAcc").show(); 
			$("#fileNumberDiv").hide();
			$("#checkNumberDiv").show();
			$("#coinTypeDiv").hide();
			$("#coinType").combobox("setValue","");
			$("#accountEndDateDiv").hide();
			$("#accountEndDate").datebox("setValue","");
			$("#applyMoneyDiv").hide();
			$("#applyMoney").textbox("setValue","");
			$("#passMoney").textbox("setValue","");
		}
		if(accountType=="2"||accountType=="3"||accountType=="4"){//专用
			$("#shortDiv").hide();
			$("#dedicatedDiv").show();
			$("#openCommAcc").hide(); 
			$("#fileNumberDiv").show();
			$("#checkNumberDiv").show();
			$("#coinTypeDiv").show();
			$("#accountEndDateDiv").hide();
			$("#accountEndDate").datebox("setValue","");
			if(accountType=="2"){
				$("#applyMoneyDiv").show();
			}else{
				$("#applyMoneyDiv").hide();
				$("#applyMoney").textbox("setValue","");
				$("#passMoney").textbox("setValue","");
			}
		}
		if(accountType=="5"||accountType=="6"){//临时
			$("#dedicatedDiv").hide();
			$("#shortDiv").show();
			$("#openCommAcc").hide(); 
			$("#fileNumberDiv").show();
			$("#checkNumberDiv").show();
			$("#coinTypeDiv").hide();
			$("#coinType").combobox("setValue","");
			$("#accountEndDateDiv").show();
			$("#applyMoneyDiv").show();
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
		}else if(name=="basicAreaCode"){
			if(value==""){
				alert("基本存款账户开户地地区代码不能为空!");
				return false;
			}
			if(!/^\d{6}$/.test(value)){
				alert("请录入正确的基本存款账户开户地地区代码!");
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
		}else if(name=="local"){
			if(value==""){
				alert("请选择开立账户地区类型。");
				return false;
			}
		}
		return true;
	}
	
	function getBasicInfo(){
		flag=false;
		//load step2 
		$.get("step2.txt",function(data){
			$("#divstep2").css("display","block");
			$("#divstep2").append(data);
			$.parser.parse($("#divstep2"));

		});
		//load step3
		$.get("step3.txt",function(data){
				$("#divstep3").css("display","block");
				$("#divstep3").append(data);
				$.parser.parse($("#divstep3"));
				("input",$(".auto-input").next("span")).click(function(){
					$(".listdiv").remove();
					$(this).after("<div class='listdiv' onmouseover='mouseoverFun()' onmouseout='mouseoutFun()'><ul></ul></div>");
					var p = $(this).position();
					$(".listdiv").attr("style","width:"+$(this).width()+"px;left:"+p.left+"px;top:"+(p.top+22)+"px");
					getAllInput();
				});
				
			});
		step=false;
		var dateArr=["openDate","fileEndDate"];
		var dataJson = {};
		var accountType = $("#openBasicAcc #accountType").textbox("getValue");
		
		if(trim(accountType)==""){
			alert("账户类型不能为空");
			return;
		}
		dataJson["accountType"] = accountType;
		
		//是一般户 ,从人行获取基本户信息
		if(accountType=="1"){
			var isQualified;
			$("#openCommAcc .business_ss-dm input[id]").each(function(){
				var name = $(this).attr('id');
				var value = $(this).textbox("getValue");
				dataJson[name] = value;
				isQualified=validatePre(name,value);
				if(isQualified==false){
					return false;
				}
			});
			if(isQualified==false){
				return false;
			}
			$("#openCommAcc .business_ss-dm select[id]").each(function(){
				var name = $(this).attr('id');
				var value = $(this).combobox("getValue");
				dataJson[name] = value;
				isQualified=validatePre(name,value);
				if(isQualified==false){
					return false;
				}
			});
			if(isQualified==false){
				return false;
			}
			loading.show();
			var ajax = new stAjax("getBasicInfo.action");
			ajax.setData(dataJson);
			ajax.setSuccessCallback(function(data) {
				loading.hide();
				if(data.success){
					//将获取的数据返显
					if (data.data){
						$("#openBookDiv .business_ss-dm input[id]").each(
							function() {
								var name = $(this).attr('id');
								if(name=="clientInfo.legalRepresentSurname"){
									if(data.data.linkMan!=null&&data.data.linkMan.length>0){
										$(this).textbox('setValue',data.data.linkMan.substring(0,1));
									}
								}else if(name=="clientInfo.legalRepresentName"){
									if(data.data.linkMan!=null&&data.data.linkMan.length>1){
										$(this).textbox('setValue',data.data.linkMan.substring(1,data.data.linkMan.length));
									}
								}else if(name=="depositorName"){
									if(data.data.accountName!=null&&data.data.accountName!=""){
										$(this).textbox('setValue',data.data.accountName);
									}
								}else if(name=="areaTax"){
									if(data.data.areaTax!=null&&data.data.areaTax!=""){
										$(this).textbox('setValue',data.data.areaTax.replace(/[\u4E00-\u9FA5]/g,''));
									}
								}else if(name=="countryTax"){
									if(data.data.countryTax!=null&&data.data.countryTax!=""){
										$(this).textbox('setValue',data.data.countryTax.replace(/[\u4E00-\u9FA5]/g,''));
									}
								}
								else if((data.data)[name]!=null&&(data.data)[name]!=""){
									var className = $(this).attr('class');
									if(className.indexOf("easyui-combobox")>-1){
										$(this).combobox('setValue',(data.data)[name]);
									}else{
										$(this).textbox('setValue',(data.data)[name]);
									}
								}
						});
						$("#openBookDiv .business_ss-dm select[id]").each(
							function(){
								var name = $(this).attr('id');
								$(this).combobox('setValue',(data.data)[name]);
						});
						$("#chargeDiv .business_ss-dm input[id]").each(
							function(){
								var name = $(this).attr('id');
								name=name.split(".")[1];
								if(data.data.bookCharge!=null&&(data.data.bookCharge)[name]!=null&&(data.data.bookCharge)[name]!=""){
									var className = $(this).attr('class');
									if(className.indexOf("easyui-combobox")>-1){
										$(this).combobox('setValue',(data.data.bookCharge)[name]);
									}else{
										$(this).textbox('setValue',(data.data.bookCharge)[name]);
									}
								}
						});
						$("#chargeDiv .business_ss-dm select[id]").each(
							function(){
								var name = $(this).attr('id');
								name=name.split(".")[1];
								$(this).combobox('setValue',(data.data.bookCharge)[name]);
						});
						//核对框入局填充
						$("#basicInfoCheckW td[tdName]").each(
							function(){
								var name = $(this).attr('tdName');
								names=name.split(".");
								if(names.length>1){
									if(data.data.bookCharge!=null&&(data.data.bookCharge)[names[1]]!=null){
										$(this).text((data.data.bookCharge)[names[1]]);
									}
								}else{
									if(data.data!=null&&(data.data)[name]!=null){
										if(name=="registAddress"){
											$(this).text((data.data)[name].replace(/[,]/g,""));
										}else{
											$(this).text((data.data)[name]);	
										}
									}
									
								}
						});
						if(data.data.nofundflag){
							$("#rstNofundflag").attr("checked", true)
						}
						$('#openBasicAcc').window('close');
						$("#basicInfoCheckW").window('open');
						//隐藏时添加表格时输入框没有宽度
						$("div[id*='divstep']").show();
						reloadAddress();
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
		}else{
			//从工商获取客户信息
			var fileNumber = $("#openBasicAcc #fileNumber").textbox("getValue");
			if(trim(fileNumber)==""){
				alert("营业执照号不能为空");
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
						$("#openBookDiv .business_ss-dm input[id]").each(
							function() {
								var name = $(this).attr('id');
								names=name.split(".");
								var className = $(this).attr('class');
								if ((data.data)[name]!=null) {
									if(className.indexOf("easyui-combobox")>-1){
										$(this).combobox('setValue',(data.data)[name]);
									}else{
										$(this).textbox('setValue',(data.data)[name]);
									}
								}
								if(names.length>1){
									if(className.indexOf("easyui-combobox")>-1){
										$(this).combobox('setValue',(data.data.clientInfo)[names[1]]);
									}else{
										$(this).textbox('setValue',(data.data.clientInfo)[names[1]]);
									}
								}
						});
						$("#openBookDiv .business_ss-dm select[id]").each(
							function(){
								var name = $(this).attr('id');
								$(this).combobox('setValue',(data.data)[name]);
								if(name=="clientInfo.publicCompany"){
									if((data.data.clientInfo)["publicCompany"]!=null){
										$(this).combobox('setValue',""+(data.data.clientInfo)["publicCompany"]);
									}
								}
						});
						$('#openBasicAcc').window('close');
						//隐藏时添加表格时输入框没有宽度
						$("div[id*='divstep']").show();
						reloadAddress();
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
	
	function putCheck(sts,direct){
		if(!$('#divstep'+curr.toString()).form('validate')){
			return;
		};
		$.messager.confirm('提示:', '你确认要提交吗?', function(event) {
			if(event){
				saveBook(sts,direct);
			}
		});
	}
	
	function saveBook(sts,direct) {
		
		
		if(!$('#divstep'+curr.toString()).form('validate')){
			return;
		}; 
		
		var dataJson = {};

		
		//账户币种选择
		/*var accMoneyType = "";
		$('#accBzDiv input:checkbox:checked').each(function(){
			accMoneyType += ($(this).val()+",");
		});
		if(accMoneyType==""){
			alert("请至少选择一个账户币种。");
			$("#accBzDiv #BZ0").focus();
			return;
		}
		accMoneyType=accMoneyType.substring(0,accMoneyType.length-1);
		dataJson["accMoneyType"]=accMoneyType;*/
		
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
		if(curr==3&&highSeasons==""){
			alert("商业活动旺季至少选择一个季度");
			$("#W1").focus();
			return;
		}
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

		var other = $("#I").val()!=null?$("#I").val().trim().replace(",","，"):"";//其他
		var content = /* tel+","+cardNo+","+ */other; 
		$('#authorizeDiv input:checkbox:checked').each(function(){
			content += (","+$(this).val());
		});
		//alert(content);
        dataJson["authorize.authorizeContent"] = content;
       	
      	//开办产品选择项
		var choseProducts = "";
		dataJson["productInfo.openNoteInfo"] ="";
		$('#products input:checkbox').each(function(){//由于上传为null的不会更新数据库，将不上传的产品信息设置为空字符串
			$("#"+$(this).val()+"Div .business_ss-dm input[id]").each(function(){
				var name = $(this).attr('id');
				dataJson[name] = "";
			});
		});
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
					//代扣缴税款    国家征收机关处理
					if(name == "secondMobileCode" && value!=null && value!="" ){
						//  国家征收机关名称
						dataJson["firstMobileCode"] = $(this).textbox("getText");
						//  国家征收机关代码
						dataJson["secondMobileCode"] = value;
					}else if(name == "secondTelCode" && value!=null && value!="" ){
						//  地方征收机关名称
						dataJson["secondMoneyMan"] = $(this).textbox("getText");
						//  地方征收机关代码
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
		dataJson["handleStatus"] = sts;

		//处理开户申请书中未填写的法人  和对公客户信息相同
		dataJson["linkMan"] = dataJson["clientInfo.legalRepresentSurname"]+dataJson["clientInfo.legalRepresentName"];
		dataJson["linkIdEndDate"] = dataJson["clientInfo.endDateLegal"];
		dataJson["clientInfo.idTypeLegal"] = dataJson["idType"];
		dataJson["clientInfo.idNoLegal"] = dataJson["idNumber"];
		
		//处理财务负责人姓名
		dataJson["firstMoneyMan"] = dataJson["clientInfo.moneyManSurname"]+dataJson["clientInfo.moneyManName"];
		//处理联系人姓名 
		dataJson["stockHolder"] = dataJson["clientInfo.contactManSurname"]+dataJson["clientInfo.contactManName"];
		
		dataJson["clientInfo.createDate"] = dataJson["registDate"];
		//行业分类  行业代码相同
		dataJson["busiType"] = dataJson["accountCategory"];
		//存款人类别/客户子类型
		dataJson["peopleSonType"] = dataJson["peopleType"];
		
		//存款人英文名称
		dataJson["accountEnName"] = dataJson["accountEnName"].toUpperCase();
		
		loading.show();
		var ajax = new stAjax("saveBasicOpenBook.action");
		ajax.setData(dataJson);
		ajax.setSuccessCallback(function(data) {
			loading.hide();
			if (data.success) {
				if(direct){
					window.location.href="accountShow.action?hstatus=0";
				}
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
				
				//controlBtnShow();
				//alert(data.msg ? data.msg : "操作成功！");
				alert("操作成功！");
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
		if(name=="accountName"){
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
				alert("请先保存后，再打印。");
				return;
			}else{
				dataJson["activeId"]=activeId;
			}
			
			var ajax = new stAjax("printOpenBook.action");
			ajax.setData(dataJson);
			ajax.setSuccessCallback(function(data) {
				if(data.success){			
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
	
	function setOfficeAddress(){
		$("#officeAddressG").textbox("setValue",$("#registAddressG").textbox("getValue"));
		$("#officeAddressS").textbox("setValue",$("#registAddressS").textbox("getValue"));
		$("#officeAddressQ").textbox("setValue",$("#registAddressQ").textbox("getValue"));
		$("#officeAddressD").textbox("setValue",$("#registAddressD").textbox("getValue"));
		$("#postCodeNews").textbox("setValue",$("#postCode").textbox("getValue"));
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
	