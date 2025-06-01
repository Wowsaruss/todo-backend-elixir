.PHONY: setup compile test clean db.create db.migrate server

# Load environment variables
include .env
export

# Setup the project
setup:
	mix deps.get
	mix deps.compile

# Compile the project
compile:
	mix compile

iex:
	mix deps.get
	mix deps.compile
	iex

# Run tests
test:
	mix test

# Clean build artifacts
clean:
	mix deps.clean --all
	mix clean

# Database commands
db.create:
	mix ecto.create

db.migrate:
	mix ecto.migrate

db.reset:
	mix ecto.drop
	mix ecto.create
	mix ecto.migrate

# Start the server
server:
	mix run --no-halt

# Format code
format:
	mix format

# Check code style
check:
	mix format --check-formatted
	mix credo
	mix dialyzer

# Install development dependencies
dev.setup:
	mix deps.get
	mix deps.compile
	mix ecto.create
	mix ecto.migrate

# Help command
help:
	@echo "Available commands:"
	@echo "  make setup        - Install and compile dependencies"
	@echo "  make compile     - Compile the project"
	@echo "  make test        - Run tests"
	@echo "  make clean       - Clean build artifacts"
	@echo "  make db.create   - Create the database"
	@echo "  make db.migrate  - Run database migrations"
	@echo "  make db.reset    - Reset the database (drop, create, migrate)"
	@echo "  make server      - Start the server"
	@echo "  make format      - Format code"
	@echo "  make check       - Run code checks (format, credo, dialyzer)"
	@echo "  make dev.setup   - Full development setup" 