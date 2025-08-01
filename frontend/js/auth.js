document.getElementById('loginForm').addEventListener('submit', async (e) => {
    e.preventDefault();

    const email = document.getElementById('email').value.trim();
    const password = document.getElementById('password').value;

    try {
        const response = await fetch('http://localhost:8080/api/auth/login', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email, password }),
        });

        if (!response.ok) {
            const errorData = await response.json();
            throw new Error(errorData.message || 'Login failed');
        }

        const data = await response.json();

        // Save JWT and role to localStorage
        localStorage.setItem('token', data.token);
        localStorage.setItem('role', data.role);
        localStorage.setItem('email', data.email);

        // Redirect based on the role (relative paths assuming login.html is in /pages/)
        switch (data.role) {
            case 'ADMIN':
                window.location.href = '/pages/admin-dashboard.html';
                break;
            case 'DOCTOR':
                window.location.href = '/pages/doctor-dashboard.html';
                break;
            case 'PATIENT':
                window.location.href = '/pages/patient-dashboard.html';
                break;
            default:
                alert('Unknown user role');
        }

    } catch (error) {
        document.getElementById('errorMsg').textContent = error.message;
    }
});
