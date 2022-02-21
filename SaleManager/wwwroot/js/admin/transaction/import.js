$(document).ready(function () {

    //Event
    $('button.btn-import-csv').click(() => {
        $('#csv').trigger('click');
        
    });
    $('#csv').change(function () {
        $('button.btn-import-csv').removeClass('btn-outline-secondary').addClass('btn-success');
        if ($(this).val() != '' && $('#img').val() != '') $('button.btn-next').removeClass('hidden').addClass('show zoomer');
    });

    $('button.btn-import-img').click(() => {
        $('#img').trigger('click');
    });
    $('#img').change(function () {
        $('button.btn-import-img').removeClass('btn-outline-secondary').addClass('btn-success');
        if ($(this).val() != '' && $('#csv').val() != '') $('button.btn-next').removeClass('hidden').addClass('show zoomer');
    });

    $('button.btn-next').click(() => {

        var formData = new FormData();
        formData.append('csv', $("input.file").get(0).files[0]);
        formData.append('img', $("input.file").get(1).files[0]);

        $.ajax({
            url: '/admin/transaction/apiImportConfirm',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (result) {
                CreateTable(result);
                SetImage(result);
                $('div.main-input').removeClass('show').addClass('hidden');
                $('div.main-confirm').removeClass('hidden').addClass('show fadeIn');
                $('button.btn-register').addClass('zoomer');
            },
            error: function (error) {
                alert(error, 'danger');
            }
        });
    });

    $('button.btn-register').click(() => {

        var formData = new FormData();
        formData.append('csv', $("input.file").get(0).files[0]);
        formData.append('img', $("input.file").get(1).files[0]);

        $.ajax({
            url: '/admin/transaction/apiImport',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (result) {
                alert('Thêm hoá đơn thành công', 'success');
            },
            error: function (error) {
                alert(error,'danger');
            }
        });
    });

    //
    function CreateTable(data) {
        let html = '';
        data.data.forEach(async (elm, idx) => {
            html += '<tr>';
            html += '<th scope="row">' + (idx + 1) + '</th>'
            html += '<td>' + elm.name + '</td>'
            html += '<td>' + elm.quantity + '</td>'
            html += '<td>' + parseInt(elm.priceBuy).toLocaleString() + '</td>'
            html += '<td>' + parseInt(elm.price).toLocaleString() + '</td>'
            html += '</tr>';
        });
        $('table>tbody').append(html);
    }

    function SetImage(data) {
        $('img').attr('src', data.imgPath);
    }
});