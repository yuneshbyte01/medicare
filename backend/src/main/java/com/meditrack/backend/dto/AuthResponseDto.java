package com.meditrack.backend.dto;

import lombok.Data;
import lombok.AllArgsConstructor;

@Data
@AllArgsConstructor
public class AuthResponseDto {
    private String token;
    private String email;
    private String role;
}
