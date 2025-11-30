--1-st task--

CREATE TABLE Orders (
    o_id SERIAL PRIMARY KEY ,
    order_date DATE NOT NULL

    
);

CREATE TABLE Products (
    p_name TEXT PRIMARY KEY NOT NULL,
    price MONEY NOT NULL

    
);

CREATE TABLE Order_Items (
    order_id INT NOT NULL,
    product_name TEXT NOT NULL,
    amount numeric(7,2) NOT NULL DEFAULT 1 CHECK (amount > 0),

	PRIMARY KEY (order_id, product_name),
	FOREIGN KEY (order_id) REFERENCES Orders(o_id),
	FOREIGN KEY (product_name) REFERENCES Products(p_name)
);


--2-nd tasl--

insert into Orders(order_date) values ('2011-11-11'), ('2012-12-12')
insert into Products(p_name, price) values('p1',1300), ('p2',300)
insert into Order_Items

INSERT INTO Order_Items (order_id, product_name) VALUES (1, 'p1'),(1, 'p2');
INSERT INTO Order_Items (order_id, product_name, amount) VALUES (2, 'p1', 3),(2, 'p2', 5);


SELECT o_id, order_date FROM Orders;
SELECT p_name, price FROM Products;


--3-rd task--

alter table Order_Items drop constraint order_items_product_name_fkey;
ALTER TABLE products DROP CONSTRAINT products_pkey;
alter table Products add column p_id SERIAL not null;
alter table Products add constraint products_pkey PRIMARY KEY(p_id);
alter table Products add constraint products_p_name_unique UNIQUE(p_name);

ALTER TABLE Order_Items
ADD CONSTRAINT order_items_product_name_fkey
FOREIGN KEY (product_name) REFERENCES products(p_name);


alter table Order_Items add column total MONEY NOT NULL, add column price MONEY NOT NULL;
update Order_Items OI set price = p.price from products p where OI.product_name = p.p_name;
update Order_Items set total = price * amount;
alter table Order_Items add constraint total_check CHECK (total =price * amount);


--4-th tasl--

update Products set p_name = 'product1' where p_name = 'p1';
delete from Order_Items where order_id = 1 and product_name = 'p2';
delete from Orders where o_id = 2;

update Products set price = 5 where p_name = 'product1';
update Order_Items oi
set price = p.price, total = amount * p.price
from Products p
where oi.product_name = p.p_name;

insert into Orders(order_date) values (current_date);
insert into Order_Items(order_id, product_name, amount, price, total)
select o.o_id, 'product1', 3, p.price, 3 * p.price
from Orders o
join Products p on p.p_name = 'product1'
where o.order_date = current_date;


