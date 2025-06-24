package cucumber.testRunner;


import courgette.api.CourgetteOptions;
import courgette.api.CourgetteRunLevel;
import courgette.api.junit.Courgette;
import courgette.api.CourgetteTestOutput;
import courgette.api.CucumberOptions;
import org.junit.runner.RunWith;

@RunWith(Courgette.class)
@CourgetteOptions(
        reportTargetDir = "target/TestRunner_Regression",
        threads = 6,
        runLevel = CourgetteRunLevel.FEATURE,
        rerunFailedScenarios = true,
		testOutput = CourgetteTestOutput.CONSOLE,
        cucumberOptions = @CucumberOptions(
                features = "src/test/resources/cucumber/features",
                tags = {
                		"@Regression"
            		},
                plugin = {
                        "pretty",
                        "json:target/TestRunner_Regression/cucumber.json",
                        "html:target/TestRunner_Regression/cucumber.html"
                    },
        		glue = {
        				"cucumber.steps"
        			}
        ))
public class TestRunner_Regression {
}
