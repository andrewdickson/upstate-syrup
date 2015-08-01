function resizeAboutImage(screenWidth){
    if(screenWidth <= 820){
        var newWidth = screenWidth - 50;
        var newHeight = newWidth * .75;
        $('#about_image').css('width', newWidth);
        $('#about_image').css('height', newHeight);
    }
}

$(document).ready(function(event){
    resizeAboutImage($(window).width());
});