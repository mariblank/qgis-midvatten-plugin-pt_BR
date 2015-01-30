# -*- coding: utf-8 -*- This line is just for your information, the python plugin will not use the first line;;
create view CHANGETOVIEWNAME as select tab1.rowid as rowid, tab1.obsid as obsid, cast(tab2.h_gs - tab1.depthtop as real) as z_coord, cast(tab1.depthtop - tab1.depthbot as real) as height, geometry from stratigraphy as tab1, (select obsid, geometry, (case when ((h_gs is null or not(h_gs >0)) and h_toc > 0 and h_tocags > 0) then h_toc - h_tocags else (case when ((h_gs is null or not(h_gs >0)) and (h_tocags is null or h_tocags=0) and h_toc > 0) then h_toc - 1 else h_gs end) end) as h_gs from obs_points where (typeof(h_toc) in ('integer', 'real') or typeof(h_gs) in ('integer', 'real'))) as tab2 WHERE tab1.obsid = tab2.obsid and typeof("tab2"."h_gs") = 'real' and tab1.geoshort CHANGETOPLOTTYPESDICTVALUE;
insert into views_geometry_columns (view_name, view_geometry, view_rowid, f_table_name, f_geometry_column, read_only) values ('CHANGETOVIEWNAME', 'geometry', 'rowid', 'obs_points', 'geometry',1);
