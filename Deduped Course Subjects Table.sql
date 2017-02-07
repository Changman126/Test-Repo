--Deduped Course Subjects Table

- name: course_subject_deduped
  location: course_subject_deduped.sql
  description: a table that dedupes course subjects by alphbetical order and then returns the top result


DROP TABLE IF EXISTS course_subject_deduped;
CREATE TABLE IF NOT EXISTS course_subject_deduped AS
SELECT
	course_id,
	subject_title,
	rank
FROM
	(
		SELECT 
			course_id,
			subject_title,
			row_number() OVER (PARTITION BY course_id ORDER BY subject_title asc) AS rank
		FROM
			production.d_course_subjects
	) s
WHERE
	rank = 1
;