--PostgreSQL: How to reset the pg_stat statistics tables?
--The Postgres pg_stat tables show a variety of statistical information regarding the database. In certain situations (such as after major updates to your application), you may want to clear out the gathered statistics and start from scratch. For instance, if you recently implemented numerous SQL query and indexing optimizations, and you want to see statistical data based on the new changes, you should first clear out the old stats. Here is how you do this:

--Open a connection to your database using psql or GUI tool
--Run the command:
select pg_stat_reset();
