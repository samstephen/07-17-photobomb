function goHome() {
    window.location.replace("/home");
}
var logo = document.getElementById('logo');
logo.addEventListener('click', goHome);

function showModal(event) {
    event.preventDefault();
    document.getElementById('add-user-form').style.visibility = 'visible';
}

var link = document.getElementById('add-user-link');
link.addEventListener('click', showModal);

function hideModal() {
    document.getElementById('add-user-form').style.visibility = 'hidden';
}

var close = document.getElementById('close');
close.addEventListener('click', hideModal);