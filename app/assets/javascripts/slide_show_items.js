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


$(document).ready(function(){

    var preview = $(".upload-preview img");

    $(".file").change(function(event){
        var input = $(event.currentTarget);
        var file = input[0].files[0];
        var reader = new FileReader();
        reader.onload = function(e){
            image_base64 = e.target.result;
            preview.attr("src", image_base64);
        };

        reader.readAsDataURL(file);
        var max_height = $('#slideshow_form').data('max-height');
        var max_width = $('#slideshow_form').data('max-width');
        var min_width = $('#slideshow_form').data('min-width');
        var min_height = $('#slideshow_form').data('min-height');


        $('img#test').css('max-height', max_height + 'px');
        $('img#test').css('max-width', max_width + 'px');
        $('img#test').css('min-height', min_height + 'px');
        $('img#test').css('min-width', min_width + 'px');
    });

    setIndexEvents();

});