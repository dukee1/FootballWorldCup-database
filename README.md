# World Cup Database

This repository contains the PostgreSQL database dump and Bash scripts for the World Cup project.

## Database Structure

The `worldcup` database contains 2 tables with relational links (Primary & Foreign Keys):

- `teams`: Unique national teams (`team_id` SERIAL primary key, `name` VARCHAR UNIQUE).
- `games`: Results of the final three rounds of the 2014 and 2018 World Cups (`game_id` SERIAL primary key, `year`, `round`, `winner_id` and `opponent_id` as foreign keys to `teams.team_id`, `winner_goals`, `opponent_goals`).

All columns have the `NOT NULL` constraint.

## How to Rebuild the Database

To restore the database from the SQL dump, execute the following command in a terminal where PostgreSQL is installed:

```bash
psql -U postgres < worldcup.sql
```

## Usage

Fill the tables from the CSV file, then run the queries:

```bash
./insert_data.sh
./queries.sh
```

## Project Structure

```text
.
├── games.csv            # Source data
├── insert_data.sh       # Fills the teams and games tables from games.csv
├── queries.sh           # SQL queries with statistics about the games
├── worldcup.sql         # Database dump
└── README.md
```