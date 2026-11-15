
package com.tracknest.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    private static final String URL =
            System.getenv("TRACKNEST_DB_URL");

    private static final String USER =
            System.getenv("TRACKNEST_DB_USER");

    private static final String PASSWORD =
            System.getenv("TRACKNEST_DB_PASSWORD");

    public static Connection getConnection() throws SQLException {
        if (URL == null || USER == null || PASSWORD == null) {
            throw new SQLException(
                    "Database environment variables are not configured."
            );
        }
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("SQL Server JDBC Driver could not be loaded.", e);
        }

        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
