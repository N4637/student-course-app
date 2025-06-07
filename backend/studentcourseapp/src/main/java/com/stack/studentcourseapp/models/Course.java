package com.stack.studentcourseapp.models;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Column;
import jakarta.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "courses")
public class Course {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name = "course_code", nullable = false, unique = true)
    @JsonProperty("course_code")
    private String courseCode;

    @Column(nullable = false)
    private long credits;

    @Column(name = "course_name", nullable = false, unique = true)
    @JsonProperty("course_name")
    private String courseName;

    @ManyToMany(mappedBy = "enrolledCourses")
    @JsonIgnore
    private List<Student> enrolledStudents = new ArrayList<>();

    public Course() {
    }

    public Course(String courseCode, String courseName, long credits) {
        this.courseCode = courseCode;
        this.courseName = courseName;
        this.credits = credits;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getCourseCode() {
        return courseCode;
    }

    public void setCourseCode(String courseCode) {
        this.courseCode = courseCode;
    }

    public long getCredits() {
        return credits;
    }

    public void setCredits(long credits) {
        this.credits = credits;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public List<Student> getEnrolledStudents() {
        return enrolledStudents;
    }

    public void setEnrolledStudents(List<Student> enrolledStudents) {
        this.enrolledStudents = enrolledStudents;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Course)) return false;

        Course course = (Course) o;
        return courseCode != null ? courseCode.equals(course.courseCode) : course.courseCode == null;
    }

    @Override
    public int hashCode() {
        return courseCode != null ? courseCode.hashCode() : 0;
    }
}