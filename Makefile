.PHONY: format lint type-check test install plan external-refs clean reset upgrade

install:
	uv sync --all-extras
	uv run -- prek install

clean:
	rm -rf .cache
	rm -rf .ruff_cache
	rm -rf .pytest_cache

reset: clean
	uv venv --clear
	$(MAKE) install

upgrade:
	uv sync --upgrade --all-extras

# SQLMesh Commands
plan:
	uv run -- sqlmesh plan
	
ready: lint format test external-refs

format:
	uv run -- ruff format

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