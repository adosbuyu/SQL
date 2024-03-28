-- Create tables
CREATE TABLE Salesperson_buyuh (
    salesperson_id INT PRIMARY KEY,
    name VARCHAR(50),
    commission DECIMAL(10, 2)
);
CREATE TABLE Customer_buyuh (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100)
);
CREATE TABLE Car_buyuh (
    car_id INT PRIMARY KEY,
    serial_number VARCHAR(20) UNIQUE,
    make VARCHAR(50),
    model VARCHAR(50),
    year INT,
    price NUMERIC(10, 2),
    condition VARCHAR(10) -- New or Used
);
CREATE TABLE Invoice_buyuh (
    invoice_id INT PRIMARY KEY,
    car_id INT,
    salesperson_id INT,
    total_amount NUMERIC(10, 2),
    FOREIGN KEY (car_id) REFERENCES Car_buyuh(car_id),
    FOREIGN KEY (salesperson_id) REFERENCES Salesperson_buyuh(salesperson_id)
);
CREATE TABLE ServiceTicket_buyuh (
    serviceTicket_id INT PRIMARY KEY,
    car_id INT,
    customer_id INT,
    ticket_date DATE,
    description TEXT,
    FOREIGN KEY (car_id) REFERENCES Car_buyuh(car_id),
    FOREIGN KEY (customer_id) REFERENCES Customer_buyuh(customer_id)
);
CREATE TABLE Mechanic_buyuh (
    mechanic_id INT PRIMARY KEY,
    name VARCHAR(50)
);
CREATE TABLE ServiceHistory_buyuh (
    serviceHistory_id INT PRIMARY KEY,
    car_id INT,
    service_date DATE,
    description TEXT,
    mechanic_id INT,
    FOREIGN KEY (car_id) REFERENCES Car_buyuh(car_id),
    FOREIGN KEY (mechanic_id) REFERENCES Mechanic_buyuh(mechanic_id)
);

CREATE TABLE Parts_buyuh (
    part_id INT PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC(10, 2)
);
CREATE TABLE ServiceTicketParts_buyuh (
    serviceTicket_id INT,
    part_id INT,
    quantity INT,
    PRIMARY KEY (serviceTicket_id, part_id),
    FOREIGN KEY (serviceTicket_id) REFERENCES ServiceTicket_buyuh(serviceTicket_id),
    FOREIGN KEY (part_id) REFERENCES Parts_buyuh(part_id)
);

DROP FUNCTION IF EXISTS InsertSalesperson(integer, character varying, numeric);

CREATE OR REPLACE FUNCTION InsertSalesperson(salesperson_id INT, name VARCHAR(50), commission DECIMAL(10, 2))
RETURNS VOID AS $$
BEGIN
    INSERT INTO Salesperson_buyuh(salesperson_id, name, commission)
    VALUES (salesperson_id, name, commission);
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS InsertCustomer(integer, character varying, character varying);

CREATE OR REPLACE FUNCTION InsertCustomer(customer_id INT, name VARCHAR(50), email VARCHAR(100))
RETURNS VOID AS $$
BEGIN
    INSERT INTO Customer_buyuh (customer_id, name, email)
    VALUES (customer_id, name, email);
END;
$$ LANGUAGE plpgsql;



-- Add sample data
INSERT INTO Salesperson_buyuh (salesperson_id, name, commission) VALUES
(1, 'John Doe', 0.1),
(2, 'Jane Smith', 0.12);

INSERT INTO Customer_buyuh (customer_id, name, email) VALUES
(1, 'Alice Johnson', 'alice@example.com'),
(2, 'Bob Anderson', 'bob@example.com');

INSERT INTO Car_buyuh (car_id, serial_number, make, model, year, price, condition) VALUES
(1, '123ABC', 'Toyota', 'Corolla', 2022, 15000.00, 'New'),
(2, '456DEF', 'Honda', 'Civic', 2019, 12000.00, 'Used');

INSERT INTO Invoice_buyuh (invoice_id, car_id, salesperson_id, total_amount) VALUES
(1, 1, 1, 15000.00),
(2, 2, 2, 12000.00);

INSERT INTO ServiceTicket_buyuh (serviceTicket_id, car_id, customer_id, ticket_date, description) VALUES
(1, 1, 1, '2024-03-21', 'Oil change and tire rotation'),
(2, 2, 2, '2024-03-20', 'Brake inspection');

INSERT INTO Mechanic_buyuh (mechanic_id, name) VALUES
(1, 'Mike Johnson'),
(2, 'Emily Brown');

INSERT INTO Parts_buyuh (part_id, name, price) VALUES
(1, 'Oil Filter', 5.00),
(2, 'Brake Pad', 30.00);

INSERT INTO ServiceTicketParts_buyuh (serviceTicket_id, part_id, quantity) VALUES
(1, 1, 1),
(2, 2, 2);

UPDATE Customer_buyuh
SET email = 'alice.johnson@gmail.com'
WHERE customer_id = 1;

UPDATE Customer_buyuh
SET email = 'bob.anderson@ymail.com'
WHERE customer_id = 2;

-- insert salesperson using the function "InsertSalesperson"
select InsertSalesperson(3, 'Jurry Joe', 0.17);

--insert a customer using the function "InsertCustomer"
select InsertCustomer(3, 'John Mary', 'mary.john@aol.com');

select * from Salesperson_buyuh
select * from Customer_buyuh
select * from car_buyuh 
select * from invoice_buyuh 
select * from serviceticket_buyuh 
select * from Mechanic_buyuh 
select * from Parts_buyuh
select * from serviceticketparts_buyuh 








