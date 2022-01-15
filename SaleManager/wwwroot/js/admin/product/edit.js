
(function ($) {
    'use strict'

    $('input#formFile').change(function () {
        uploadFile('formFile');
    });

    function uploadFile(inputId) {
        event.preventDefault();
        var fileUpload = $("#" + inputId).get(0);
        var files = fileUpload.files;
        var formData = new FormData();
        formData.append('image', files[0]);
        formData.append('secret', $('input#Id').val() + $('input#Barcode').val());

        $.ajax({
            url: '/admin/product/uploader',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (result) {
                $('img.image-size').attr('src', '/' + result.data);
                $('input#ImageUrl').val(result.data);
            },
            error: function (errorMessage) {
                console.log(errorMessage);
            }
        });
    }
})(jQuery)
