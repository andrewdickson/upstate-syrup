
$(document).ready(function(){

    var map;
     var elevator;
     var myOptions = {
         zoom: 10,
         center: new google.maps.LatLng(0, 0),
         mapTypeId: 'terrain'
     };
     map = new google.maps.Map($('#map_canvas')[0], myOptions);


     var address_data = $('#mapAddress').data('address');
     var address = encodeURIComponent(address_data); //'3164 state route 26 Constableville, NY 13325, USA'

     $.getJSON('http://maps.googleapis.com/maps/api/geocode/json?address='+address+'&sensor=false', null, function (data) {
         var p = data.results[0].geometry.location
         var latlng = new google.maps.LatLng(p.lat, p.lng);
         var markers = new google.maps.Marker({
             position: latlng,
             map: map
         });

         map.fitBounds([markers].reduce(function(bounds, marker) {
            return bounds.extend(marker.getPosition());
         }, new google.maps.LatLngBounds()));


         zoomChangeBoundsListener =
             google.maps.event.addListenerOnce(map, 'bounds_changed', function(event) {
                 if (this.getZoom()){
                     this.setZoom(8);
                 }
             });
         setTimeout(function(){google.maps.event.removeListener(zoomChangeBoundsListener)}, 2000);


     /*    var infowindow = new google.maps.InfoWindow({
             content:"Kraeger Syrup"
         });
         infowindow.open(map,markers[0]); todo: label with brand */
     });

});