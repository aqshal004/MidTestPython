CREATE TABLE item_bought (
    buyer TEXT NOT NULL,
    item TEXT NOT NULL
);

INSERT INTO item_bought (buyer, item) VALUES
('A', 'Asus'),
('B', 'Lenovo'),
('C', 'Lenovo'),
('D', 'Acer'),
('E', 'Acer'),
('F', 'Acer');

-- TASK 1
SELECT item
FROM (
    SELECT item, COUNT(*) AS total_bought
    FROM item_bought
    GROUP BY item
) AS item_counts
WHERE total_bought NOT IN (
    SELECT MAX(total_bought) 
    FROM (
        SELECT COUNT(*) AS total_bought
        FROM item_bought
        GROUP BY item
    ) AS max_counts
    UNION
    SELECT MIN(total_bought) 
    FROM (
        SELECT COUNT(*) AS total_bought
        FROM item_bought
        GROUP BY item
    ) AS min_counts
);

-- TASK 2
WITH item_counts AS (
    SELECT item, COUNT(*) AS total_bought
    FROM item_bought
    GROUP BY item
), min_max_counts AS (
    SELECT MIN(total_bought) AS min_count, MAX(total_bought) AS max_count
    FROM item_counts
)
SELECT item
FROM item_counts, min_max_counts
WHERE total_bought != min_count AND total_bought != max_count;

-- TASK 3
WITH item_counts AS (
    SELECT item, COUNT(*) AS total_bought
    FROM item_bought
    GROUP BY item
), min_max_counts AS (
    SELECT MIN(total_bought) AS min_count, MAX(total_bought) AS max_count
    FROM item_counts
)
SELECT item
FROM item_counts, min_max_counts
WHERE total_bought != min_count AND total_bought != max_count;



