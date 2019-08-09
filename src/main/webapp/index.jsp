<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

<script type="text/javascript" src="${APP_PATH}/static/js/jquery.min.js"></script>
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<!-- 添加员工的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
      </div>
      <div class="modal-body">
	      <form class="form-horizontal">
	  <div class="form-group">
	    <label for="empName_add_input" class="col-sm-2 control-label">员工姓名</label>
	    <div class="col-sm-10">
	      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
	    </div>
	  </div>
	  	<!-- <div class="form-group">
	   		<label for="email_add_input" class="col-sm-2 control-label">email</label>
	    	<div class="col-sm-10">
	    		<input type="text" class="form-control" id="email_add_input" placeholder="email@163.com">
	    	</div>
  		</div> -->
	  	<div class="form-group">
	   		<label class="col-sm-2 control-label">性别</label>
		    <div class="col-sm-10">
		    	<label class="radio-inline">
				  <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
				</label>
				<label class="radio-inline">
				  <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
				</label>
		    </div>
	  	</div>
	  	<div class="form-group">
	   		<label class="col-sm-2 control-label">部门名</label>
		    <div class="col-sm-3">
		    	<select class="form-control" name="dId">
				</select>
		    </div>
	  	</div>
	</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_add_save_btn">保存</button>
      </div>
    </div>
  </div>
</div>

	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>基于SSM的CRUD系统</h1>
			</div>
		</div>
		<hr />
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>

		</div>
		<!-- 表格 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
		</div>
		<!-- 分页 -->
		<div class="row">
			<div class="col-md-6" id="page_info"></div>
			<!-- 分页条 -->
			<div class="col-md-6" id="page_nav"></div>
		</div>
	</div>
	<script type="text/javascript">
	var totalRecord;
		//1.页面加载后，ajax请求，要到分页数据
		$(function() {
			to_PageNum(1);
		});

		function to_PageNum(pn){
			$.ajax({
				url : "${APP_PATH}/emps2",
				data : "pn="+pn,
				type : "GET",
				success : function(result) {
					//console.log(result);

					//1.解析员工信息
					build_emps_table(result);
					//2.解析分页信息
					build_page_info(result);
					//3.显示分页条
					build_page_nav(result);
				}
			});
		}
		
		function build_emps_table(result) {
			$("#emps_table tbody").empty();
			var emps = result.map.pageInfo.list;
			$.each(emps, function(index, item) {
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var empGenderTd = $("<td></td>").append(
						item.gender == 'M' ? "男" : "女");
				//var empEmailTd=$("<td></td>").append(item.empName);
				var empDeptNameTd = $("<td></td>").append(
						item.department.deptName);
				
				var editBtn = $("<button></button>").addClass(
						"btn btn-primary btn-sm").append(
						$("<span></span>").addClass(
								"glyphicon glyphicon-pencil").append(" ").append("编辑"));

				var delBtn = $("<button></button>").addClass(
						"btn btn-danger btn-sm").append(
						$("<span></span>").addClass(
								"glyphicon glyphicon-trash").append(" ").append("删除"));
				var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn);
				
				$("<tr></tr>").append(empIdTd).append(empNameTd).append(
						empGenderTd).append($("<td>12306@163.com</td>"))
						.append(empDeptNameTd).append(btnTd).appendTo("#emps_table tbody");
			});
		}
		
		function build_page_info(result){
			$("#page_info").empty();
			$("#page_info").append("当前第"+result.map.pageInfo.pageNum+"页,总"+result.map.pageInfo.pages+"页,总"
					+result.map.pageInfo.total+"条记录");
			totalRecord=result.map.pageInfo.total;
		}
	
		function build_page_nav(result) {
			$("#page_nav").empty();
			var ul=$("<ul></ul>").addClass("pagination");
			var firstLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","javascript:void(0)"));
			var preLi=$("<li></li>").append($("<a></a>").append("&laquo;").attr("href","javascript:void(0)"));
			if(result.map.pageInfo.hasPreviousPage==false){
				firstLi.addClass("disabled");
				preLi.addClass("disabled");
			}
			else {
					firstLi.click(function(){
						to_PageNum(1);
					});
					preLi.click(function(){
						to_PageNum(result.map.pageInfo.pageNum-1);
					});
				}
			var nextLi=$("<li></li>").append($("<a></a>").append("&raquo;").attr("href","javascript:void(0)"));
			var lastLi=$("<li></li>").append($("<a></a>").append("尾页").attr("href","javascript:void(0)"));
			if(result.map.pageInfo.hasNextPage==false){
				nextLi.addClass("disabled");
				lastLi.addClass("disabled");
			}
			else{
				lastLi.click(function(){
					to_PageNum(result.map.pageInfo.pages);
				});
				nextLi.click(function(){
					to_PageNum(result.map.pageInfo.pageNum+1);
				});
			}
			ul.append(firstLi).append(preLi);
			$.each(result.map.pageInfo.navigatepageNums,function(index,item){
				var numLi=$("<li></li>").append($("<a></a>").append(item).attr("href","javascript:void(0)"));
				if(item==result.map.pageInfo.pageNum){
					numLi.addClass("active");
				}
				numLi.click(function(){
					to_PageNum(item);
				});
				ul.append(numLi);
			});
			ul.append(nextLi).append(lastLi);
			var nav=$("<nav></nav>").append(ul);
			nav.appendTo("#page_nav");
		}
		
		$("#emp_add_modal_btn").click(function(){
			
			getDeptName();
			$("#empAddModal").modal({
				backdrop:"static"
			});
		});
		function getDeptName(){
			$("#empAddModal select").empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					//console.log(result);
					$.each(result.map.depts,function(){
							$("#empAddModal select").append($("<option></option>")
															.append(this.deptName).attr("value",this.deptId));
					});
				}
			});
		}
		$("#emp_add_save_btn").click(function(){
			
			//alert("进入点击事件");
			/* $.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result){
					alert(result.msg);
				}
			}); */
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result){
					alert(result.msg);
					$('#empAddModal').modal('hide');
					to_PageNum(totalRecord);
				}
			});
		});
		
	</script>
</body>
</html>