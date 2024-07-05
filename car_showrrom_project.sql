create database Car_showroom;
use Car_showroom;
create table Car_details(
car_name varchar(40) primary key,
company_name varchar(40),
car_type varchar(30),
fuel_type varchar(25),
model_color varchar(30),
car_price_in_lacs int);

select*from Car_details;


truncate Car_details;


insert into Car_details
values
('Swift Dezire','Maruti Suzuki','Sedan','Diesel','Matt Silver','7'),
('WagonR','Maruti Suzuki','Hatchback','Petrol','Red','5.50'),
('Swift','Maruti Suzuki','Hatchback','Petrol','Matt Grey','6'),
('Nexon','Tata Motors','Suv','Petrol','Black','11'),
('Venue','Hyundai','Suv','Petrol','Matt Grey','9'),
('Altroz','Tata Motors','Hatchback','Petrol','White','6.65'),
('Vitara Brezza','Maruti Suzuki','Suv','Diesel','Green','9.69'),
('Tiguan','Volkswagen','Suv','Petrol','Dark Grey','35.16'),
('Audi Q5','Audi','Suv','Petrol','Matt silver','65.18'),
('Defender','Land Rover','Suv','Diesel','Matt Grey','67.90');


create table customer_details(
car_name varchar(40),
cust_name varchar(50) not null,
cust_gender varchar(20),
cust_contact varchar(10) not null,
customer_city varchar(30) not null,
cust_profession varchar(30),
primary key(cust_name),
foreign key(car_name) references Car_details(car_name));

insert into customer_details values
('Tiguan','Rohit S','M','9658247832','Hyderabad','Businessman'),
('Defender','Saurabh P','M','7249152787','Pune','Data Scientist'),
('Audi Q5','Virat K','M','6582977812','Mumbai','Cricketer'),
('Altroz','Rozi Kh','F','8659247823','Benguluru','Sr.Manager'),
('Vitara Brezza','Shruti K','F','9356897425','Mumbai','Actress'),
('Venue','Nora F','F','7365984125','Pune','Actress'),
('Swift','Tiger S','M','8456231589','Hyderabad','Actor'),
('Nexon','Katrina K','F','9124568975','Pune','Data Scientist'),
('WagonR','Kiayara K','F','8452146590','Mumbai','Teacher'),
('Swift Dezire','Chaitanya I','M','9625481657','Mumbai','Junior Scientist');

select*from customer_details;


create table payment_details(
cust_name varchar(50),
payment_amount int not null,
payment_mode varchar(20) not null,
date_of_transaction date,
foreign key(cust_name) references customer_details(cust_name));

insert into payment_details values
('Saurabh P','68','CASH','2024-03-08'),
('Rohit S','36','CASH','2024-03-09'),
('Virat K','66','UPI','2024-03-10'),
('Rozi Kh','7','EMI','2024-03-11'),
('Shruti K','10','UPI','2024-03-12'),
('Nora F','9','CASH','2024-03-13'),
('Tiger S','6','EMI','2024-03-14'),
('Katrina K','11','UPI','2024-03-15'),
('Kiayara K','6','EMI','2024-03-16'),
('Chaitanya I','7','CASH','2024-03-17');


select*from payment_details;

drop table payment_details;
-- Give me detail information of all cars which are sold ?
select*from car_details;

-- How many cars are sold by this showroom ?

select count(*) as No_Of_Cars 
from Car_details; 

-- How many Maruti suzuki company cars are sold ?

select count(*) as Cars_sold 
from Car_details 
where company_name ='Maruti Suzuki';

-- Give me all the information of cars which are between 1 to 20 lacs ?

select*from Car_details 
where 
car_price_in_lacs between '1' and '20';   --


-- Give me detail information of all Suv cars 

-- select*from Car_details 
-- where car_type='Suv';

-- -------------------------------------------------------------------------------------
-- Give me detail information of customers
select*from customer_details;

-- How many Female customers are there ?

select count(*) as Number_Of_Female_customer 
from customer_details 
where cust_gender='F';

-- Give me all the information of cars are sold by Pune and Mumbai showrrom ?

 -- select*from customer_details 
 -- where customer_city in ('Mumbai','Pune');
 
 -- Show me the information with ascending order of car_names 
 
 select * from customer_details 
 order by car_name asc;
 
 -- find the cars in each city 
 
 select customer_city ,count(car_name) 
 from customer_details 
 group by customer_city;
 
 -- ------------------------------------------------------------------------------------------
 -- Give me information of payment details
 select * from payment_details;
 
 -- How many transactions are done in cash ?
 
 select count(*) as No_Of_transaction_in_cash 
 from payment_details;   ---------
 
 -- Give me Maximum transaction amount
 
 select max(payment_amount) as Max_car_amount_in_lacs 
 from payment_details;
 
 -- How many payment happened in cash,emi and upi
 
 select payment_mode,count(payment_mode)  
 from payment_details 
 group by payment_mode; 
 
 -- How many transactions are between 4 to 15 lacs
 
 select count(*) as No_of_transaction 
 from payment_details 
 where payment_amount between '4' and '15';
 
 -- Give me first 3 transaction
