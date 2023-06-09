---
editor_options: 
  markdown: 
    wrap: 72
---

# Advanced-databases

This repository contains tasks related to advanced databases.

## I. Hierarchical Task

1.  Propose a tree structure:
    World
    \-\--Continents
    \-\-\-\-\-\--Countries
    \-\-\-\-\-\-\-\-\-\--Cities
    \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--Streets

    Represent this structure in a table using the hierarchical type.

2.  Write SQL commands:
    a) Display an entire branch of the tree (from World to Street).
    b) Add a new country.
    c) Display the name of the continent where the city 'x' is located.
    d) Display the names of all countries.
    e) Check if country 'x' is located on continent 'y'.
    f) Check if both 'x' and 'y' are countries.
    g) Display all streets of city 'x'.

3\. Represent the tree structure from point 1 without using the
hierarchical type and answer the questions from point 2.

## II. Filetable Task

1.  Configure the database server to enable the FileTable feature.

2.  Create a new database with FileTable support.

3.  In the database, create a table using FileTable.

4.  Use SQL to store the following file and directory structure (from
    existing files) in the table:

    -   file0.xls

    -   file0.doc

    -   file0.txt

    -   new_folder1

        -   file1.xls

        -   file1.doc

        -   file1.txt

        -   new_folder2

            -   file2.ppt

            -   file2.doc

            -   file2.txt

            -   new_folder3

                -   file3.txt

                -   file3.doc

5.  Update two selected files by changing their content.

    -   Replace an existing file with new textual content.

    -   Replace an existing file with the content of another non-text
        file.

6.  Delete a selected file from the disk using SQL.

## III. XML Task

Create a new table containing data related to orders. The order
description should be in XML format.

The complexity level of the order description should be such that it
requires the use of at least 7 tables in the relational database.

Add sample descriptions of 3 orders to the table (as separate records)
in XML format.

Write queries:

-   Display order submission dates.

-   Display information about the customers.

-   Display information about the order contents (what the order
    contains, e.g., package contents).

-   Search for orders shipped to a specific location (e.g., city).

-   Add additional content to a selected order.
