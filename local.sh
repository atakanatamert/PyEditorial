#!/bin/bash

cp .env.dev.example .env

cp .env.postgres.example .postgres.env

docker compose build

docker compose up -d
