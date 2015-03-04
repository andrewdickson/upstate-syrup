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
        $('img#test').css('max-height', '300px');
        $('img#test').css('max-width', '2000px');
    });

    setIndexEvents();

});