package cucumber.testRunner;


import courgette.api.CourgetteOptions;
import courgette.api.CourgetteRunLevel;
import courgette.api.junit.Courgette;
import courgette.api.CourgetteTestOutput;
import courgette.api.CucumberOptions;
import org.junit.runner.RunWith;

@RunWith(Courgette.class)
@CourgetteOptions(
        reportTargetDir = "target/TestRunner_JurorTransformation",
        threads = 1,
        runLevel = CourgetteRunLevel.SCENARIO,
        rerunFailedScenarios = true,
		testOutput = CourgetteTestOutput.CONSOLE,
        cucumberOptions = @CucumberOptions(
                features = "src/test/resources/cucumber/features",
                tags = {
                		"@JurorTransformation"
            		},
                plugin = {
                        "pretty",
                        "json:target/TestRunner_JurorTransformation/cucumber.json",
                        "html:target/TestRunner_JurorTransformation/cucumber.html"
                    },
        		glue = {
        				"cucumber.steps"
        			}
        ))
public class TestRunner_JurorTransformation {
}
