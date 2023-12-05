CREATE OR REPLACE FUNCTION change_data_secure(with_name text, new_course integer)
    RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare
        q varchar;
    begin
        q := 'update student
        set course = $1
        where s_name = $2';
        execute q using new_course, with_name;
        return 1;
    end;
    $$;