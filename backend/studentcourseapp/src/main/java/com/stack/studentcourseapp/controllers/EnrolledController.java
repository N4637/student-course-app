package com.stack.studentcourseapp.controllers;

import com.stack.studentcourseapp.models.*;
import com.stack.studentcourseapp.repositories.CourseRepository;
import com.stack.studentcourseapp.repositories.StudentRepository;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.core.Authentication;

@RestController
public class EnrolledController {


    @Autowired
    private StudentRepository sRepo;

    @Autowired
    private CourseRepository cRepo;

    @GetMapping("/api/enrolledCourses")
    public ResponseEntity<?> getCourses(Authentication authentication) {
        String email = authentication.getName();
        Optional<Student> thisStudent = sRepo.findByEmail(email);
        Student student  = thisStudent.get();
        List<Course> courses = student.getEnrolledCourses();
        
        return ResponseEntity.ok(courses);
    }

    @GetMapping("/api/availableCourses")
    public ResponseEntity<?> availableCourses(Authentication authentication) {
        List<Course> courses = cRepo.findAll();
        return ResponseEntity.ok(courses);
    }
}
