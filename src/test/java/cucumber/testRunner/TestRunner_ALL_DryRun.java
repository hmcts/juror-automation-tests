package cucumber.testRunner;

import io.cucumber.junit.Cucumber;
import org.junit.runner.RunWith;
import courgette.api.CourgetteTestOutput;
import courgette.api.CucumberOptions;

@RunWith(Cucumber.class)
@CucumberOptions(
        		dryRun = true,
                features = "src/test/resources/cucumber/features",
                tags = {
                		"~@ATOL"
            		},
                plugin = {
                        "pretty",
                        "json:target/TestRunner_ALL_DryRun/cucumber.json",
                        "html:target/TestRunner_ALL_DryRun/cucumber.html"
                    },
        		glue = {
        				"cucumber.steps"
        			}
)
public class TestRunner_ALL_DryRun {

}
