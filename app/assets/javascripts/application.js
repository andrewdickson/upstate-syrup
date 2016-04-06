// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require underscore
//= require gmaps/google
//= require jquery-fileupload
//= require jquery.raty


var ckedits;

function setCkEditors(){
    ckedits = [];
    $('.rte').each(function () {
        setCkEditor(this.id);
    });
}

function setCkEditor(id){
    var ckeditor = CKEDITOR.replace(id);
    ckeditor.textarea_id = id;
    ckedits.push(ckeditor);
    return ckeditor;
}

//info, warning, danger
function toast(message, urgency){
    if(urgency !=' info' && urgency!='danger' && urgency !='warning' && urgency!='success')
        urgency = 'info';

    $('#alerts').append("<div class='alert alert-" + urgency + " alert-dismissable' role='alert'>" +
        "<button type=button class='close' data-dismiss='alert' + aria-label='Close'>" +
        "<span aria-hidden='true'>&times;</span></button>" + message + "</div>");
}

function resizeHeader(width){
    if(width <= 400){
        $('.navbar-brand').css('font-size', '1.75em');
        $('.navbar-brand img').hide();
        $('.nav-pills li a').css('font-size', '1.25em');
    }


    if(width <= 750){
        $('#pills').css('padding-top', '0px');
        $('#pills').css('padding-bottom', '10px');
    }

}

$(document).ready(function(event){
    resizeHeader($(window).width());

    if($(window).width() >= 500){
        $('#paypal_content').css('margin-left', "65px");
    }

    $('.raty-view').raty({
        readOnly: true,
       score: function(){
           return $(this).data('score');
       }
    });

    $('.raty-edit').raty({
        scoreName: 'review[rating]',
        readOnly: false,
        required: true

    });
    $('.raty-edit').attr('required', true);


    $('#toggleReviewForm').click(function(event){
        $('#review_form').toggle();

        $('html, body').animate({
            scrollTop: $("#review_name").offset().top
        }, 0);
    });
    setCkEditors();


});