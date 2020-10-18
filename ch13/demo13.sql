-- Local Indexes and Unique Constraints

drop table partitioned purge;

set echo on

CREATE TABLE partitioned
  ( timestamp date,
    id        int,
    constraint partitioned_pk primary key(id)
  )
  PARTITION BY RANGE (timestamp)
  (
  PARTITION part_1 VALUES LESS THAN
  ( to_date('01/01/2014','dd/mm/yyyy') ) ,
  PARTITION part_2 VALUES LESS THAN
  ( to_date('01/01/2015','dd/mm/yyyy') )
  )
/


insert into partitioned values(to_date('01/01/2013','dd/mm/yyyy'),1);
insert into partitioned values(to_date('01/01/2014','dd/mm/yyyy'),2);

column segment_name format a25
column partition_name format a25
column segment_type form a15

select segment_name, partition_name, segment_type
from user_segments;

drop table partitioned purge;

CREATE TABLE partitioned
  ( timestamp date,
    id        int
  )
  PARTITION BY RANGE (timestamp)
  (
  PARTITION part_1 VALUES LESS THAN
  ( to_date('01-jan-2014','dd-mon-yyyy') ) ,
  PARTITION part_2 VALUES LESS THAN
  ( to_date('01-jan-2015','dd-mon-yyyy') )
  )
/

create index partitioned_idx on partitioned(id) local;

insert into partitioned values(to_date('01/01/2013','dd/mm/yyyy'),1);
insert into partitioned values(to_date('01/01/2014','dd/mm/yyyy'),2);

select segment_name, partition_name, segment_type
from user_segments;

alter table partitioned
  add constraint
  partitioned_pk
  primary key(id)
/
