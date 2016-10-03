/**
 * Created by eric on 02/10/16.
 */

var pleaseWait = $("#pleaseWaitDialog");
pleaseWait.modal();

var url_prefix = "http://" + document.location.hostname + ":8080";

$("#form_motion").submit(function (event) {
    var params = {
        base : parseInt($("#base").val()),
        shoulder : parseInt($("#shoulder").val()),
        elbow : parseInt($("#elbow").val()),
        wrist : parseInt($("#wrist").val()),
        hand : parseInt($("#hand").val())
    }

    $.ajax({
        url: url_prefix + $(this).attr("action") + $.param(params),
        method: $(this).attr("method"),
        beforeSend: function(){
            pleaseWait.modal('show');
        }
    }).always(function(){
        pleaseWait.modal('hide');
    });

    event.preventDefault();
});

$("#form_gripper").submit(function (event) {
    var opened = $("#gripper").val() == "ouverte";

    $.ajax({
        url: url_prefix + $(this).attr("action") + (opened ? "open" : "close"),
        method: $(this).attr("method"),
        beforeSend: function(){
            pleaseWait.modal('show');
        }
    }).always(function(){
        pleaseWait.modal('hide');
    });

    event.preventDefault();
});
