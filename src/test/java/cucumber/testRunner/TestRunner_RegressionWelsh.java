package cucumber.testRunner;


import courgette.api.CourgetteOptions;
import courgette.api.CourgetteRunLevel;
import courgette.api.junit.Courgette;
import courgette.api.CourgetteTestOutput;
import courgette.api.CucumberOptions;
import org.junit.runner.RunWith;

@RunWith(Courgette.class)
@CourgetteOptions(
        reportTargetDir = "target/TestRunner_RegressionWelsh",
        threads = 6,
        runLevel = CourgetteRunLevel.FEATURE,
        rerunFailedScenarios = true,
		testOutput = CourgetteTestOutput.CONSOLE,
        cucumberOptions = @CucumberOptions(
                features = "src/test/resources/cucumber/features",
                tags = {
                		"@RegressionWelsh"
            		},
                plugin = {
                        "pretty",
                        "json:target/TestRunner_RegressionWelsh/cucumber.json",
                        "html:target/TestRunner_RegressionWelsh/cucumber.html"
                    },
        		glue = {
        				"cucumber.steps"
        			}
        ))
public class TestRunner_RegressionWelsh {
}
