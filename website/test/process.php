<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'];
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Validate input
    if (empty($username) || empty($password)) {
        echo 'Username and password are required.';
        exit;
    }

    // Determine action: login or register
    if ($action === 'login') {
        // Check credentials
        $file = fopen('users.csv', 'r');
        while (($row = fgetcsv($file)) !== FALSE) {
            if ($row[0] === $username && $row[1] === $password) {
                echo 'Login successful.';
                fclose($file);
                exit;
            }
        }
        fclose($file);
        echo 'Invalid credentials.';
    } elseif ($action === 'register') {
        // Check if username already exists
        $file = fopen('users.csv', 'r');
        while (($row = fgetcsv($file)) !== FALSE) {
            if ($row[0] === $username) {
                echo 'Username already exists.';
                fclose($file);
                exit;
            }
        }
        fclose($file);

        // Append new user to CSV
        $file = fopen('users.csv', 'a');
        fputcsv($file, array($username, $password));
        fclose($file);
        echo 'Registration successful.';
    } else {
        echo 'Invalid action.';
    }
}
?>