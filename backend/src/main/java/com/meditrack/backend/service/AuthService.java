package com.meditrack.backend.service;

import com.meditrack.backend.dto.AuthRequestDto;
import com.meditrack.backend.dto.AuthResponseDto;
import com.meditrack.backend.model.User;
import com.meditrack.backend.repository.UserRepository;
import com.meditrack.backend.util.JwtUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final AuthenticationManager authenticationManager;
    private final UserRepository userRepository;
    private final JwtUtil jwtUtil;

    public AuthResponseDto authenticate(AuthRequestDto request) {
        // 1. Authenticate email and password
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(request.getEmail(), request.getPassword())
        );

        // 2. Find user in DB
        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));

        // 3. Generate JWT token
        String token = jwtUtil.generateToken(user.getEmail(), user.getRole().name());

        // 4. Return response
        return new AuthResponseDto(token, user.getEmail(), user.getRole().name());
    }
}
