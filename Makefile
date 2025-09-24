.PHONY: test test-verbose test-coverage clean install install-dev build publish version help

# Default target
help:
	@echo "Available targets:"
	@echo "  test          - Run all tests"
	@echo "  test-verbose  - Run tests with verbose output"  
	@echo "  test-coverage - Run tests with coverage report"
	@echo "  test-unittest - Run tests using unittest (fallback)"
	@echo "  clean         - Clean up generated files"
	@echo "  install       - Install package in development mode"
	@echo "  install-dev   - Install package with development dependencies"
	@echo "  build         - Build the package for distribution"
	@echo "  publish       - Build and publish package to PyPI (requires VERSION=x.y.z)"
	@echo "  version       - Show current version and suggest next versions"
	@echo "  lint          - Run code linting (if available)"

# Test targets
test:
	python -m pytest tests/

test-verbose:
	python -m pytest tests/ -v

test-coverage:
	@if python -c "import pytest_cov" 2>/dev/null; then \
		python -m pytest tests/ --cov=gcm --cov-report=html --cov-report=term; \
	else \
		echo "pytest-cov not available. Install with: pip install pytest-cov"; \
		echo "Running tests without coverage..."; \
		python -m pytest tests/ -v; \
	fi

test-unittest:
	python -m unittest discover tests -v

# Development targets  
install:
	pip install -e .

install-dev:
	pip install -e ".[dev]"

# Maintenance targets
clean:
	rm -rf __pycache__/
	rm -rf .pytest_cache/
	rm -rf .coverage
	rm -rf htmlcov/
	rm -rf dist/
	rm -rf build/
	rm -rf *.egg-info/
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete

# Build and publish targets
build:
	@echo "Building package..."
	rm -rf dist/ build/ *.egg-info/
	python -m build
	@echo "Build complete. Files in dist/:"
	@ls -la dist/

version:
	@CURRENT=$$(grep '^version = ' pyproject.toml | sed 's/version = "\(.*\)"/\1/'); \
	MAJOR=$$(echo $$CURRENT | cut -d. -f1); \
	MINOR=$$(echo $$CURRENT | cut -d. -f2); \
	PATCH=$$(echo $$CURRENT | cut -d. -f3); \
	echo "Current version: $$CURRENT"; \
	echo "Suggested versions:"; \
	echo "  Patch: $$MAJOR.$$MINOR.$$((PATCH + 1))   (bug fixes)"; \
	echo "  Minor: $$MAJOR.$$((MINOR + 1)).0   (new features)"; \
	echo "  Major: $$((MAJOR + 1)).0.0   (breaking changes)"; \
	echo ""; \
	echo "To publish: make publish VERSION=x.y.z"

publish:
	@if [ -z "$(VERSION)" ]; then \
		echo "Error: VERSION is required. Usage: make publish VERSION=x.y.z"; \
		exit 1; \
	fi
	@echo "Publishing version $(VERSION)..."
	./publish.sh $(VERSION)

lint:
	@if command -v flake8 >/dev/null 2>&1; then \
		echo "Running flake8..."; \
		flake8 gcm/ tests/; \
	else \
		echo "flake8 not available. Install with: pip install flake8"; \
	fi
	@if command -v black >/dev/null 2>&1; then \
		echo "Running black..."; \
		black --check gcm/ tests/; \
	else \
		echo "black not available. Install with: pip install black"; \
	fi
