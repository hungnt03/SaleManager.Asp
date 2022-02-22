$(document).ready(function () {

    // Event
    let supplierId = '';
    $('tr.hand').click(function () {
        supplierId = $(this).find('span.supplier-id').text();
        var formData = new FormData();
        formData.append('id', supplierId);
        $.post("/admin/repayment/apiSupplierDetail", { 'id': supplierId }, function (data, status) {
            var html = '';
            data.data.forEach(elm => {
                html += '<tr>';
                html += '<td><input class="form-check-input detail-check" type="checkbox"></td>';
                html += '<td><a href="/Admin/repayment/supplierDetail?date=' + elm.createdAt.replace('/', '-').replace('/', '-') + '&supplier=' + supplierId + '">' + elm.createdAt + '</a></td>';
                html += '<td>' + parseInt(elm.ammount).toLocaleString() + '</td>';
                html += '<td>' + parseInt(elm.payment).toLocaleString() + '</td>';
                html += '<td>' + parseInt(elm.payBack).toLocaleString() + '</td>';
                html += '</tr>';
            });
            $('table#detail tbody').empty().append(html);
            $('div#detailModal').modal('show');
        });
    });

    $('input:checkbox.detail-check-all').change(() => {
        $("input:checkbox.detail-check").prop('checked', $("input:checkbox.detail-check-all").is(':checked'));
    });

    $('button.btn-pay').click(function () {
        let checked = $('input.detail-check:checked');
        if (checked.length == 0) {
            alert('Hãy chọn ngày muốn trả nợ !.', 'warning');
            return;
        }

        let arrDate = new Array();
        $(checked).each((idx, elm) => {
            arrDate.push($(elm).parent().parent().find('a').eq(0).text().replace('/', '-').replace('/', '-'));
        });

        var formData = new FormData();
        formData.append('id', supplierId);
        formData.append('dates', arrDate);
        $.ajax({
            url: '/admin/repayment/apiSupplierPay',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (result) {
                alert('Giao dịch thành công !.', 'success');
                $('div#detailModal').modal('hide');
                setTimeout(window.location.reload(), 7000);
            },
            error: function (error) {
                alert(error, 'danger');
            }
        });
    });
});