
package com.tracknest.service;

import com.tracknest.dao.CustomerDAO;
import com.tracknest.model.Customer;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.SQLException;

public class CustomerService {

    private final CustomerDAO customerDAO;

    public CustomerService() {
        this.customerDAO = new CustomerDAO();
    }

    public String registerCustomer(
            String fullName,
            String email,
            String password,
            String confirmPassword) throws SQLException {

        // Validate empty fields
        if (fullName == null || email == null ||
                password == null || confirmPassword == null ||
                fullName.isBlank() || email.isBlank() ||
                password.isBlank() || confirmPassword.isBlank()) {

            return "All fields are required.";
        }

        // Validate name
        if (fullName.trim().length() < 2) {
            return "Full name must contain at least 2 characters.";
        }

        // Validate email format
        if (!email.trim().matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            return "Please enter a valid email address.";
        }

        // Validate password length
        if (password.length() < 8) {
            return "Password must contain at least 8 characters.";
        }

        // Confirm password
        if (!password.equals(confirmPassword)) {
            return "Passwords do not match.";
        }

        String normalizedEmail = email.trim().toLowerCase();

        // Check duplicate email
        if (customerDAO.emailExists(normalizedEmail)) {
            return "An account with this email already exists.";
        }

        // Hash password
        String passwordHash = BCrypt.hashpw(
                password,
                BCrypt.gensalt(12)
        );

        // Create customer object
        Customer customer = new Customer(
                fullName.trim(),
                normalizedEmail,
                passwordHash
        );

        // Save customer
        boolean registered = customerDAO.registerCustomer(customer);

        if (registered) {
            return "SUCCESS";
        }

        return "Registration failed. Please try again.";
    }
}
