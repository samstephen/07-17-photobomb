/**
 * Created by Patmando73 on 7/16/15.
 */


//var users = $.getJSON("/view_users", function() {
//    users = users.responseJSON;
//});


document.getElementById("submitter").addEventListener("click", addUser);

function addUser(event) {
    // event.preventDefault();

    // creates variable containing the form
    var form = document.getElementById("add-user-form");

    // creates new XHR request
    var request = new XMLHttpRequest();

    // opens new POST request
    request.open("POST", "/save-user");

    // sends info from form (via FormData) to previously opened POST route
    request.responseType = "json";
    request.send(new FormData(form));

    request.addEventListener("load", function() {
        var confirm = this.response.email + " has been registered!";
        $("#confirm")[0].style.display = 'block';
        $("#confirm")[0].innerText = confirm;
    });
}
