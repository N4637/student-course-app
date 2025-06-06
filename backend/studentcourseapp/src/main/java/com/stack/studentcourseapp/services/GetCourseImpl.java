package com.stack.studentcourseapp.services;

import java.util.List;
import com.stack.studentcourseapp.models.*;
import com.stack.studentcourseapp.repositories.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class GetCourseImpl implements GetCoursesService {

    @Override
    public List<Course> enrolledCourses(Student student) {
    
        List<Course> enrolledCourses = student.getEnrolledCourses();
        return enrolledCourses;
    }
}