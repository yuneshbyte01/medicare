package com.meditrack.backend.util;

import com.meditrack.backend.dto.UserRequestDto;
import com.meditrack.backend.dto.UserResponseDto;
import com.meditrack.backend.model.Role;
import com.meditrack.backend.model.User;

public class UserMapper {
    public static User toEntity(UserRequestDto dto) {
        User user = new User();
        user.setUsername(dto.getUsername());
        user.setName(dto.getName());
        user.setEmail(dto.getEmail());
        user.setPassword(dto.getPassword());
        try {
            user.setRole(dto.getRole() != null ?
                    Role.valueOf(dto.getRole().toUpperCase()) :
                    Role.PATIENT);
        } catch (IllegalArgumentException e) {
            user.setRole(Role.PATIENT);
        }

        user.setPhoneNumber(dto.getPhoneNumber());
        user.setGender(dto.getGender());
        user.setDob(dto.getDob());
        return user;
    }

    public static UserResponseDto toDto(User user) {
        UserResponseDto dto = new UserResponseDto(user.getId(), user.getUsername(), user.getName(), user.getEmail(), user.getRole(), user.getPhoneNumber(), user.getGender(), user.getDob(), user.getCreatedAt());
        dto.setId(user.getId());
        dto.setUsername(user.getUsername());
        dto.setName(user.getName());
        dto.setEmail(user.getEmail());
        dto.setRole(user.getRole());
        dto.setPhoneNumber(user.getPhoneNumber());
        dto.setGender(user.getGender());
        dto.setDob(user.getDob());
        dto.setCreatedAt(user.getCreatedAt());
        return dto;
    }
}

