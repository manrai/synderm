# PyPI Deployment Guide

## Initial Setup

Install tools:
```bash
pip install build twine
```

Get API token from https://pypi.org/manage/account/token/ and create `~/.pypirc`:
```ini
[pypi]
username = __token__
password = pypi-YOUR_PRODUCTION_TOKEN

[testpypi]
username = __token__
password = pypi-YOUR_TEST_TOKEN
repository = https://test.pypi.org/legacy/
```

Set permissions:
```bash
chmod 600 ~/.pypirc
```

## Release Process

### 1. Update Version
Edit `pyproject.toml`:
```toml
version = "0.1.4"  # Increment: MAJOR.MINOR.PATCH
```

### 2. Build
```bash
./QUICK_DEPLOY.sh
```

### 3. Upload to PyPI
```bash
python3 -m twine upload dist/*
```

### 3a. Test in a new env
```bash
python3 -m venv test_env
source test_env/bin/activate
pip install synderm
python3 -c "from synderm.fine_tune import fine_tune_text_to_image; print('✅ Success!')"
deactivate
rm -rf test_env
```


### 4. Update Git
```bash
git add .
git commit -m "Release v0.1.4"
git tag -a v0.1.4 -m "Release v0.1.4"
git push origin main
git push origin v0.1.4
```

## Optional: Test on TestPyPI First

```bash
python3 -m twine upload --repository testpypi dist/*
pip install --index-url https://test.pypi.org/simple/ --no-deps synderm
```

## Quick Commands

Full release:
```bash
./QUICK_DEPLOY.sh 
python3 -m twine upload dist/* 
git add . 
git commit -m "Release v0.1.4" 
git tag -a v0.1.4 -m "Release v0.1.4" 
git push origin main
push origin v0.1.4
```

Git tag management:
```bash
git tag -l                              # List tags
git tag -d v0.1.3                       # Delete local tag
git push origin --delete v0.1.3         # Delete remote tag
```
