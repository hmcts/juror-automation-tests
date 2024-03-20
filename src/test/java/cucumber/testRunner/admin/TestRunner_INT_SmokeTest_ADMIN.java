package cucumber.testRunner.admin;


import courgette.api.CourgetteOptions;
import courgette.api.CourgetteRunLevel;
import courgette.api.junit.Courgette;
import courgette.api.CourgetteTestOutput;
import courgette.api.CucumberOptions;
import org.junit.runner.RunWith;

@RunWith(Courgette.class)
@CourgetteOptions(
        threads = 5,
        runLevel = CourgetteRunLevel.SCENARIO,
        rerunFailedScenarios = false,
		testOutput = CourgetteTestOutput.CONSOLE,
        cucumberOptions = @CucumberOptions(
                features = "src/test/resources/cucumber/features",
                tags = {
                		"@SmokeTest_INT_Admin"
            		},
                plugin = {
                        "pretty",
                        "json:target/TestRunner_INT_SmokeTest_Admin/cucumber.json",
                        "html:target/TestRunner_INT_SmokeTest_Admin/cucumber.html"
                    },
        		glue = {
        				"cucumber.steps"
        			}
        ))
public class TestRunner_INT_SmokeTest_ADMIN {
}
