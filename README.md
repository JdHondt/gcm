# Generative Correlation Manifolds (GCM)

This Python package provides an implementation of the Generative Correlation Manifolds (GCM) method for generating synthetic data. As described in the accompanying whitepaper, GCM is a computationally efficient method that is mathematically guaranteed to preserve the entire Pearson correlation structure of a z-normalized source dataset.

This makes it an ideal tool for a variety of tasks, including:

* Privacy-preserving data sharing
* Robust model augmentation
* High-fidelity simulation
* Algorithmic fairness and auditing

## Installation

To install the package, clone the repository and install it using pip:

```bash
git clone <repository-url>
cd <repository-directory>
pip install .
```

## Usage

The package provides a simple, easy-to-use interface through the `GCM` class. Here is a basic example of how to generate synthetic data from a source dataset:

```python
import numpy as np
from gcm import GCM

# 1. Create a source dataset with a known correlation structure
mean = [0, 0, 0]
cov = [[1.0, 0.8, 0.3],
       [0.8, 1.0, 0.6],
       [0.3, 0.6, 1.0]]
source_data = np.random.multivariate_normal(mean, cov, 1000)

# 2. Initialize the GCM model and fit it to the source data
gcm = GCM()
gcm.fit(source_data)

# 3. Generate synthetic samples
synthetic_data = gcm.sample(num_samples=500)

# 4. Verify that the correlation structure is preserved
print("Source Correlation Matrix:")
print(np.corrcoef(source_data, rowvar=False))
print("\nSynthetic Correlation Matrix:")
print(np.corrcoef(synthetic_data, rowvar=False))
```
