package com.meditrack.backend.dto;

import com.meditrack.backend.model.Role;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
public class UserResponseDto {

    private Long id;
    private String username;
    private String name;
    private String email;
    private Role role;
    private String phoneNumber;
    private String gender;
    private LocalDate dob;
    private LocalDateTime createdAt;
}
