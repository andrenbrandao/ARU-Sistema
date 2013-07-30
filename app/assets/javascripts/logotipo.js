function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#logo').attr('src', e.target.result);
        }

        reader.readAsDataURL(input.files[0]);
    }
}


$(function(){ 
    var input;

    var currentthumb_src = $('#logo').attr('src');

    $("#republica_logotipo").change(function(){
        input = this;

        setTimeout(function(){

            if($('.customfile-feedback').val() != "Logotipo da República...") {
                readURL(input);    
            }
            else {
                $('#logo').attr('src', currentthumb_src)
            }

        }, 10);

    });
});