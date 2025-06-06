package com.stack.studentcourseapp.services;

import com.stack.studentcourseapp.models.*;
import java.util.List;

public interface  GetCoursesService {
    List<Course> enrolledCourses(Student student);
}
