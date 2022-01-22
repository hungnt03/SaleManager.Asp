$(document).ready(function () {
    // Init
    var table = $('#myTable').DataTable();

    var price = '';
    $('td.total').each(function () {
        price = $(this).text().replace('.00', '')
        $(this).empty().append(parseInt(price).toLocaleString());
    });

    // Event
    $('tr.hand').click(function () {
        alert('click');
        var id = $(this).find('span.customer-id');
        GetDetaillsByDate(id);
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