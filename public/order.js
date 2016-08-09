

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
            if(!response || !response.results || !response.results.length || !response.results[0] || !response.results[0].formatted_address)
                return;

            var town = response.results[0].formatted_address;
            var comma_index = town.indexOf(",");
            var display = town.substr(0, comma_index + 3);

            $("#zone_data").data("google_zip", display);

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
        var state_name = $("#state_name_select").val();

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

var refreshShippingCost = function(){

    var is_pickup = $("#pickup").is(':checked');
    if(is_pickup){
        $("#shipping_label").html("Free");
        $("#shipping_label2").hide();
    }
    else {

        var box_cost_a = $("#zone_data").data("shipping_cost_box_a"),
            box_cost_b = $("#zone_data").data("shipping_cost_box_b"),
            productSize = $("#product_size option:selected").text();

        if (productSize && productSize.toLowerCase().indexOf("1 gallon") < 0) {
            $("#shipping_label").html(box_cost_a)
        }
        else {
            $("#shipping_label").html(box_cost_b);
        }

        $("#shipping_label2").show();

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
            $("#state_name_select").val(regionName)
        }

        $.get("/zones.json", function(response) {
            var zones = response;
            $("#zone_data").data("zones", response);
            setShippingCostByState();
        });
    }, "json");


    $("#state_name_select").change(function(){
        setShippingCostByState();
    });




    stylizePaypal();
});
