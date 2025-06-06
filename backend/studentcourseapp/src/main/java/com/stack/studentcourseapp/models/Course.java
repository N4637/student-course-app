package com.stack.studentcourseapp.models;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Column;
import jakarta.persistence.Table;
import java.util.List;

@Entity
@Table(name = "courses")
public class Course {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(nullable = false, unique = true)
    private String course_code;

    @Column(nullable = false)
    private long credits;

    @Column(nullable = false, unique = true)
    private String course_name;

    @ManyToMany(mappedBy = "enrolledCourses")
    private List<Student> enrolledStudents;

    public Course() {
    }

    public Course(String courseCode, String courseName, long credits) {
        this.course_code = courseCode;
        this.course_name = courseName;
        this.credits = credits;
    }
}
