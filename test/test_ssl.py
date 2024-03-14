import requests


def request_ok(url, **kwargs):
  try:
    return requests.get(url, **kwargs).ok
  except Exception:
    return False


def test_ssl():
  url_good = 'https://sha256.badssl.com/'
  url_bad = 'https://expired.badssl.com/'
  urls = '''https://cartodb.com/
  https://environment.data.gov.uk/
  https://server.arcgisonline.com/
  https://data.gov.uk/
  https://api.os.uk/
  https://osdatahub.os.uk/
  https://download.geofabrik.de/
  https://openstreetmap.org/
  https://overpass-api.de/
  https://dataspace.copernicus.eu/
  https://repo.anaconda.com/
  https://pypi.org/
  https://cran.r-project.org/
  https://maven.apache.org/
  https://repo1.maven.org/'''.split()

  results = {
    url_good: request_ok(url_good),
    url_bad: not request_ok(url_bad),
    **{url: request_ok(url) for url in urls},
  }
  assert all(results.values()), results
  return results


if __name__ == "__main__":
  test_ssl()
