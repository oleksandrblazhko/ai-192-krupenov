CREATE OR REPLACE FUNCTION get_data_secure(with_name text)
    RETURNS table ( s_id numeric(5, 0), s_name varchar(20), course numeric(5, 0) ) 
    LANGUAGE plpgsql
    AS $$
    declare
        q varchar;
    begin
        q := 'select student.s_id, student.s_name, student.course
        from student
        where student.s_name = $1;';
        return query execute q using with_name;
    end;
    $$;