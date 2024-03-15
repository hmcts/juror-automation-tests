package cucumber.utils;

import cucumber.testdata.DBConnection;
import org.apache.log4j.Logger;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Objects;

public class DatabaseSetup {
    private static Logger log = Logger.getLogger(DatabaseSetup.class);

    public static void main(String[] args) {
        log.info("Database setup started");
        new DatabaseSetup();
        log.info("Database setup completed");
    }

    private DatabaseSetup() {
        DBConnection db = new DBConnection();
        String env_property = "test";
        try (Connection conn = db.getConnection(env_property)) {
            File dbDirectory = new File("src/test/resources/db");
            Arrays.stream(Objects.requireNonNull(dbDirectory.listFiles()))
                .sorted(Comparator.comparing(File::getName))
                .forEach(file -> {
                    System.out.println("Loading SQL file: " + file.getName());
                    log.info("Loading SQL file: " + file.getName());
                    try (Statement stmt = conn.createStatement()) {
                        executeDBScripts(file, stmt);
                    } catch (Exception e) {
                        throw new RuntimeException("Failed to connect to database", e);
                    }
                });
            conn.commit();
        } catch (Exception e) {
            throw new RuntimeException("Failed to connect to database", e);
        }
    }


    public void executeDBScripts(File file, Statement stmt) {
        StringBuilder sb = new StringBuilder();
        try {
            BufferedReader in = new BufferedReader(new FileReader(file));
            String str;

            while ((str = in.readLine()) != null) {
                sb.append(str);
            }
            in.close();

            stmt.executeUpdate(sb.toString());
        } catch (Exception e) {
            throw new RuntimeException("Failed to Execute" + file, e);
        }
    }
}
