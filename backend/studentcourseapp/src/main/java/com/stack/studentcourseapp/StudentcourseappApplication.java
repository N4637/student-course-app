package com.stack.studentcourseapp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class StudentcourseappApplication {

    public static void main(String[] args) {
        // Use environment variables passed from the OS or Docker
        String dbUrl = System.getenv("DB_URL");
        String dbUsername = System.getenv("DB_USERNAME");
        String dbPassword = System.getenv("DB_PASSWORD");

        // Optional: Set them as system properties if needed by Spring config
        System.setProperty("DB_URL", dbUrl != null ? dbUrl : "");
        System.setProperty("DB_USERNAME", dbUsername != null ? dbUsername : "");
        System.setProperty("DB_PASSWORD", dbPassword != null ? dbPassword : "");

        SpringApplication.run(StudentcourseappApplication.class, args);
    }
}
