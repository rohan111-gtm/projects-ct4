package seltest;

import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

import java.util.List;
import java.util.concurrent.TimeUnit;

public class devopsscraping {
    public static void main(String[] args) {
        // Set Chrome Driver path
        System.setProperty("webdriver.chrome.driver", "C:\\chromedriver.exe");
        
      //create object of chrome options
        ChromeOptions options = new ChromeOptions();
        
        //add the headless argument
        options.addArguments("headless");

        // Initialize WebDriver
        WebDriver driver = new ChromeDriver();
        driver.manage().window().maximize();
        driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
        
        // Open Azure DevOps Products Page
        driver.get("https://azure.microsoft.com/en-us/products/devops/#Features-3");

        // **Use JavaScript to extract dynamically loaded content**
        JavascriptExecutor js = (JavascriptExecutor) driver;
        List<String> productElements = (List<String>) js.executeScript(
            "return Array.from(document.querySelectorAll('#Features-3 h3')).map(el => el.innerText.trim());"
        );

        // **Print extracted product names**
        System.out.println("Azure DevOps Products:");
        if (productElements.isEmpty()) {
            System.out.println("❌ No products found. Check if XPath is correct or the page takes longer to load.");
        } else {
            for (String product : productElements) {
                System.out.println("- " + product);
            }
        }

        // **Ensure driver quits properly**
        driver.close();
    }
}