-- select * from payment_details limit 3;
 
 select*from car_details
 where model_color = 'Matt Grey';
 
 -- ------------------------------------------------------------------------------------------------------
 -- INNER JOIN ON Car_details and customer_detals
 select*from Car_details as C
 inner join customer_details as cust
 on C.car_name=cust.car_name;
 
 -- RIGHT JOIN ON Car_details and customer_detals
 select*from Car_details as C
 right join customer_details as cust
 on cust.car_name=C.car_name;
 
 -- How many male customers are buys a suv car
 
 select count(*) as Male_having_Suv_customer 
 from customer_details as cust
 left join Car_details as C
 on cust.car_name=C.car_name where cust_gender='M' and car_type='Suv';
 
 select*from customer_details as cust
 inner join payment_details as p
 on p.cust_name=cust.cust_name;
 
 -- Extract infomation of all suv car customers with car company names
 
SELECT C.company_name,customer_details.cust_name
FROM customer_details
JOIN Car_details AS C 
ON customer_details.car_name = C.car_name
WHERE C.car_type = 'SUV';

-- Give me details of Saurabh P customer in that i have to know his car model color,company name,price and payment mode payment.

SELECT 
car_details.model_color,
car_details.company_name,
car_details.car_price_in_lacs,
payment_details.payment_mode
FROM
car_details
JOIN
customer_details ON car_details.car_name = customer_details.car_name
JOIN
payment_details ON customer_details.cust_name = payment_details.cust_name
WHERE
customer_details.cust_name = 'Saurabh P';

-- extract lowest car price information such as  name,company name, color ,customer name,,city and payment


SELECT 
    C.car_name,
    C.company_name,
    C.model_color,
    C.car_price_in_lacs,
    Cust.cust_name,
    Cust.customer_city,
    P.payment_amount
FROM
    car_details AS C
JOIN
    customer_details AS Cust ON C.car_name = Cust.car_name
JOIN
    payment_details AS P ON Cust.cust_name = P.cust_name
ORDER BY
    C.car_price_in_lacs ASC
LIMIT 1;

-- Extract information of Data scientist car which has price more than 50 lacs

select * from Car_details as C
left join customer_details as cust
on c.car_name=cust.car_name
where cust.cust_profession='Data Scientist' and C.car_price_in_lacs>50;

  
-- I want to konw Hatch back car details and customer details 

SELECT * FROM Customer_Details AS CD
JOIN Car_Details AS CD1
ON CD.car_name = CD1.car_name
WHERE CD1.car_type = 'Hatchback';

-- give me information of cars name,company name,color,fuel type,price with ascending order of city

select 
CD.car_name,CD.company_name,CD.model_color,
CD.fuel_type,CD.car_price_in_lacs,Cust.customer_city
from Car_Details CD
LEFT JOIN Customer_Details Cust ON CD.car_name=Cust.car_name
ORDER BY Cust.customer_city;


-- Give me details of car such as name ,company,color  and custopmer  which are not from mumbai city and pune city
  
  
SELECT 
    C.car_name,
    C.company_name,
    C.model_color,
    D.cust_name
FROM
    Car_details AS C
JOIN
    Customer_details AS D
ON
    C.car_name = D.car_name
WHERE
    D.customer_city NOT IN ('Mumbai', 'Pune');
    
-- give me details of male customer who has done payment in  emi 

select * from Customer_details 
where cust_gender='M' and cust_name 
in (select cust_name from payment_details where payment_mode='EMI');

-- give me a count of how many male customer buys a car and how many female buys a car

SELECT
cust_gender,
COUNT(DISTINCT cust_name) AS Number_of_Customers
FROM customer_details
GROUP BY
cust_gender;

-- give me car details of car where car price is second highest.

SELECT * FROM Car_details
ORDER BY car_price_in_lacs DESC
LIMIT 1 OFFSET 1;


SELECT *
FROM car_details
ORDER BY car_price_in_lacs DESC
LIMIT 3,1;

-- Give me fifth lowest car price details 

select * from Car_details 
order by car_price_in_lacs asc limit 1 offset 5;


describe car_details;


describe customer_details;


describe payment_details;

select  distinct(customer_city) from customer_details;

s