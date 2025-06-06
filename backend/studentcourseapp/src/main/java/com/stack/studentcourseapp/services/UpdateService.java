package com.stack.studentcourseapp.services;

import com.stack.studentcourseapp.models.*;
import java.util.List;
public interface UpdateService {
    void addCourse(List<Course> courses, Student student);
    void dropCourse(List<Course> courses, Student student);
}
