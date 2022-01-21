(function ($) {
    'use strict'

    var price = '';
    //setTimeout(, 1000);
    $('td.total').each(function () {
        alert($(this).text());
        price = $(this).text().replace('.00', '')
        $(this).empty().append(parseInt(price).toLocaleString());
    })
});