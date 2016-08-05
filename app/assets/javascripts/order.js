

var setPaypal = function(product){
    $(".product_container").hide();
    $("#product_container_" + product.id).show();


    $(".paypal_code").hide();
    var is_pickup = $("#pickup").is(':checked');
    var paypalCodeSelector = "#paypal_code_" + product.id + "_" + (is_pickup ? "pickup" : "ship");
    $(paypalCodeSelector).show();

    if(is_pickup){
        $("#shipping_label").html("Free");
    }
    else{
        $("#shipping_label").html(product.shipping_option);
    }

};
var productSelected = function(productId){
    var productId = productId || $("#product_size").val();

    $.ajax({
        type: "GET",
        url: "/products/" + productId,
        dataType: "json",
        success: function (product) {
            setPaypal(product);
        }
    });
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
    $(".paypal_code form img").css("margin-top", "150px");
    $(".paypal_code form table tr td:first").css("font-weight", "bold");
    $(".paypal_code form table tr td").css("font-size", "18px");
    $(".paypal_code form table tr td select").css("font-size", "18px");
    $(".paypal_code form table tr td select").parent().css("padding-top", "10px");
    $(".paypal_code form table").css("border", "0px none transparent");
    $(".paypal_code form table").css("margin-top", "20px");
    $(".paypal_code form table tr td select").addClass("form-control");
    $(".paypal_code form table tr td select").css("font-family", "verdana, arial, helvetica, sans-serif");

});
