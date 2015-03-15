

$(document).ready(function(){

    $('.file-upload').fileupload({

        url: '/reviews',
        dataType: 'script',
        disableImageResize: false,
        imageMaxHeight: 100,
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
                imageMaxHeight: 100} ,{
                action: "save"}
        ]
    });

});