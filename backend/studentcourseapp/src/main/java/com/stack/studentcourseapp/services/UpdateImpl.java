package com.stack.studentcourseapp.services;

import java.util.List;
import com.stack.studentcourseapp.models.*;
import com.stack.studentcourseapp.repositories.CourseRepository;
import com.stack.studentcourseapp.repositories.StudentRepository;
import java.util.Optional;
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
            Course thisCourse = cRepo.findByCourseCode(course.getCourseCode())
                    .orElseThrow(() -> new RuntimeException("Course not found: " + course.getCourseCode()));

            if (!student.getEnrolledCourses().contains(thisCourse)) {
                student.getEnrolledCourses().add(thisCourse);
            }

            if (!thisCourse.getEnrolledStudents().contains(student)) {
                thisCourse.getEnrolledStudents().add(student);
            }
        }
        sRepo.save(student);
    }

    @Override
    public void dropCourse(List<Course> courses, Student student) {
        for (Course c : courses) {
            Optional<Course> course = cRepo.findByCourseCode(c.getCourseCode());
            Course thisCourse = course.get();
            
                thisCourse.getEnrolledStudents().remove(student);
                student.getEnrolledCourses().remove(thisCourse);
                cRepo.save(thisCourse);
            
        sRepo.save(student);
    }

    }
}