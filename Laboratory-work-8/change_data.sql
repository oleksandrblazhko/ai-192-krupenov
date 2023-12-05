CREATE OR REPLACE FUNCTION change_data(with_name text, new_course integer)
    RETURNS integer
    LANGUAGE plpgsql
    AS $$
    begin
        execute 'update student
        set course = ' || new_course || '
        where s_name = ''' || with_name || ''';';
        return 1;
    end;
    $$;