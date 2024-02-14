package cucumber.testRunner;


import courgette.api.CourgetteOptions;
import courgette.api.CourgetteRunLevel;
import courgette.api.CourgetteTestOutput;
import courgette.api.CucumberOptions;
import courgette.api.junit.Courgette;
import org.junit.runner.RunWith;

@RunWith(Courgette.class)
@CourgetteOptions(
        threads = 6,
        runLevel = CourgetteRunLevel.SCENARIO,
        rerunFailedScenarios = true,
		testOutput = CourgetteTestOutput.CONSOLE,
        cucumberOptions = @CucumberOptions(
                features = "src/test/resources/cucumber/features",
                tags = {
                		"@NewSchemaConverted"
            		},
                plugin = {
                        "pretty",
                        "json:target/TestRunner_NewSchemaConverted/cucumber.json"
                    },
        		glue = {
        				"cucumber.steps"
        			}
        ))
public class TestRunner_NewSchemaConverted {
}
