(function ($) {
    'use strict'

    $('#myDataTable').DataTable();

    $.noConflict();
    $.ajax({
        type: "POST",
        url: "/admin/product/listData",
        data: '{}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: OnSuccess,
        failure: function (response) {
            alert(response.d);
        },
        error: function (response) {
            alert(response.d);
        }
    });

    function OnSuccess(response) {
        $("#example").DataTable({
            data: response.data,
            'columns': [
                {
                    'data': 'name',
                    render: function (data, type, row, meta) {
                        return '<a href="/Admin/Product/Edit/' + row['id'] + '">' + data + '</a>';
                    }
                },
                {
                    'data': 'price',
                    render: function (data, type, row, meta) {
                        return parseInt(data).toLocaleString();
                    }
                },
                { 'data': 'quantity' },
                { 'data': 'unit' },
                {
                    'data': 'expirationDate',
                    render: function (data, type, row, meta) {
                        return (new Date(data)).toISOString().slice(0, 10);
                    }
                },
                {
                    'data': 'disable',
                    'visible': false
                },
            ],
            columnDefs: [{
                "defaultContent": "-",
                "targets": "_all"
            }],
            rowCallback: function (row, data, index) {
                if (data['disable'] == true) {
                    $(row).css('background-color', 'rgb(112, 112, 112, 68%)');
                }
            },
            'order': [[5,'asc'],[0,'asc']]
        });
    };

    $('a.btn-import').click(function () {
        $('#csv').trigger('click');
    });
    $('input#csv').change(function () {
        uploadFile('csv');
    });

    function uploadFile(inputId) {
        event.preventDefault();
        var fileUpload = $("#" + inputId).get(0);
        var files = fileUpload.files;
        var formData = new FormData();
        formData.append('csv', files[0]);

        $.ajax({
            url: '/admin/product/import',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (result) {
                var view = '';
                var modal = $('div#myModal');
                view += '<p class="mx-auto lh-base text-warning"><strong>Những sản phẩm sau đây đã được đăng ký. Vui lòng xoá bỏ trong file import.csv và đăng lý lại.</strong></p>'
            },
            error: function (error) {
                var view = '';
                var modal = $('div#myModal');
                $('div.modal-body').empty();
                if (error.status == 409) {  
                    view += '<p class="mx-auto lh-base text-warning"><strong>Những sản phẩm sau đây đã được đăng ký. Vui lòng xoá bỏ trong file import.csv và đăng lý lại.</strong></p>'
                    view += '<table class="table"><thead><tr><th scope="col">#</th><th scope="col">Barcode</th><th scope="col">Tên sản phẩm</th></tr></thead><tbody>';
                    error.responseJSON.forEach(function (elm, idx) {
                        view += '<tr><th scope="row">' + (idx+1) + '</th><td>' + elm['barcode'] + '</td><td>' + elm['name'] + '</td></tr>';
                    });
                    view += '</tbody></table>';
                    $('div.modal-body').append(view);
                    modal.modal('show');
                } else if (error.status == 400) {
                    view += '<p class="mx-auto lh-base text-danger"><strong>Dữ liệu đăng ký của những sản phẩm sau đây có lỗi. Vui lòng sửa trong file import.csv và đăng lý lại.</strong></p>'
                    view += '<table class="table"><thead><tr><th scope="col">#</th><th scope="col">Barcode</th><th scope="col">Tên sản phẩm</th><th scope="col">Lỗi</th></tr></thead><tbody>';
                    error.responseJSON.forEach(function (elm, idx) {
                        view += '<tr><th scope="row">' + (idx+1) + '</th><td>' + elm['key'] + '</td><td>' + elm['subkey'] + '</td><td>' + elm['value'] + '</td></tr>';
                    });
                    view += '</tbody></table>';
                    $('div.modal-body').append(view);
                    modal.modal('show');
                } else {
                    view += '<p class="mx-auto lh-base text-danger"><strong>Có lỗi xảy ra, vui lòng liên hệ với quản trị viên.</strong></p>';
                    $('div.modal-body').append(view);
                    modal.modal('show');
                }
            }
        });
    }
})(jQuery)
