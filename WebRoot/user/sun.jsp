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
  	 <!--  <div id="r-result">
	 	城市名: <input id="cityName" type="text" style="width:100px; margin-right:10px;" />
		<input type="button" value="查询" onclick="theLocation()" />
	 </div> -->
  	 <div style="width:99.6%;height:99%;border:1px solid gray" id="container"></div>
  </body>
</html>

 <script type="text/javascript">
	
	/*创建地图实例*/
	var map = new BMap.Map("container"); 
	var  mPoint = new BMap.Point(114.404, 30.915);  
	map.enableScrollWheelZoom();
	map.centerAndZoom(mPoint,12);
	/*初始化地图，设置中心点坐标和地图级别*/ 
	
	
		/*start 绘制圆形的方法 */
	 function getSquareBounds(centerPoi,r){
   var a = Math.sqrt(2) * r; //正方形边长
   mPoint = getMecator(centerPoi);
     var x0 = mPoint.x, y0 = mPoint.y;
   var x1 = x0 + a / 2 , y1 = y0 + a / 2;//东北点
   var x2 = x0 - a / 2 , y2 = y0 - a / 2;//西南点
  var ne = getPoi(new BMap.Pixel(x1, y1)), sw = getPoi(new BMap.Pixel(x2, y2));
   return new BMap.Bounds(sw, ne); 
 }
  //根据球面坐标获得平面坐标。
  function getMecator(poi){
  return map.getMapType().getProjection().lngLatToPoint(poi);
   }
//根据平面坐标获得球面坐标。
  function getPoi(mecator){
   return map.getMapType().getProjection().pointToLngLat(mecator);
  }
	/*start 绘制圆形的方法 */
	
	
	
	/*  start 实现定位*/
	/* 
	var point = new BMap.Point(116.331398,39.897445);
	map.centerAndZoom(point,8);
	map.addControl(new BMap.MapTypeControl());//加载缩放控件
	//map.addControl(new BMap.MapTypeControl());
	map.enableScrollWheelZoom(true);

	var geolocation = new BMap.Geolocation();
	geolocation.getCurrentPosition(function(r){
		if(this.getStatus() == BMAP_STATUS_SUCCESS){
			var mk = new BMap.Marker(r.point);
			//alert(r.point);
			map.addOverlay(mk);
			map.panTo(r.point);
		alert('您的位置：'+r.point.lng+','+r.point.lat);
		}
		else {
			alert('failed'+this.getStatus());
		}        
	},{enableHighAccuracy: true}) ;
	*/
	/* end实现定位*/
	
	/*
	map.centerAndZoom("湖北省",8);              
	map.addControl(new BMap.MapTypeControl());
	map.addControl(new BMap.MapTypeControl());
	map.enableScrollWheelZoom(true);
	*/
	       
	
	
	/*向地图添加缩放控件*/
	var ctrlNav = new window.BMap.NavigationControl({  
        anchor: BMAP_ANCHOR_TOP_LEFT,  
        type: BMAP_NAVIGATION_CONTROL_LARGE  
    });  
    map.addControl(ctrlNav); 
        var pointArray = [];

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
    		//var message = response.responseText;
    		//alert(data);
    		//var list=result.gisData;
    		var list = eval(data);
   		  	for (var i = 0; i < list.length; i++) {
   		  		/*按照地图点坐标生成标记  */
				/*按照原数组的point格式将地图点坐标的经纬度分别提出来  */
				
		        var p0 = list[i].point.split(",")[0]; 
		        var p1 = list[i].point.split(",")[1]; 
		        
		        /*循环生成新的地图点 */
		        point[i] = new window.BMap.Point(p0, p1); 
		        
		        var circle = new BMap.Circle(mPoint,9000,{fillColor:"blue", strokeWeight: 1 ,fillOpacity: 0.3, strokeOpacity: 0.3});  
    			map.addOverlay(circle);  
   			 	var local =  new BMap.LocalSearch(map, {renderOptions: {map: map, autoViewport: false}});    
 			    var bounds = getSquareBounds(circle.getCenter(),circle.getRadius());  
  			 	 local.searchInBounds("加油站",bounds);  
  			 	
  			 	
    			//百度地图调用

		        /*如果大于0的代表未超标，则显绿色图标，否则显示红色并且抖动*/
		    /*     if(list[i].overData<0){
					marker[i] = new window.BMap.Marker(point[i]);
					marker[i].setAnimation(BMAP_ANIMATION_BOUNCE);
				}else{
					var myIcon = new BMap.Icon("img/markers.png",
						 new BMap.Size(23, 25),{imageOffset: new BMap.Size(0, 0 - 10 * 25)});
					marker[i] = new window.BMap.Marker(point[i],{icon:myIcon});
				} */
				  var myIcon = new BMap.Icon("img/markers.png",
						 new BMap.Size(23, 25),{imageOffset: new BMap.Size(0, 0 - 10 * 25)});
			    marker[i] = new window.BMap.Marker(point[i],{icon:myIcon});
				map.addOverlay(marker[i]); 
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
</script>