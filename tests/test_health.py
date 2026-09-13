from django.test import Client


def test_home_page_exists():
    client = Client()
    response = client.get("/")
    assert response.status_code == 200


def test_health_check_returns_ok():
    client = Client()
    response = client.get("/health/")
    assert response.status_code == 200
    assert response.json()["status"] == "ok"
