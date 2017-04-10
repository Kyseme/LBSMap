<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>GIS展现数据信息</title>		
    <script type="text/javascript" src="/sun_gis/jslib/jquery-1.8.3.js"></script>
    <link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" /> 
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=29IIh9alDDOOk4l2wg5yD0rN"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>
    <link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" /> 
    <style type="text/css">
		body, html{width: 100%;height: 100%;margin:0;font-family:"微软雅黑";}
		#allmap{height:500px;width:100%;}
		#r-result{width:100%; font-size:14px;}
	</style>
	<!-- 移除百度地图标志 -->
	<style type="text/css"> 
		.anchorBL{ 
			display:none; 
		} 
	</style> 
  </head>
  
  <body>
  	 <div style="width:99.6%;height:99%;border:1px solid gray" id="container"></div>
  </body>
</html>

 <script type="text/javascript">
  /*城市查询定位方法*/
	 /* function theLocation(){
		var city = document.getElementById("cityName").value;
		if(city != ""){
			 用城市名设置地图中心点 
			map.centerAndZoom(city,20);      
		}
	} */
	/*创建地图实例*/
					function getDistance(lng1,lati1,lng2,lati2){  
				        var lat1 = (Math.PI/180)*lati1;  
				        var lat2 = (Math.PI/180)*lati2;  
				          
				       var lon1 = (Math.PI/180)*lng1;  
				        var  lon2 = (Math.PI/180)*lng2;  
				          
				        //地球半径  
				        var R = 6371;  
				        var PI = Math.PI; 
				        //两点间距离 km，如果想要米的话，结果*1000就可以了  
				        var d =  Math.acos(Math.sin(lat1)*Math.sin(lat2)+Math.cos(lat1)*Math.cos(lat2)*Math.cos(lon2-lon1))*R;  
				        var d1=d*1000;
				        return d1;  
					  
				    } ; 

	var map = new BMap.Map("container"); 
	var  mPoint = new BMap.Point(114.3162, 30.5810);  
	map.enableScrollWheelZoom();
	map.centerAndZoom(mPoint,16);
	var marker = new BMap.Marker(mPoint );  // 创建标注
	map.addOverlay(marker);               // 将标注添加到地图中
	marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
	
	/*start 定位得到经纬度 */
/* 	var geolocation = new BMap.Geolocation();
	geolocation.getCurrentPosition(function(r){
	if(this.getStatus() == BMAP_STATUS_SUCCESS){
			var mk = new BMap.Marker(r.point);
			map.addOverlay(mk);
			map.panTo(r.point);
			alert('您的位置：'+r.point.lng+','+r.point.lat);
		}
		else {
			alert('failed'+this.getStatus());
		}        
	},{enableHighAccuracy: true}) */
		/*end 定位得到经纬度 */
	
	map.addControl(new BMap.MapTypeControl());
	map.addControl(new BMap.MapTypeControl());
	map.enableScrollWheelZoom(true);
	
	/*向地图添加缩放控件*/
	var ctrlNav = new window.BMap.NavigationControl({  
        anchor: BMAP_ANCHOR_TOP_LEFT,  
        type: BMAP_NAVIGATION_CONTROL_LARGE  
    });  
    map.addControl(ctrlNav); 
  
	/* 	map.setViewport(pointArray); //调整视野    */              
    /*存放标注点经纬信息的数组*/
    var point = new Array();   
    /*存放标注点对象的数组  */
    var marker = new Array(); 
    /*存放提示信息对象的数组  */
    var info = new Array();
    /*存放提示信息窗口对象的数组  */
    var infoWindow =new Array(); 
    $.ajax({
    	url:'/sun_gis/GisServlet?method=findAll2',
    	success:function(data){
    	  // alert(data);

    		var list = eval(data);
   		  	for (var i = 0; i < list.length; i++) {
   		  		/*按照地图点坐标生成标记  */
				/*按照原数组的point格式将地图点坐标的经纬度分别提出来  */
				
		        var p0 = list[i].point.split(",")[0]; 
		        var p1 = list[i].point.split(",")[1]; 
		        
		       var c= getDistance(114.404, 30.915,p0,p1);  
					alert(c);
		        /*循环生成新的地图点 */
		        point[i] = new window.BMap.Point(p0, p1); 
		        if(c<=40000)
		        {
		        		var myIcon = new BMap.Icon("/sun_gis/img/markers.png",
						 new BMap.Size(23, 25),{imageOffset: new BMap.Size(0, 0 -10 * 25)});
			            marker[i] = new window.BMap.Marker(point[i],{icon:myIcon});
				         map.addOverlay(marker[i]); 
				         
		        }
		        /*如果大于0的代表未超标，则显绿色图标，否则显示红色并且抖动*/
		    /*     if(list[i].overData<0){
					marker[i] = new window.BMap.Marker(point[i]);
					marker[i].setAnimation(BMAP_ANIMATION_BOUNCE);
				}else{
					var myIcon = new BMap.Icon("img/markers.png",
						 new BMap.Size(23, 25),{imageOffset: new BMap.Size(0, 0 - 10 * 25)});
					marker[i] = new window.BMap.Marker(point[i],{icon:myIcon});
				} */
				info[i]="<p style=’font-size:12px;lineheight:1.8em;’>" 
		      			+ list[i].gname+"</br> 电话：" + list[i].gtel 
		      			+ "</br> 简介：" + list[i].des + "</br></p>";
		        /*创建信息窗口对象(包含了路线查询)  */
		        infoWindow[i] = new BMapLib.SearchInfoWindow(map, info[i], {
		            title  : list[i].gname, //标题
		            width  : 300,//宽度
		            height : 100,//高度
		            panel  : "panel",//检索结果面板
		            enableAutoPan : true,//自动平移
		            searchTypes   :[
		                BMAPLIB_TAB_SEARCH,//周边检索
		                BMAPLIB_TAB_TO_HERE,//到这里去
		                BMAPLIB_TAB_FROM_HERE//从这里出发
		            ]
		        });
		        /*多个标注点添加事件需要闭包*/
		    	marker[i].addEventListener("mouseover", (function(k){
		    			return function(){
		    				infoWindow[k].open(point[k]);
		    			};
		    		})(i)
			 	); 
   		  	}
    	}
    });
    var circle = new BMap.Circle(mPoint,400,{fillColor:"blue", strokeWeight: 1 ,fillOpacity: 0.3, strokeOpacity: 0.3});
    map.addOverlay(circle);
    var local =  new BMap.LocalSearch(map, {renderOptions: {map: map, autoViewport: false}});  
  
</script>