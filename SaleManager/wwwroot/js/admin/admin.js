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
function alert(message, type) {
    var wrapper = document.createElement('div')
    wrapper.className = "bounceIn";
    wrapper.innerHTML = '<div class="alert alert-' + type + ' alert-dismissible" role="alert">' + message + '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>'

    document.getElementById('liveAlert').append(wrapper)
}