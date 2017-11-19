$(function(){
	("input",$(".auto-input").next("span")).click(function(){
		$(".listdiv").remove();
		$(this).after("<div class='listdiv' onmouseover='mouseoverFun()' onmouseout='mouseoutFun()'><ul></ul></div>");
		var p = $(this).position();
		$(".listdiv").attr("style","width:"+$(this).width()+"px;left:"+p.left+"px;top:"+(p.top+22)+"px");
		getAllInput();
	});
});
function autoInit(table){
	("input",$("#" + table +" tr:last-child").find(".auto-input").next("span")).click(function(){
		$(".listdiv").remove();
		$(this).after("<div class='listdiv' onmouseover='mouseoverFun()' onmouseout='mouseoutFun()'><ul></ul></div>");
		var p = $(this).position();
		$(".listdiv").attr("style","width:"+$(this).width()+"px;left:"+p.left+"px;top:"+(p.top+22)+"px");
		getAllInput();
	});
	
	("input",$("#" + table +" tr:last-child").find(".auto-input").next("span")).blur(function(){
		$(".listdiv").remove();
	});
}
			
function mouseoverFun(){
	$(document).unbind("click");
}
			
function mouseoutFun(){
	$(document).click(function(){
		$(".listdiv").remove();
		$(document).unbind("click");
	});
}
			
function getAllInput(){
	var rows = getAllTableVal();
	
	for (var a = 0 ; a < rows.length ; a++) {
		$(".listdiv ul").append("<li id='"+a+"'>"+rows[a][rows[a].maininput]+"</li>");
	}
	
	if(rows.length==0){
		$(".listdiv").remove();
	}
	
	
	$(".listdiv li").click(function(){
		var tr = $(this).parents("tr");
		var row = rows[this.id];
		$.each(tr.find("td"), function() {
			var inHtml = $(this).find("input:first");
			var icla = inHtml.attr("class");
			var name = $(inHtml).attr("alt");
			var surname = $(inHtml).attr("surname");
			if(icla&&icla.indexOf("easyui-textbox")!=-1){
				if(surname&&surname=="surname"){
					$(inHtml).textbox("setValue",row[name].substring(0,1));
				}else if(name&&name=="bname"){
					$(inHtml).textbox("setValue",row["name"].substring(1,row["name"].length));
				}else{
					$(inHtml).textbox("setValue",row[name]);
				}
			}else if(icla&&icla.indexOf("easyui-combobox")!=-1){
				$(inHtml).combobox("setValue",row[name]);
			}else if(icla&&icla.indexOf("easyui-datebox")!=-1){
				$(inHtml).datebox("setValue",row[name]);
			}
		});
		$(".listdiv").remove();
	});
	
	setTimeout(function(){
			$(document).click(function(){
				$(".listdiv").remove();
				$(document).unbind("click");
			});
		},10);
}

function getAllTableVal(){
	var tables = $(".auto-table");
	var rows = [];
	for (var a = 0 ; a < tables.length ; a++) {
		var trs = $(tables[a]).find("tr");
		for (var b = 0 ; b < trs.length ; b++) {
			var tds = $(trs[b]).find("td");
			var row = {};
			for (var c = 0 ; c < tds.length ; c++) {
				var inputHTML = $(tds[c]).find("input:first");
				var cla = $(inputHTML).attr("class");
				var name = $(inputHTML).attr("alt");
				var surname = $(inputHTML).attr("surname");
				if(name&&cla&&cla.indexOf("easyui-textbox")!=-1){
					var val = $(inputHTML).textbox("getValue");
					if(surname&&surname=="surname"){
						var val2 = $($(tds[c+1]).find("input:first")).textbox("getValue");
						val+=val2;
					}
					row[name]=val;
				}else if(name&&cla&&cla.indexOf("easyui-combobox")!=-1){
					var val = $(inputHTML).combobox("getValue");
					row[name]=val;
				}else if(name&&cla&&cla.indexOf("easyui-datebox")!=-1){
					var val = $(inputHTML).datebox("getValue");
					row[name]=val;
				}
				if(cla && cla.indexOf("auto-input") !=-1 ){
					if($.trim(val)==""){
						row = {};
						break;
					}else{
						row["maininput"] = name;
					}
				}
					
			}
			
			if(!$.isEmptyObject(row)){
				var flag = true;
				
				for (var d = 0 ; d < rows.length; d++) {
					if(rows[d][rows[d].maininput] == row[row.maininput]){
						flag = false;
						break;
					}
				}
				if(flag){
					rows.push(row);
				}
			}
		}
	}
	return rows;
}
