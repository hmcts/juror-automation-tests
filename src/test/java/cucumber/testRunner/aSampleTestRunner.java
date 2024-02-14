package cucumber.testRunner;

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
				"@ostest"
			},
		glue = {
			"cucumber.steps"
		}
)

public class aSampleTestRunner {

}

