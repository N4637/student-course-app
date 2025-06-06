package com.stack.studentcourseapp.services;

import com.stack.studentcourseapp.models.Student;

public interface AuthService {
    String register(Student student);
    String login(String email , String password);
}
