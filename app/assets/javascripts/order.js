

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

});
