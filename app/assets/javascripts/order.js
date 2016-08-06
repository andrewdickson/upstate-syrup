

var setPaypal = function(product){
    $(".product_container").hide();
    $("#product_container_" + product.id).show();
    var is_pickup = $("#pickup").is(':checked');

    $(".paypal_code").hide();
    var paypalCodeSelector = "#paypal_code_" + product.id + "_" + (is_pickup ? "pickup" : "ship");
    $(paypalCodeSelector).show();

};
var productSelected = function(productId){
    var productId = productId || $("#product_size").val();

    $.ajax({
        type: "GET",
        url: "/products/" + productId,
        dataType: "json",
        success: function (product) {
            setPaypal(product);
            refreshShippingCost();
            stylizePaypal();
        }
    });
};

var setShippingCostByZipCode = function(zipCode){
    if(!zipCode) return;

    $.get("http://maps.googleapis.com/maps/api/geocode/json?address=" + zipCode,
        function(response){
            if(!response || !response.results || !response.results.length || !response.results[0] || !response.results[0].address_components || !response.results[0].address_components.length)
                return;

            $("#zone_data").data("google_zip", response);

            setShippingCostByState();
        }
    );
};


var setShippingCostByState = function(){
    var is_pickup = $("#pickup").is(':checked');

    if(is_pickup){
        $("#shipping_label").html("Free");
    }
    else {
        var zones = $("#zone_data").data("zones");
        var state_name = getStateName();

        if(state_name) {
            state_name = state_name.toLowerCase().trim();
            var shipping_zones = zones.filter(function (zone) {
                return ( zone && zone.states && zone.states.toLowerCase().indexOf(state_name) >= 0 );
            });

            if (shipping_zones && shipping_zones.length) {
                var zone = shipping_zones[0];

                $("#zone_data").data("shipping_cost_box_a", zone.box_a_cost);
                $("#zone_data").data("shipping_cost_box_b", zone.box_b_cost);

                refreshShippingCost();
            }
        }
    }
};

var getStateName = function(){
    var ret = null;
    var g = $("#zone_data").data("google_zip");
    if(g && g.results  && g.results.length && g.results[0] && g.results[0].address_components && g.results[0].address_components.length >= 1){
        var address_components = g.results[0].address_components;
        for(var i=0; i<address_components.length; ++i){
            if(address_components[i].types.indexOf("administrative_area_level_1") >= 0){
                ret = address_components[i].long_name;
                break;
            }
        }

        if(ret == null){
            $("#zone_data").data("google_zip", "");
            return getStateAbbreviation();
        }
    }
    else {
        var geo_ip = $("#zone_data").data("geo_ip")
        if (geo_ip && geo_ip.region_name) {
            ret = geo_ip.region_name;
        }
    }

    return ret;
};

var refreshShippingCost = function(){

    var is_pickup = $("#pickup").is(':checked');
    if(is_pickup){
        $("#shipping_label").html("Free");
    }
    else {

        var box_cost_a = $("#zone_data").data("shipping_cost_box_a"),
            box_cost_b = $("#zone_data").data("shipping_cost_box_b"),
            productSize = $("#product_size option:selected").text();

        if (productSize && productSize.toLowerCase().indexOf("gallon") < 0) {
            $("#shipping_label").html(box_cost_a + " to " + getStateName());
        }
        else {
            $("#shipping_label").html(box_cost_b + " to " + getStateName());
        }
    }
};

var stylizePaypal = function(){

    $(".paypal_code form img").css("margin-top", "150px");
    $(".paypal_code form table tr td:first").css("font-weight", "bold");
    $(".paypal_code form table tr td").css("font-size", "18px");
    $(".paypal_code form table tr td select").css("font-size", "18px");
    $(".paypal_code form table tr td select").parent().css("padding-top", "10px");
    $(".paypal_code form table").css("border", "0px none transparent");
    $(".paypal_code form table").css("margin-top", "20px");
    $(".paypal_code form table tr td select").addClass("form-control");
    $(".paypal_code form table tr td select").css("font-family", "verdana, arial, helvetica, sans-serif");
};

$(document).ready(function(){

    $("#product_size").change(function(event){
        productSelected($(this).val());
    });

    $("input[name='ship_pickup']").change(function(e){
        productSelected(null);
    });

    $("#orderSyrup").click(function(){
        $("#orderSyrupContainer").toggle();
    });

    productSelected(null);

    $('#orderSyrupContainer').hide();

    $.get("http://freegeoip.net/json/", function(response) {
        var ipAddress, regionName;
        if(response && response.ip){
            ipAddress = response.ip;
            regionName = response.region_name && response.region_name;
            $("#zone_data").data("geo_ip", response);
        }

        $.get("/zones.json", function(response) {
            var zones = response;
            $("#zone_data").data("zones", response);
            setShippingCostByState();
        });
    }, "json");

    $("#zip_code").on('input', function(){
        var val = $(this).val();

        if(val && val.length === 5){
            setShippingCostByZipCode(val);
        }
        else{
            var d = $("#zone_data").data("google_zip");
            if(d && d.length) {
                $("#zone_data").data("google_zip", '');
                setShippingCostByState();
            }
        }
    });




    stylizePaypal();
});
