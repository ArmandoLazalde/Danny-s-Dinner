# Danny's Diner: the customer's vision uncovered

## 📄 Context

Danny seriously loves Japanese food so in the beginning of 2021, he decides to embark upon a risky venture and opens up a cute little restaurant that sells his 3 favourite foods: sushi, curry and ramen.

Danny’s Diner is in need for data analyst assistance to help the restaurant stay afloat - the restaurant has captured some very basic data from their few months of operation but have no idea how to use their data to help them run the business.

## 💼 Business problem

He wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite. Having this deeper connection with his customers will help him deliver a better and more personalised experience for his loyal customers.

These insights will help him to decide whether he should expand the existing customer loyalty program - additionally he needs help to generate some basic datasets so his team can easily inspect the data without needing to use SQL.

Has provided us with a sample of his overall customer data due to privacy issues. We have 3 key datasets for this case study:

1. Sales – this dataset holds valuable information about the transactions that take place at Danny’s Diner, including the customer ID, menu items ordered and the order date.
2. Menu – It encompasses all the delightful culinary creations offered at the restaurant including curry, ramen and sushi. It contains details such as item names, and their prices.
3. Members – This dataset holds information about when customers joined the beta version of Danny’s loyalty program.

Entity Relationship Diagram

![image](https://i0.wp.com/herdataproject.com/wp-content/uploads/2023/06/image.png?w=804&ssl=1)

## 📝 Requirements

Each of the following case study questions can be answered using a single SQL statement:

1. What is the total amount each customer spent at the restaurant?
2. How many days has each customer visited the restaurant?
3. What was the first item from the menu purchased by each customer?
4. What is the most purchased item on the menu and how many times was it purchased by all customers?
5. Which item was the most popular for each customer?
6. Which item was purchased first by the customer after they became a member?
7. Which item was purchased just before the customer became a member?
8. What is the total items and amount spent for each member before they became a member?
9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just
    sushi - how many points do customer A and B have at the end of January?
11. Create basic data tables that Danny and his team can use to quickly derive insights without needing to join the underlying tables using SQL.
12. Danny also requires further information about the ranking of customer products, but he purposely does not need the ranking for non-member            purchases so he expects null ranking values for the records when customers are not yet part of the loyalty program.

## 💡 Sample solution to some requirements with SQL queries

![image](https://github.com/ArmandoLazalde/Danny-s-Dinner/assets/99104425/cb433734-3b8d-4015-b3c1-358ab580c768)

![image](https://github.com/ArmandoLazalde/Danny-s-Dinner/assets/99104425/7bc944db-c676-49a1-af05-e995f4d938f9)

![image](https://github.com/ArmandoLazalde/Danny-s-Dinner/assets/99104425/5f6f8d2c-36fb-4d10-a947-4f6850ba61cd)

## 📊 Results examples

![image](https://github.com/ArmandoLazalde/Danny-s-Dinner/assets/99104425/68e2abf5-a2ed-46ea-8684-3bb32b4328b0)

![image](https://github.com/ArmandoLazalde/Danny-s-Dinner/assets/99104425/b7177904-cac9-493b-a29d-46dcfd0ddfe6)

![image](https://github.com/ArmandoLazalde/Danny-s-Dinner/assets/99104425/5dbfc8eb-9ee0-485d-8e9d-b51a7ba38b12)

**This project is part of Danny Ma's [8WeekSQLChallenge](https://8weeksqlchallenge.com/case-study-1/), and was made possible through his guidance. Visit his website for more case studies and SQL for data analysis projects, [DataWithDanny](https://www.datawithdanny.com/)**









