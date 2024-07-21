-- Easy Questions

-- 1:Who is the senior most employee based on the job title?

select * from employee
ORDER BY levels desc
limit 1

-- 2:Which country has most Invoices?

select COUNT(*) as c, billing_country
from invoice
GROUP BY billing_country
ORDER BY c desc

-- 3:What are top 3 values of local Invoice?

SELECT total FROM invoice
ORDER BY total desc
limit 3


-- 4:Which City has the best customers? We would like to thow a prmotional Music Festival in the city
-- we made the most money. Write a query that returns one city that has the highest sum of invoice total.
-- Return both the city name & sum of all invoice totals

SELECT SUM(total) as invoice_total,billing_city 
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total desc
	

-- 5:Who is the best customer? The customer who has spent the most money will be declared the best customer.
-- Write the query that returns the person who has spent the most money.

SELECT customer.customer_id, first_name, last_name, SUM(total) AS total_spending
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total_spending DESC
LIMIT 1;


-- Moderate Questions


--6:Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
--Return your list ordered alphabetically by email starting with A. 


SELECT DISTINCT email AS Email,first_name AS FirstName, last_name AS LastName, genre.name AS Name
FROM customer
JOIN invoice ON invoice.customer_id = customer.customer_id
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
JOIN track ON track.track_id = invoice_line.track_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
ORDER BY email;


--7:Let's invite the artists who have written the most rock music in our dataset. 
--Write a query that returns the Artist name and total track count of the top 10 rock bands. 

SELECT artist.artist_id, artist.name,COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC
LIMIT 10;

--8:Return all the track names that have a song length longer than the average song length. 
--Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. 

SELECT name,miliseconds
FROM track
WHERE miliseconds > (
	SELECT AVG(miliseconds) AS avg_track_length
	FROM track )
ORDER BY miliseconds DESC;
