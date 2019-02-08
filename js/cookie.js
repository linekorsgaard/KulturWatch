$(document).ready(function () {
    if (document.cookie.indexOf("CookieNotificationShown=true") < 0) {
        document.getElementById("cookieNotification").style.display = "block";

        document.getElementById("cookieNotificationClose").addEventListener("click", function () {
            document.getElementById("cookieNotification").style.display = "none";
            document.cookie = "CookieNotificationShown=true; expires=Fri, 31 Dec 9999 23:59:59 GMT; path=/";
        });
    }
});