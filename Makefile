.PHONY: format lint type-check test install plan external-refs clean reset upgrade

install:
	uv sync --all-extras
	uv run -- prek install
	cp .env.example .env

clean:
	rm -rf .cache .ruff_cache .pytest_cache

reset: clean
	uv venv --clear
	$(MAKE) install

upgrade:
	uv sync --upgrade --all-extras

# SQLMesh Commands
prod-plan:
	uv run -- sqlmesh plan prod

dev-plan:
	uv run -- sqlmesh plan dev_cort --no-prompts --auto-apply --test-changed-only
	
# Dev Commands
ready: lint format test external-refs

format:
	uv run -- ruff format
	uv run -- sqlmesh format

lint:
	uv run -- ruff check --fix
	uv run -- sqlmesh lint

type-check:
	uv run -- ty check

test:
	uv run -- sqlmesh test

external-refs:
	rm -f external_models.yaml
	uv run -- sqlmesh create_external_models