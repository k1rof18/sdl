CREATE DATABASE mydb;

\c mydb;

CREATE TABLE clients (
  client_id UUID PRIMARY KEY
);

CREATE TABLE recruits (
  recruit_id UUID PRIMARY KEY,
  title TEXT NOT NULL,
  client_id UUID NOT NULL REFERENCES clients(client_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE projects (
  recruit_id UUID REFERENCES recruits(recruit_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
    PRIMARY KEY
);

-- 以下はサンプルデータ
INSERT INTO clients (client_id) VALUES
('CF71705D-DE27-40FE-9181-E190E0A65EB6'),
('D2BC191E-DB64-46BC-AE16-916A7E53839A');

INSERT INTO recruits (recruit_id, title, client_id) VALUES
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4f', 'Software Engineer', 'CF71705D-DE27-40FE-9181-E190E0A65EB6'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4e', 'Product Manager', 'CF71705D-DE27-40FE-9181-E190E0A65EB6'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4d', 'Designer', 'CF71705D-DE27-40FE-9181-E190E0A65EB6'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4c', 'Sales', 'CF71705D-DE27-40FE-9181-E190E0A65EB6'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4b', 'Marketing', 'CF71705D-DE27-40FE-9181-E190E0A65EB6'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4a', 'Customer Success', 'CF71705D-DE27-40FE-9181-E190E0A65EB6'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b49', 'Finance', 'D2BC191E-DB64-46BC-AE16-916A7E53839A'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b48', 'HR', 'D2BC191E-DB64-46BC-AE16-916A7E53839A'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b47', 'Legal', 'D2BC191E-DB64-46BC-AE16-916A7E53839A'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b46', 'Operations', 'D2BC191E-DB64-46BC-AE16-916A7E53839A'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b45', 'Data Scientist', 'D2BC191E-DB64-46BC-AE16-916A7E53839A');

INSERT INTO projects (recruit_id) VALUES
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4f'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4e'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4d'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4c'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4b'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4a');

-- INSERT INTO comps (recruit_id) VALUES
-- ('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b49'),
-- ('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b48'),
-- ('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b47'),
-- ('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b46'),
-- ('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b45');