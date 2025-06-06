package com.stack.studentcourseapp.services;

import java.util.List;
import com.stack.studentcourseapp.models.*;
import com.stack.studentcourseapp.repositories.CourseRepository;
import com.stack.studentcourseapp.repositories.StudentRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UpdateImpl implements UpdateService {

    @Autowired
    private StudentRepository sRepo;

    @Autowired
    private CourseRepository cRepo;

    @Override
    @Transactional
    public void addCourse(List<Course> courses, Student student) {

        for (Course course : courses) {
            cRepo.save(course);
            student.getEnrolledCourses().add(course);
            course.getEnrolledStudents().add(student);
        }
        sRepo.save(student);
    }

    @Override
    @Transactional
    public void dropCourse(List<Course> courses, Student student) {
        for (Course course : courses) {
            cRepo.save(course);
            student.getEnrolledCourses().remove(course);
            course.getEnrolledStudents().remove(student);
        }
        
        sRepo.save(student);
    }
}
