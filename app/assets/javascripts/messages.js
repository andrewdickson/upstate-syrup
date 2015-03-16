$(document).ready(function(){
    $('.remove_message').click(function(event){
        var item_row = $(this).parent().parent();
        $.ajax({
            type: "POST",
            url: $(this).data('url'),
            dataType: "json",
            data: {"_method": "delete"},
            complete: function () {
                item_row.remove();
            }
        });
    });
});