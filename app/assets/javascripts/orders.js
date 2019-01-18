/*
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
*/

$( document ).ready(function() {


    $('#discount').click(function(event) {
        event.preventDefault();
        $.ajax({
            type: "GET",
            url: "/orders/new",
            dataType: 'json',
            success:function(ajax_responce){
                $('#discount').html(ajax_responce.data)
            }
        })
    });



});
