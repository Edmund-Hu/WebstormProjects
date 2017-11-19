<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="santai" uri="/tags/santai"%>
<%@ taglib prefix="santai_ams" uri="/tags/santai_ams"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>组织机构信用代码系统备案</title>
		<link rel="stylesheet" type="text/css" href="js/jquery/jquery-easyui/easyui.css" />
		<link rel="stylesheet" type="text/css" href="js/jquery/jquery-easyui/icon.css" />
		<link rel="stylesheet" type="text/css" href="css/main.css" />
		<script type="text/javascript" src="js/jquery/jquery.js"></script>
		<script type="text/javascript" src="js/jquery/jquery-easyui/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="js/jquery/jquery-easyui/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="js/santai.core.js"></script>
		<script type="text/javascript" src="js/common/common.js"></script>
		<script type="text/javascript" src="js/common/validate.js"></script>

		<script language="javascript" type="text/javascript">
		
			$(function(){
				$("div[name='needHidden']").hide();
				$(".role_window_button a[name='saveBtn']").hide();
				//初始化是载入一些下拉框数据
				getAddress("country","country");
				getAddress("provCode","provice");
				getAddress("provCodeW","provice");
			})
		
			function getInfo(){
				var dataJson = {};
				dataJson["checkNumber"]=$("#checkNumber").val();
				var ajax = new stAjax("getInfo.action");
				ajax.setData(dataJson);
				ajax.setSuccessCallback(function(data) {
					if (data.success) {
						$("#eccsDiv .business_ss-dm input[id]").each(
							function() {
								var name = $(this).attr('id');
								if ((data.data)[name]!=null) {
									$(this).val((data.data)[name]);
								}
						});
						
						return false;
					}
					alert(data.msg ? data.msg : "操作失败！");
					return false;
				});
				ajax.setErrorCallback(function() {
					loading.hide();
					alert("服务器处理出现异常！");
				});
				ajax.invoke();
			}
			
			//obj：html中对象和正式提交时的参数名  code:下拉框请求时url所需的参数名
			function getAddress(obj,code){
				$("#"+obj).empty();
				var dataJson = {};
				dataJson["op"]=code;
				if(code=="country"){
					
				}else if(code=="provice"){
					
				}else if(code=="city"){
					if(obj=="cityCode"){
						dataJson["provCode"]=$("#eccsDiv #provCode").val();
						dataJson["cityCode"]=$("#eccsDiv #cityCode").val();
					}else if(obj=="cityCodeW"){
						dataJson["provCode"]=$("#eccsDiv #provCodeW").val();
						dataJson["cityCode"]=$("#eccsDiv #cityCodeW").val();
					}
				}else if(code=="county"){
					if(obj=="countryCode"){
						dataJson["cityCode"]=$("#eccsDiv #cityCode").val();
						dataJson["county"]=$("#eccsDiv #countryCode").val();
					}else if(obj=="countryCodeW"){
						dataJson["cityCode"]=$("#eccsDiv #cityCodeW").val();
						dataJson["county"]=$("#eccsDiv #countryCodeW").val();
					}
				}else if(code=="orgkindsub"){
					dataJson["orgkindsub"]=$("#eccsDiv #orgKindSub").val();
					dataJson["orgkind"]=$("#eccsDiv #orgKind").val();
				}
				var ajax = new stAjax("getAddress.action");
				ajax.setData(dataJson);
				ajax.setSuccessCallback(function(data) {
					if (data.success) {
						$("#eccsDiv #"+obj).append(data.data);
						return false;
					}
					alert(data.msg ? data.msg : "操作失败！");
					return false;
				});
				ajax.setErrorCallback(function() {
					loading.hide();
					alert("服务器处理出现异常！");
				});
				ajax.invoke();
			}
			
			function save(){
				var dateArr=["buildDate","maturityDate"];
				var dataJson = {};
				var flag;
				$("#eccsDiv .business_ss-dm input[id],#eccsDiv .business_ss-dm select[id]").each(
					function() {
						var name = $(this).attr("id");
						if($.inArray(name, dateArr)>=0){
							dataJson[name]=$(this).datebox("getValue");
						}else{
							var value = $(this).val();
							flag = validate(name,value);
							if(!flag){
								return false;
							}
							dataJson[name]=$(this).val();
						}
				});
				if(!flag){
					return false;
				}
				var ajax = new stAjax("recordEccs.action");
				ajax.setData(dataJson);
				ajax.setSuccessCallback(function(data) {
					if (data.success) {
						alert(data.msg);
						$(".role_window_button a[name='saveBtn']").hide();
						return false;
					}
					alert(data.msg ? data.msg : "操作失败！");
					return false;
				});
				ajax.setErrorCallback(function() {
					loading.hide();
					alert("服务器处理出现异常！");
				});
				ajax.invoke();
			}
			
			function preVerify(){
				var dataJson = {};
				var flag;
				$("#preDiv .business_ss-dm input[id]").each(
					function() {
						var name = $(this).attr("id");
						var value = $(this).val();
						dataJson[name]=value;
						flag = validatePre(name,value);
						if(!flag){
							return false;
						}
				});
				if(!flag){
					return false;
				}
				$("#preDiv .business_ss-dm select[id]").each(
					function() {
						var name = $(this).attr("id");
						value = $(this).val();
						dataJson[name]=value;
						flag = validatePre(name,value);
						if(!flag){
							return false;
						}
				});
				if(!flag){
					return false;
				}
				
				var ajax = new stAjax("preVerify.action");
				ajax.setData(dataJson);
				ajax.setSuccessCallback(function(data) {
					if (data.success) {
						dealPreVerifyRst(data.data);
						return false;
					}
					alert(data.msg ? data.msg : "操作失败！");
					return false;
				});
				ajax.setErrorCallback(function() {
					loading.hide();
					alert("服务器处理出现异常！");
				});
				ajax.invoke();
			}
			
			function dealPreVerifyRst(result){
			   var isOut = result.indexOf("您没有登录或访问时间超时，请重新登录");
		       var status = result.substr(0,result.indexOf('|',0));
		       var crcCode =  result.substr(result.indexOf('|',0)+1,result.indexOf('&',0)-1); 
		       var has = result.substr(result.indexOf('&')+1,result.length);
		       var path="";
		       if(status=="0"){
			        $("#crccode").val(crcCode);
		    	   	path = "/eccs/entering.do?op=enterData";
		    	   	redirect("",path);
			   }else if(isOut>-1){
				   	alert("访问时间超时，请重新登录！");		
			   }else if(status=="no"){
			   		alert("该中征码在企业征信系统中不存在，请核实后重新录入！");
			   }else if(status=="1"){
	    	   		var hasCrcCode = has.split("&")[0];
					var dispatchtimes = has.split("&")[1];
					var type = has.split("&")[4];
					var title="";
	    	   		if(dispatchtimes>0){
	    	   			alert("该机构在系统中已生成机构信用代码。\r\n目前该功能尚未实现，请在人行【组织机构代码系统】更新");
	    	   			return;
	    	   			title = "该机构在系统中已生成机构信用代码，是否确认进行代码信息更新？";
	    	   			path = "/eccs/manage.do?op=CreditCodeModifyDeteal&crcCode=" + hasCrcCode;	//已发码维护
	    	   			redirect(title,path);
					}else{
						alert("该机构的信息代码申请资料在系统中已存在。\r\n目前该功能尚未实现，请在人行【组织机构代码系统】更新");
	    	   			return;
						title = "该机构的信息代码申请资料在系统中已存在，是否确认进行信息更新？";
						path = "/eccs/manage.do?op=noCodeModifyDeteal&crcCode=" + hasCrcCode;	//未发码维护
						redirect(title,path);
					}
			   }else if(status!=""){
			   		alert(status);
			   }else{
					alert("新增代码失败！");
			   }
			}
			
			function redirect(title,path){
				loading.show();
				var dataJson = {};
				$("#preDiv .business_ss-dm input[id]").each(
					function() {
						var name = $(this).attr("id");
						var value = $(this).val();
						dataJson[name]=value;
				});
				$("#preDiv .business_ss-dm select[id]").each(
					function() {
						var name = $(this).attr("id");
						value = $(this).val();
						dataJson[name]=value;
				});
				dataJson["path"]=path;
				
				var ajax = new stAjax("manage.action");
				ajax.setData(dataJson);
				ajax.setSuccessCallback(function(data) {
					loading.hide();
					if (data.success) {
						//其他部分显示
						$("div[name='needHidden']").show();
						$(".role_window_button a[name='saveBtn']").show();
						if(typeof(data.dataMap) != 'undefined'){
							$("#crccode").val(data.dataMap.crccode);
							$("#datafrom").val(data.dataMap.datafrom);
						}else if(typeof(data.data)!= 'undefined'){
							//显示所有数据
							$("#eccsDiv .business_ss-dm input[id],#eccsDiv .business_ss-dm select[id]").each(
								function(){
									var name = $(this).attr('id');
									if ((data.data)[name]!=null) {
										$(this).val((data.data)[name]);
									}
							});
						}
						//机构标识信息不可用
						$("#preDiv .business_ss-dm input[id],#eccsDiv .business_ss-dm select[id]").each(
							function() {
								$(this).attr("readonly",true);
						});
						return false;
					}

					alert(data.msg ? data.msg : "操作失败！");
					return false;
				});
				ajax.setErrorCallback(function() {
					loading.hide();
					alert("服务器处理出现异常，获取机构代码信息失败！");
				});
				ajax.invoke();
			}
			
			function validatePre(name,value){
				var flag=true;
				if(name=="checkNumber"){
					flag = valiNull("开户许可证核准号",value);
					if(flag){
						flag = valiCheckNumber(value);
					}
					return flag;
				}else if(name=="registertype"){
					return valiNull("登记注册号类型",value);
				}else if(name=="registercode"){
					flag = valiNull("登记注册号码",value);
					if(flag){
						flag = valiTax("登记注册号码",value);
					}
					return flag;
				}else if(name=="countryTax" || name=="areaTax"){
					flag = valiNull("税号",value);
					if(flag){
						flag = valiTax("税号",value);
					}
					return flag;
				}
				return flag;
			}
			
			function validate(name,value){
				var flag=true;
				if(name=="departKind"){
					return valiNull("登记部门",value);
				}else if(name=="countryCode" || name=="registAddress"){
					return valiNull("注册（登记）地址",value);
				}else if(name=="orgKindSub"){
					return valiNull("组织机构类别",value);
				}else if(name=="manager0Name"){
					return valiNull("法定代表人名",value);
				}else if(name=="manager0IdType"){
					return valiNull("法定代表人证件类型",value);
				}else if(name=="manager0IdNumber"){
					return valiNull("法定代表人证件证件号码",value);
				}else if(name=="busiScope" && value.length>=200){
					alert("“经营（业务）范围”的长度不能大于200个汉字");
					return false;
				}
				return flag;
			}
		</script>

	</head>

	<body>
		<div class="easyui-panel" iconCls="ico_280" style="width: 100%;" id="eccsDiv" data-options="fit:true">
			<div class="role_window" style="height:1235px">
				<div class="role_window_border" id="preDiv" style="height:240px">
					<div class="role_window_title14">机构标识信息</div>
					<div class="business_ss-dm">
						<input type="hidden" name="crccode" id="crccode" value=''/>
						<input type="hidden" name="datafrom" id="datafrom" value=''/>
						<div class="business_title2">开户许可证核准号：</div>
						<div class="business_input9">
							<input id="checkNumber" class="easyui-validatebox" style="width:100%;" data-options="required:true"/>
						</div>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'ico_091'"
							onclick="getInfo()" style="margin-left:30px;width:15%; ;">
							<span style="font-size:14px;">提取基础信息</span>
						</a>
					</div>
					<div class="business_ss-dm">
						<div class="business_ss-dm">
							<div class="business_title2">组织机构代码：</div>
							<div class="business_input9">
								<input id="orgInstitId" class="easyui-validatebox" style="width:100%;"/>
							</div>
							<div class="business_title2">中征码：</div>
							<div class="business_input9">
								<input id="loancardcode" class="easyui-validatebox" style="width:100%;"/>
							</div>
						</div>
					</div>
					
					<div class="business_ss-dm">
						<div class="business_title2">登记注册号类型：</div>
						<div class="business_input9">
							<select id="registertype" style="width:100%;" >
								<option value=''>--请选择--</option>
								<option value="01">工商注册号</option>
								<option value="07">统一社会信用代码</option>
								<option value="02">机关和事业单位登记号</option>
								<option value="03">社会团体登记号</option>
								<option value="04">民办非企业单位登记号</option>
								<option value="05">基金会登记号</option>
								<option value="06">宗教活动场所登记号</option>
								<option value="08">商事与非商事登记证号</option>
								<option value="99">其他</option>
							</select>
						</div>
						<div class="business_title2">登记注册号码：</div>
						<div class="business_input9">
							<input id="registercode" class="easyui-validatebox" style="width:100%;" data-options="required:true"/>
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">纳税号（国税）：</div>
						<div class="business_input9">
							<input id="countryTax" class="easyui-validatebox" style="width:100%;"/>
						</div>
						<div class="business_title2">纳税号（地税）：</div>
						<div class="business_input9">
							<input id="areaTax" class="easyui-validatebox" style="width:100%;"/>
						</div>
					</div>
					<div class="business_ss-dm" style="text-align:center;margin-top:10px;">
						<a href="javascript:void(0)" name="preVerifyBtn" class="easyui-linkbutton" data-options="iconCls:'ico_hdmx'"
							style="padding:3px 0px;width:20%;" onclick="preVerify()">
							<span style="font-size:14px;">提交</span>
						</a>
					</div>
				</div>
				<div class="role_window_border" name="needHidden" style="height:350px">
					<div class="role_window_title14">基本属性信息</div>
					<div class="business_ss-dm">
						<div class="business_title2">机构中文名称：</div>
						<div class="business_input9">
							<input id="accountName" class="easyui-validatebox" style="width:100%;" data-options="required:true"/>
						</div>
						<div class="business_title2">机构英文名称：</div>
						<div class="business_input9">
							<input id="accountEnName" class="easyui-validatebox" style="width:100%;"/>
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">注册（登记）地址：</div>
						<div class="business_input10">
							<select id="country"  style="width:15%;" >
								
							</select>
							<select id="provCode" style="width:15%;" onchange="getAddress('cityCode','city')">
								
							</select>
							<select id="cityCode" style="width:15%;"  onchange="getAddress('countryCode','county')">
								
							</select>
							<select id="countryCode" style="width:15%;">
								
							</select>
							<input id="registAddress" class="easyui-validatebox" style="width:20%;" data-options="required:true"/>
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">登记部门：</div>
						<div class="business_input9">
							<select id="departKind" style="width:100%;" >
								<option value=''>--请选择--</option>
								<option value="G">工商部门</option>        
								<option value="B">机构编制部门</option>            
								<option value="M">民政部门</option>            
								<option value="S">司法行政部门</option>            
								<option value="Z">宗教部门</option>            
								<option value="W">外交部门</option>             
								<option value="P">人民银行</option>            
								<option value="Q">其他</option>
							</select>
						</div>
						<div class="business_title2">成立日期：</div>
						<div class="business_input9">
							<input id="buildDate" class="easyui-datebox" style="width:100%;" />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">证书到期日：</div>
						<div class="business_input9">
							<input id="maturityDate" class="easyui-datebox" style="width:100%;" />
						</div>
					</div>
					<div class="business_ss-dm" style="height: 60px;">
						<div class="business_title2">经营（业务）范围：</div>
						<div class="business_input10">
							<input id="busiScope" type="textarea" style="width:100%;height:50px" />
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">注册资本币种：</div>
						<div class="business_input9">
							<select id="registMoneyType" style="width:100%;">
								<option value=''>--请选择--</option><option value='CNY'>人民币</option><option value='SDR'>特别提款权</option><option value='AUD'>澳大利亚元</option><option value='CAD'>加拿大元</option><option value='ASF'>记帐瑞士法郎</option><option value='EUR'>欧元</option><option value='JPY'>日元</option><option value='MOP'>澳门币</option><option value='GBP'>英镑</option><option value='CHF'>瑞士法郎</option><option value='HKD'>港币</option><option value='THB'>泰币</option><option value='USD'>美元</option><option value='SGD'>新加坡元</option><option value='KRW'>韩元</option><option value='RUB'>俄国卢布</option><option value='TWD'>台湾元</option><option value='CFC'>记帐法国法郎</option><option value='CSF'>记帐瑞士法郎</option><option value='CUS'>记帐美元</option><option value='CUR'>清算卢布</option><option value='CPS'>记帐英镑</option><option value='UDM'>蒙古美元</option><option value='AED'>阿联酋迪拉姆</option><option value='ALL'>阿尔尼亚列克</option><option value='DZD'>阿尔及利亚第纳</option><option value='ATS'>奥地利先令</option><option value='BDT'>孟加拉国塔卡</option><option value='BEF'>比利时法郎</option><option value='BHD'>巴林第纳尔</option><option value='BIF'>布隆迪法郎</option><option value='BGL'>保加利亚列瓦</option><option value='BUK'>缅甸币</option><option value='BWP'>博茨瓦纳普拉</option><option value='CYP'>塞浦路斯镑</option><option value='CSK'>捷克克朗</option><option value='KPW'>朝鲜币</option><option value='DKK'>丹麦克朗</option><option value='DEM'>德国马克</option><option value='NLG'>荷兰盾</option><option value='EGP'>埃及镑</option><option value='ETB'>埃塞俄比亚比尔</option><option value='XEU'>欧洲货币单位</option><option value='FIM'>芬兰马克</option><option value='FRF'>法国法郎</option><option value='GHC'>加纳塞地</option><option value='XAU'>黄金</option><option value='GRD'>希腊德拉马克</option><option value='GNS'>几内亚西里</option><option value='HUF'>匈牙利福林</option><option value='IDR'>印度尼西亚卢比</option><option value='INR'>印度罗比</option><option value='IRR'>伊朗里亚尔</option><option value='IQD'>伊拉克地纳尔</option><option value='ITL'>意大利里拉</option><option value='JOD'>约旦第纳尔</option><option value='KES'>肯尼亚先令</option><option value='KWD'>科威特第纳尔</option><option value='LYD'>利比亚第纳尔</option><option value='MYR'>马币</option><option value='MLF'>马里法郎</option><option value='MGF'>马达加斯加法郎</option><option value='MNT'>蒙古图格里克</option><option value='MAD'>摩洛哥地拉姆</option><option value='MUR'>毛里求斯卢比</option><option value='NPR'>尼泊尔卢比</option><option value='NZD'>新西兰元</option><option value='NGN'>尼日利亚奈拉</option><option value='NOK'>挪威克朗</option><option value='PKR'>巴基斯坦卢比</option><option value='PGK'>巴布亚新基那</option><option value='PHP'>菲律宾比索</option><option value='PLZ'>波兰兹罗提</option><option value='ROL'>罗马尼亚列依</option><option value='RWF'>卢旺达法郎</option><option value='SCR'>塞舌尔卢比</option><option value='SDP'>苏丹镑</option><option value='SLL'>塞拉利昂</option><option value='XAG'>白银</option><option value='ESP'>西班牙比塞塔</option><option value='XDR'>特别提款权</option><option value='LKR'>斯里兰卡卢比</option><option value='SEK'>瑞典克朗</option><option value='SYP'>叙利亚镑</option><option value='TZS'>坦桑尼亚先令</option><option value='TND'>突尼斯第纳尔</option><option value='TRL'>土耳其里拉</option><option value='SUR'>苏联卢布</option><option value='VND'>越南盾</option><option value='XOF'>西非共同体法郎</option><option value='YER'>也门里亚尔</option><option value='ZMK'>赞比亚克瓦查</option><option value='MXN'>墨西哥比索</option><option value='BRL'>巴西里亚尔</option><option value='LUF'>卢森堡法郎</option>
							</select>
						</div>
						<div class="business_title2">注册资本(万元)：</div>
						<div class="business_input9">
							<input id="registMoney" class="easyui-validatebox" style="width:100%;" data-options="required:true"/>
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">组织机构类别：</div>
						<div class="business_input9">
							<select id="orgKind" style="width:100%;" onchange="getAddress('orgKindSub','orgkindsub')" >
								<option value=''>--请选择--</option>
								<option value="1">企业</option>           
								<option value="2">事业单位</option>           
								<option value="3">机关</option>             
								<option value="4">社会团体</option>            
								<option value="7">个体工商户</option>            
								<option value="9">其他</option>
							</select>
						</div>
						<div class="business_input9">
							<select id="orgKindSub" style="width:100%;" >
								
							</select>
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">经济行业分类：</div>
						<div class="business_input9">
							<input id="vocationCode" class="easyui-validatebox" style="width:100%;"/>
						</div>
						<div class="business_title2">经济类型：</div>
						<div class="business_input9">
							<select id="economyType" style="width:100%;" >
								<option value="">--请选择--</option>
								<option value="10">内资</option>            
								<option value="11">国有全资</option>            
								<option value="12">集体全资</option>           
								<option value="13">股份合作</option>           
								<option value="14">联营</option>           
								<option value="15">有限责任公司</option>            
								<option value="16">股份有限公司</option>           
								<option value="17">私有</option>           
								<option value="19">其它内资</option>
								<option value="20">港澳台投资</option>
								<option value="21">内地和港澳台投资</option>
								<option value="22">内地和港澳台合作</option>
								<option value="23">港澳台独资</option>
								<option value="24">港澳台投资股份有限公司</option>
								<option value="29">其他港澳台投资</option>
								<option value="30">国外投资</option>
								<option value="31">中外合资</option>
								<option value="32">中外合作</option>
								<option value="33">外资</option>
								<option value="34">国外投资股份有限公司</option>
								<option value="39">其他国外投资</option>
								<option value="90">其他</option>
							</select>
						</div>
					</div>
				</div>
				<div class="role_window" name="needHidden" style="height:80px">
					<div class="role_window_title14">法定代表人信息</div>
					<div class="business_ss-dm">
						<div class="business_title2">名称：</div>
						<div class="business_input8">
							<input id="manager0Name" class="easyui-validatebox" style="width:100%;" data-options="required:true"/>
						</div>
						<div class="business_input8" style="display:none">
							<input id="manager0Type" class="easyui-validatebox" style="width:100%;" value="5"/>
						</div>
						<div class="business_title2">证件类型：</div>
						<div class="business_input8">
							<select id="manager0IdType" style="width:100%;" >
								<option value="" ></option>
								<option value="0" >身份证</option>
								<option value="1" >户口簿</option>
								<option value="2" >护照</option>
								<option value="3" >军官证</option>
								<option value="4" >士兵证</option>
								<option value="5" >港澳居民来往内地通行证</option>
								<option value="6" >台湾同胞来往内地通行证</option>
								<option value="7" >临时身份证</option>
								<option value="8" >外国人居留证</option>
								<option value="9" >警官证</option>
								<option value="A" >香港身份证</option>
								<option value="B" >澳门身份证</option>
								<option value="C" >台湾身份证</option>
								<option value="X" >其他证件</option>
							</select>
						</div>
						<div class="business_title2">证件号码：</div>
						<div class="business_input8">
							<input id="manager0IdNumber" class="easyui-validatebox" style="width:100%;" data-options="required:true"/>
						</div>
					</div>
				</div>
				<div class="role_window" name="needHidden" style="height:80px">
					<div class="role_window_title14">机构状态信息</div>
					<div class="business_ss-dm">
						<div class="business_title2">机构状态：</div>
						<div class="business_input8">
							<select id="orgState" style="width:100%;" >
								<option value="1"  selected>正常</option>
								<option value="2">注销</option>
								<option value="9">其他</option>
								<option value="X">未知</option>
							</select>
						</div>
						<div class="business_title2">基本户状态：</div>
						<div class="business_input8">
							<select id="state" style="width:100%;"  >
								<option value="1"  selected >正常</option>
								<option value="2">久悬</option>
								<option value="3">注销</option>
								<option value="9">其他</option>
								<option value="4">待审核</option>
								<option value="X">未知</option>
							</select>
						</div>
						<div class="business_title2">企业规模：</div>
						<div class="business_input8">
							<select id="vocationamount" style="width:100%;" >
								<option value="">--请选择--</option>
								<option value="2">大型企业</option>
								<option value="3">中型企业</option>
								<option value="4">小型企业</option>
								<option value="5">微型企业</option>
								<option value="9">其他</option>
								<option value="X">未知</option>
							</select>
						</div>
					</div>
				</div>
				<div class="role_window" name="needHidden" style="height:130px">
					<div class="role_window_title14">联络信息</div>
					<div class="business_ss-dm">
						<div class="business_title2">办公（生产、经营）地址：</div>
						<div class="business_input10">
							<select id="provCodeW" style="width:15%;"  onchange="getAddress('cityCodeW','city')">
								
							</select>
							<select id="cityCodeW" style="width:15%;"  onchange="getAddress('countryCodeW','county')">
								
							</select>
							<select id="countryCodeW" style="width:15%;">
								
							</select>
							<input id="officeAddress" class="easyui-validatebox" style="width:20%;"/>
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">联系电话：</div>
						<div class="business_input9">
							<input id="workTel" class="easyui-validatebox" style="width:100%;" />
						</div>
						<div class="business_title2">财务部联系电话：</div>
						<div class="business_input9">
							<input id="financeTel" class="easyui-validatebox" style="width:100%;" />
						</div>
					</div>
				</div>
				<div class="role_window" name="needHidden" style="height:190px">
					<div class="role_window_title14">高管及主要关系人信息</div>
					<div class="business_ss-dm">
						<div class="business_title2">董事长：</div>
						<div class="business_input12">
							<input id="manager1Name" class="easyui-validatebox" style="width:100%;"/>
						</div>
						<div class="business_input8" style="display:none">
							<input id="manager1Type" value="1" class="easyui-validatebox" style="width:100%;"/>
						</div>
						<div class="business_title2">证件类型：</div>
						<div class="business_input12">
							<select id="manager1IdType" style="width:100%;" >
								<option value="" ></option>
								<option value="0" >身份证</option>
					             <option value="1" >户口簿</option>
					             <option value="2" >护照</option>
					             <option value="3" >军官证</option>
					             <option value="4" >士兵证</option>
					             <option value="5" >港澳居民来往内地通行证</option>
					             <option value="6" >台湾同胞来往内地通行证</option>
					             <option value="7" >临时身份证</option>
					             <option value="8" >外国人居留证</option>
					             <option value="9" >警官证</option>
					             <option value="A" >香港身份证</option>
					             <option value="B" >澳门身份证</option>
					             <option value="C" >台湾身份证</option>
					             <option value="X" >其他证件</option>
							</select>
						</div>
						<div class="business_title2">证件号码：</div>
						<div class="business_input12">
							<input id="manager1Name" class="easyui-validatebox" style="width:100%;"/>
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">总经理/主要负责人：</div>
						<div class="business_input12">
							<input id="manager2Name" class="easyui-validatebox" style="width:100%;"/>
						</div>
						<div class="business_input8" style="display:none">
							<input id="manager2Type" value="2" class="easyui-validatebox" style="width:100%;"/>
						</div>
						<div class="business_title2">证件类型：</div>
						<div class="business_input12">
							<select id="manager2IdType" style="width:100%;" >
								<option value="" ></option>
								<option value="0" >身份证</option>
					             <option value="1" >户口簿</option>
					             <option value="2" >护照</option>
					             <option value="3" >军官证</option>
					             <option value="4" >士兵证</option>
					             <option value="5" >港澳居民来往内地通行证</option>
					             <option value="6" >台湾同胞来往内地通行证</option>
					             <option value="7" >临时身份证</option>
					             <option value="8" >外国人居留证</option>
					             <option value="9" >警官证</option>
					             <option value="A" >香港身份证</option>
					             <option value="B" >澳门身份证</option>
					             <option value="C" >台湾身份证</option>
					             <option value="X" >其他证件</option>
							</select>
						</div>
						<div class="business_title2">证件号码：</div>
						<div class="business_input12">
							<input id="manager2Name" class="easyui-validatebox" style="width:100%;"/>
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">财务负责人：</div>
						<div class="business_input12">
							<input id="manager3Name" class="easyui-validatebox" style="width:100%;"/>
						</div>
						<div class="business_input8" style="display:none">
							<input id="manager3Type" value="3" class="easyui-validatebox" style="width:100%;"/>
						</div>
						<div class="business_title2">证件类型：</div>
						<div class="business_input12">
							<select id="manager3IdType" style="width:100%;" >
								<option value="" ></option>
								<option value="0" >身份证</option>
					             <option value="1" >户口簿</option>
					             <option value="2" >护照</option>
					             <option value="3" >军官证</option>
					             <option value="4" >士兵证</option>
					             <option value="5" >港澳居民来往内地通行证</option>
					             <option value="6" >台湾同胞来往内地通行证</option>
					             <option value="7" >临时身份证</option>
					             <option value="8" >外国人居留证</option>
					             <option value="9" >警官证</option>
					             <option value="A" >香港身份证</option>
					             <option value="B" >澳门身份证</option>
					             <option value="C" >台湾身份证</option>
					             <option value="X" >其他证件</option>
							</select>
						</div>
						<div class="business_title2">证件号码：</div>
						<div class="business_input12">
							<input id="manager3Name" class="easyui-validatebox" style="width:100%;"/>
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">监事长：</div>
						<div class="business_input12">
							<input id="manager4Name" class="easyui-validatebox" style="width:100%;"/>
						</div>
						<div class="business_input8" style="display:none">
							<input id="manager4Type" value="4" class="easyui-validatebox" style="width:100%;"/>
						</div>
						<div class="business_title2">证件类型：</div>
						<div class="business_input12">
							<select id="manager4IdType" style="width:100%;" >
								<option value="" ></option>
								<option value="0" >身份证</option>
					             <option value="1" >户口簿</option>
					             <option value="2" >护照</option>
					             <option value="3" >军官证</option>
					             <option value="4" >士兵证</option>
					             <option value="5" >港澳居民来往内地通行证</option>
					             <option value="6" >台湾同胞来往内地通行证</option>
					             <option value="7" >临时身份证</option>
					             <option value="8" >外国人居留证</option>
					             <option value="9" >警官证</option>
					             <option value="A" >香港身份证</option>
					             <option value="B" >澳门身份证</option>
					             <option value="C" >台湾身份证</option>
					             <option value="X" >其他证件</option>
							</select>
						</div>
						<div class="business_title2">证件号码：</div>
						<div class="business_input12">
							<input id="manager4Name" class="easyui-validatebox" style="width:100%;"/>
						</div>
					</div>
				</div>
				<%-- <div class="role_window" name="needHidden">
					<div class="role_window_title14">实际控制人信息</div>
					<div class="business_ss-dm">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'ico_088'"
							onclick="addFact()" style="margin-left:30px;width:15%; ;">
							<span style="font-size:14px;">添加控制人</span>
						</a>
					</div>
					<div class="business_ss-dm" style="width:70%;margin-left:20%">
						<table cellpadding="1" cellspacing="1" id='factTable' border="1">
							<tr>
								<th width="10%">控制人类型</th>
								<th width="20%">姓名（名称）</th>
								<th width="15%">证件类型</th>
								<th width="20%">证件号码</th>
								<th width="15%">组织机构代码</th>
								<th width="15%">机构信用代码</th>
								<th width="5%">操作</th>
							</tr>	
						</table>
					</div>
				</div>
				<div class="role_window" name="needHidden">
					<div class="role_window_title14">重要股东信息</div>
					<div class="business_ss-dm">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'ico_088'"
							onclick="addItem()" style="margin-left:30px;width:15%; ;">
							<span style="font-size:14px;">添加控股人</span>
						</a>
					</div>
					<div class="business_ss-dm" style="width:70%;margin-left:20%">
						<table cellpadding="1" cellspacing="1" id='managerTable' border="1">
							<tr>	
								<th width="10%">股东类型</th>
								<th width="20%">姓名（名称）</th>
								<th width="12%">证件类型</th>
								<th width="16%">证件号码</th>
								<th width="13%">组织机构代码</th>
								<th width="14%">机构信用代码</th>
								<th width="10%">持股比例(%) </th>
								<th width="5%">操作</th>
							</tr>	
						</table>	
					</div>
				</div> --%>
				<div class="role_window" name="needHidden" style="height:160px">
					<div class="role_window_title14">上级机构（主管单位）信息</div>
					<div class="business_ss-dm">
						<div class="business_title2">机构名称：</div>
						<div class="business_input9">
							<input id="upOrgName" class="easyui-validatebox" style="width:100%;"/>
						</div>
						<div class="business_title2">机构信用代码：</div>
						<div class="business_input9">
							<input id="upOrgInstitId" class="easyui-validatebox" style="width:100%;"/>
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">组织机构代码：</div>
						<div class="business_input9">
							<input id="upOrgCode" class="easyui-validatebox" style="width:100%;"/>
						</div>
						<div class="business_title2">登记注册号类型：</div>
						<div class="business_input9">
							<select id="upRegistertype" style="width:100%;" >
								<option value="">--请选择--</option>
								<option value="01">工商注册号</option>
								<option value="02">机关和事业单位登记号</option>
								<option value="03">社会团体登记号</option>
								<option value="04">民办非企业单位登记号</option>
								<option value="05">基金会登记号</option>
								<option value="06">宗教活动场所登记号</option>
								<option value="07">统一社会信用代码</option>
								<option value="08">商事与非商事登记证号</option>
								<option value="99">其他</option>
							</select>
						</div>
					</div>
					<div class="business_ss-dm">
						<div class="business_title2">登记注册号：</div>
						<div class="business_input9">
							<input id="upSaccfileCode" class="easyui-validatebox" style="width:100%;"/>
						</div>
					</div>
				</div>
			</div>
			<div class="role_window_button">
				<a href="javascript:void(0)" name="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
					style="padding:3px 0px;width:20%; margin-right:10px;" onclick="save()">
					<span style="font-size:14px;">保存</span>
				</a>
			</div>
		</div>
	</body>
</html>
