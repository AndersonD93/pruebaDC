
--SCRIPTS DDLs
CREATE TABLE hackers (
    hacker_id INTEGER PRIMARY KEY,
    name VARCHAR2(255) NOT NULL
);

CREATE TABLE envios (
    submission_id INTEGER PRIMARY KEY,
    hacker_id INTEGER,
    challenge_id INTEGER,
    score INTEGER,
    FOREIGN KEY (hacker_id) REFERENCES hackers(hacker_id)
);

--Scripts DML
INSERT INTO hackers (hacker_id, name) VALUES (4071, 'Rose');
INSERT INTO hackers (hacker_id, name) VALUES (4806, 'Angela');
INSERT INTO hackers (hacker_id, name) VALUES (26071, 'Frank');
INSERT INTO hackers (hacker_id, name) VALUES (49438, 'Patrick');
INSERT INTO hackers (hacker_id, name) VALUES (74842, 'Lisa');
INSERT INTO hackers (hacker_id, name) VALUES (80305, 'Kimberly');
INSERT INTO hackers (hacker_id, name) VALUES (84072, 'Bonnie');
INSERT INTO hackers (hacker_id, name) VALUES (87868, 'Michael');
INSERT INTO hackers (hacker_id, name) VALUES (92118, 'Todd');
INSERT INTO hackers (hacker_id, name) VALUES (95895, 'Joe');


INSERT INTO envios (submission_id, hacker_id, challenge_id, score) VALUES (67194, 74842, 63132, 76);
INSERT INTO envios (submission_id, hacker_id, challenge_id, score) VALUES (64479, 74842, 19797, 98);
INSERT INTO envios (submission_id, hacker_id, challenge_id, score) VALUES (40742, 26071, 49593, 20);
INSERT INTO envios (submission_id, hacker_id, challenge_id, score) VALUES (17513, 4806, 49593, 32);
INSERT INTO envios (submission_id, hacker_id, challenge_id, score) VALUES (69846, 80305, 19797, 19);
INSERT INTO envios (submission_id, hacker_id, challenge_id, score) VALUES (41002, 26071, 89343, 36);
INSERT INTO envios (submission_id, hacker_id, challenge_id, score) VALUES (52826, 49438, 49593, 9);
INSERT INTO envios (submission_id, hacker_id, challenge_id, score) VALUES (31093, 26071, 19797, 2);
INSERT INTO envios (submission_id, hacker_id, challenge_id, score) VALUES (81614, 84072, 49593, 100);
INSERT INTO envios (submission_id, hacker_id, challenge_id, score) VALUES (44829, 26071, 89343, 17);
INSERT INTO envios (submission_id, hacker_id, challenge_id, score) VALUES (75147, 80305, 49593, 48);
INSERT INTO envios (submission_id, hacker_id, challenge_id, score) VALUES (14115, 4806, 49593, 76);
INSERT INTO envios (submission_id, hacker_id, challenge_id, score) VALUES (6943, 4071, 19797, 95);
INSERT INTO envios (submission_id, hacker_id, challenge_id, score) VALUES (12855, 4806, 25917, 13);
INSERT INTO envios (submission_id, hacker_id, challenge_id, score) VALUES (73343, 80305, 49593, 42);
INSERT INTO envios (submission_id, hacker_id, challenge_id, score) VALUES (84264, 84072, 63132, 0);
INSERT INTO envios (submission_id, hacker_id, challenge_id, score) VALUES (9951, 4071, 49593, 43);
INSERT INTO envios (submission_id, hacker_id, challenge_id, score) VALUES (45104, 49438, 25917, 34);
INSERT INTO envios (submission_id, hacker_id, challenge_id, score) VALUES (53795, 74842, 19797, 5);
INSERT INTO envios (submission_id, hacker_id, challenge_id, score) VALUES (26363, 26071, 19797, 29);
INSERT INTO envios (submission_id, hacker_id, challenge_id, score) VALUES (10063, 4071, 49593, 96);

--Scripts DQL
WITH PuntuacionMaxima AS (
    SELECT
        hacker_id,
        challenge_id,
        MAX(score) AS max_score
    FROM
        envios
    GROUP BY
        hacker_id,
        challenge_id
)
SELECT
    h.hacker_id,
    h.name,
    COALESCE(SUM(pm.max_score), 0) AS puntuacion_total
FROM
    hackers h
LEFT JOIN
    PuntuacionMaxima pm ON h.hacker_id = pm.hacker_id
GROUP BY
    h.hacker_id,
    h.name
HAVING
    COALESCE(SUM(pm.max_score), 0) > 0
ORDER BY
    puntuacion_total DESC,
    h.hacker_id ASC;