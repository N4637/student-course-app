package com.stack.studentcourseapp.controllers;

import com.stack.studentcourseapp.models.*;
import com.stack.studentcourseapp.repositories.CourseRepository;
import com.stack.studentcourseapp.repositories.StudentRepository;
import com.stack.studentcourseapp.services.UpdateService;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.core.Authentication;

@RestController
public class UpdateController {

    @Autowired
    private UpdateService updateService;

    @Autowired
    private StudentRepository sRepo;

    @Autowired
    private CourseRepository cRepo;

    @PostMapping("/api/enrolledCourses/add")
    public ResponseEntity<?> enroll(Authentication authentication, @RequestBody List<Course> courses) {
        String email = authentication.getName();
        Optional<Student> thisStudent = sRepo.findByEmail(email);
        if (thisStudent.isEmpty()) {
            return ResponseEntity.badRequest().body("Student not found");
        }
        Student student = thisStudent.get();


        updateService.addCourse(courses, student);
        sRepo.save(student);

        return ResponseEntity.ok(student.getEnrolledCourses());
    }

    @PostMapping("/api/enrolledCourses/drop")
    public ResponseEntity<?> drop(Authentication authentication, @RequestBody List<Course> courses) {
        String email = authentication.getName();
        Optional<Student> thisStudent = sRepo.findByEmail(email);
        if (thisStudent.isEmpty()) {
            return ResponseEntity.badRequest().body("Student not found");
        }
        Student student = thisStudent.get();

        List<Course> persistentCourses = courses.stream()
                .map(course -> cRepo.findByCourseCode(course.getCourseCode())
                        .orElseThrow(() -> new RuntimeException(
                                "Course not found with course code: " + course.getCourseCode())))
                .collect(Collectors.toList());

        updateService.dropCourse(persistentCourses, student);
        sRepo.save(student);

        return ResponseEntity.ok(student.getEnrolledCourses());
    }
}