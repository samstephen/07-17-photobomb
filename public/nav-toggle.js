/**
 * Created by samuelstephen on 7/18/15.
 */
/**
 * Created by Samuel Stephen & Patrick Carlton on 7/17/15.
 */


/**
 * Created by samuelstephen on 7/13/15.
 */

// show nav
document.getElementsByTagName('nav')[0].style.display = 'block';

// hide nav
//document.getElementsByTagName('nav')[0].style.display = 'none';

var buttonNav = document.getElementById('nav');
buttonNav.addEventListener('click', toggle);

function toggle(){
    var navigation = document.getElementsByTagName('nav');
    if ( navigation[0].style.display != 'none') {
        navigation[0].style.display = 'none';
    } else {
        navigation[0].style.display = 'block';
    }
}













