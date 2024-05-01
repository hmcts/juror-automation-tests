package cucumber.pageObjects;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import java.util.List;
import java.util.Set;

public interface WebDriveDecorator extends WebDriver, JavascriptExecutor {


    WebDriver getDriver();


    default void get(String url) {
        this.getDriver().get(url);
    }

    default String getCurrentUrl() {
        return this.getDriver().getCurrentUrl();
    }

    default String getTitle() {
        return this.getDriver().getTitle();
    }

    default List<WebElement> findElements(By by) {
        return this.getDriver().findElements(by);
    }

    default WebElement findElement(By by) {
        return this.getDriver().findElement(by);
    }

    default String getPageSource() {
        return this.getDriver().getPageSource();
    }

    default void close() {
        this.getDriver().close();
    }

    default void quit() {
        this.getDriver().quit();
    }

    default Set<String> getWindowHandles() {
        return this.getDriver().getWindowHandles();
    }

    default String getWindowHandle() {
        return this.getDriver().getWindowHandle();
    }

    default TargetLocator switchTo() {
        return this.getDriver().switchTo();
    }

    default Navigation navigate() {
        return this.getDriver().navigate();
    }

    default Options manage() {
        return this.getDriver().manage();
    }

    default Object executeScript(String script, Object... args) {
        return ((JavascriptExecutor) getDriver()).executeScript(script, args);
    }

    default Object executeAsyncScript(String script, Object... args) {
        return ((JavascriptExecutor) getDriver()).executeAsyncScript(script, args);
    }
}
