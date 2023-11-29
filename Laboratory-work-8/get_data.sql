CREATE OR REPLACE FUNCTION get_data(with_name text)
    RETURNS table ( s_id numeric(5, 0), s_name varchar(20), course numeric(5, 0) ) 
    LANGUAGE plpgsql
    AS $$
    begin
        return query execute 'select student.s_id, student.s_name, student.course
        from student
        where student.s_name = ''' || with_name || ''';';
    end;
    $$;