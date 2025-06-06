package com.stack.studentcourseapp.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.ArrayList;

@Component
public class JwtFilter extends OncePerRequestFilter {

    @Autowired
    private JwtUtil jwtUtil;

    @Override
    protected void doFilterInternal(HttpServletRequest request,
            HttpServletResponse response,
            FilterChain filterChain)
            throws ServletException, IOException {
        String path = request.getServletPath();
        System.out.println("Incoming request path: " + path); // ✅ Log 1

        if (path.startsWith("/api/auth/")) {
            System.out.println("Skipping auth for path: " + path); // ✅ Log 2
            filterChain.doFilter(request, response);
            return;
        }

        String authHeader = request.getHeader("Authorization");
        System.out.println("Authorization Header: " + authHeader); // ✅ Log 3

        String token = null;
        String email = null;

        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            token = authHeader.substring(7);
            try {
                email = jwtUtil.extractUsername(token);
                System.out.println("Extracted email from token: " + email); // ✅ Log 4
            } catch (Exception e) {
                System.out.println("Error extracting username from token: " + e.getMessage()); // ✅ Log 5
            }
        }

        if (email != null && SecurityContextHolder.getContext().getAuthentication() == null) {
            boolean isValid = jwtUtil.validateToken(token, email);
            System.out.println("Is token valid? " + isValid); // ✅ Log 6

            if (isValid) {
                UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(email, null,
                        new ArrayList<>());
                authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                SecurityContextHolder.getContext().setAuthentication(authToken);
                System.out.println("Authentication context set for: " + email); // ✅ Log 7
            }
        }

        System.out.println("SecurityContext: " + SecurityContextHolder.getContext().getAuthentication()); // ✅ Log 8

        filterChain.doFilter(request, response);
    }
}
