package cucumber.testRunner.Database;

import io.cucumber.junit.Cucumber;
import org.junit.runner.RunWith;
import courgette.api.CourgetteTestOutput;
import courgette.api.CucumberOptions;

@RunWith(Cucumber.class)
@CucumberOptions(
		plugin = { 
			"pretty",
			"html:target/CaseStatusTests/html/",
			"json:target/CaseStatusTests/Regression.json"
		},		
		features = {"src/test/resources/cucumber/features"},		
		tags = {
				"@DB_GATEWAY_Basic"
			},
		glue = {
			"cucumber.steps"
		}
)

public class TestRunner_INT_Database {

}

