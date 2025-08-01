package com.meditrack.backend.controller;

import com.meditrack.backend.dto.AuthRequestDto;
import com.meditrack.backend.dto.AuthResponseDto;
import com.meditrack.backend.dto.UserRequestDto;
import com.meditrack.backend.dto.UserResponseDto;
import com.meditrack.backend.model.User;
import com.meditrack.backend.service.AuthService;
import com.meditrack.backend.service.UserService;
import com.meditrack.backend.util.UserMapper;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;
    private final UserService userService;

    // POST /api/auth/login
    @PostMapping("/login")
    public ResponseEntity<AuthResponseDto> login(@RequestBody AuthRequestDto request) {
        AuthResponseDto response = authService.authenticate(request);
        return ResponseEntity.ok(response);
    }

    // POST /api/users/register
    @PostMapping("/register")
    public ResponseEntity<UserResponseDto> registerUser(@Valid @RequestBody UserRequestDto dto) {
        User user = UserMapper.toEntity(dto);
        user.setCreatedAt(LocalDateTime.now());
        User registered = userService.registerUser(user);
        return ResponseEntity.ok(UserMapper.toDto(registered));
    }
}
