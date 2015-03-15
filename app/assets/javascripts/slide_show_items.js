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

    var max_height = $('#slideshow_form').data('max-height');
    var max_width = $('#slideshow_form').data('max-width');

    $(selector).fileupload({

        url: $('#slideshow_form').data('url'),
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
                imageMaxWidth: 1500,
                imageMaxHeight: 500},{
                action: "save"}]

    });
}

$(document).ready(function(){

    if($('.file-upload').length)
        setFileUpload('.file-upload');

    setIndexEvents();


    /*
     $('.file-upload').fileupload({

     url: $('#slideshow_form').data('url'),
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
     imageMaxWidth: 1500,
     imageMaxHeight: 500},{
     action: "save"}]

     });
     */
});