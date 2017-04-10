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
      <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.5&ak=29IIh9alDDOOk4l2wg5yD0rN"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>
    <link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" /> 
    <style type="text/css">
		body, html{width: 100%;height: 100%;margin:0;font-family:"微软雅黑";}
		#allmap{height:500px;width:100%;}
		#r-result{width:100%; font-size:14px;}
		.inp{margin-left:150px;}
	</style>
	<!-- 移除百度地图标志 -->
	<style type="text/css"> 
		.anchorBL{ 
			display:none; 
		} 
	</style> 
  </head>
  
  <body>
  <div>
         要查询的地址：<input id="txt" type="text" value="湖北工业大学" style="margin-right:100px;"/>
         <input type="button" value="退出" onclick="fan();">
         <br/>
        查询结果经度：<input id="lng" type="text" />
		纬度：<input id="lat" type="text"/><br/>
			<div class="inp">
        <input type="button" value="定位"  onclick="searchByStationName();"/> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
		 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<input type="button" value="搜索" onclick="myPoints();"/>
		 	</div>
		</div>
  	 <div style="width:99.6%;height:99%;border:1px solid gray" id="container"></div>
  </body>
</html>

 <script type="text/javascript">
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
				    function fan(){
				    	window.location.href="../index.jsp";
				    }
		 function searchByStationName() {
					   // map.clearOverlays();//清空原来的标注
					    var keyword = document.getElementById("txt").value;
					    localSearch.setSearchCompleteCallback(function (searchResult) {
					     var poi = searchResult.getPoi(0);
					 	document.getElementById("lng").value = poi.point.lng;
						document.getElementById("lat").value=poi.point.lat;
					     map.centerAndZoom(poi.point, 14);
					     var marker = new BMap.Marker(new BMap.Point(poi.point.lng, poi.point.lat));  // 创建标注，为要查询的地方对应的经纬度
       					map.addOverlay(marker);
       					marker.addEventListener("click", function () { this.openInfoWindow(infoWindow); });
        				marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
					    });
					    localSearch.search(keyword);
					} 

					var map = new BMap.Map("container"); 
					//var  mPoint = new BMap.Point(114.3153, 30.4855);  //湖北工业大学的定位点
					map.enableScrollWheelZoom();
					map.centerAndZoom("武汉",14);
					 map.enableScrollWheelZoom();    //启用滚轮放大缩小，默认禁用
				    map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用
				
				    map.addControl(new BMap.NavigationControl());  //添加默认缩放平移控件
				    map.addControl(new BMap.OverviewMapControl()); //添加默认缩略地图控件
				    map.addControl(new BMap.OverviewMapControl({ isOpen: true, anchor: BMAP_ANCHOR_BOTTOM_RIGHT }));   //右下角，打开
				
				    var localSearch = new BMap.LocalSearch(map);
				    localSearch.enableAutoViewport(); //允许自动调节窗体大小
					
	
	
	map.addControl(new BMap.MapTypeControl());
	map.addControl(new BMap.MapTypeControl());
	map.enableScrollWheelZoom(true);
	
	/*向地图添加缩放控件*/
	var ctrlNav = new window.BMap.NavigationControl({  
        anchor: BMAP_ANCHOR_TOP_LEFT,  
        type: BMAP_NAVIGATION_CONTROL_LARGE  
    });  
    map.addControl(ctrlNav); 
  
  function myPoints(){
    var point1=document.getElementById("lng").value;
	var point2=document.getElementById("lat").value;
	
	var  mPoint = new BMap.Point(point1, point2);  
	map.enableScrollWheelZoom();
	map.centerAndZoom(mPoint,14);
	var marker = new BMap.Marker(mPoint );  // 创建标注
	//map.addOverlay(marker);               // 将标注添加到地图中
	//marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画       
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
    	 	 //alert(data);
    		var list = eval(data);
   		  	for (var i = 0; i < list.length; i++) {
   		  		/*按照地图点坐标生成标记  */
				/*按照原数组的point格式将地图点坐标的经纬度分别提出来  */
				
		        var p0 = list[i].point.split(",")[0]; 
		        var p1 = list[i].point.split(",")[1]; 
		        
		       var c= getDistance(point1,point2,p0,p1);  
					//alert(c);
		        /*循环生成新的地图点 */
		        point[i] = new window.BMap.Point(p0, p1); 
		    	   if(c<=3000)
		        {
		        		var myIcon = new BMap.Icon("/sun_gis/img/markers.png",
						 new BMap.Size(23, 25),{imageOffset: new BMap.Size(0, 0 -10 * 25)});
			            marker[i] = new window.BMap.Marker(point[i],{icon:myIcon});
				         map.addOverlay(marker[i]); 
				         
		        }
		        else{
		        	continue;
		        }
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
     var circle = new BMap.Circle(mPoint,3000,{fillColor:"blue", strokeWeight: 1 ,fillOpacity: 0.3, strokeOpacity: 0.3});
    map.addOverlay(circle);
    var local =  new BMap.LocalSearch(map, {renderOptions: {map: map, autoViewport: false}});  
  };
	
</script>