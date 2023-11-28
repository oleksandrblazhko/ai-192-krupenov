CREATE OR REPLACE FUNCTION user_logout(v_username text)
    RETURNS boolean
    LANGUAGE plpgsql
    AS $$
    DECLARE
        v_user_id integer;
    BEGIN
        select users.user_id into v_user_id 
        from users
        where users.username = v_username;
        if found then
            delete from sso_tokens where user_id = v_user_id;
        end if;
        return found;
    END;
    $$;