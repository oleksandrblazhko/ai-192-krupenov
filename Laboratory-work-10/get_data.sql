CREATE OR REPLACE FUNCTION get_data(with_course integer, v_user_name text, v_token text)
    RETURNS table ( s_id numeric(5, 0), s_name varchar(20), course numeric(5, 0) ) 
    LANGUAGE plpgsql
    AS $$
    begin
        if not exists (
            select from users u, sso_tokens t
            where u.username = v_user_name 
                and u.user_id = t.user_id
                and t.token = v_token
            ) then
            raise exception 'Authentication Error: user token not found.';
        end if;

        return query select student.s_id, student.s_name, student.course
        from student
        where student.course = with_course;
    end;
    $$;