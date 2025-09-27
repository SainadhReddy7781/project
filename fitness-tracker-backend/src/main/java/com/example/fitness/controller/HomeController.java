package com.example.fitness.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HomeController {

    @GetMapping("/")
    public String home() {
        return "Fitness Tracker Backend API is running! Visit /actuator/health for health check.";
    }

    @GetMapping("/api")
    public String api() {
        return "Fitness Tracker API Endpoints:\n" +
               "POST /api/users/register - Register new user\n" +
               "POST /api/users/login - Login user\n" +
               "GET /actuator/health - Health check";
    }
}

