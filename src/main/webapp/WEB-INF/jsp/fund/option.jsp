<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
	<link rel="stylesheet" href="${APP_PATH}/css/main.css">
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	table tbody tr:nth-child(odd){background:#F4F4F4;}
	table tbody td:nth-child(even){color:#C00;}
	</style>
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <div><a class="navbar-brand" style="font-size:32px;" href="#">资金管理平台</a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li style="padding-top:8px;">
				<div class="btn-group">
				  <button type="button" class="btn btn-default btn-success dropdown-toggle" data-toggle="dropdown">
					<i class="glyphicon glyphicon-user"></i> ${loginUser.userName} <span class="caret"></span>
				  </button>
					  <ul class="dropdown-menu" role="menu">
						<li><a href="#"><i class="glyphicon glyphicon-cog"></i> 个人设置</a></li>
						<li><a href="#"><i class="glyphicon glyphicon-comment"></i> 消息</a></li>
						<li class="divider"></li>
						<li><a href="${APP_PATH}/logout"><i class="glyphicon glyphicon-off"></i> 退出系统</a></li>
					  </ul>
			    </div>
			</li>
            <li style="margin-left:10px;padding-top:8px;">
				<button type="button" class="btn btn-default btn-danger">
				  <span class="glyphicon glyphicon-question-sign"></span> 帮助
				</button>
			</li>
          </ul>
          <form class="navbar-form navbar-right">
            <input type="text" class="form-control" placeholder="Search...">
          </form>
        </div>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
			<div class="tree">
				<ul style="padding-left:0px;" class="list-group">
					<li class="list-group-item tree-closed" >
						<a href="${APP_PATH}/main"><i class="glyphicon glyphicon-dashboard"></i> 控制面板</a>
					</li>
					<li class="list-group-item tree-closed">
						<span><i class="glyphicon glyphicon glyphicon-tasks"></i> 基金管理 <span class="badge" style="float:right">3</span></span>
						<ul style="margin-top:10px;">
							<li style="height:30px;">
								<a href="${APP_PATH}/fund/steady"><i class="glyphicon glyphicon-align-left"></i> 稳健型基金配置 </a>
							</li>
							<li style="height:30px;">
								<a href="${APP_PATH}/fund/radical"><i class="glyphicon glyphicon-align-right"></i> 激进型基金配置 </a>
							</li>
							<li style="height:30px;">
								<a href="${APP_PATH}/fund/option"><i class="glyphicon glyphicon-align-center"></i> 自选基金池 </a>
							</li>
						</ul>
					</li>
				</ul>
			</div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表 -- 自选基金池配置</h3>
			  </div>
			  <div class="panel-body">
<form class="form-inline" role="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">查询条件</div>
      <input id="queryText" class="form-control has-success" type="text" placeholder="请输入基金代码或名称">
    </div>
  </div>
  <button id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button type="button" class="btn btn-danger" onclick="deleteFunds()" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button type="button" class="btn btn-primary" style="float:right;" onclick="addFund('option')"><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <form id="userForm">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
				  <th width="30"><input type="checkbox" id="allSelBox"></th>
					<th>基金代码</th>
					<th>基金名称</th>
					<th>基金类型</th>
					<th>月涨幅</th>
					<th>三月涨幅</th>
					<th>六月涨幅</th>
					<th>年涨幅</th>
					<th>基金经理</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              
              <tbody id="userData">
                  
              </tbody>
              
			  <tfoot>
			     <tr >
				     <td colspan="11" align="center">
						<ul class="pagination">

						</ul>
					 </td>
				 </tr>

			  </tfoot>
            </table>
            </form>
          </div>
			  </div>
			</div>
        </div>
      </div>
    </div>

    <script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH}/script/docs.min.js"></script>
	<script src="${APP_PATH}/layer/layer.js"></script>
        <script type="text/javascript">
            var likeflg = false;
            $(function () {
			    $(".list-group-item").click(function(){
				    if ( $(this).find("ul") ) {
						$(this).toggleClass("tree-closed");
						if ( $(this).hasClass("tree-closed") ) {
							$("ul", this).hide("fast");
						} else {
							$("ul", this).show("fast");
						}
					}
				});
			    
			    pageQuery(1);
			    
			    $("#queryBtn").click(function(){
			    	var queryText = $("#queryText").val();
			    	if ( queryText == "" ) {
			    		likeflg = false;
			    	} else {
			    		likeflg = true;
			    	}
			    	
			    	pageQuery(1);
			    });
			    
			    $("#allSelBox").click(function(){
			    	var flg = this.checked;
			    	
			    	$("#userData :checkbox").each(function(){
			    		this.checked = flg;
			    	});
			    });
            });
            $("tbody .btn-success").click(function(){
                window.location.href = "assignRole.html";
            });
            $("tbody .btn-primary").click(function(){
                window.location.href = "edit.html";
            });
            
            // 分页查询
            function pageQuery( pageNum ) {
            	var loadingIndex = null;

            	var jsonData = {"pageNum" : pageNum, "pageSize" : 10};
            	if ( likeflg == true ) {
            		jsonData.queryText = $("#queryText").val();
            	}

            	jsonData.type = "option";
            	
            	$.ajax({
					type : "POST",
            		url  : "${APP_PATH}/fund/pageQuery",
					datatype :"json",
					contentType:"application/json;charsetset=UTF-8",
            		data : JSON.stringify(jsonData),
            		beforeSend : function(){
            			loadingIndex = layer.msg('处理中', {icon: 16});
            		},
            		success : function(result) {
            			layer.close(loadingIndex);
            			if ( result.success ) {
            				// 局部刷新页面数据
            				var tableContent = "";
            				var pageContent = "";
            				
            				var fundOptionPage = result.data;
            				var fundOptions = fundOptionPage.records;
            				
            				$.each(fundOptions, function(i, fundOption){
            	                tableContent += '<tr>';
	          	                tableContent += '  <td>'+(i+1)+'</td>';
	          					tableContent += '  <td><input type="checkbox" name="fundid" value="'+fundOption.id+'"></td>';
	          	                tableContent += '  <td>'+fundOption.fundCode+'</td>';
	          	                tableContent += '  <td>'+fundOption.fundName+'</td>';
	          	                tableContent += '  <td>'+fundOption.fundType+'</td>';
								tableContent += '  <td>'+fundOption.monthGrowth+'</td>';
								tableContent += '  <td>'+fundOption.threeMonthsGrowth+'</td>';
								tableContent += '  <td>'+fundOption.sixMonthsGrowth+'</td>';
								tableContent += '  <td>'+fundOption.yearGrowth+'</td>';
								tableContent += '  <td>'+fundOption.manager+'</td>';
	          	                tableContent += '  <td>';
								tableContent += '  <button type="button" onclick="insertSteady('+fundOption.fundCode+')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-plus"></i></button>';
								tableContent += '  <button type="button" onclick="insertRadical('+fundOption.fundCode+')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-plus"></i></button>';
	          					tableContent += '  <button type="button" onclick="deleteFund('+fundOption.id+')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
	          					tableContent += '  </td>';
	          	                tableContent += '</tr>';
            				});
            				
            				if ( pageNum > 1 ) {
            					pageContent += '<li><a href="#" onclick="pageQuery('+(pageNum-1)+')">上一页</a></li>';
            				}
            				
            				for ( var i = 1; i <= fundOptionPage.pages; i++ ) {
            					if ( i == pageNum ) {
            						pageContent += '<li class="active"><a  href="#">'+i+'</a></li>';
            					} else {
            						pageContent += '<li ><a href="#" onclick="pageQuery('+i+')">'+i+'</a></li>';
            					}
            				}
            				
            				if ( pageNum < fundOptionPage.pages ) {
            					pageContent += '<li><a href="#" onclick="pageQuery('+(pageNum+1)+')">下一页</a></li>';
            				}

            				$("#userData").html(tableContent);
            				$(".pagination").html(pageContent);
            			} else {
                            layer.msg("用户信息分页查询失败", {time:2000, icon:5, shift:6}, function(){
                            	
                            });
            			}
            		}
            	});
            }

			function insertSteady( code ) {
				layer.confirm("添加自选基金到稳健型基金池, 是否继续",  {icon: 3, title:'提示'}, function(cindex){

					window.location.href = "${APP_PATH}/fund/addFund?fundCode="+code+"&addType="+"steady";
				});

			}

			function insertRadical( code ) {
				layer.confirm("添加自选基金到激进型基金池, 是否继续",  {icon: 3, title:'提示'}, function(cindex){

					window.location.href = "${APP_PATH}/fund/addFund?fundCode="+code+"&addType="+"radical";
				});

			}

            function deleteFunds() {
            	var ids = [];
            	$("input[name='fundid']:checked").each(function (i) {
					ids[i] = $(this).val();
				});

            	if ( ids.length == 0 ) {
                    layer.msg("请选择需要删除的基金信息", {time:2000, icon:5, shift:6}, function(){

                    });
            	} else {
        			layer.confirm("删除选择的基金信息, 是否继续",  {icon: 3, title:'提示'}, function(cindex){
        				// 删除选择的用户信息
        				$.ajax({
        					type : "POST",
							datatype :"json",
							contentType:"application/json;charsetset=UTF-8",
        					url  : "${APP_PATH}/fund/deletes",
        					data : JSON.stringify({
								"fundIds": ids,
								"type": "option"
							}),
        					success : function(result) {
        						if ( result.success ) {
        							pageQuery(1);
        						} else {
                                    layer.msg("基金信息删除失败", {time:2000, icon:5, shift:6}, function(){
                                    	
                                    });
        						}
        					}
        				});
        				
        				layer.close(cindex);
        			}, function(cindex){
        			    layer.close(cindex);
        			});
            	}
            }
            
            function deleteFund( id) {
    			layer.confirm("删除基金信息, 是否继续",  {icon: 3, title:'提示'}, function(cindex){
    			    
    				// 删除用户信息
    				$.ajax({
    					type : "GET",
    					url  : "${APP_PATH}/fund/delete",
						data : {
							id : id ,
							type: "option"
						},
    					success : function(result) {
    						if ( result.success ) {
    							pageQuery(1);
    						} else {
                                layer.msg("基金信息删除失败", {time:2000, icon:5, shift:6}, function(){
                                	
                                });
    						}
    					}
    				});
    				
    				layer.close(cindex);
    			}, function(cindex){
    			    layer.close(cindex);
    			});
            }

			function addFund(type) {
				window.location.href = "${APP_PATH}/fund/add?addType="+type;
			}
        </script>
  </body>
</html>