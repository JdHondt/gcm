# GCM Test Suite

This directory contains comprehensive unit tests for the Generative Correlation Manifolds (GCM) package.

## Test Coverage

The test suite includes 16 tests across the following categories:

### 1. Core Functionality Tests
- **`test_fit_basic_functionality`**: Tests basic model fitting
- **`test_fit_with_1d_data`**: Tests handling of 1D input data
- **`test_fit_from_correlation_matrix`**: Tests fitting from pre-computed correlation matrices
- **`test_sample_without_fit`**: Ensures proper error handling when sampling before fitting
- **`test_sample_size_consistency`**: Verifies correct output sample sizes

### 2. Correlation Preservation Tests
- **`test_correlation_preservation`**: Verifies that correlations are approximately preserved in synthetic data
- **`test_cholesky_decomposition_properties`**: Tests mathematical properties of Cholesky decomposition
- **`test_statistical_significance_of_correlations`**: Ensures preserved correlations are statistically significant

### 3. Statistics Preservation Tests
- **`test_mean_std_preservation_when_true`**: Tests that means and standard deviations are preserved when `preserve_stats=True`
- **`test_standardized_output_when_false`**: Tests that output has mean≈0 and std≈1 when `preserve_stats=False`

### 4. Edge Case and Robustness Tests
- **`test_single_feature_case`**: Tests behavior with single-feature datasets
- **`test_edge_case_perfect_correlation`**: Tests handling of perfectly correlated data
- **`test_different_random_seeds`**: Ensures different random seeds produce different results
- **`test_fit_from_correlation_invalid_input`**: Tests error handling for invalid correlation matrices

### 5. Integration Tests
- **`test_full_workflow_preserve_stats_true`**: Complete workflow test with statistics preservation
- **`test_full_workflow_preserve_stats_false`**: Complete workflow test with standardized output

## Key Test Focus Areas

### 1. Correlation Preservation
Tests verify that the correlation structure of the original data is maintained in the generated synthetic data within acceptable tolerances (typically ±0.05 for correlation coefficients).

### 2. Statistics Preservation
When `preserve_stats=True`:
- Original means are preserved (±0.1 tolerance)
- Original standard deviations are preserved (±0.2 tolerance)

When `preserve_stats=False`:
- Generated data has means ≈ 0 (±0.1 tolerance)
- Generated data has standard deviations ≈ 1 (±0.1 tolerance)

### 3. Mathematical Correctness
Tests verify that:
- Cholesky decomposition is computed correctly
- The decomposition satisfies L @ L.T = original correlation matrix
- Single-feature datasets are handled properly

## Running Tests

From the project root directory:

### Using pytest (recommended)
```bash
# Run all tests
python -m pytest tests/

# Run with verbose output
python -m pytest tests/ -v

# Run with coverage report (requires pytest-cov)
python -m pytest tests/ --cov=gcm --cov-report=html

# Run specific test file
python -m pytest tests/test_gcm.py -v

# Run specific test method
python -m pytest tests/test_gcm.py::TestGCM::test_correlation_preservation -v

# Run and stop on first failure
python -m pytest -x
```

### Using unittest directly
```bash
# Run all tests
python -m unittest discover tests -v

# Run specific test class
python -m unittest tests.test_gcm.TestGCM -v

# Run specific test method
python -m unittest tests.test_gcm.TestGCM.test_correlation_preservation -v
```

### Using Makefile (convenient shortcuts)
```bash
# Run all tests
make test

# Run with verbose output
make test-verbose

# Run with coverage (if pytest-cov available)
make test-coverage

# Run with unittest (fallback option)
make test-unittest
```

## Test Structure

- `test_gcm.py` - Comprehensive unit tests for the GCM class
- `__init__.py` - Makes this a Python package for proper test discovery
- `README.md` - This documentation file

## Test Data

Tests use carefully constructed datasets with known correlation structures to verify that the GCM algorithm correctly preserves these relationships. The test data includes:

- Multi-feature datasets with varying correlation strengths
- Single-feature datasets
- Edge cases like perfectly correlated variables
- Datasets with specific means and standard deviations

## Tolerances

The tests use reasonable tolerances that account for:
- Sampling variance in finite datasets
- Numerical precision limitations
- Statistical fluctuations in correlation estimates

Default tolerances:
- Correlation coefficients: ±0.05
- Means: ±0.1 to ±0.2 depending on test
- Standard deviations: ±0.1 to ±0.3 depending on test

These tolerances are based on typical statistical variation expected with the sample sizes used in tests (typically 1000-10000 samples).
