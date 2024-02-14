package cucumber.testRunner.admin;


import courgette.api.CourgetteOptions;
import courgette.api.CourgetteTestOutput;
import courgette.api.CucumberOptions;
import courgette.api.CourgetteRunLevel;
import courgette.api.junit.Courgette;

import org.junit.runner.RunWith;

@RunWith(Courgette.class)
@CourgetteOptions(
        threads = 8,
        runLevel = CourgetteRunLevel.SCENARIO,
        rerunFailedScenarios = true,
		testOutput = CourgetteTestOutput.CONSOLE,
        cucumberOptions = @CucumberOptions(
                features = "src/test/resources/cucumber/features",
                tags = "@ADMIN_Features",
                plugin = {
                        "pretty",
                        "json:target/TestRunner_INT_Features_ADMIN/cucumber.json",
                        "html:target/TestRunner_INT_Features_ADMIN/cucumber.html"
                    },
        		glue = {
        				"cucumber.steps"
        			}
        ))
public class TestRunner_INT_Features_ADMIN {
}
