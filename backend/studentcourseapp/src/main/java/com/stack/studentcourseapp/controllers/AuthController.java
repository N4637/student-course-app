package com.stack.studentcourseapp.controllers;

import com.stack.studentcourseapp.dto.*;
import com.stack.studentcourseapp.models.Student;
import com.stack.studentcourseapp.services.AuthService;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.Map;

@RestController
public class AuthController {


    @Autowired
    private AuthService studentService;

    @PostMapping("/api/auth/register")
    public ResponseEntity<?> register(@RequestBody RegisterRequest request) {
        System.out.println("Register endpoint hit");
    try {
        Student student = new Student();
        student.setEmail(request.getEmail());
        student.setPassword(request.getPassword());
        student.setName(request.getName());

        String token = studentService.register(student);
        return ResponseEntity.ok(new JwtResponse(token));  
    } catch (Exception e) {
        return ResponseEntity.badRequest().body(Map.of("message", e.getMessage()));
    }
}

    @PostMapping("/api/auth/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest loginRequest) {
        try {
            String token = studentService.login(loginRequest.getEmail(), loginRequest.getPassword());
            return ResponseEntity.ok(new JwtResponse(token));
        } catch (Exception e) {
            return ResponseEntity.status(401).body(Map.of("message", e.getMessage()));
        }
    }

    @GetMapping("/api/auth/validate")
    public ResponseEntity<?> validate(HttpServletRequest request){
         return ResponseEntity.ok("Valid token");
    }
}
