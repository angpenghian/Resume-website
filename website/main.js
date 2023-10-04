document.addEventListener("DOMContentLoaded", function() {
    // Select all elements with class "tab-links" and "tab-contents"
    var tablinks = document.getElementsByClassName("tab-links");
    var tabcontents = document.getElementsByClassName("tab-contents");

    // Function to switch tabs. It is attached to the global window object to make it accessible from the HTML file
    window.opentab = function(tabname) {
        // Remove the "active-link" class from all tab links
        for (let tablink of tablinks) {
            tablink.classList.remove("active-link");
        }

        // Remove the "active-tab" class from all tab contents
        for (let tabcontent of tabcontents) {
            tabcontent.classList.remove("active-tab");
        }

        // Add the "active-link" class to the current tab link and the "active-tab" class to the current tab content
        event.currentTarget.classList.add("active-link");
        document.getElementById(tabname).classList.add("active-tab");
    }

    // Select the side menu element
    var sidemenu = document.getElementById("sidemenu");

    // Function to open the side menu. It is attached to the global window object to make it accessible from the HTML file
    window.openmenu = function() {
        sidemenu.style.right = "0";
    }

    // Function to close the side menu. It is attached to the global window object to make it accessible from the HTML file
    window.closemenu = function() {
        sidemenu.style.right = "-200px";
    }

    // Function to run when the window is scrolled
    window.onscroll = function () {
        scrollFunction();
    };

    function scrollFunction() {
        // Get the vertical position of the header
        var aboutOffset = document.getElementById("header").offsetTop;
        
        // If the scroll position is beyond the header, display the "Go to top" button, otherwise hide it
        if (window.pageYOffset > aboutOffset) {
            document.getElementById("topBtn").style.display = "block";
        } else {
            document.getElementById("topBtn").style.display = "none";
        }
    }

    // Function to scroll to the top of the page. It is attached to the global window object to make it accessible from the HTML file
    window.topFunction = function() {
        document.body.scrollTop = 0; // For Safari
        document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
    }

    // Function to copy the content of a code block to the clipboard. It is attached to the global window object to make it accessible from the HTML file
    window.copyCodeToClipboard = function(btn) {
        // Create a new textarea element and set its value to the text of the code block
        const el = document.createElement("textarea");
        const codeToCopy = btn.previousElementSibling.innerText;
        el.value = codeToCopy;

        // Add the textarea to the body, select its content, and copy it
        document.body.appendChild(el);
        el.select();
        document.execCommand("copy");

        // Remove the textarea from the body
        document.body.removeChild(el);
    }
});