document.getElementById('registerForm').addEventListener('submit', async (e) => {
    e.preventDefault();

    const user = {
        name: document.getElementById('name').value.trim(),
        email: document.getElementById('email').value.trim(),
        password: document.getElementById('password').value,
        phoneNumber: document.getElementById('phoneNumber').value.trim(),
        gender: document.getElementById('gender').value,
        dob: document.getElementById('dob').value, // format: yyyy-mm-dd
        role: 'PATIENT'  // Default role on register
    };

    try {
        const response = await fetch('http://localhost:8080/api/auth/register', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(user),
        });

        if (!response.ok) {
            const errorData = await response.json();
            throw new Error(errorData.message || 'Registration failed');
        }

        document.getElementById('successMsg').textContent = 'Registration successful! Redirecting to login...';
        document.getElementById('errorMsg').textContent = '';

        setTimeout(() => {
            window.location.href = 'login.html';
        }, 2000);
    } catch (error) {
        document.getElementById('errorMsg').textContent = error.message;
        document.getElementById('successMsg').textContent = '';
    }
});
