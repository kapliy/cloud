CREATE USER 'slurm'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'slurm'@'localhost' WITH GRANT OPTION;
CREATE USER 'slurm'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'slurm'@'%' WITH GRANT OPTION;
