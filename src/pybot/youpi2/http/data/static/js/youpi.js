/**
 * Created by eric on 02/10/16.
 */

var pleaseWait = $("#please_wait_dlg");
pleaseWait.modal();

var errorModal = $("#error_dlg")
var errorMsg = $("#error_msg");
errorModal.modal();

function error_message(msg) {
    errorMsg.text(msg);
    errorModal.modal('show');
}

var url_prefix = "http://" + document.location.hostname + ":8080";

var form_motion = $("#form_motion");
var motion_action = form_motion.attr('action');

$.getJSON(url_prefix + motion_action, function(data){
    $("#base").val(Math.round(data.base));
    $("#shoulder").val(Math.round(data.shoulder));
    $("#elbow").val(Math.round(data.elbow));
    $("#wrist").val(Math.round(data.wrist));
    $("#hand").val(Math.round(data.hand));
});

form_motion.submit(function (event) {
    var params = {
        base : parseInt($("#base").val()),
        shoulder : parseInt($("#shoulder").val()),
        elbow : parseInt($("#elbow").val()),
        wrist : parseInt($("#wrist").val()),
        hand : parseInt($("#hand").val())
    }

    $.ajax({
        url: url_prefix + motion_action + $.param(params),
        method: $(this).attr("method"),
        beforeSend: function(){
            pleaseWait.modal('show');
        }
    }).always(function(){
        pleaseWait.modal('hide');
    });

    event.preventDefault();
});

var form_ik = $("#form_ik");
var ik_action = form_ik.attr('action');
var xyz_action = $("#action-xyz").val();

$.getJSON(url_prefix + xyz_action, function(data){
    $("#x").val(Math.round(data.x));
    $("#y").val(Math.round(data.y));
    $("#z").val(Math.round(data.z));
});

form_ik.submit(function (event) {
    var params = {
        x : parseInt($("#x").val()),
        y : parseInt($("#y").val()),
        z : parseInt($("#z").val()),
        pitch : 90,
    }

    $.ajax({
        url: url_prefix + ik_action + $.param(params),
        method: $(this).attr("method"),
        beforeSend: function () {
            pleaseWait.modal('show');
        }
    }).fail(function(jqXHR, textStatus, errorThrown){
        var msg = jqXHR.responseText;
        if (msg.startsWith('mechanical limit')) {
            var joint = msg.split(/[()]/)[1];
            switch (joint) {
                case "shoulder":
                    joint = "épaule";
                    break;
                case "elbow":
                    joint = "coude";
                    break;
                case "wrist":
                    joint = "poignet";
                    break;
            }
            msg = "Mouvement impossible : limite mécanique atteinte (" + joint + ").";
        } else if (msg.startsWith('out of reach')) {
            msg = "Position hors d'atteinte du bras."
        }
        error_message(msg);

    }).always(function(){
        pleaseWait.modal('hide');
    });

    event.preventDefault();
});

var form_gripper = $("#form_gripper");
var gripper_action = form_gripper.attr('action');

$.getJSON(url_prefix + gripper_action, function(data){
    $("#gripper").val(data.closed ? "fermée" : "ouverte");
});


form_gripper.submit(function (event) {
    var opened = $("#gripper").val() == "ouverte";

    $.ajax({
        url: url_prefix + gripper_action + (opened ? "/open" : "/close"),
        method: $(this).attr("method"),
        beforeSend: function(){
            pleaseWait.modal('show');
        }
    }).always(function(){
        pleaseWait.modal('hide');
    });

    event.preventDefault();
});
