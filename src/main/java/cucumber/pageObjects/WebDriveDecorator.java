package cucumber.pageObjects;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import java.util.List;
import java.util.Set;

public abstract class WebDriveDecorator implements WebDriver {

    
    public abstract WebDriver getDriver();
    
    @Override
    public void get(String url) {
        this.getDriver().get(url);
    }

    @Override
    public String getCurrentUrl() {
        return this.getDriver().getCurrentUrl();
    }

    @Override
    public String getTitle() {
        return this.getDriver().getTitle();
    }

    @Override
    public List<WebElement> findElements(By by) {
        return this.getDriver().findElements(by);
    }

    @Override
    public WebElement findElement(By by) {
        return this.getDriver().findElement(by);
    }

    @Override
    public String getPageSource() {
        return this.getDriver().getPageSource();
    }

    @Override
    public void close() {
        this.getDriver().close();
    }

    @Override
    public void quit() {
        this.getDriver().quit();
    }

    @Override
    public Set<String> getWindowHandles() {
        return this.getDriver().getWindowHandles();
    }

    @Override
    public String getWindowHandle() {
        return this.getDriver().getWindowHandle();
    }

    @Override
    public TargetLocator switchTo() {
        return this.getDriver().switchTo();
    }

    @Override
    public Navigation navigate() {
        return this.getDriver().navigate();
    }

    @Override
    public Options manage() {
        return this.getDriver().manage();
    }
}
