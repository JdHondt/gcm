# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2025-09-23

### Added

* **Statistical Preservation**: Added `preserve_stats` parameter to the `GCM` constructor (default: `True`)
  * When `preserve_stats=True`: Generated data preserves the mean and standard deviation of the original data for each feature
  * When `preserve_stats=False`: Generated data is standardized with mean=0 and std=1
  * Correlation structure is preserved in both modes

### Changed

* Enhanced documentation with additional usage examples
* Added comprehensive examples showing both statistical preservation modes

### Notes

* All existing code will continue to work unchanged
* Default behavior now preserves original data statistics, which provides more intuitive results for most use cases

## [1.0.0] - Initial Release

### Features

* Initial implementation of Generative Correlation Manifolds (GCM)
* `fit()` method to learn correlation structure from existing data
* `fit_from_correlation()` method to specify correlation matrix directly
* `sample()` method to generate synthetic data with preserved correlation structure
* Complete documentation and usage examples
