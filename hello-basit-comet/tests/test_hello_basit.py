import os
import sys
import pytest

# Ensure the application source is on the Python path
BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
sys.path.insert(0, BASE_DIR)

from src.app import app


@pytest.fixture
def client():
    """Flask test client."""
    with app.test_client() as client:
        yield client


def test_404(client):
    """Test a non-existent route returns 404."""
    response = client.get("/foobar")
    assert response.status_code == 404
