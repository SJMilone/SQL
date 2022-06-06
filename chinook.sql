/* 1. Select full name, id, country where country not USA */

SELECT FirstName||' '||LastName as 'Customer', CustomerID, Country
FROM customers
Where Country <> 'USA';

/* 2. Show only customers from Brazil */

SELECT FirstName||' '||LastName as 'Customer', CustomerID, Country
FROM customers
Where Country = 'Brazil';

/* 3. Find the invoices of customers from Brazil*/

SELECT c.FirstName||' '||c.LastName as 'Customer Name', i.invoiceID, i.invoiceDate, i.BillingCountry
FROM customers c
JOIN invoices i
  ON c.customerid=i.customerid
Where Country = 'Brazil';

/* 4. Show employees who are sales agents */

SELECT FirstName||' '||LastName as 'Employee', Title
FROM employees
WHERE Title = 'Sales Support Agent';

/* 5. Find a unique/distinct listing of BillingCountry from Invoices table */

SELECT distinct i.BillingCountry
FROM invoices i;


/* 6. A Query that shows invoices associated with each sales agent. incklude agent's full name. */

SELECT e.Firstname||' '||e.Lastname as 'Sales Agent', i.invoiceid, c.customerid
FROM employees e
join customers c
  on e.employeeid=c.SupportRepId
  join invoices i
    on c.customerid=i.customerid;

/* 7. Show invoice total, customer name, country, sales agent name for all invoices/customers */

SELECT i.invoiceid,i.total, (c.firstname ||' '|| c.lastname) AS 'Cust Name', c.country, (e.firstname||' '||e.lastname) AS 'Sales Agent'
FROM invoices i
join customers c
  on i.customerid=c.customerid
  join employees e
    on e.employeeid=c.SupportRepID;

/* 8. How many invoices were there in 2009? */

select count(invoiceid)
from invoices
where strftime('%Y', invoicedate) = '2009';

/* 9. What are total sales for 2009? */

select sum(total)
from invoices
where strftime('%Y', invoicedate) = '2009';

/* 10. Query to show purchased track name with invoice line item */

SELECT t.name, ii.invoiceLineid
from Invoice_items ii
join tracks t
  on ii.trackid=t.trackid;

/* 11. purchased track name artist name and track id number */

SELECT t.name as 'Track Name', art.name as 'Artist', ii.invoiceLineid
from Invoice_items ii
join tracks t
  on ii.trackid=t.trackid
  join albums on t.albumid=albums.AlbumId
  join artists art on albums.ArtistId=art.artistid;
  
/* 12. Query to show all tracks, including Album name, Media Type and Genre */
SELECT t.name as 'Track', alb.title as 'Album', m.name as 'Media Type', g.name as 'Genre'
FROM tracks t
join albums alb
  on t.albumid=alb.albumid
  join media_types m
    on m.mediatypeid=t.mediatypeid
    join genres g
      on g.genreid=t.genreid
ORDER BY alb.title, t.name;

/* 13. Total sales by sales agent */

SELECT e.FirstName||' '||e.lastname AS 'Sales Agent', sum(i.total)
FROM invoices i
join customers c
  on i.customerid = c.customerid
  join employees e
  on e.employeeid=c.SupportRepId
group by e.employeeid;

/* 14. Who made most sales in 2009 */

SELECT e.FirstName||' '||e.lastname AS 'Sales Agent', sum(i.total)
FROM invoices i
join customers c
  on i.customerid = c.customerid
  join employees e
  on e.employeeid=c.SupportRepId
where i.invoicedate between '2009-01-01' and '2009-12-31'
group by e.employeeid;

/* Listing of all Artists/Albums/tracks */

select art.name Artist, a.title Album, T.Name Track
FROM albums a
join tracks t
  on a.albumid=t.albumid
  join artists art
  on a.artistid=art.artistid
order by art.name, a.title, t.name;

/* List of all playlists */
select p.playlistid as 'Playlist', p.name as Name, pt.trackid, t.name Track
from Playlists p
join playlist_track pt on p.playlistid=pt.playlistid
join tracks t on pt.trackid=t.trackid
Order by p.playlistid