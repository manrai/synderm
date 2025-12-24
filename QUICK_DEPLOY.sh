#!/bin/bash
# Quick deployment script for synderm package
# Usage: ./QUICK_DEPLOY.sh

set -e  # Exit on error

echo "Cleaning old builds..."
rm -rf dist/ build/ *.egg-info synderm.egg-info

echo "Building package..."
python3 -m build

echo "Verifying wheel contents..."
echo "Wheel contents:"
unzip -l dist/*.whl | grep "synderm/"

echo ""
echo "Build complete!"
echo ""
echo "Next steps:"
echo "1. Review the wheel contents above"
echo "2. Upload to TestPyPI (optional): python3 -m twine upload --repository testpypi dist/*"
echo "3. Upload to PyPI: python3 -m twine upload dist/*"
echo ""
echo "Don't forget to:"
echo "- Commit your changes to git"
echo "- Tag the release: git tag v$(grep 'version = ' pyproject.toml | cut -d'"' -f2) && git push origin --tags"

