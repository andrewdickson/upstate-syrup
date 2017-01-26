function getParameterByName(name, url) {
    if (!url) {
        url = window.location.href;
    }
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}

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

    $('.filter_spam').click(function(event){
       var filter = {
           show_spam: $("#show_spam").is(":checked")
       };

        var url = "/messages?show_spam=" + (filter.show_spam ? "1" : "0");

        window.location.href = url;
        /*$.ajax({
            type: "POST",
            url: "/messages/filter.json",
            dataType: "json",
            success: function () {

            }
        });*/
   });

    if(getParameterByName('show_spam') == "1"){
        $("#show_spam").attr('checked','checked');
    }
});