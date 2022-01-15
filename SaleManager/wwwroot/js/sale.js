(function ($) {
    'use strict'

    let table = $('#myTable').DataTable({
        'paging': false,
        'ordering': false,
        'info': false,
        'searching': false,
        'columnDefs': [
            {
                className: "textSmall",
                "targets": [0]
            },
        ]
    });

    GetPinProductAjax();

    var condition = $('input#condition');
    $('input#condition').change(function () {
        SearchAjax(condition);
    });

    $('#myTable').on('click', 'span.btn-up', function () {
        var parent = $(this).parent().parent().parent().parent();
        var quantity = parent.find('span.quantity');
        var priceInt = parseInt(parent.find('span.price').text().replace('.', ''));
        quantity.text(parseInt(quantity.text()) + 1);
        var amount = parent.find('span.amount');
        amount.text((priceInt * parseInt(quantity.text())).toLocaleString());
        GetTotal();
        CalcPayback();
    });

    $('#myTable').on('click', 'span.btn-down', function () {
        var parent = $(this).parent().parent().parent().parent();
        var quantity = parent.find('span.quantity');
        if (parseInt(quantity.text()) == 1) return;
        var priceInt = parseInt(parent.find('span.price').text().replace('.', ''));
        quantity.text(parseInt(quantity.text()) - 1);
        var amount = parent.find('span.amount');
        amount.text((priceInt * parseInt(quantity.text())).toLocaleString());
        GetTotal();
        CalcPayback();
    });

    $('input.payment').change(function () {
        CalcPayback();
    });

    $('#pinModal').on('click', 'button.add-to-list[data-bs-dismiss="modal"]', function () {
        var parentDom = $(this).parent().parent();
        var data = new Object();
        data.id = parentDom.find('span.pin-product-id').text();
        data.unit = parentDom.find('span.pin-product-unit').text();
        data.price = parentDom.find('span.pin-product-price').text();
        data.name = parentDom.find('span.pin-product-name').text();
        data.quantity = 1;
        tableAddRow(data);
        GetTotal();
        CalcPayback();
    });

    $('#searchModal').on('click', 'button.add-to-list[data-bs-dismiss="modal"]', function () {
        var parentDom = $(this).parent().parent();
        var data = new Object();
        data.id = parentDom.find('span.pin-product-id').text();
        data.unit = parentDom.find('span.pin-product-unit').text();
        data.price = parentDom.find('span.pin-product-price').text();
        data.name = parentDom.find('span.pin-product-name').text();
        data.quantity = 1;
        tableAddRow(data);
        GetTotal();
        CalcPayback();
    });

    $('#myTable').on('click', 'span.remove-product', function () {
        table.row($(this).parents('tr')).remove().draw();
        GetTotal();
        CalcPayback();
    });

    $('button.btn-pay').click(function () {
        if (table.data().length == 0) return false;
        if (parseInt($('div.payback').text()) < 0) {
            $('div#payModal').modal('show');
            return;
        }
        PayAjax(TableToJson(), $('input.payment').val(), $('div#payModal textarea.note').val());
    });

    $('button.btn-pay-with-note').click(function () {
        PayAjax(TableToJson(), $('input.payment').val(), $('div#payModal textarea.note').val());
        $('div#payModal').modal('hide');
    });

    $('btn.clear').click(function () {
        var dom = $('input#condition');
        dom.val('');
        dom.focus();
    });



    // Ajax
    function SearchAjax(dom) {
        event.preventDefault();
        var formData = new FormData();
        formData.append('condition', dom.val());

        $.ajax({
            url: '/sale/search',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (result) {
                if (result.data.length == 1) {
                    tableAddRow(result.data[0]);
                } else {
                    RenderModal(result, 'search-body');
                    $('#searchModal').modal('show');
                }
                dom.val('');
                dom.focus();
                GetTotal();
                CalcPayback();
            },
            error: function (errorMessage) {
                console.log(errorMessage);
            }
        });
    }

    function GetPinProductAjax() {

        $.ajax({
            url: '/sale/getPinProduct',
            type: 'POST',
            data: '',
            processData: false,
            contentType: false,
            success: function (result) {
                RenderModal(result, 'pin-body');
            },
            error: function (errorMessage) {
                console.log(errorMessage);
            }
        });
    }

    function PayAjax(orders, payment, note) {
        event.preventDefault();
        var formData = new FormData();
        for (var i = 0; i < orders.length; i++) {
            formData.append("orders[" + i + "].Id", orders[i].id);
            formData.append("orders[" + i + "].Quantity", orders[i].quantity);
        }
        formData.append('payment', payment);
        formData.append('note', note);

        $.ajax({
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            url: '/sale/pay',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (result) {
                alert('Tạo đơn hàng thành công!', 'success');
            },
            error: function (error) {
                if (error.status != 200) {
                    console.log('tao don hang - error' + error.responseText);
                    alert('Tạo đơn hàng thất bại!, vui lòng tạo lại.', 'danger');
                } else {
                    alert('Tạo đơn hàng thành công!', 'success');
                }
            }
        });
    }

    // Modify Table
    function tableAddRow(data) {
        // If existed data, process up quantity 1 unit
        var exitsElm = $('span.id[value="' + data['id'] + '"]');
        if (exitsElm.length > 0) {
            exitsElm.parent().parent().parent().find('span.btn-up').click();
            CalcPayback();
            return;
        }
        // If not existed data, add new row
        var row = table.row.add([
            '<div>' + (table.data().length + 1) + '<span class="id d-none" value="' + data['id'] + '">' + data['id'] + '</span></div>',
            '<span>' + data['name'] + '</span>',
            '<span class="price">' + parseInt(data['price']).toLocaleString() + '</span>',
            '<div class="d-flex flex-row"><span class = "quantity align-self-center w-30">' + data['quantity'] +
            '</span><div class="d-flex flex-column ml-1 p-0"><span class="m-0 p-0 font-small btn-up">▲</span><span class="m-0 p-0 font-small btn-down">▼</span></div></div>',
            '<span>' + data['unit'] + '</span>',
            '<span class="amount">' + parseInt(data['price']).toLocaleString() + '</span>',
            '<span class="remove-product"><i class="far fa-trash-alt"></i><div>'
        ]).draw();
        for (let idx = 0; idx < 7; idx++) {
            table.row(row).column(idx).nodes().to$().addClass('align-middle');
        }
        table.row(row).draw();
    }

    function GetTotal() {
        var doms = $('span.amount');
        var total = 0;
        doms.each(function (idx, dom) {
            total += parseInt($(dom).text().replace('.', ''));
        });
        $('span.total').text(total.toLocaleString());
    }

    function CalcPayback() {
        $('div.payback').text((parseInt($('input.payment').val()) - parseInt($('span.total').text().replace('.', ''))).toLocaleString());
    }

    function RenderModal(result, bodyClass) {
        if (result.data.length == 0) return;
        var baseHtml = '<div class="card m-1" style="width: 8rem;">' +
            '<img src="PRODUCT_IMAGE" class="card-img-top card-img-size">' +
            '<div class="card-body">' +
            '<h5 class="card-title text-center"><span class="pin-product-price">PRODUCT_PRICE</span></h5>' +
            '<p class="card-text text-center cut-text"><span class="pin-product-name">PRODUCT_NAME</span></p>' +
            '<div class="d-grid gap-2 col-12 mx-auto">' +
            '<button class="btn btn-sm btn-primary add-to-list" type="button" data-bs-dismiss="modal"><i class="fas fa-cart-plus"></i></button>' +
            '<span class="d-none pin-product-id">PRODUCT_ID</span>' +
            '<span class="d-none pin-product-unit">PRODUCT_UNIT</span>' +
            '</div></div></div>';
        var html = '';
        result.data.forEach(function (elm) {
            html += baseHtml.replace('PRODUCT_PRICE', elm['price'])
                .replace('PRODUCT_NAME', elm['name'])
                .replace('PRODUCT_IMAGE', elm['image'])
                .replace('PRODUCT_ID', elm['id'])
                .replace('PRODUCT_UNIT', elm['unit']);
        });
        $('div.' + bodyClass).empty();
        $('div.' + bodyClass).append(html);
    }

    function TableToJson() {
        var datas = new Array();
        $('table#myTable tbody tr').each(function () {
            datas.push({ id: parseInt($(this).find('span.id').text()), quantity: parseInt($(this).find('span.quantity').text()) });
        }).get();
        return datas;
    }
})(jQuery)
