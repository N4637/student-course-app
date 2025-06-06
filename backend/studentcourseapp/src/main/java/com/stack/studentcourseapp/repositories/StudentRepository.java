package com.stack.studentcourseapp.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import com.stack.studentcourseapp.models.Student;
import java.util.Optional;

public interface StudentRepository extends JpaRepository<Student, Long> {
    Optional<Student> findByEmail(String email);
}
