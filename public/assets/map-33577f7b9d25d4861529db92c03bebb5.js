$(document).ready(function(){var e,t={zoom:10,center:new google.maps.LatLng(0,0),mapTypeId:"terrain"};e=new google.maps.Map($("#map_canvas")[0],t);var n=encodeURIComponent("3164 state route 26 Constableville, NY 13325, USA");$.getJSON("http://maps.googleapis.com/maps/api/geocode/json?address="+n+"&sensor=false",null,function(t){var n=t.results[0].geometry.location,i=new google.maps.LatLng(n.lat,n.lng),r=new google.maps.Marker({position:i,map:e});e.fitBounds([r].reduce(function(e,t){return e.extend(t.getPosition())},new google.maps.LatLngBounds)),zoomChangeBoundsListener=google.maps.event.addListenerOnce(e,"bounds_changed",function(){this.getZoom()&&this.setZoom(8)}),setTimeout(function(){google.maps.event.removeListener(zoomChangeBoundsListener)},2e3)})});