(function ($) {
    'use strict'
    $.noConflict();

    $.ajax({
        type: "POST",
        url: "/admin/repayment/listData",
        data: '{}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: OnSuccess,
        failure: function (response) {
            alert(response);
        },
        error: function (response) {
            alert(response);
        }
    });

    function OnSuccess(response) {
        var tableCustomer = $("#customer").DataTable({
            data: response.customers,
            'columns': [
                { 'data': '' },
                {
                    'data': 'customerName',
                    render: function (data, type, row, meta) {
                        return '<a href="/Admin/Repayment/CustomerDetails/' + row['customerId'] + '">' + data + '</a>';
                    }
                },
                { 'data': 'telephone' },
                {
                    'data': 'total',
                    render: function (data, type, row, meta) {
                        return parseInt(data).toLocaleString();
                    }
                },
            ],
            columnDefs: [{
                "defaultContent": "-",
                "targets": "_all"
            }],
            "order": [[1, 'asc']],
            "info": false
        });

        var tableSupplier = $("#supplier").DataTable({
            data: response.suppliers,
            'columns': [
                { 'data': '' },
                {
                    'data': 'SupplierName',
                    render: function (data, type, row, meta) {
                        return '<a href="/Admin/Repayment/SupplierDetails/' + row['supplierId'] + '">' + data + '</a>';
                    }
                },
                {
                    'data': 'EmployeeName',
                },
                {
                    'data': 'Telephone',
                },
                {
                    'data': 'total',
                    render: function (data, type, row, meta) {
                        return parseInt(data).toLocaleString();
                    }
                },
            ],
            columnDefs: [{
                "defaultContent": "-",
                "targets": "_all"
            }],
            "order": [[1, 'asc']],
            "info": false
        });

        tableCustomer.on('order.dt search.dt', function () {
            tableCustomer.column(0, { search: 'applied', order: 'applied' }).nodes().each(function (cell, i) {
                cell.innerHTML = i + 1;
            });
        }).draw();
        tableSupplier.on('order.dt search.dt', function () {
            tableSupplier.column(0, { search: 'applied', order: 'applied' }).nodes().each(function (cell, i) {
                cell.innerHTML = i + 1;
            });
        }).draw();
    };

    

})(jQuery)
