document.getElementById('registerForm').addEventListener('submit', async (e) => {
    e.preventDefault();

    const rawDob = document.getElementById('dob').value;
    const formattedDob = new Date(rawDob).toISOString().split('T')[0];

    const user = {
        username: document.getElementById('username').value.trim(),
        name: document.getElementById('name').value.trim(),
        email: document.getElementById('email').value.trim(),
        password: document.getElementById('password').value,
        phoneNumber: document.getElementById('phoneNumber').value.trim(),
        gender: document.getElementById('gender').value,
        dob: formattedDob,
        role: 'PATIENT'
    };

    document.getElementById('errorMsg').textContent = `Sending payload: ${JSON.stringify(user, null, 2)}`;

    try {
        const response = await fetch('http://localhost:8080/api/auth/register', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(user),
        });

        const responseText = await response.text();

        document.getElementById('errorMsg').textContent = `Response: ${responseText}`;

        if (!response.ok) {
            throw new Error('Registration failed');
        }

        document.getElementById('successMsg').textContent = 'Registration successful! Redirecting to login...';

        setTimeout(() => {
            window.location.href = 'login.html';
        }, 2000);
    } catch (error) {
        document.getElementById('errorMsg').textContent += `\n\nError: ${error.message}`;
    }
});
