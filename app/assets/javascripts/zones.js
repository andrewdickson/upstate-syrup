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

    $("tr[data-link]").click(function() {
        window.location = this.dataset.link;
    });
}

$(document).ready(function(){

    setIndexEvents();

});
