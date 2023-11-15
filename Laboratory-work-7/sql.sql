CREATE OR REPLACE RULE student_update AS ON UPDATE TO krupenyov.students
DO INSTEAD
    UPDATE PUBLIC.STUDENT
    SET s_name = NEW.s_name,
				course = NEW.course,
				spot_conf = NEW.spot_conf
    WHERE
				spot_conf <= (SELECT al.access_level
          FROM GROUPS_ACCESS_LEVEL al, pg_group g
          WHERE UPPER(al.group_name) = UPPER(g.GRONAME))
				AND NEW.spot_conf <= (SELECT al.access_level
          FROM GROUPS_ACCESS_LEVEL al, pg_group g
          WHERE UPPER(al.group_name) = UPPER(g.GRONAME));

---

CREATE OR REPLACE RULE student_insert AS ON INSERT TO krupenyov.students
DO INSTEAD
    INSERT INTO PUBLIC.STUDENT
    SELECT
        NEW.s_id,
        NEW.s_name,
				NEW.course,
				(SELECT al.access_level
          FROM GROUPS_ACCESS_LEVEL al, pg_group g
          WHERE UPPER(al.group_name) = UPPER(g.GRONAME));

---

CREATE OR REPLACE RULE student_delete AS ON DELETE TO krupenyov.students
DO INSTEAD
    DELETE FROM PUBLIC.STUDENT
    WHERE s_id = OLD.s_id
      AND OLD.spot_conf <= (
        SELECT
          al.access_level
            FROM GROUPS_ACCESS_LEVEL al, pg_group g
            WHERE UPPER(al.group_name) = UPPER(g.GRONAME)
      );