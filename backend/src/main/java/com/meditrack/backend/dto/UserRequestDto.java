package com.meditrack.backend.dto;

import jakarta.validation.constraints.*;
import lombok.Data;

import java.time.LocalDate;

@Data
public class UserRequestDto {

    @NotBlank
    private String username;

    @NotBlank
    private String name;

    @Email
    @NotBlank
    private String email;

    @NotBlank
    @Size(min = 8)
    private String password;

    @NotNull
    private String role;

    @NotBlank
    private String phoneNumber;

    @NotBlank
    private String gender;

    @Past
    @NotNull
    private LocalDate dob;
}
