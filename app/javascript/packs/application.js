// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.


require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import '../stylesheets/application'
let jQuery = require("jquery");
// import jQuery from "jquery";
global.$ = jQuery;
import 'bootstrap';
import 'signature_pad';
import SignaturePad from "signature_pad";

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
const images = require.context('../images', true)
const imagePath = (name) => images(name, true)
function resizeCanvas(canvas) {
    var ratio =  Math.max(window.devicePixelRatio || 1, 1);
    canvas.width = canvas.offsetWidth * ratio;
    canvas.height = canvas.offsetHeight * ratio;
    canvas.getContext("2d").scale(ratio, ratio);
}

$(document).on('turbolinks:load', function() {
    var canvas = document.querySelector("canvas");
    if (canvas){
        canvas.height = canvas.offsetHeight;
        canvas.width = canvas.offsetWidth;
        window.onresize = resizeCanvas(canvas);
        resizeCanvas(canvas);
        let signature_pad;
        signature_pad = new SignaturePad(canvas);
        $('.signature_pad_clear').click(function() { signature_pad.clear() });
        $('.signature_pad_save').click(function(event) {
            if (signature_pad.isEmpty()){
                alert('You must sign to accept the Terms and Conditions');
                event.preventDefault();
            } else {
                $('.signature_pad_input').val(signature_pad.toDataURL());
            }
        });
    }
});
