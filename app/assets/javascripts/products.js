function setIndexEvents(){
    $('a.remove').click(function(event){
        var row = $(this).parent().parent();
        if (confirm("Are you sure you want to remove " + $(this).data('name') + '?')) {
            $.ajax({
                type: "POST",
                url: $(this).data('url'),
                dataType: "script",
                data: {"_method": "delete"},
                complete: function () {
                    setIndexEvents();
                }
            });
        }
        event.stopPropagation();
    });

    $('a.move').click(function(event){
        var a = $(this)
        var row = $(this).parent().parent();
        $.ajax({
            type: "POST",
            url: $(this).data('url'),
            dataType: "script",
            data: {"_method": "PUT"},
            complete: function (event) {
                setIndexEvents();
            }
        });
        event.stopPropagation();
    });

    $("tr[data-link]").click(function() {
        window.location = this.dataset.link;
    });
}


function setFileUpload(selector){

    var max_height = $('#product_form').data('max-height');
    var max_width = $('#product_form').data('max-width');

    $(selector).fileupload({

        url: $('#product_form').data('url'),
        dataType: 'script',
        disableImageResize: false,
        imageMaxWidth: max_width,
        imageMaxHeight: max_height,
        uploadTemplateId: null,
        downloadTemplateId: null,

        add: function(e,data){
            var current_data = $(this);
            data.process(function(){
                return current_data.fileupload('process',data);
            }).done(function(){
                data.submit();
            });

        },
        process: [{
            action: "load",
            fileTypes: /^image\/(gif|jp?g)$/,
            maxFileSize: 20000000},
            {action: "resize",
                imageMaxWidth: max_width,
                imageMaxHeight: max_height},{
                action: "save"}]

    });
}

var setPaypal = function(product){
    $(".product_container").hide();
    $("#product_container_" + product.id).show();


    $(".paypal_code").hide();
    var is_pickup = $("#pickup").is(':checked');
    var paypalCodeSelector = "#paypal_code_" + product.id + "_" + (is_pickup ? "pickup" : "ship");
    $(paypalCodeSelector).show()

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

    if($('.file-upload').length)
        setFileUpload('.file-upload');

    setIndexEvents();

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
