package cucumber.steps;

import io.cucumber.java.en.*;
import io.cucumber.java.PendingException;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.Before;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import cucumber.pageObjects.*;
import cucumber.testdata.DatabaseTester;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.PageFactory;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static org.junit.Assert.*;

public class StepDef_summoningprogress {
    private final WebDriver webDriver;
    private final PoolSummoningProgress POOL_SUMMONING_PROGRESS;
    private final DatabaseTester DBT;
    private final aSamplePO SPO;
    private final Login LGN;
    private final NavigationShared NAV;
    private final ScreenShotTaker SST;
    private final PoolRequests POOL_REQUESTS_PAGE;
    private final ActivePools ACTIVE_POOLS_PAGE;
    private final CheckPoolRequest CHECK_POOL_REQUEST_PAGE;
    private final PoolOverview POOL_OVERVIEW_PAGE;
    private final JurorRecordSearch JUROR_RECORD_SEARCH;
    private final SummonsReply SUMMONS_REPLY;
    private final PoolSearch POOL_SEARCH;
    private final ViewSummonsReply VIEW_SUMMONS_REPLY;
    private final Header HEADER_PAGE;

    public StepDef_summoningprogress(PoolSummoningProgress poolSummoningProgress, SharedDriver webDriver, DatabaseTester dbt){
        POOL_SUMMONING_PROGRESS = poolSummoningProgress;
        this.webDriver = webDriver;
        DBT = dbt;
        SPO = PageFactory.initElements(webDriver, aSamplePO.class);
        LGN = PageFactory.initElements(webDriver, Login.class);
        NAV = PageFactory.initElements(webDriver, NavigationShared.class);
        SST = PageFactory.initElements(webDriver, ScreenShotTaker.class);
        POOL_REQUESTS_PAGE = PageFactory.initElements(webDriver, PoolRequests.class);
        ACTIVE_POOLS_PAGE = PageFactory.initElements(webDriver, ActivePools.class);
        CHECK_POOL_REQUEST_PAGE = PageFactory.initElements(webDriver, CheckPoolRequest.class);
        POOL_OVERVIEW_PAGE = PageFactory.initElements(webDriver, PoolOverview.class);
        JUROR_RECORD_SEARCH = PageFactory.initElements(webDriver, JurorRecordSearch.class);
        SUMMONS_REPLY = PageFactory.initElements(webDriver, SummonsReply.class);
        POOL_SEARCH = PageFactory.initElements(webDriver, PoolSearch.class);
        VIEW_SUMMONS_REPLY = PageFactory.initElements(webDriver, ViewSummonsReply.class);
        HEADER_PAGE = PageFactory.initElements(webDriver, Header.class);
    }
    @Then("^I navigate to the pool summoning progress screen$")
    public void iNavigateToSummoningProgress(){
        POOL_REQUESTS_PAGE.openPoolManagement();
        POOL_SUMMONING_PROGRESS.clickSummoningProgressTab();
    }

    @And("^I see the summoning progress page banner$")
    public void iSeeTheSummoningProgressBanner() {
        assertTrue(POOL_SUMMONING_PROGRESS.summoningProgressBannerIsDisplayed());
    }

    @And("^I enter \"([^\"]*)\" as the court$")
    public void iEnterAsTheCourt(String courtCode){
        POOL_SUMMONING_PROGRESS.enterCourtCodeForSearch(courtCode);
    }

    @And("^I select the \"([^\"]*)\" court type$")
    public void iSelectTheCourtType(String courtType) {
        String lowerCaseCourtType = courtType.toLowerCase();
        switch (lowerCaseCourtType){
            case "crown":
                POOL_SUMMONING_PROGRESS.clickCrownRadioButton();
                break;
            case "civil":
                POOL_SUMMONING_PROGRESS.clickCivilRadioButton();
                break;
            case "high":
                POOL_SUMMONING_PROGRESS.clickHighRadioButton();
                break;
            default:
                System.out.println("Input: "+lowerCaseCourtType+" Does not match crown, civil, high");
                break;
        }

    }

    @And("^I click search$")
    public void iClickSearch() {
        POOL_SUMMONING_PROGRESS.clickSearch();
    }

    @Then("^I clear down the data for all the pools I created for this test$")
    public void iClearDownThePoolsICreated() throws SQLException {
        List<String> poolList = StepDef_jurorpool.poolNumbers.get().stream().map(e -> "'" + e + "'").toList();
        String poolsCreated = poolList.toString().replace("[","(").replace("]",")");
        DBT.cleanNewActivePools(poolsCreated);
        ArrayList<String> pools = StepDef_jurorpool.poolNumbers.get();
        pools.clear();
    }

    @And("^I see all the pool numbers that were created are present on the screen$")
    public void iSeeAllThePoolNumbersThatWereCreatedOnTheScreen() throws Throwable {
        ArrayList<String> pools = StepDef_jurorpool.poolNumbers.get();
        int poolsCreatedSize = pools.size();
        int index = 0;
        do {
            NAV.textPresentOnPage(pools.get(index));
            System.out.println("Value in position "+index+" is " +pools.get(index));
            index++;
        } while (index < poolsCreatedSize);
    }
    @Then("^I see the pool I created in a row on the search results with the values$")
    public void iSeeThePoolCreatedInTheSearchResultsTable(DataTable dataTable) throws Throwable {
        Map<String, String> expectedData = dataTable.asMap(String.class, String.class);

        ArrayList<String> pools = StepDef_jurorpool.poolNumbers.get();

        String poolCreated = pools.get(0);
        NAV.textPresentOnPage(poolCreated);
        String[] actualData = POOL_SUMMONING_PROGRESS.getRowOfTableContainingPoolNumber(poolCreated);
        System.out.println(Arrays.toString(actualData));
        assertEquals(expectedData.get("requested"),actualData[2]);
        assertEquals(expectedData.get("summoned"),actualData[3]);
        assertEquals(expectedData.get("confirmed"),actualData[4]);
        assertEquals(expectedData.get("balance"),actualData[5]);

    }

    @Given("^the poolNumbers lists is empty$")
    public void thePoolNumbersListsIsEmpty() {
        ArrayList<String> pools = StepDef_jurorpool.poolNumbers.get();
        pools.clear();
    }
}
