package com.stack.studentcourseapp.services;

import com.stack.studentcourseapp.model.Student;
import com.stack.studentcourseapp.security.JwtUtil;
import com.stack.studentcourseapp.repositories.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class AuthServiceImpl implements AuthService {

    @Autowired
    private StudentRepository sRepo;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private BCryptPasswordEncoder passEncoder;

    @Override
    public String register(Student student) {
        
        if(student.getEmail() == null || student.getPassword() == null) {
            throw new RuntimeException("Email and password are required");
        }

        Optional<Student> existingStudent = sRepo.findByEmail(student.getEmail());
        if(existingStudent.isPresent()){
            throw new RuntimeException("Email already registered");
        }

        
        student.setPassword(passEncoder.encode(student.getPassword()));

        Student savedStudent = sRepo.save(student);

        return jwtUtil.generateToken(savedStudent.getEmail());
    }

    @Override
    public String login(String email, String password) {
       
        if(email == null || password == null) {
            throw new RuntimeException("Email and password are required");
        }

        Optional <Student> thisStudent = sRepo.findByEmail(email);
        if(!thisStudent.isPresent()){
            throw new RuntimeException("user does not exist");
        }

        Student student = thisStudent.get();
        
        if(!passEncoder.matches(password, student.getPassword())) {
            throw new RuntimeException("Invalid credentials");
        }


        return jwtUtil.generateToken(student.getEmail());
    }
}
