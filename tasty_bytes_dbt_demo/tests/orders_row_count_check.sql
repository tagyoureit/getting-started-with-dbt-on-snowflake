-- Validates that the orders model has at least as many rows as order_detail.
-- A bad join (e.g. wrong join key) drops rows via INNER JOIN, causing this to fail.
select 1
from (
    select count(*) as orders_count from {{ ref('orders') }}
) o
cross join (
    select count(*) as detail_count from {{ ref('raw_pos_order_detail') }}
) d
where o.orders_count < d.detail_count
