package com.meditrack.backend.controller;

import com.meditrack.backend.dto.UserResponseDto;
import com.meditrack.backend.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/admin")
@PreAuthorize("hasRole('ADMIN')")
@RequiredArgsConstructor
public class AdminController {

    private final UserService userService;

    @GetMapping("/users")
    public List<UserResponseDto> getAllUsers() {
        // Assuming you have a method to convert User entities to UserResponseDto
        return userService.getAllUsers()
                .stream()
                .map(user -> new UserResponseDto(
                        user.getId(),
                        user.getUsername(),
                        user.getName(),
                        user.getEmail(),
                        user.getRole(),
                        user.getPhoneNumber(),
                        user.getGender(),
                        user.getDob(),
                        user.getCreatedAt()))
                .toList();
    }

    // Add more admin-only endpoints here -
    // For example, you might want to add methods for deleting users, updating roles, etc.
}
