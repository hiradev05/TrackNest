
package com.tracknest.service;

import com.tracknest.dao.CustomerDAO;
import com.tracknest.model.Customer;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.SQLException;

public class LoginService {

    private final CustomerDAO customerDAO;

    public LoginService() {
        this.customerDAO = new CustomerDAO();
    }

    public Customer authenticate(String email, String password)
            throws SQLException {

        if (email == null || email.isBlank()
                || password == null || password.isBlank()) {
            return null;
        }

        Customer customer = customerDAO.findByEmail(
                email.trim().toLowerCase()
        );

        if (customer == null) {
            return null;
        }

        if (BCrypt.checkpw(password, customer.getPasswordHash())) {
            return customer;
        }

        return null;
    }
}
