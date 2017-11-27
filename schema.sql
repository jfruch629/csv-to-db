DROP TABLE IF EXISTS ingredients;

CREATE TABLE ingredients (
  id SERIAL PRIMARY KEY,
  step INTEGER NOT NULL,
  ingredient VARCHAR(255) NOT NULL
)
