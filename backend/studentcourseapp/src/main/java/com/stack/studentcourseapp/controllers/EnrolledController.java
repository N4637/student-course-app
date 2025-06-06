package com.stack.studentcourseapp.controllers;

import com.stack.studentcourseapp.models.*;
import com.stack.studentcourseapp.repositories.StudentRepository;
import com.stack.studentcourseapp.services.GetCoursesService;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.core.Authentication;

@RestController
public class EnrolledController {

    @Autowired
    private GetCoursesService coursesService;

    @Autowired
    private StudentRepository sRepo;

    @PostMapping("/api/enrolledCourses")
    public ResponseEntity<?> getCourses(Authentication authentication) {
        String email = authentication.getName();
        Optional<Student> thisStudent = sRepo.findByEmail(email);
        Student student  = thisStudent.get();
        List<Course> courses = coursesService.enrolledCourses(student);
        
        return ResponseEntity.ok(courses);
    }
}
