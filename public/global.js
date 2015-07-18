var logo = document.getElementById('logo');
logo.addEventListener('click', goHome);

function goHome() {
    var req = new XMLHttpRequest();
    var navigation = document.getElementsByTagName('nav');
    req.open('get', '/home');
    req.send();
}