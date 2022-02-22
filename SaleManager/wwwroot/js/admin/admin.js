$(document).ready(function () {

    $('#sidebarCollapse').on('click', function () {
        $('#sidebar').toggleClass('active');
    });

    $('.currency').each((idx, elm) => {
        let temp = $(elm).text();
        $(elm).text(parseInt(temp).toLocaleString());
    });

    // Action
    $('#sidebar').on('click', 'a.dropdown-toggle', () => {
        $('#' + (this).attr('aria-controls')).find('ul.collapse').css('display', 'block');
    });
});

// Write your JavaScript code.
function alert(messages, type) {
    var wrapper = document.createElement('div')
    wrapper.className = "bounceIn";
    if (Array.isArray(messages))
        wrapper.innerHTML = '<div class="alert alert-' + type + ' alert-dismissible" role="alert">' + messages.join('</br>') + '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>';
    else
        wrapper.innerHTML = '<div class="alert alert-' + type + ' alert-dismissible" role="alert">' + messages + '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>';

    document.getElementById('liveAlert').append(wrapper)
}