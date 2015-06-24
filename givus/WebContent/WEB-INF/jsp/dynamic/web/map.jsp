<%@  page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<style type="text/css">
  html { height: 100% }
  body { height: 100%; margin: 0; padding: 0 }
  #map_canvas { height: 100% }
</style>
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false&language=ko"></script>
<script type="text/javascript">
   function initialize() {
		var geocoder = new google.maps.Geocoder();
		var latlng = new google.maps.LatLng(-34.397, 150.644);
		var myOptions = {
		  zoom: 16,
		  center: latlng,
		  mapTypeId: google.maps.MapTypeId.ROADMAP
		}
		var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
		
		var address = "${dispatcher.data.address}";
		geocoder.geocode( { 'address': address}, function(results, status) {
		  if (status == google.maps.GeocoderStatus.OK) {
			map.setCenter(results[0].geometry.location);
			var marker = new google.maps.Marker({
				map: map, 
				position: results[0].geometry.location
			});
		  } else {
			alert("Geocode was not successful for the following reason: " + status);
		  }
		});
	}
</script>
</head>
<body onload="initialize()">
<style>
* {
	font-size: 9pt;
	font-family: 돋움, tahoma, Arial;
	word-spacing: normal;
	text-decoration: none;
/*	color: #656565; */
}
.map-address{
	text-align: center;
	padding: 3px;
	border: 1px solid #656565;
}
</style>
<div class="map-address">
	${dispatcher.data.name} - ${dispatcher.data.address}
</div>
	<div id="map_canvas" style="width:100%; height:100%"></div>
</body>
</html>