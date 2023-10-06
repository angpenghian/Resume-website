// Login Form
document.getElementById('loginForm').addEventListener('submit', function(e) {
    e.preventDefault();

    var username = document.getElementById('loginUsername').value;
    var password = document.getElementById('loginPassword').value;

    fetch('users.csv')
        .then(response => response.text())
        .then(data => {
            var users = data.trim().split('\n');
            var loginSuccessful = users.some(user => {
                var [userUsername, userPassword] = user.split(',');
                return userUsername === username && userPassword === password;
            });

            alert(loginSuccessful ? 'Login Successful' : 'Invalid Credentials');
        });
});

// Registration Form
document.getElementById('registrationForm').addEventListener('submit', function(e) {
    e.preventDefault();

    var username = document.getElementById('regUsername').value;
    var password = document.getElementById('regPassword').value;

    fetch('users.csv')
        .then(response => response.text())
        .then(data => {
            var users = data.trim().split('\n');
            var userExists = users.some(user => user.split(',')[0] === username);

            if(userExists) {
                alert('Username already exists.');
            } else {
                var newUser = username + ',' + password + '\n';
                var blob = new Blob([data.trim() + '\n' + newUser], { type: 'text/csv' });
                var link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                link.download = 'users.csv';
                link.click();
                alert('Registration successful. Please download the updated CSV file.');
            }
        });
});
