package cucumber.testRunner;


import courgette.api.CourgetteOptions;
import courgette.api.CourgetteRunLevel;
import courgette.api.junit.Courgette;
import courgette.api.CourgetteTestOutput;
import courgette.api.CucumberOptions;
import org.junit.runner.RunWith;

@RunWith(Courgette.class)
@CourgetteOptions(
        reportTargetDir = "target/TestRunner_Expenses",
        threads = 5,
        runLevel = CourgetteRunLevel.SCENARIO,
        rerunFailedScenarios = false,
		testOutput = CourgetteTestOutput.CONSOLE,
        cucumberOptions = @CucumberOptions(
                features = "src/test/resources/cucumber/features",
                tags = {
                		"@expenses"
            		},
                plugin = {
                        "pretty",
                        "json:target/TestRunner_Expenses/cucumber.json",
                        "html:target/TestRunner_Expenses/cucumber.html"
                    },
        		glue = {
        				"cucumber.steps"
        			}
        ))
public class TestRunner_Expenses {
}
