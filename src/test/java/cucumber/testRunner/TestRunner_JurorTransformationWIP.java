package cucumber.testRunner;


import courgette.api.CourgetteOptions;
import courgette.api.CourgetteRunLevel;
import courgette.api.junit.Courgette;
import courgette.api.CourgetteTestOutput;
import courgette.api.CucumberOptions;
import org.junit.runner.RunWith;

@RunWith(Courgette.class)
@CourgetteOptions(
        threads = 1,
        runLevel = CourgetteRunLevel.FEATURE,
        rerunFailedScenarios = true,
		testOutput = CourgetteTestOutput.CONSOLE,
        cucumberOptions = @CucumberOptions(
                features = "src/test/resources/cucumber/features",
                tags = {
                		"@JurorTransformationWIP"
            		},
                plugin = {
                        "pretty",
                        "json:target/TestRunner_JurorTransformationWIP/cucumber.json"
                    },
        		glue = {
        				"cucumber.steps"
        			}
        ))
public class TestRunner_JurorTransformationWIP {
}
