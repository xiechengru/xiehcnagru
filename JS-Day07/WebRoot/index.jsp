<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>微冷的雨考试成绩统计系统</title>
    <style type="text/css">
    
      body{
      font-size:30px;
      background:#DAE4F6;
      font-family:"楷体";
      }
      
       #container{
        margin:0px auto;
       }
      
       #box{
          /* border:1px solid red; */
          overflow:hidden;
        margin:0px auto;
       }
       
       #box label{
       margin-top:5px;
       background:#B0E0E6;
        width:80px;
        display:inline-block;
        text-align:right;
        margin-left:50px;
       }
    </style>
    <script type="text/javascript">
    //获取用户已经做了的题目
     //获取所有的复选框
     var data=new Array();  
      function selectCheckBox(){
       //定义一个字典保存题目编号和用户填写的答案
        
	  /*   data.push=function(o){  
	        //如果o是object  
	        if(typeof(o)=='object') for(var p in o) this[p]=o[p];  
	    }; */
	    
       // data.push({2:"A"});
         //alert(data.a)  
        var selectnum = 0;
          var mycheckboxs = document.getElementsByTagName("input");//获取所有的input标签对象
		var checkboxArray = [];//初始化空数组，用来存放checkbox对象。
		for(var i=0;i<mycheckboxs.length;i++){
		  var obj = mycheckboxs[i];
		  if(obj.type=='checkbox'){
		     checkboxArray.push(obj);
		  }
		}
		for(var i=0;i<checkboxArray.length;i++){
		   if(checkboxArray[i].checked){
		      //选择了某个复选框
		       selectnum++;
		       //复选框提交的文本
		       var tidAndAnswer=checkboxArray[i].value;
		       var myarray=tidAndAnswer.split(":");
		        //题目
               var tid = parseInt(myarray[1]);
                //答案
               var useranswer = myarray[0];
               var flag=false;
               data[0] = "";
               //看题目编号是否已经被记录
               for ( var item in data) {
				   if(item!=0){
				      if(item==tid){
				         data[item]=data[item]+useranswer;
				         flag=true;
				         break;
				      }
				   }
			   }
			   if(flag==false){
			      //data.push({tid:useranswer});
			      data[tid]=tid+":"+useranswer;
			   }
			   
		   }
		}
		
		//
		if (selectnum==0){
            alert('请至少做一道题目');
            return false;
        }else{
          return true;
        }
        //
       }
       //表单校验
       
       function checkName(){
         var txtName=document.getElementById("txtName");
         if(txtName.value==""||txtName.value==null){
            alert('请输入姓名');
            return false;
         }
         return true;
       }
    
    
    
       //加载完所有的标签，图片和css后执行
        window.onload=function(){
        
        
        
        var myform=document.getElementById("form1");
        var mydata=document.getElementById("selectData");
            myform.onsubmit=function(){
             var mycount=0;
            if(!checkName()){
               mycount--;
            }else{
              if(!selectCheckBox()){
               mycount--;
               }
            }
            
            if(mycount==0){
            //var str = JSON.stringify(data); 
            //alert(str);
               mydata.value=data;
               return true;
            }else{
              return false;
            }
            
       };
        
        
        
        
          var row=15;
          var col=3;
         var mybody=document.getElementById('mybody');
         if(col>4){
           mybody.style.width=document.body.scrollWidth+(col-4)*350;
         }
          
         //mybody.style.width="3333px";
          initOptions(row,col);
          //alert(body.documentElement.clientWidth);
        // document.body.scrollWidth=3333;
          var cbxs=document.getElementsByName("rchoice");
          for ( var i = 0; i < cbxs.length; i++) {
			 cbxs[i].style.cssText="margin-left:20px;";
		  }
        };
        //动态加载答题区控件！
        function initOptions(row,column){
           var box=document.getElementById('box');
           //题目编号，从0开始
            var count = 0;
            var mytag; //CheckBox的Tag属性值
           //
            for (var i = 1; i <=row ; i++){  //默认i的值为15
                count++;
                 var mydiv=document.createElement("div");
                  box.appendChild(mydiv);
                  //mydiv.style.border="1px solid blue";
                  // mydiv.style.paddingRight="700px";
                   mydiv.style.overflow="auto";
                for (var j = 1; j <=column; j++){   //默认j的值为2
                 	//创建一个label
                	var label=document.createElement('label');
                	
                      //设置座位号
                    if (j == 1)
                    {
                        label.innerHTML = count+ "题";
                         mytag = count;
                    }
                    else
                    {
                        //多列的情况下创建题目编号的方式
                        label.innerHTML = (count +row*(j-1)) + "题";
                        mytag = count + row*(j-1);
                    }
                    var littlediv=document.createElement("div");
                    littlediv.style.float="left";
                    
                    //littlediv.style.border="3px solid blue";
                    mydiv.appendChild(littlediv);
                    littlediv.appendChild(label);
                    //创建四个选项
                    var checkbox1=document.createElement("input");
                    checkbox1.setAttribute("type","checkbox");
                    checkbox1.setAttribute("value","A:"+mytag);
                    checkbox1.setAttribute("name","rchoice");
                    var cbtxt=document.createTextNode("A");
                    littlediv.appendChild(checkbox1);
                    littlediv.appendChild(cbtxt);
                   
                    //第二个checkbox
                      var checkbox2=document.createElement("input");
                    checkbox2.setAttribute("type","checkbox");
                    checkbox2.setAttribute("value","B:"+mytag);
                    checkbox2.setAttribute("name","rchoice");
                    var cbtxt2=document.createTextNode("B");
                    littlediv.appendChild(checkbox2);
                    littlediv.appendChild(cbtxt2);
                    //第三个checkbox
                      var checkbox3=document.createElement("input");
                    checkbox3.setAttribute("type","checkbox");
                    checkbox3.setAttribute("value","C:"+mytag);
                    checkbox3.setAttribute("name","rchoice");
                    var cbtxt3=document.createTextNode("C");
                    littlediv.appendChild(checkbox3);
                    littlediv.appendChild(cbtxt3);
                    
                     //第四个checkbox
                      var checkbox4=document.createElement("input");
                    checkbox4.setAttribute("type","checkbox");
                    checkbox4.setAttribute("value","D:"+mytag);
                    checkbox4.setAttribute("name","rchoice");
                    var cbtxt4=document.createTextNode("D");
                    
                    littlediv.appendChild(checkbox4);
                    littlediv.appendChild(cbtxt4);
                    var myline=document.createElement("br");
                   
                    if(j==column){
                        mydiv.appendChild(myline);
                    }
              }
           }
           
        }
        
    </script>
  </head>
  
  <body id="mybody">
     <div id="container">
      <div id="box">
		      
		      </div>
        <form action="${pageContext.request.contextPath}/SaveServlet?action=save" method="post" id="form1">
              
	         <!-- <fieldset>
		      <legend>答题区 :本软件由微冷的雨出品!如有问题，请发送反馈信息到：yymqqc@126.com</legend> -->
		     
		     <div id="tool">
		           <label for="txtRow" >行:</label><input id="txtRow" type="text" style="width:50px;"/>
		           <label for="txtColumn" >列:</label><input id="txtColumn" type="text" style="width:50px;"/>
		           <input type="button" value="生成"/>
		           <label for="txtName" >姓名:</label><input id="txtName" name="txtName" type="text"/>
		           <c:if test="${not empty errors && not empty errors['txtName']}">
								<span class="error">${errors['txtName']}</span>
							</c:if>
							<c:if test="${empty errors || empty errors['txtName']}"><span></span></c:if>
		           <input type="submit" value="提交"/>
		      </div>
		      <input type="hidden" id="selectData" name="selectData" value=""/>
	   </form> 
	     <!-- </fieldset> -->
     </div>
  </body>
</html>
