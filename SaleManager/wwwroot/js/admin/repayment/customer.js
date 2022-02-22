$(document).ready(function () {
    // Init
    var table = $('#myTable').DataTable();

    var price = '';

    // Event
    var customerId = '';
    $('tr.hand').click(function () {
        customerId = $(this).find('span.customer-id').text();
        var formData = new FormData();
        formData.append('id', customerId);
        $.post("/admin/repayment/apiCustomerDetails", { 'id': customerId }, function (data, status) {
            var html = '';
            data.data.forEach(elm => {
                html += '<tr>';
                html += '<td><input class="form-check-input detail-check" type="checkbox"></td>';
                html += '<td><a href="/Admin/repayment/customerDetail?date=' + elm.createdAt.replace('/', '-').replace('/', '-') + '&customer=' + customerId + '">' + elm.createdAt + '</a></td>';
                html += '<td>' + parseInt(elm.ammount).toLocaleString() + '</td>';
                html += '<td>' + parseInt(elm.payment).toLocaleString() + '</td>';
                html += '<td>' + parseInt(elm.payBack).toLocaleString() + '</td>';
                html += '</tr>';
            });
            $('table#detail tbody').empty().append(html);
            $('div#detailModal').modal('show');
        });
    });

    $('button.btn-pay').click(function () {
        let checked = $('input.detail-check:checked');
        if (checked.length == 0) {
            alert('Hãy chọn ngày muốn thu hồi nợ !.','warning');
            return;
        }

        let arrDate = new Array();
        $(checked).each((idx, elm) => {
            arrDate.push($(elm).parent().parent().find('a').eq(0).text().replace('/', '-').replace('/', '-'));
        });

        var formData = new FormData();
        formData.append('id', customerId);
        formData.append('dates', arrDate);
        $.ajax({
            url: '/admin/repayment/apiCustomerPay',
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

    $('input:checkbox.detail-check-all').change(() => {
        $("input:checkbox.detail-check").prop('checked', $("input:checkbox.detail-check-all").is(':checked'));
    });

    // Ajax
    function GetDetaillsByDate(id) {
        event.preventDefault();
        var formData = new FormData();
        formData.append('id', id);
        $.ajax({
            type: "POST",
            url: "/admin/repayment/apiCustomerDetails",
            data: formData,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                $('table#detail').dataTable({
                    "ajax": result.data,
                    'paging': false,
                    'ordering': false,
                    'info': false,
                    'searching': false,
                });
                $('div#detailModal').modal('show');
            },
            failure: function (response) {
                console.log(response);
            },
            error: function (response) {
                console.log(response);
            }
        });
    }

    function getData(self) {
        event.preventDefault();
        var formData = new FormData();
        formData.append('id', $(self).find('span.customer-id'));
        $.ajax({
            type: "POST",
            url: "/admin/repayment/listData",
            data: formData,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                
            },
            failure: function (response) {
                alert(response);
            },
            error: function (response) {
                alert(response);
            }
        });
    }
});