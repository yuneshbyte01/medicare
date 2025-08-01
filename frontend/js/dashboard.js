document.addEventListener('DOMContentLoaded', () => {
    const token = localStorage.getItem('token');
    if (!token) {
        alert('Please login first.');
        window.location.href = '/pages/login.html';
        return;
    }

    // Decode token payload (optional) or fetch user info from the backend
    // Assuming your token subject is user email:
    const email = localStorage.getItem('email');
    const role = localStorage.getItem('role');
    const usernameElem = document.getElementById('username');
    const emailElem = document.getElementById('email');
    const roleElem = document.getElementById('role');

    usernameElem.textContent = email.split('@')[0]; // Simple username from email
    emailElem.textContent = email;
    roleElem.textContent = role;

    document.getElementById('logoutBtn').addEventListener('click', () => {
        localStorage.clear();
        window.location.href = '/pages/login.html';
    });
});
