package com.meditrack.backend.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/patient")
@PreAuthorize("hasRole('PATIENT')")
@RequiredArgsConstructor
public class PatientController {

    // Inject necessary services here (e.g., AppointmentService, DoctorService)
    // private final AppointmentService appointmentService;

    @GetMapping("/dashboard")
    public String patientDashboard() {
        return "Welcome, Patient! 🧑‍⚕️ You have access to patient features.";
    }

    // Add more patient-only endpoints here
}
