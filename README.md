# Strategic Market Entry Analysis: Scaling High-End Tech in the Magist Ecosystem

📋 **Project Overview**
Eniac, a premium tech manufacturer, is considering a strategic expansion into the Brazilian market via the Magist marketplace. This project evaluates the partnership's viability by analyzing three years of transactional data to identify market demand and potential logistics risks. By isolating "Premium Tech" categories and analyzing fulfillment lifecycles, I provided a data-driven recommendation on whether Magist’s infrastructure can support a high-end brand's reputation.

📊 **Dataset & Sources**
Source: Provided via a MySQL Database Dump (.sql) from WBS coding school.

Size: ~100,000 orders spanning 2016 to 2018.

Key Features: order_purchase_timestamp, order_delivered_carrier_date, order_delivered_customer_date, product_category_name_english, price, and order_status.

Preprocessing: Filtered specifically for delivered orders within 2017–2018 and mapped 70+ categories into a specialized "Tech" segment. 
The project involved a full database restoration from the dump file. Data was cleaned to handle null delivery timestamps and to join Portuguese-to-English category translations for standardized reporting.

🚀 **Key Findings & Results**
- The "big fish" opportunity: Despite high traffic, a leadership gap exists in the tech sector; only one seller currently exceeds €8k/month in revenue (peaking at €18k).

- <u>Demand growth</u>: The "tech" category saw a 42% YoY growth from 2017 to 2018, signaling a maturing tech audience.
*Tech categories includes 'audio','electronics','computers_accessories','computers','telephony'*

- <u>Delayed delivery processings</u>: While carrier speeds are 'stable'but slow, internal warehouse processing times for tech products increased in 2018 as volume scaled, posing a risk to Eniac's delivery standards.

- <u>Accuracy Risk</u>: Qualitative review analysis identified recurring "Wrong Product Delivered" complaints, low customer support, long delays.

🛠️ **Technologies Used**
--> <u>Database</u>: MySQL
--> <u>Visualization</u>: Tableau
--> <u>Communication</u>: Canva

📁** Project Structure**
![Magist Logistic time delivery](images/Magist_logistic_delivery.png)
*Handling time from both Magist and Carrier is inefficient

! [Tech sellers opportunity](images/Magist_10_tech_seller_rev.png)
* No real competitor playing in Eniac's field


**Final recommendations:**
## To move forward with Magist, Eniac is requesting those conditions:
_Premium delivery service option
Dedicated premium customer support
Dedicated tech-handling team for our product or double check protocol_
