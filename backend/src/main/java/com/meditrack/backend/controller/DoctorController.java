package com.meditrack.backend.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/doctor")
@PreAuthorize("hasRole('DOCTOR')")
@RequiredArgsConstructor
public class DoctorController {

    // Inject services like AppointmentService, PatientService, etc., as necessary
    // private final AppointmentService appointmentService;

    @GetMapping("/dashboard")
    public String doctorDashboard() {
        return "Welcome, Doctor! 🩺 You have access to doctor-only features.";
    }

    // Add more doctor-specific endpoints here
}
